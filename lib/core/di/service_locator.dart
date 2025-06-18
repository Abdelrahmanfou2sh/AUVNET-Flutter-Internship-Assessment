import 'package:auvnet/features/auth/data/datasources/firestore_datasource.dart';
import 'package:auvnet/features/auth/data/models/user_model.dart';
import 'package:auvnet/features/auth/domain/usecases/get_auth_state_use_case.dart';
import 'package:auvnet/features/auth/domain/usecases/get_last_signed_in_use_case.dart';
import 'package:auvnet/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:auvnet/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:auvnet/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:auvnet/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:auvnet/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:auvnet/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:auvnet/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:auvnet/features/auth/domain/repositories/auth_repository.dart';
import 'package:auvnet/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:auvnet/features/home/data/datasources/home_local_datasource.dart';
import 'package:auvnet/features/home/data/datasources/home_remote_datasource.dart';
import 'package:auvnet/features/home/data/models/restaurant_model.dart';
import 'package:auvnet/features/home/data/models/service_model.dart';
import 'package:auvnet/features/home/data/models/shortcut_model.dart';
import 'package:auvnet/features/home/data/repositories/home_repository_impl.dart';
import 'package:auvnet/features/home/domain/repositories/home_repository.dart';
import 'package:auvnet/features/home/domain/usecases/get_restaurants_usecase.dart';
import 'package:auvnet/features/home/domain/usecases/get_services_usecase.dart';
import 'package:auvnet/features/home/domain/usecases/get_shortcuts_usecase.dart';
import 'package:auvnet/features/home/presentation/bloc/home_bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Initialize Hive
  await Hive.initFlutter();

  /// Auth Boxes
  final userBox = await Hive.openBox<UserModel>('user_box');
  sl.registerLazySingleton<Box<UserModel>>(() => userBox);

  /// Home Boxes
  final restaurantsBox = await Hive.openBox<RestaurantModel>('restaurants');
  final servicesBox = await Hive.openBox<ServiceModel>('services');
  final shortcutsBox = await Hive.openBox<ShortcutModel>('shortcuts');

  sl.registerLazySingleton<Box<RestaurantModel>>(() => restaurantsBox);
  sl.registerLazySingleton<Box<ServiceModel>>(() => servicesBox);
  sl.registerLazySingleton<Box<ShortcutModel>>(() => shortcutsBox);

  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Auth Datasources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(userBox: sl()),
  );

  sl.registerLazySingleton<FirestoreDataSource>(
    () => FirestoreDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      localDataSource: sl(),
      firestoreDataSource: sl(),
    ),
  );

  // Auth Repository & UseCases
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => GetAuthStateUseCase(sl()));
  sl.registerLazySingleton(() => GetLastSignedInUserUseCase(sl()));

  // Auth Bloc
  sl.registerFactory(
    () => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      signOutUseCase: sl(),
      getAuthStateUseCase: sl(),
      getLastSignedInUserUseCase: sl(),
    ),
  );

  // Onboarding Cubit
  sl.registerFactory(() => OnBoardingCubit());

  // Home Datasources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(
      restaurantsBox: sl(),
      servicesBox: sl(),
      shortcutsBox: sl(),
    ),
  );

  // Home Repository & UseCases
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetRestaurantsUseCase(sl()));
  sl.registerLazySingleton(() => GetServicesUseCase(sl()));
  sl.registerLazySingleton(() => GetShortcutsUseCase(sl()));

  // Home Bloc
  sl.registerFactory(
    () => HomeBloc(getRestaurants: sl(), getServices: sl(), getShortcuts: sl()),
  );
}

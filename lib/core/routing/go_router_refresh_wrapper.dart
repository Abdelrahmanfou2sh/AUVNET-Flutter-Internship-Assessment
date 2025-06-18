import 'dart:async';

import 'package:flutter/widgets.dart';

class GoRouterRefreshStreamWrapper extends ChangeNotifier {
  GoRouterRefreshStreamWrapper({required Stream<dynamic> stream}) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

# AuvNet - Internship Assessment Project 🚀

[English](#english) | [العربية](#arabic)

<a name="english"></a>
## 🌟 English

AuvNet is a modern Flutter e-commerce application focused on food & service delivery, built with a clean and scalable architecture using the BLoC pattern. This project serves as an assessment for AUVNET's internship program, demonstrating architectural integrity, modular design, and robust state management.

### 🏗️ Architecture

The project follows Clean Architecture with clear separation of concerns:
```
lib/
├── core/                 → Global configs (router, theme, errors, services)
├── features/
│   └── auth/             → Authentication flow (login/signup)
│   └── home/             → Home screen UI + business logic
│       ├── data/         → Models, repositories, datasources
│       ├── domain/       → Entities + Use Cases
│       └── presentation/ → UI + BLoC
```

### 🛠️ Technical Stack

| Category | Tech Used |
|----------|------------|
| 🧱 Architecture | Clean Architecture |
| 🧠 State Management | BLoC (flutter_bloc) |
| 💾 Local Storage | Hive |
| 🔐 Authentication | Firebase Auth |
| ☁️ Cloud Database | Cloud Firestore |
| 🧪 Dependency Injection | GetIt |
| 🎨 UI Design | Material Design + Custom Theme |
| 🎭 Theme | Primary: #FF6B00, Secondary: #1E1E1E |
| 🖌️ Typography | DM Sans, Mulish, Poppins, Rubik |
| 📱 Responsiveness | flutter_screenutil |

### 📱 Features

#### 🔐 Authentication
- Email & password login/signup using Firebase Auth
- Secure state listening with authStateChanges

#### 🏠 Home Screen
- Gradient header with profile
- Horizontally scrolling Services
- "Got a Code?" section
- Shortcuts menu
- Auto-cached Restaurants section using Firestore
- Dynamic banner slider

#### 💾 Caching
- All dynamic data is cached locally using Hive
- The app works offline using previously stored data

### 🎨 Theme & Design System

#### Colors
- Primary: #FF6B00 (Orange)
- Secondary: #1E1E1E (Dark Gray)
- Background: Light theme with subtle shadows
- Text: Dark on light backgrounds, White on colored surfaces

#### Typography
- Primary Font: DM Sans (Headings and important text)
- Secondary Fonts: Mulish, Poppins, Rubik
- Text Styles: Consistent hierarchy with defined sizes

#### UI Components
- Custom gradient headers
- Rounded corners (16.5r standard)
- Consistent shadow effects
- Responsive spacing using ScreenUtil
- Custom navigation bar

### 🔧 Installation Guide

1. Clone the repository:
```bash
git clone https://github.com/your-username/auvnet_flutter.git
cd auvnet_flutter
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run build runner:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Configure Firebase:
- Add your google-services.json and GoogleService-Info.plist
- Enable Firebase Auth & Firestore in your project

5. Run the app:
```bash
flutter run
```

### 💡 Why This Architecture?
- Ensures testability and scalability
- Separates UI from logic for maintainability
- Follows modern patterns like copyWith, immutability, and repository pattern
- Respects SOLID principles in practice

### ✅ Evaluation Readiness

| Requirement | Status |
|-------------|--------|
| Clean Architecture | ✅ Applied |
| BLoC (not Cubit) | ✅ Used |
| copyWith in States | ✅ Done |
| Firebase Integration | ✅ Done |
| Local Caching via Hive | ✅ Applied |
| Responsive UI | ✅ Used |
| Code Comments & Modularity | ✅ Done |
| README with Technical Overview | ✅ Done |

---

<a name="arabic"></a>
## 🌟 العربية

AuvNet هو تطبيق تجارة إلكترونية حديث مبني بـ Flutter يركز على توصيل الطعام والخدمات، تم بناؤه باستخدام بنية نظيفة وقابلة للتطوير باستخدام نمط BLoC. يعمل هذا المشروع كتقييم لبرنامج التدريب في AUVNET، ويوضح سلامة البنية المعمارية، والتصميم النمطي، وإدارة الحالة القوية.

### 🏗️ البنية المعمارية

يتبع المشروع البنية النظيفة مع فصل واضح للمسؤوليات:
```
lib/
├── core/                 ← التكوينات العامة (التوجيه، السمة، الأخطاء، الخدمات)
├── features/
│   └── auth/             ← تدفق المصادقة (تسجيل الدخول/التسجيل)
│   └── home/             ← واجهة الشاشة الرئيسية + منطق الأعمال
│       ├── data/         ← النماذج، المستودعات، مصادر البيانات
│       ├── domain/       ← الكيانات + حالات الاستخدام
│       └── presentation/ ← واجهة المستخدم + BLoC
```

### 🛠️ المكونات التقنية

| الفئة | التقنية المستخدمة |
|----------|------------|
| 🧱 البنية المعمارية | البنية النظيفة |
| 🧠 إدارة الحالة | BLoC (flutter_bloc) |
| 💾 التخزين المحلي | Hive |
| 🔐 المصادقة | Firebase Auth |
| ☁️ قاعدة البيانات السحابية | Cloud Firestore |
| 🧪 حقن التبعيات | GetIt |
| 🎨 تصميم واجهة المستخدم | Material Design + مخصص |
| 📱 التجاوب | flutter_screenutil |

### 📱 المميزات

#### 🔐 المصادقة
- تسجيل الدخول/التسجيل بالبريد الإلكتروني وكلمة المرور باستخدام Firebase Auth
- استماع آمن لحالة المصادقة مع authStateChanges

#### 🏠 الشاشة الرئيسية
- رأس متدرج مع الملف الشخصي
- خدمات قابلة للتمرير أفقياً
- قسم "لديك رمز؟"
- قائمة الاختصارات
- قسم المطاعم مع تخزين مؤقت تلقائي باستخدام Firestore
- شريط إعلانات متحرك

#### 💾 التخزين المؤقت
- يتم تخزين جميع البيانات الديناميكية محلياً باستخدام Hive
- يعمل التطبيق بدون اتصال باستخدام البيانات المخزنة مسبقاً

### 🔧 دليل التثبيت

1. استنساخ المستودع:
```bash
git clone https://github.com/your-username/auvnet_flutter.git
cd auvnet_flutter
```

2. تثبيت التبعيات:
```bash
flutter pub get
```

3. تشغيل build runner:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. تكوين Firebase:
- إضافة ملفات google-services.json و GoogleService-Info.plist
- تمكين Firebase Auth و Firestore في مشروعك

5. تشغيل التطبيق:
```bash
flutter run
```

### 💡 لماذا هذه البنية المعمارية؟
- تضمن قابلية الاختبار والتطوير
- تفصل واجهة المستخدم عن المنطق للصيانة
- تتبع الأنماط الحديثة مثل copyWith وعدم قابلية التغيير ونمط المستودع
- تحترم مبادئ SOLID في التطبيق العملي

### ✅ جاهزية التقييم

| المتطلب | الحالة |
|-------------|--------|
| البنية النظيفة | ✅ مطبق |
| BLoC (وليس Cubit) | ✅ مستخدم |
| copyWith في الحالات | ✅ منجز |
| تكامل Firebase | ✅ منجز |
| التخزين المحلي عبر Hive | ✅ مطبق |
| واجهة مستخدم متجاوبة | ✅ مستخدم |
| تعليقات الكود والنمطية | ✅ منجز |
| README مع نظرة عامة تقنية | ✅ منجز |

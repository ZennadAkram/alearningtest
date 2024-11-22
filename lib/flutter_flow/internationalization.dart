import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
  }) =>
      [enText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // student_UI
  {
    '792bjbux': {
      'en': 'Practical Work Assignments',
      'ar': 'مهام العمل العملية',
    },
    'iup80skz': {
      'en': 'Your hands-on learning tasks',
      'ar': 'مهام التعلم العملي الخاصة بك',
    },
    'tnz6f9li': {
      'en': 'My Courses',
      'ar': 'دوراتي',
    },
    'z1r4rdnz': {
      'en': 'Introduction to Computer Science',
      'ar': 'مقدمة في علوم الكمبيوتر',
    },
    '180k2pla': {
      'en': 'CS101 • Prof. Johnson',
      'ar': 'CS101 • البروفيسور جونسون',
    },
    'biapk03d': {
      'en': 'Calculus I',
      'ar': 'حساب التفاضل والتكامل 1',
    },
    '4arh47lx': {
      'en': 'MATH201 • Prof. Smith',
      'ar': 'MATH201 • البروفيسور سميث',
    },
    '2nwg5jte': {
      'en': 'World History',
      'ar': 'التاريخ العالمي',
    },
    'dz22qki2': {
      'en': 'HIST101 • Prof. Davis',
      'ar': 'HIST101 • البروفيسور ديفيس',
    },
    'ecwi025i': {
      'en': 'Recent Assignments',
      'ar': 'المهام الأخيرة',
    },
    'jh10oo8q': {
      'en': 'Lab 1: Introduction to Python',
      'ar': 'المختبر 1: مقدمة إلى بايثون',
    },
    'lb31ufvl': {
      'en':
          'Learn the basics of Python programming through hands-on exercises.',
      'ar': 'تعلم أساسيات برمجة بايثون من خلال التمارين العملية.',
    },
    '12mwm8lo': {
      'en': 'Due: May 15, 2024',
      'ar': 'الموعد النهائي: 15 مايو 2024',
    },
    'hvzjku4r': {
      'en': 'View Details',
      'ar': 'عرض التفاصيل',
    },
    'onr22yhg': {
      'en': 'Lab 2: Data Structures in C++',
      'ar': 'المختبر 2: هياكل البيانات في C++',
    },
    'i6ae0d27': {
      'en': 'Implement and analyze various data structures using C++.',
      'ar': 'تنفيذ وتحليل هياكل البيانات المختلفة باستخدام C++.',
    },
    '6f6sdipq': {
      'en': 'Due: May 18, 2024',
      'ar': 'الموعد النهائي: 18 مايو 2024',
    },
    'lgfp7595': {
      'en': 'View Details',
      'ar': 'عرض التفاصيل',
    },
    'ajky9xbf': {
      'en': 'Lab 3: Web Development Basics',
      'ar': 'المختبر 3: أساسيات تطوير الويب',
    },
    'w5hphghu': {
      'en': 'Create a simple website using HTML, CSS, and JavaScript.',
      'ar': 'إنشاء موقع ويب بسيط باستخدام HTML وCSS وJavaScript.',
    },
    '4urpqc1w': {
      'en': 'Due: May 20, 2023',
      'ar': 'الموعد النهائي: 20 مايو 2023',
    },
    '5awswk4e': {
      'en': 'View Details',
      'ar': 'عرض التفاصيل',
    },
    'fpsuelf2': {
      'en': 'Dashboard',
      'ar': 'لوحة القيادة',
    },
  },
  // teacher_UI
  {
    'vlr4ur7q': {
      'en': 'Teacher Dashboard',
      'ar': 'لوحة معلومات المعلم',
    },
    'c1dw4lhy': {
      'en': 'Manage your  and student submissions',
      'ar': 'إدارة إرسالياتك وإرساليات الطلاب',
    },
    'tk1l8jto': {
      'en': 'My Courses',
      'ar': 'دوراتي',
    },
    '2zb64s4p': {
      'en': 'Advanced Biology',
      'ar': 'علم الأحياء المتقدم',
    },
    '6wlqqybd': {
      'en': 'Grade 11 • 28 Students',
      'ar': 'الصف الحادي عشر • 28 طالبًا',
    },
    'u2t993wn': {
      'en': 'Calculus I',
      'ar': 'حساب التفاضل والتكامل 1',
    },
    'e8dvioy7': {
      'en': 'Grade 12 • 22 Students',
      'ar': 'الصف الثاني عشر • 22 طالبًا',
    },
    'oc23q0k8': {
      'en': 'World History',
      'ar': 'التاريخ العالمي',
    },
    '38gtgxot': {
      'en': 'Grade 10 • 30 Students',
      'ar': 'الصف العاشر • 30 طالبًا',
    },
    'mo0cx6sw': {
      'en': 'Students Submessions',
      'ar': 'إرساليات الطلاب',
    },
    'wvxj8wll': {
      'en': 'View All',
      'ar': 'عرض الكل',
    },
    'skzeocld': {
      'en': 'Filter by:',
      'ar': 'تصفية حسب:',
    },
    'znvwn5p5': {
      'en': 'All Modules',
      'ar': 'جميع الوحدات',
    },
    'e5r4g1p0': {
      'en': 'John Doe',
      'ar': 'جون دو',
    },
    'bkqdo44g': {
      'en': 'Intro to Programming - PW1',
      'ar': 'مقدمة في البرمجة - PW1',
    },
    'xidv3dq7': {
      'en': 'Submitted',
      'ar': 'مُقَدَّم',
    },
    '1tirpq6o': {
      'en': 'Jane Smith',
      'ar': 'جين سميث',
    },
    '9gnht2at': {
      'en': 'Web Dev Fundamentals - PW2',
      'ar': 'أساسيات تطوير الويب - PW2',
    },
    '5zxy46so': {
      'en': 'Late',
      'ar': 'متأخر',
    },
    'xsfsbrhp': {
      'en': 'Dashboard',
      'ar': 'لوحة القيادة',
    },
    '8ku056ld': {
      'en': 'Profile',
      'ar': 'حساب تعريفي',
    },
  },
  // student_assignment_details
  {
    '36rw90qn': {
      'en': 'Assignment Details',
      'ar': 'تفاصيل المهمة',
    },
    '0j3g2wlq': {
      'en': 'Lab 1: Introduction to Python',
      'ar': 'المختبر 1: مقدمة إلى بايثون',
    },
    'eizg9j6x': {
      'en': 'Objectives:',
      'ar': 'أهداف:',
    },
    'uktw4c9a': {
      'en':
          '• Understand basic Python syntax\n• Learn about variables and data types\n• Implement simple algorithms',
      'ar':
          '• فهم قواعد بناء الجملة الأساسية في بايثون\n• التعرف على المتغيرات وأنواع البيانات\n• تنفيذ خوارزميات بسيطة',
    },
    '5h4tkh75': {
      'en': 'Materials Needed:',
      'ar': 'المواد المطلوبة:',
    },
    '6nsxx84o': {
      'en':
          '• Python 3.x installed on your computer\n• A text editor or IDE (e.g., PyCharm, VS Code)\n• Access to online Python documentation',
      'ar':
          '• تثبيت Python 3.x على جهاز الكمبيوتر الخاص بك\n• محرر نصوص أو IDE (على سبيل المثال، PyCharm، VS Code)\n• الوصول إلى وثائق Python عبر الإنترنت',
    },
    'qzyrtuvn': {
      'en': 'Steps:',
      'ar': 'خطوات:',
    },
    '9s00p8kq': {
      'en':
          '1. Set up your Python environment\n2. Write a \'Hello, World!\' program\n3. Implement a simple calculator\n4. Create a program to find prime numbers\n5. Submit your code and a brief report',
      'ar':
          '1. قم بإعداد بيئة Python الخاصة بك\n2. اكتب برنامج \"Hello, World!\"\n3. قم بتنفيذ آلة حاسبة بسيطة\n4. قم بإنشاء برنامج للعثور على الأعداد الأولية\n5. قم بإرسال الكود الخاص بك وتقرير موجز',
    },
    'xkz4fotz': {
      'en': 'Assignment: Introduction to Python',
      'ar': 'الواجب: مقدمة إلى بايثون',
    },
    'a2230aqj': {
      'en': 'Due: Nov 20, 2024',
      'ar': 'الموعد النهائي: 20 نوفمبر 2024',
    },
    'wb08thry': {
      'en': 'Intro_to_python_Assignment.pdf',
      'ar': 'مقدمة إلى بايثون.pdf',
    },
    'obk4eujz': {
      'en': '2.3 MB',
      'ar': '2.3 ميجا بايت',
    },
    'puuvqtg0': {
      'en': 'View',
      'ar': 'منظر',
    },
    'kcxse0ce': {
      'en': 'Helpful Resources:',
      'ar': 'مصادر مفيدة:',
    },
    'ky88k266': {
      'en': 'Video Tutorial: How to install python3',
      'ar': 'فيديو تعليمي: كيفية تثبيت Python3',
    },
    'fy7ak5nv': {
      'en': 'YouTube - MathMaster101',
      'ar': 'يوتيوب - MathMaster101',
    },
    '9h84jxk4': {
      'en': 'Textbook: Python Faundamentals',
      'ar': 'كتاب مدرسي: أساسيات بايثون',
    },
    'bqs1r0pi': {
      'en': 'Chapter 7, Pages 342-350',
      'ar': 'الفصل السابع، الصفحات 342-350',
    },
    'm6jhmcn0': {
      'en': 'Submission Form',
      'ar': 'نموذج التقديم',
    },
    'ey861uun': {
      'en': 'All',
      'ar': 'الجميع',
    },
    'ka83v0cg': {
      'en': 'All',
      'ar': 'الجميع',
    },
    'wi5uo4j7': {
      'en': 'Step1',
      'ar': 'الخطوة 1',
    },
    '1idbxkhl': {
      'en': 'Step2',
      'ar': 'الخطوة 2',
    },
    '74cqako0': {
      'en': 'Steps',
      'ar': 'خطوات',
    },
    'm76ip0od': {
      'en': 'Search...',
      'ar': 'يبحث...',
    },
    '9uytpjo5': {
      'en': 'Solution',
      'ar': 'حل',
    },
    'hpbhpj9c': {
      'en': 'Attach Files',
      'ar': 'إرفاق الملفات',
    },
    '8pzvlb5a': {
      'en': 'Submit',
      'ar': 'يُقدِّم',
    },
    'cwuqe3zb': {
      'en': 'Teacher Feedback',
      'ar': 'تعليقات المعلم',
    },
    'hwjee25f': {
      'en':
          'Great work on your Python introduction lab! Your code is well-structured and shows a good understanding of basic concepts. Here are some specific comments:',
      'ar':
          'عمل رائع في مختبرك التمهيدي لـ Python! الكود الخاص بك منظم بشكل جيد ويُظهِر فهمًا جيدًا للمفاهيم الأساسية. فيما يلي بعض التعليقات المحددة:',
    },
    'qdvohsl2': {
      'en':
          '• Excellent use of functions in your calculator program\n• Consider adding error handling for invalid inputs\n• Your prime number algorithm is efficient, but could be optimized further',
      'ar':
          '• استخدام ممتاز للوظائف في برنامج الآلة الحاسبة الخاص بك\n• فكر في إضافة معالجة الأخطاء للمدخلات غير الصالحة\n• خوارزمية الأعداد الأولية الخاصة بك فعّالة، ولكن يمكن تحسينها بشكل أكبر',
    },
    'uuttcp5z': {
      'en': 'Overall Score: 90/100',
      'ar': 'التقييم الإجمالي: 90/100',
    },
    'mzcnuptq': {
      'en': 'Dashboard',
      'ar': 'لوحة القيادة',
    },
    '15x9zdgb': {
      'en': 'Profile',
      'ar': 'حساب تعريفي',
    },
    'vssrsv73': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // student_module_assignments
  {
    'guw737ax': {
      'en': 'Introduction to Computer Science assignments',
      'ar': 'واجبات مقدمة في علوم الكمبيوتر',
    },
    'sxoyachw': {
      'en': 'Assignments',
      'ar': 'المهام',
    },
    'y6zah8rv': {
      'en': 'Available Assignments',
      'ar': 'المهام المتاحة',
    },
    'p78cuzwf': {
      'en': 'Lab 1: Introduction to Python',
      'ar': 'المختبر 1: مقدمة إلى بايثون',
    },
    '39kpjuyg': {
      'en':
          'Learn the basics of Python programming through hands-on exercises.',
      'ar': '',
    },
    'e2p27kld': {
      'en': 'Due: Nov 15, 2024',
      'ar': '',
    },
    '0bmjek8d': {
      'en': 'View Details',
      'ar': '',
    },
    '27u82k42': {
      'en': 'Lab 2: Data Structures in C++',
      'ar': '',
    },
    'c8dm0g8n': {
      'en': 'Implement and analyze various data structures using C++.',
      'ar': '',
    },
    'c6t2in4b': {
      'en': 'Due: Nov 18, 2024',
      'ar': '',
    },
    'l3lzqv55': {
      'en': 'View Details',
      'ar': '',
    },
    'vvke9ojx': {
      'en': 'Lab 3: Web Development Basics',
      'ar': '',
    },
    '2fiswqx3': {
      'en': 'Create a simple website using HTML, CSS, and JavaScript.',
      'ar': '',
    },
    '0s122gdc': {
      'en': 'Due: Nov 20, 2023',
      'ar': '',
    },
    '17cqycvk': {
      'en': 'View Details',
      'ar': '',
    },
    'w83qzhf8': {
      'en': 'Lab 3: Web Development Basics',
      'ar': '',
    },
    'ly8sudnu': {
      'en': 'Create a simple website using HTML, CSS, and JavaScript.',
      'ar': '',
    },
    'bna9pgfc': {
      'en': 'Due: Nov 20, 2023',
      'ar': '',
    },
    '0molc7ln': {
      'en': 'View Details',
      'ar': '',
    },
    '8z0g9ued': {
      'en': 'Dashboard',
      'ar': 'لوحة القيادة',
    },
    'y5tch15y': {
      'en': 'Profile',
      'ar': 'حساب تعريفي',
    },
    'awvwmtzt': {
      'en': 'Home',
      'ar': '',
    },
  },
  // teacher_course_assignments
  {
    '1ktf45ah': {
      'en': 'Web Development Fundamentals',
      'ar': '',
    },
    'tnh72m6z': {
      'en': 'Assignments',
      'ar': '',
    },
    'bantdaxk': {
      'en': 'Add Practical Work',
      'ar': '',
    },
    'l2g3svdw': {
      'en': 'PW Title',
      'ar': '',
    },
    'gbvue9ho': {
      'en': 'Objectives',
      'ar': '',
    },
    'l1a6m04d': {
      'en': 'Steps',
      'ar': '',
    },
    'r74aczd8': {
      'en': 'Attach Files',
      'ar': '',
    },
    'oiqdzhuf': {
      'en': 'Publish',
      'ar': '',
    },
    '74irnj7b': {
      'en': 'Published Assignments',
      'ar': '',
    },
    '3i1mg7bv': {
      'en': 'Lab 1: Introduction to Python',
      'ar': '',
    },
    'u7qftv5n': {
      'en':
          'Learn the basics of Python programming through hands-on exercises.',
      'ar': '',
    },
    'mnggu0z6': {
      'en': 'Lab 2: Data Structures in C++',
      'ar': '',
    },
    's7jqfb97': {
      'en': 'Implement and analyze various data structures using C++.',
      'ar': '',
    },
    '1wc385jz': {
      'en': 'Lab 3: Web Development Basics',
      'ar': '',
    },
    'fq15o8ug': {
      'en': 'Create a simple website using HTML, CSS, and JavaScript.',
      'ar': '',
    },
    'uftiolsk': {
      'en': 'Dashboard',
      'ar': '',
    },
    '2rhdie84': {
      'en': 'Profile',
      'ar': '',
    },
    '1lky2r8i': {
      'en': 'Home',
      'ar': '',
    },
  },
  // teacher_assignment_view
  {
    'v8airum1': {
      'en': 'John Doe',
      'ar': '',
    },
    '18w21i53': {
      'en': 'Intro to Programming PW1',
      'ar': '',
    },
    't2uj8wqw': {
      'en': 'Student Solution',
      'ar': '',
    },
    'wqn5w6mq': {
      'en': 'Solution',
      'ar': '',
    },
    'o5kd1nrc': {
      'en':
          'My code shows how inheritance works in Python.\n\n1. There is a base class called `Animal` with a method `speak()` that returns `\"Some generic sound\"`.\n2. Then there is a subclass `Dog` that inherits from `Animal`.\n3. `Dog` has its own `speak()` method, which overrides the `speak()` method of `Animal`.\n4. Instead of `\"Some generic sound\"`, `Dog`’s `speak()` method returns `\"Bark\"`.\n5. This is called **method overriding**, where the subclass provides a new version of a method.\n6. If we create an object of `Dog` and call `speak()`, it will return `\"Bark\"`.\n7. This demonstrates how inheritance and overriding work in Python.',
      'ar': '',
    },
    'al8y8l4b': {
      'en': 'Attached Files:',
      'ar': '',
    },
    'y2d3q0r7': {
      'en': 'solution.pdf',
      'ar': '',
    },
    'wv7p2578': {
      'en': 'code_snippet.py',
      'ar': '',
    },
    'lbip6jlp': {
      'en': 'diagram.jpg',
      'ar': '',
    },
    'ax5uxt2s': {
      'en': 'Send Feedback',
      'ar': '',
    },
    'm6biqb3b': {
      'en': 'Feedback',
      'ar': '',
    },
    'ivs865m1': {
      'en': 'Grade Solution',
      'ar': '',
    },
    '0oraoxd4': {
      'en': 'Send',
      'ar': '',
    },
    'f1s3fkb1': {
      'en': 'Dashboard',
      'ar': '',
    },
    's5bs1itf': {
      'en': 'Profile',
      'ar': '',
    },
    '8bt4y0fa': {
      'en': 'Home',
      'ar': '',
    },
  },
  // profile
  {
    '4atrmju0': {
      'en': 'Student Profile',
      'ar': '',
    },
    'cfp9bbbi': {
      'en': 'View and manage your profile information',
      'ar': '',
    },
    '1ym6lc5d': {
      'en': 'Alex Johnson',
      'ar': '',
    },
    'lxzyvdnn': {
      'en': 'Computer Science Major',
      'ar': '',
    },
    'hmalkwm3': {
      'en': '3.8 GPA',
      'ar': '',
    },
    'xvdzpjyd': {
      'en': 'Junior Year',
      'ar': '',
    },
    'q5qgj40w': {
      'en': 'Personal Information',
      'ar': '',
    },
    '05ov92v7': {
      'en': 'Email',
      'ar': '',
    },
    'pzs0njso': {
      'en': 'alex.johnson@university.edu',
      'ar': '',
    },
    '7rkrwbrx': {
      'en': 'Student ID',
      'ar': '',
    },
    'kmf5c9rk': {
      'en': 'CS2023456',
      'ar': '',
    },
    'y6014rws': {
      'en': 'Date of Birth',
      'ar': '',
    },
    '097h891o': {
      'en': 'May 15, 2002',
      'ar': '',
    },
    'bfu2lg49': {
      'en': 'App Settings',
      'ar': '',
    },
    '15d9rs6i': {
      'en': 'Notifications',
      'ar': '',
    },
    'u4bt0qm2': {
      'en': 'Dark Mode',
      'ar': '',
    },
    'e5qjlmf7': {
      'en': 'Language',
      'ar': '',
    },
    'xczxccjt': {
      'en': 'English',
      'ar': '',
    },
    'wsqo0m26': {
      'en': 'Edit Profile',
      'ar': '',
    },
    'qgrjqnf5': {
      'en': 'Profile',
      'ar': '',
    },
  },
  // teacherprofile
  {
    'jjitezab': {
      'en': 'Teacher Profile',
      'ar': '',
    },
    'si79p4ll': {
      'en': 'View and manage your professional information',
      'ar': '',
    },
    '5is8pdki': {
      'en': 'Dr. Emily Parker',
      'ar': '',
    },
    'uio09fhl': {
      'en': 'Mathematics Professor',
      'ar': '',
    },
    'b1wc4gpn': {
      'en': '15 Years Experience',
      'ar': '',
    },
    'l2mn46mu': {
      'en': 'PhD in Mathematics',
      'ar': '',
    },
    'jy86ja6v': {
      'en': 'Professional Information',
      'ar': '',
    },
    'zns5n01k': {
      'en': 'Email',
      'ar': '',
    },
    'ydkdrr6c': {
      'en': 'emily.parker@university.edu',
      'ar': '',
    },
    'u920pe0g': {
      'en': 'Department',
      'ar': '',
    },
    'haox6jmh': {
      'en': 'Mathematics',
      'ar': '',
    },
    'ip6dh5bd': {
      'en': 'Office',
      'ar': '',
    },
    'ohjqnidj': {
      'en': 'Science Building, Room 305',
      'ar': '',
    },
    'ug2xn43g': {
      'en': 'Office Hours',
      'ar': '',
    },
    '99dzsyli': {
      'en': 'Mon, Wed: 2-4 PM',
      'ar': '',
    },
    'y5k4hdak': {
      'en': 'Courses Taught',
      'ar': '',
    },
    'il70vat3': {
      'en': 'Advanced Calculus',
      'ar': '',
    },
    'p7co1dsc': {
      'en': 'Linear Algebra',
      'ar': '',
    },
    'ufqcoiol': {
      'en': 'Number Theory',
      'ar': '',
    },
    'mqnqhonc': {
      'en': 'Profile Settings',
      'ar': '',
    },
    '3uc6oo1m': {
      'en': 'Public Profile',
      'ar': '',
    },
    'j73hbx7u': {
      'en': 'Email Notifications',
      'ar': '',
    },
    '95b1x133': {
      'en': 'Dark Mode',
      'ar': '',
    },
    'grljn5ie': {
      'en': 'Edit Profile',
      'ar': '',
    },
    'lc61n82p': {
      'en': 'Dashboard',
      'ar': '',
    },
    'g7p2v12o': {
      'en': 'Profile',
      'ar': '',
    },
    'g48guer6': {
      'en': 'Schedule',
      'ar': '',
    },
  },
  // students_timeplate
  {
    '7gx6ouny': {
      'en': 'Course Schedule',
      'ar': '',
    },
    'epq3chxh': {
      'en': 'TD & TP Sessions',
      'ar': '',
    },
    'pkz0hcw8': {
      'en': 'This Week\'s Schedule',
      'ar': '',
    },
    '6ubfjltv': {
      'en': 'Monday',
      'ar': '',
    },
    '8xut3cid': {
      'en': 'Web Development (TD)',
      'ar': '',
    },
    'vd81xu7s': {
      'en': '09:00 AM - 10:30 AM',
      'ar': '',
    },
    'rdnoeepx': {
      'en': 'Room 201',
      'ar': '',
    },
    'c439ga5c': {
      'en': 'Database Systems (TP)',
      'ar': '',
    },
    '4cgzz2d4': {
      'en': '02:00 PM - 04:00 PM',
      'ar': '',
    },
    'a3z5npeq': {
      'en': 'Lab 105',
      'ar': '',
    },
    'h3r3q2cv': {
      'en': 'Wednesday',
      'ar': '',
    },
    'c2pueofx': {
      'en': 'Data Structures (TD)',
      'ar': '',
    },
    'cg1q7fdg': {
      'en': '10:00 AM - 11:30 AM',
      'ar': '',
    },
    'nw69974z': {
      'en': 'Room 305',
      'ar': '',
    },
    '6dxz49ws': {
      'en': 'Algorithms (TP)',
      'ar': '',
    },
    '8moi7rhl': {
      'en': '03:00 PM - 05:00 PM',
      'ar': '',
    },
    '6nv390qy': {
      'en': 'Lab 202',
      'ar': '',
    },
    'trpzffnr': {
      'en': 'Friday',
      'ar': '',
    },
    'uqcrt9jr': {
      'en': 'Software Engineering (TD)',
      'ar': '',
    },
    'raaeumfr': {
      'en': '11:00 AM - 12:30 PM',
      'ar': '',
    },
    '4hum4574': {
      'en': 'Room 401',
      'ar': '',
    },
    'rocxml25': {
      'en': 'Mobile App Development (TP)',
      'ar': '',
    },
    'hhqtqo05': {
      'en': '02:30 PM - 04:30 PM',
      'ar': '',
    },
    '7qirwffc': {
      'en': 'Lab 303',
      'ar': '',
    },
    'in4e3lvv': {
      'en': 'Upcoming Assignments',
      'ar': '',
    },
    'd5ilrvp7': {
      'en': 'Web Development Project',
      'ar': '',
    },
    'uddfknzu': {
      'en': 'Due: May 15',
      'ar': '',
    },
    '0gbond1e': {
      'en': 'Database Systems Report',
      'ar': '',
    },
    '42ijnwnj': {
      'en': 'Due: May 20',
      'ar': '',
    },
    '4hwp8e3o': {
      'en': 'Algorithms Implementation',
      'ar': '',
    },
    '078hojlj': {
      'en': 'Due: May 25',
      'ar': '',
    },
    '6safwlej': {
      'en': 'Schedule',
      'ar': '',
    },
  },
  // admin
  {
    'sl4drs4n': {
      'en': 'Welcome, Admin',
      'ar': '',
    },
    'yiz9lybp': {
      'en': 'Your learning journey starts here',
      'ar': '',
    },
    'qk4ams2q': {
      'en': 'Total Students',
      'ar': '',
    },
    '0jsmoxh4': {
      'en': '1,234',
      'ar': '',
    },
    'bv9zareg': {
      'en': 'Submissions',
      'ar': '',
    },
    'gdxtxn0n': {
      'en': '5,678',
      'ar': '',
    },
    '6durrb4v': {
      'en': 'Feedback Given',
      'ar': '',
    },
    '2k9mz343': {
      'en': '3,456',
      'ar': '',
    },
    'ehmr62lv': {
      'en': 'User Management',
      'ar': '',
    },
    'j2zutll9': {
      'en': 'Search users...',
      'ar': '',
    },
    'r6thxk5x': {
      'en': 'Active',
      'ar': '',
    },
    'osawybwc': {
      'en': 'Inactive',
      'ar': '',
    },
    '1cpij5yv': {
      'en': 'Name',
      'ar': '',
    },
    'ghranu55': {
      'en': 'Email',
      'ar': '',
    },
    't52u0y34': {
      'en': 'Role',
      'ar': '',
    },
    'ftem16um': {
      'en': 'Last Login',
      'ar': '',
    },
    'pi9t6mx5': {
      'en': 'Actions',
      'ar': '',
    },
    'g909hkvf': {
      'en': 'John Doe',
      'ar': '',
    },
    '2d1wxu5y': {
      'en': 'john@example.com',
      'ar': '',
    },
    '3ujg1ecz': {
      'en': 'Student',
      'ar': '',
    },
    'rxydan3k': {
      'en': '2023-06-15',
      'ar': '',
    },
    'k1trezk3': {
      'en': 'Jane Smith',
      'ar': '',
    },
    '0f79wo7e': {
      'en': 'jane@example.com',
      'ar': '',
    },
    'y3owj2pl': {
      'en': 'Teacher',
      'ar': '',
    },
    'dghyr862': {
      'en': '2023-06-14',
      'ar': '',
    },
    'lyqrnixv': {
      'en': 'Add User',
      'ar': '',
    },
    '7b2433h8': {
      'en': 'Full Name',
      'ar': '',
    },
    'bu3yx33i': {
      'en': 'Email Address',
      'ar': '',
    },
    '851pog2g': {
      'en': 'Role',
      'ar': '',
    },
    'cw7r6b26': {
      'en': 'Administrator',
      'ar': '',
    },
    'qks7j5gw': {
      'en': 'Teacher',
      'ar': '',
    },
    'mung81yn': {
      'en': 'Student',
      'ar': '',
    },
    'urute01i': {
      'en': 'Save User',
      'ar': '',
    },
    '09xutvnb': {
      'en': 'Create Academic Module',
      'ar': '',
    },
    'p5qk5c5t': {
      'en': 'Module Details',
      'ar': '',
    },
    'ryhzu5cl': {
      'en': 'Module Name',
      'ar': '',
    },
    'q8xnzj4c': {
      'en': 'Module Description',
      'ar': '',
    },
    'riu6v3m0': {
      'en': 'Software Engineering',
      'ar': '',
    },
    'w3m0vwy7': {
      'en': 'Civil Engineering',
      'ar': '',
    },
    'w1bv46bi': {
      'en': 'Mechanical Engineering',
      'ar': '',
    },
    'rnt82tlc': {
      'en': 'Electrical Engineering',
      'ar': '',
    },
    's14qp5hd': {
      'en': 'Assign Teachers',
      'ar': '',
    },
    '5ztyd7lj': {
      'en': 'Dr. Smith',
      'ar': '',
    },
    '8e3jn7yi': {
      'en': 'Prof. Johnson',
      'ar': '',
    },
    'veio65le': {
      'en': 'Dr. Williams',
      'ar': '',
    },
    'hd9e98yn': {
      'en': 'Prof. Brown',
      'ar': '',
    },
    'e5px2ep6': {
      'en': 'Dr. Davis',
      'ar': '',
    },
    'qv8ij6hh': {
      'en': 'Student Year Assignment',
      'ar': '',
    },
    '7i6tg2f5': {
      'en': 'Year 1',
      'ar': '',
    },
    'o5i6sgws': {
      'en': 'Year 2',
      'ar': '',
    },
    '920ljnsy': {
      'en': 'Year 3',
      'ar': '',
    },
    'hl3x0kuo': {
      'en': 'Year 4',
      'ar': '',
    },
    '1fnyfk75': {
      'en': 'Class Schedule Setup',
      'ar': '',
    },
    '58wk6pde': {
      'en': 'Lecture',
      'ar': '',
    },
    'xzcapld1': {
      'en': 'Monday',
      'ar': '',
    },
    'f4ha2i1t': {
      'en': 'Tuesday',
      'ar': '',
    },
    '5mbf4mfb': {
      'en': 'Wednesday',
      'ar': '',
    },
    'or569fgz': {
      'en': 'Thursday',
      'ar': '',
    },
    'aqw5sxyt': {
      'en': 'Friday',
      'ar': '',
    },
    '4gw4kapc': {
      'en': 'Start Time',
      'ar': '',
    },
    'i90r5rpi': {
      'en': 'End Time',
      'ar': '',
    },
    'v4mutjms': {
      'en': 'Location',
      'ar': '',
    },
    'dh1svfke': {
      'en': 'Tutorial (TD)',
      'ar': '',
    },
    'e1zghw78': {
      'en': 'Monday',
      'ar': '',
    },
    'idycmgqx': {
      'en': 'Tuesday',
      'ar': '',
    },
    'yzb1czxt': {
      'en': 'Wednesday',
      'ar': '',
    },
    'mrqg3zzj': {
      'en': 'Thursday',
      'ar': '',
    },
    '0nlia8w0': {
      'en': 'Friday',
      'ar': '',
    },
    '0ngbq9gb': {
      'en': 'Start Time',
      'ar': '',
    },
    'f1lcj6ba': {
      'en': 'End Time',
      'ar': '',
    },
    'u0bvoz2d': {
      'en': 'Location',
      'ar': '',
    },
    '11ou3nz4': {
      'en': 'Practical Lab (TP)',
      'ar': '',
    },
    'li9il3x7': {
      'en': 'Monday',
      'ar': '',
    },
    'a5qv3usp': {
      'en': 'Tuesday',
      'ar': '',
    },
    'upugj9k5': {
      'en': 'Wednesday',
      'ar': '',
    },
    'bwnfoj5i': {
      'en': 'Thursday',
      'ar': '',
    },
    'm9d8v2e6': {
      'en': 'Friday',
      'ar': '',
    },
    '8s9gxz43': {
      'en': 'Start Time',
      'ar': '',
    },
    'wbj0wudy': {
      'en': 'End Time',
      'ar': '',
    },
    'rns6lo3s': {
      'en': 'Location',
      'ar': '',
    },
    'duvwwd4k': {
      'en': 'Preview',
      'ar': '',
    },
    'z6wd1qgp': {
      'en': 'Save Module',
      'ar': '',
    },
    'f4i2qwif': {
      'en': 'Home',
      'ar': '',
    },
  },
  // teachertimeplate
  {
    'mhsgv6lg': {
      'en': 'Teacher Schedule',
      'ar': '',
    },
    'cia14zg6': {
      'en': 'Courses, TD & TP Sessions',
      'ar': '',
    },
    'ltl232ss': {
      'en': 'This Week\'s Schedule',
      'ar': '',
    },
    'fpl0bxfs': {
      'en': 'Monday',
      'ar': '',
    },
    '2xd1tmml': {
      'en': 'Web Development (TD)',
      'ar': '',
    },
    'eg5rdzaa': {
      'en': '09:00 AM - 10:30 AM',
      'ar': '',
    },
    'pskz5n8n': {
      'en': 'Room 201',
      'ar': '',
    },
    'dl5lu8rg': {
      'en': 'Database Systems (TP)',
      'ar': '',
    },
    'dhtlt3c3': {
      'en': '02:00 PM - 04:00 PM',
      'ar': '',
    },
    '36av92br': {
      'en': 'Lab 105',
      'ar': '',
    },
    'ldmoap75': {
      'en': 'Wednesday',
      'ar': '',
    },
    'gsbfr2b9': {
      'en': 'Data Structures (TD)',
      'ar': '',
    },
    '1hyyqsxt': {
      'en': '10:00 AM - 11:30 AM',
      'ar': '',
    },
    'esgxg1ct': {
      'en': 'Room 305',
      'ar': '',
    },
    '9cj7y6ob': {
      'en': 'Algorithms (TP)',
      'ar': '',
    },
    'h2pjpf8n': {
      'en': '03:00 PM - 05:00 PM',
      'ar': '',
    },
    'vzr7gvh5': {
      'en': 'Lab 202',
      'ar': '',
    },
    'knecf1i1': {
      'en': 'Friday',
      'ar': '',
    },
    '6zma26xl': {
      'en': 'Software Engineering (TD)',
      'ar': '',
    },
    'lm078x9j': {
      'en': '11:00 AM - 12:30 PM',
      'ar': '',
    },
    'flpxspxx': {
      'en': 'Room 401',
      'ar': '',
    },
    'kbsbnaa7': {
      'en': 'Mobile App Development (TP)',
      'ar': '',
    },
    '3bjjlmlh': {
      'en': '02:30 PM - 04:30 PM',
      'ar': '',
    },
    'otq3drzv': {
      'en': 'Lab 303',
      'ar': '',
    },
    'zk56c0vc': {
      'en': 'Upcoming Events',
      'ar': '',
    },
    'dy2v0ks1': {
      'en': 'Department Meeting',
      'ar': '',
    },
    'diqd4rd5': {
      'en': 'May 15, 2:00 PM',
      'ar': '',
    },
    'rd1ia0u6': {
      'en': 'Exam Supervision',
      'ar': '',
    },
    'k8p9oskx': {
      'en': 'May 20, 9:00 AM',
      'ar': '',
    },
    '21rco05b': {
      'en': 'Research Presentation',
      'ar': '',
    },
    '4obsanr7': {
      'en': 'May 25, 3:00 PM',
      'ar': '',
    },
  },
  // signin
  {
    'g6tqq6v7': {
      'en': 'A Learning',
      'ar': '',
    },
    '7a7yxfhb': {
      'en': 'Welcome Back',
      'ar': '',
    },
    'q1npcc7i': {
      'en': 'Sign in to continue',
      'ar': '',
    },
    'o96lx0lg': {
      'en': 'A learning',
      'ar': '',
    },
    '1ni2dhme': {
      'en': 'Sign In',
      'ar': '',
    },
    '8fzblobf': {
      'en': 'Let\'s get started by filling out the form below.',
      'ar': '',
    },
    'fme1ipbn': {
      'en': 'Email',
      'ar': '',
    },
    'cws2e3td': {
      'en': 'Password',
      'ar': '',
    },
    'aekyhwtj': {
      'en': 'Sign In',
      'ar': '',
    },
    'mt3qfwdz': {
      'en': 'Forgot Password',
      'ar': '',
    },
    '9h1njvyr': {
      'en': 'Sign Up',
      'ar': '',
    },
    'napjibv0': {
      'en': 'Let\'s get started by filling out the form below.',
      'ar': '',
    },
    'rd2eqai2': {
      'en': 'Email',
      'ar': '',
    },
    'zhufscxp': {
      'en': 'Password',
      'ar': '',
    },
    '14jcn64i': {
      'en': 'Confirm Password',
      'ar': '',
    },
    'spd2iemm': {
      'en': 'Create Account',
      'ar': '',
    },
    '7gkybkee': {
      'en': 'Home',
      'ar': '',
    },
  },
  // ref
  {
    'odtqioaa': {
      'en': 'Assignment: Advanced Calculus',
      'ar': '',
    },
    'yfde9i53': {
      'en': 'Due: May 15, 2023',
      'ar': '',
    },
    'egurmylc': {
      'en': 'Calculus_Assignment_3.pdf',
      'ar': '',
    },
    'sxcg3yja': {
      'en': '2.3 MB',
      'ar': '',
    },
    '68cxj3q1': {
      'en': 'Download',
      'ar': '',
    },
    'n53ar7te': {
      'en': 'Helpful Resources:',
      'ar': '',
    },
    'euiw7zu8': {
      'en': 'Video Tutorial: Solving Complex Integrals',
      'ar': '',
    },
    'hzn97wgo': {
      'en': 'YouTube - MathMaster101',
      'ar': '',
    },
    'v9d665g8': {
      'en': 'Textbook: Calculus - Early Transcendentals',
      'ar': '',
    },
    'axhopgjp': {
      'en': 'Chapter 7, Pages 342-350',
      'ar': '',
    },
  },
  // students_solution
  {
    'f3clleir': {
      'en': 'Student Solution',
      'ar': '',
    },
    '88fwx0rx': {
      'en': 'Solution Text:',
      'ar': '',
    },
    'k9se2jbr': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam in velit vel augue bibendum fringilla. Sed euismod, nunc sit amet aliquam lacinia, nisl nisl aliquam nisl, nec aliquam nisl nisl sit amet nisl.',
      'ar': '',
    },
    '22m4h5u0': {
      'en': 'Attached Files:',
      'ar': '',
    },
    'vxf5jssb': {
      'en': 'solution.pdf',
      'ar': '',
    },
    'odetnshl': {
      'en': 'code_snippet.py',
      'ar': '',
    },
    '2enonz3k': {
      'en': 'diagram.jpg',
      'ar': '',
    },
    'sobawsqt': {
      'en': 'Download All',
      'ar': '',
    },
    '4f2v5vv1': {
      'en': 'Grade Solution',
      'ar': '',
    },
  },
  // teachermodifier
  {
    'gz74ay1r': {
      'en': 'My Courses',
      'ar': '',
    },
    '4ksxedjw': {
      'en': 'Add Course',
      'ar': '',
    },
    'rosvvkqp': {
      'en': 'Advanced Biology',
      'ar': '',
    },
    '4b574s5k': {
      'en': 'Grade 11 • 28 Students',
      'ar': '',
    },
    'ul9mplfs': {
      'en': 'Calculus I',
      'ar': '',
    },
    'teo29l40': {
      'en': 'Grade 12 • 22 Students',
      'ar': '',
    },
    'gbirld7p': {
      'en': 'World History',
      'ar': '',
    },
    'hmmsj0np': {
      'en': 'Grade 10 • 30 Students',
      'ar': '',
    },
  },
  // applogo
  {
    'vvbhs0q6': {
      'en': 'StudyPro',
      'ar': '',
    },
  },
  // addyear
  {
    '8tgart9h': {
      'en': 'Add Formation',
      'ar': '',
    },
    'isnow6vr': {
      'en': 'Create a new academic program',
      'ar': '',
    },
    'ecr8y10i': {
      'en': 'Formation Title',
      'ar': '',
    },
    'j2l92m0p': {
      'en': 'e.g. Computer Science',
      'ar': '',
    },
    'lvhignj2': {
      'en': 'Department',
      'ar': '',
    },
    'hjhlqjav': {
      'en': 'e.g. School of Engineering',
      'ar': '',
    },
    '21ua6zf8': {
      'en': 'Duration (Years)',
      'ar': '',
    },
    'x8uf8lqn': {
      'en': 'e.g. 4',
      'ar': '',
    },
    'abitsbnn': {
      'en': 'Description',
      'ar': '',
    },
    '9emebej9': {
      'en': 'Enter program description',
      'ar': '',
    },
    'o64jqdzv': {
      'en': 'Requirements',
      'ar': '',
    },
    '0azfe5zy': {
      'en': 'Enter admission requirements',
      'ar': '',
    },
    'b43uhcol': {
      'en': 'Create Formation',
      'ar': '',
    },
  },
  // addm
  {
    'ehdvjw0s': {
      'en': 'Computer Science',
      'ar': '',
    },
    'lxvhxdzu': {
      'en': 'Bachelor of Science',
      'ar': '',
    },
    'dtlxy80e': {
      'en': 'Year 2',
      'ar': '',
    },
    'pnwio4ia': {
      'en': 'Current Modules',
      'ar': '',
    },
    'nmyt4kgk': {
      'en': 'Credits',
      'ar': '',
    },
    'u0zxnzix': {
      'en': 'Advanced Programming',
      'ar': '',
    },
    'fmc9yr7u': {
      'en': '20',
      'ar': '',
    },
    'yocphfg2': {
      'en': 'Database Systems',
      'ar': '',
    },
    'vnlvpqwv': {
      'en': '20',
      'ar': '',
    },
    'rh8gfmax': {
      'en': 'Web Development',
      'ar': '',
    },
    'fod4nh9l': {
      'en': '20',
      'ar': '',
    },
    'pfkn4zf5': {
      'en': 'Software Engineering',
      'ar': '',
    },
    'lwj7ibwu': {
      'en': '20',
      'ar': '',
    },
    'rvtizx35': {
      'en': 'Total Credits',
      'ar': '',
    },
    'v3hja7xo': {
      'en': '80/120',
      'ar': '',
    },
  },
  // preview
  {
    'iv0tx6lf': {
      'en': 'Bachelor in Digital Innovation',
      'ar': '',
    },
    '4pw4vm2b': {
      'en': 'Specialty: Extended Reality Development',
      'ar': '',
    },
    'qb0d0ddv': {
      'en': 'Program Overview',
      'ar': '',
    },
    'mw2yapp4': {
      'en':
          'This cutting-edge program combines creative design with advanced technology, focusing on developing immersive experiences through Virtual Reality (VR), Augmented Reality (AR), and Mixed Reality (MR) applications.',
      'ar': '',
    },
    '808mjnmm': {
      'en': 'Key Features',
      'ar': '',
    },
    'crhnyi8u': {
      'en': 'Prerequisites',
      'ar': '',
    },
    '489avm0u': {
      'en':
          'Completion of fundamental programming courses and basic 3D modeling experience',
      'ar': '',
    },
    '7qnq1dbu': {
      'en': 'Core Technologies',
      'ar': '',
    },
    'j8fe1o98': {
      'en': 'Unity, Unreal Engine, WebXR, ARCore, and ARKit',
      'ar': '',
    },
    '8sxd9l9k': {
      'en': 'Industry Partners',
      'ar': '',
    },
    '5fvthp4m': {
      'en': 'Meta, Microsoft, Unity Technologies, and local tech startups',
      'ar': '',
    },
    'x6klbt7a': {
      'en': 'Career Opportunities',
      'ar': '',
    },
    '07h04stu': {
      'en':
          '• XR Development Engineer\n• Immersive Experience Designer\n• Technical Artist\n• AR/VR Solutions Architect\n• Metaverse Developer',
      'ar': '',
    },
    'wmmwck3e': {
      'en': 'Download Curriculum',
      'ar': '',
    },
    'xpiduk9z': {
      'en': 'Apply Now',
      'ar': '',
    },
  },
  // addsp
  {
    '5omjasm8': {
      'en': 'Add New Formation & Specialty',
      'ar': '',
    },
    'lzftn68w': {
      'en': '1. Formation Details',
      'ar': '',
    },
    'fzwj2hqr': {
      'en': 'Formation Title',
      'ar': '',
    },
    '9b4g8m9z': {
      'en': 'e.g., Bachelor in Computer Science',
      'ar': '',
    },
    't878ci51': {
      'en': 'Formation Code',
      'ar': '',
    },
    'q99uzu5s': {
      'en': 'e.g., CS2024',
      'ar': '',
    },
    '9vmxlbwt': {
      'en': 'Description',
      'ar': '',
    },
    'g0peel39': {
      'en': 'Provide a brief summary of the formation...',
      'ar': '',
    },
    '8chnpdzu': {
      'en': 'Academic Year',
      'ar': '',
    },
    'otom3oco': {
      'en': 'e.g., 2024-2025',
      'ar': '',
    },
    '7xbav22m': {
      'en': '2. Specialty Details',
      'ar': '',
    },
    'cfqwc3ut': {
      'en': 'Specialty Name',
      'ar': '',
    },
    'o45r54bu': {
      'en': 'e.g., Data Science, Cybersecurity',
      'ar': '',
    },
    'q9jp3c5g': {
      'en': 'Specialty Code',
      'ar': '',
    },
    'mykfa5bv': {
      'en': 'e.g., CS-DS-3Y',
      'ar': '',
    },
    'k712477e': {
      'en': 'Description',
      'ar': '',
    },
    'gg7nb9r8': {
      'en': 'Provide a summary of the specialty...',
      'ar': '',
    },
    '8m6qu0qk': {
      'en': 'Required Prerequisites',
      'ar': '',
    },
    'lxcqr1ye': {
      'en': 'List required courses and grades...',
      'ar': '',
    },
    'lszwls8n': {
      'en': '3. Curriculum Overview',
      'ar': '',
    },
    'iztczohd': {
      'en': 'Key Courses/Modules',
      'ar': '',
    },
    'nu0mdw16': {
      'en': 'List the main courses...',
      'ar': '',
    },
    '7wzd6lfi': {
      'en': 'Number of Credits',
      'ar': '',
    },
    'lcmcpdbh': {
      'en': 'Total credits for 3rd year',
      'ar': '',
    },
    'v0x4ic0j': {
      'en': '4. Additional Information',
      'ar': '',
    },
    '5v25tgfr': {
      'en': 'Available Facilities',
      'ar': '',
    },
    '7ek51r9a': {
      'en': 'List available labs and resources...',
      'ar': '',
    },
    'mdm4akin': {
      'en': 'Collaborations/Partnerships',
      'ar': '',
    },
    'bvybzki4': {
      'en': 'List affiliated organizations...',
      'ar': '',
    },
    'vvc5n08q': {
      'en': '5. Admin Actions',
      'ar': '',
    },
    'newpabt9': {
      'en': 'Approval Status',
      'ar': '',
    },
    'w92rula7': {
      'en': 'Pending',
      'ar': '',
    },
    '1yo55b6a': {
      'en': 'Approved',
      'ar': '',
    },
    '354mmbwv': {
      'en': 'Rejected',
      'ar': '',
    },
    '2g924g1q': {
      'en': 'Cancel',
      'ar': '',
    },
    'wmduyf7l': {
      'en': 'Save Changes',
      'ar': '',
    },
  },
  // Miscellaneous
  {
    'e6sp3bxe': {
      'en': '',
      'ar': '',
    },
    'vszqvywb': {
      'en': '',
      'ar': '',
    },
    'mtkxjtcq': {
      'en': '',
      'ar': '',
    },
    'pnyhmr46': {
      'en': '',
      'ar': '',
    },
    '172t961s': {
      'en': '',
      'ar': '',
    },
    'qy7x89fo': {
      'en': '',
      'ar': '',
    },
    'iqwo7tn6': {
      'en': '',
      'ar': '',
    },
    'kn3mc6os': {
      'en': '',
      'ar': '',
    },
    'ab5xdrdd': {
      'en': '',
      'ar': '',
    },
    'aqj6ushp': {
      'en': '',
      'ar': '',
    },
    '6p8rp6nr': {
      'en': '',
      'ar': '',
    },
    '4hamsqm9': {
      'en': '',
      'ar': '',
    },
    'tt11d2j0': {
      'en': '',
      'ar': '',
    },
    '45n525zs': {
      'en': '',
      'ar': '',
    },
    '39ujvf34': {
      'en': '',
      'ar': '',
    },
    '2mjz79d8': {
      'en': '',
      'ar': '',
    },
    'uwk4dnaq': {
      'en': '',
      'ar': '',
    },
    'y1tvb95t': {
      'en': '',
      'ar': '',
    },
    'td3hvwd8': {
      'en': '',
      'ar': '',
    },
    'ccg1cj4k': {
      'en': '',
      'ar': '',
    },
    'e68smgor': {
      'en': '',
      'ar': '',
    },
    '5vrlbu3b': {
      'en': '',
      'ar': '',
    },
    'spodpw8v': {
      'en': '',
      'ar': '',
    },
    'mewwfdj1': {
      'en': '',
      'ar': '',
    },
    'pfemktz5': {
      'en': '',
      'ar': '',
    },
  },
].reduce((a, b) => a..addAll(b));

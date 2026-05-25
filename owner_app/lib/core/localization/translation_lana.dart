import 'package:get/get.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      // Start Screen
      'start_desc': 'Include your store with us',
      'start_button': 'Create your store',
      'have_account': 'I already have a store',

      // Auth
      'login': 'Login',
      'welcome': 'Good to see you back!',
      'e-mail': 'Your email',
      'pass': 'password',
      'next': 'Next',
      'cancel': 'Cancel',
      'forgot_password': 'Forgot password ?',

      // Recovery password
      'recovery_title': 'Password Recovery',
      "recovery_desc":
          'Choose the method you would like us to use to send the code.',
      'email_method': 'Email',

      //forgot password
      'password_title': 'Set a new password',
      'password_desc': 'Enter a new password ',
      'new_password': 'New password',
      'confirm_password': 'Confirm Password',
      'save': 'Save',

      // User Info
      'create_account': 'Create Account',
      'username': 'Enter your full name',
      'personal_phone': 'Enter your personal phone',
      'email': 'Enter your email address',
      'password': 'Enter your password',
      'link': 'Enter your social media account link',
      'id': 'Upload a photo of your personal ID',
      'image_source': 'Select Image Source',
      'choose_image': 'Choose Image',
      'camera': 'Camera',
      'gallery': 'Gallery',

      // Store Info
      'create_store': 'Create Store',
      'cover_store': 'Add your store cover image',
      'logo_store': 'Add your store logo',
      'category': 'Category',
      'name_store': 'Store Name',
      'number_store': 'Store Phone Number',
      'desc_store': 'Description',
      'continue': 'Continue',

      // Request Status
      'pending': 'Pending',
      'request_store':
          'Your request is currently under review by the management.',

      // General
      'done': 'Done',
      'hello_title': 'Hello!',
      'activation_code': 'Enter your activation code',
      'welcome_back': 'Welcome back!',
      'verification_code': 'Enter your verification code',
      'error': 'Error',
      'full_code': 'Please enter the full code',
      'send_again': 'Send Again',
      'max_attempts':
          'You have reached the maximum number of attempts.\nPlease try again later.',
      'okay': 'Okay',
      'start': 'Start',

      //delivery price
      "delivery_prices_desc": "Add your store's delivery prices",
      "SYP":"0SYP",
      "confirm": "Confirm",
      "update": "Update",
      "area_1":
          "Al-Shaghour, Bab Musalla, Al-Midan, Al-Sina'a, Al-Zahra, Dawar Al-Batikhah",
      "area_2":
          "Bab al-Jabiyah, al-Hamidiyah, Bab Touma, al-Qassaa, Bab Sharqi",
      "area_3": "Abbasids, Trade, Adawi, Rukn al-Din, Barza",
      "area_4":
          "Baramkeh, Al-Halbouni, Al-Thawra Street, Al-Hurriya Bridge, Governorate Square",
      "area_5": "Al-Mazzeh, Kafr Souseh, Umayyad Square",
      "area_6":
          "Al-Hamra, Al-Jisr Al-Abyad, Abu Rummaneh, Al-Malki, Al-Shaalan, Al-Muhajireen",
      "area_7":
          "Babila, Yalda, Airport Road, Sayyida Zeinab, Jaramana, Beit Sahm",
      "area_8": "Damar Project, Qudsaya Suburb, Qudsaya, Damar City",
      "area_9": "Jdayda Artouz, Qatana, Sahnaya",
      "area_10": "Eastern Ghouta",

      // Settings
      'settings': 'Settings',
      'personal': 'Personal Information',
      'account': 'Account',
      'price_delivery': 'Your delivery prices',
      'languages': 'Language',
      'english': 'English',
      'arabic': 'Arabic',
      'theme': 'Change Theme',

      // Logout
      'log_out': 'Log Out',
      'dialog_logout': 'You are about to log out of your account',

      // Delete Account
      'delete_account': 'Delete Account',
      'dialog_delete': 'You are about to delete your account',
      'desc_delete': 'You won\'t be able to restore your data',
      'delete': 'Delete',
    },

    'ar': {
      // Start Screen
      'start_desc': 'أضف متجرك معنا',
      'start_button': 'أنشئ متجرك',
      'have_account': 'لدي متجر بالفعل',

      // Auth
      'login': 'تسجيل الدخول',
      'welcome': 'سعيد برؤيتك مجدداً!',
      'e-mail': 'بريدك الالكتروني',
      'pass': 'كلمة المرور ',
      'next': 'التالي',
      'cancel': 'إلغاء',
      'forgot_password': 'هل نسيت كلمة السر؟',

      // Recovery password
      'recovery_title': 'استعادة كلمة المرور',
      'recovery_desc': 'اختر الطريقة التي تود أن نستخدمها لإرسال الرمز.',
      'email_method': 'البريد الإلكتروني',

      // forgot password
      'password_title': 'تعيين كلمة مرور جديدة',
      'password_desc': 'أدخل كلمة مرور جديدة',
      'new_password': 'كلمة المرور الجديدة',
      'confirm_password': 'تأكيد كلمة المرور',
      'save': 'حفظ',

      // User Info
      'create_account': 'إنشاء حساب',
      'username': 'أدخل اسمك الكامل',
      'personal_phone': 'أدخل رقم هاتفك الشخصي',
      'email': 'أدخل عنوان بريدك الإلكتروني',
      'password': 'أدخل كلمة المرور',
      'link': 'أدخل رابط حسابك على وسائل التواصل',
      'id': 'أضف صورة عن هويتك الشخصية',
      'image_source': 'اختر مصدر الصورة',
      'choose_image': 'اختر صورة',
      'camera': 'الكاميرا',
      'gallery': 'المعرض',

      // Store Info
      'create_store': 'إنشاء متجر',
      'cover_store': 'أضف صورة غلاف المتجر',
      'logo_store': 'أضف شعار المتجر',
      'category': 'التصنيف',
      'name_store': 'اسم المتجر',
      'number_store': 'رقم هاتف المتجر',
      'desc_store': 'الوصف',
      'continue': 'متابعة',

      // Request Status
      'pending': 'قيد المراجعة',
      'request_store': 'طلبك قيد المراجعة حالياً من قبل الإدارة.',

      // General
      'done': 'تم',
      'hello_title': 'مـرحـبـاً!',
      'activation_code': 'أدخل رمز التفعيل',
      'welcome_back': 'أهلاً بعودتك!',
      'verification_code': 'أدخل رمز التحقق',
      'error': 'خطأ',
      'full_code': 'يرجى إدخال الرمز كاملاً',
      'send_again': 'إعادة الإرسال',
      'max_attempts':
          'لقد تجاوزت الحد الأقصى للمحاولات.\nيرجى المحاولة لاحقاً.',
      'okay': 'حسناً',
      'start': 'ابدأ',

      //delivery price
      "delivery_prices_desc": "أضف أسعار التوصيل الخاصة بمتجرك .",
      "SYP":'0ل.س',
      "confirm": "تأكيد",
      "update": "تحديث",
      "area_1": "الشاغور، باب مصلى، الميدان، الصناعة، الزاهرة، دوار البطيخة",
      "area_2": "باب الجابية، الحميدية، باب توما، القصاع، باب شرقي",
      "area_3": "العباسيين، التجارة، العدوي، ركن الدين، برزة",
      "area_4": "البرامكة، الحلبوني، شارع الثورة، جسر الحرية، ساحة المحافظة",
      "area_5": "المزة، كفرسوسة، ساحة الأمويين",
      "area_6": "الحمراء، الجسر الأبيض، أبو رمانة، المالكي، الشعلان، المهاجرين",
      "area_7": "ببيلا، يلدا، طريق المطار، السيدة زينب، جرمانا، بيت سحم",
      "area_8": "مشروع دمر، ضاحية قدسيا، قدسيا، مدينة دمر",
      "area_9": "جديدة عرطوز، قطنا، صحنايا",
      "area_10": "الغوطة الشرقية",

      // Settings
      'settings': 'الإعدادات',
      'personal': 'المعلومات الشخصية',
      'account': 'الحساب',
      'price_delivery': 'أسعار التوصيل الخاصة بك ',
      'languages': 'اللغة',
      'english': 'الإنجليزية',
      'arabic': 'العربية',
      'theme': 'تغيير المظهر',

      // Logout
      'log_out': 'تسجيل الخروج',
      'dialog_logout': 'أنت على وشك تسجيل الخروج من حسابك',

      // Delete Account
      'delete_account': 'حذف الحساب',
      'dialog_delete': 'أنت على وشك حذف حسابك',
      'desc_delete': 'لن تتمكن من استعادة بياناتك بعد الحذف',
      'delete': 'حذف',
    },
  };
}

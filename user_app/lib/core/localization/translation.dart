import 'package:get/get.dart';


class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': _englishKeys,
    'ar': _arabicKeys,
  };

  // ENGLISH
  static Map<String, String> get _englishKeys => {
    // START / SPLASH
    'start_desc': 'Shop with us at your favorite store',
    'start_button': "Let's get started",
    'start': 'Start',

    // AUTH
    'have_account': 'I already have an account',
    'login': 'Login',
    'create_account': 'Create Account',

    // Welcome
    'welcome': 'Good to see you back!',
    'welcome_back': 'Welcome back!',
    'hello_title': 'Hello!',

    // User Info
    'username': 'User name',
    'phone': 'Phone',
    'number': 'Your number',
    'e-mail': 'Your email',

    // Gender
    'male': 'Male',
    'female': 'Female',

    // Buttons
    'next': 'Next',
    'cancel': 'Cancel',
    'done': 'Done',
    'save': 'Save',
    'okay': 'Okay',
    'retry': 'Retry',
    'continue': 'Continue',
    'exit': 'Exit',

    // OTP / Verification
    'activation_code': 'Type your activation code',
    'verification_code': 'Type your verification code',
    'send_again': 'Send Again',
    'full_code': 'Enter full code',

    // Errors
    'error': 'Error',
    'success': 'Success',
    'max_attempts': 'You reached maximum attempts.\nPlease try again later.',

    // Onboarding
    'hello1': 'Welcome to our world! Your first step starts here.',
    'hello2': 'Explore a unique experience designed specifically for you.',
    'hello3':
        'Start your journey today towards better shopping and an easier life.',

    // Password
    'pass': 'Password',
    'forgot_password': 'Forgot password ?',

    // Recovery Password
    'recovery_title': 'Password Recovery',
    'recovery_desc': 'Enter your email address to send the verification code.',
    'email_method': 'Email',

    // New Password
    'password_title': 'Set a new password',
    'password_desc': 'Enter a new password',
    'new_password': 'New password',
    'confirm_password': 'Confirm Password',

    // ===================================================================
    // SETTINGS
    // ===================================================================
    'settings': 'Settings',
    'personal': 'Personal',
    'account': 'Account',

    // Join Us
    'join_us': 'Join us as a shop owner',
    'join': 'Join Request',
    'fill_form': 'Please fill out the form to submit your request',
    'open': 'Open Form',

    // Language
    'languages': 'Language',
    'english': 'English',
    'arabic': 'Arabic',

    // Theme
    'theme': 'Change theme',

    // About
    'about_us': 'About Us',
    'about': 'About Storia',
    'desc_about':
        'The first app in Syria aimed at owners of small online stores or those who only have Instagram accounts for their stores. '
        'Now you can add your store to us and you will have an online store within the application. '
        'We also provided user-friendly interfaces to enable users to order all types of clothing from these online stores in the simplest steps.\n'
        'For complaints, please contact us:',

    // Logout
    'log_out': 'Log out',
    'daialog_logout': 'You are going to logout your account',

    // Validation
    'Please enter your full name': 'Please enter your full name',
    'Please enter your phone number': 'Please enter your phone number',
    'phone_required': 'Phone number is required',
    'phone_numbers_only': 'Phone must contain numbers only',
    'phone_length': 'Phone number must be 10 digits',
    'Please enter your email': 'Please enter your email',
    'Please enter a valid email': 'Please enter a valid email',
    'Please enter a password': 'Please enter a password',
    'Password must be at least 6 characters':
        'Password must be at least 6 characters',
    'Account created successfully! Please verify your email.':
        'Account created successfully! Please verify your email.',
    'Registration failed': 'Registration failed',
    'An error occurred. Please try again.':
        'An error occurred. Please try again.',
    'Verification successful!': 'Verification successful!',
    'Invalid OTP. Please try again.': 'Invalid OTP. Please try again.',
    'OTP sent successfully!': 'OTP sent successfully!',
    'Failed to resend OTP.': 'Failed to resend OTP.',

    // Loading
    'loading': 'Loading...',

    // Session
    'session_expired': 'Session Expired',
    'session_expired_message': 'Your session has expired. Please login again.',

    // Account Blocked
    'account_blocked': 'Account Blocked',
    'account_blocked_message':
        'Your account has been blocked by the administrator. Please contact support for more information.',
    'account_deleted': 'Account Deleted',
    'account_deleted_message':
        'Your account has been deleted by the administrator.',
    'contact_support': 'For inquiries, please contact support.',

    // Form Link
    'form_link_error': 'Failed to get form link.',
    'invalid_server_response': 'Invalid server response.',
    'form_link_not_found': 'Form link not found.',
    'could_not_open_form': 'Could not open the form link.',

    // Order Notifications
    'order_accepted': '✅ Order Accepted',
    'order_accepted_message': 'Your order has been accepted',
    'order_rejected': '❌ Order Rejected',
    'order_rejected_message': 'Your order has been rejected',
    'order_on_the_way': '🚚 Order On The Way',
    'order_on_the_way_message': 'Your order is on the way',
    'order_delivered': '📦 Order Delivered',
    'order_delivered_message': 'Your order has been delivered',

    // ===================================================================
    // HOME / STORES / PRODUCTS
    // ===================================================================
    'home_title': 'STORIA',
    'all_stores': 'All Stores',
    'stores': 'Stores',
    'see_all': 'See all',
    'categories': 'Categories',
    'category_label': 'Category',
    'category': 'Category',
    'Girl': 'Girl',
    'Boy': 'Boy',
    'Men': 'Men',
    'Women': 'Women',
    'men': 'Men',
    'women': 'Women',
    'boys': 'Boys',
    'girls': 'Girls',
    'sub_category': 'Sub-Category',
    'select_category_first': 'Select a category first',
    'shorts': 'Shorts',
    'pants': 'Pants',
    'no_items': 'No items found',
    'no_stores': 'No stores found  yet',
    'search': 'Search...',
    'store_description': 'Shop with us at your favorite store',
    'High_to_Low': 'High to Low',
    'Low_to_High': 'Low to High',
    'price': 'Price',
    'Filter': 'Filter',
    'tshirt': 'T-shirt',
    'jacket': 'Jacket',
    'dress': 'Dress',
    'hoodie': 'Hoodie',
    'skirt': 'Skirt',
    'sweater': 'Sweater',
    'set': 'Set',
    'abaya': 'Abaya',
    'size': 'Size',
    'color': 'Color',
    'all': 'All',
    'clear': 'Clear',
    'apply': 'Apply',
    'description': 'Description',
    'material': 'Material',
    'select_size': 'Select Size',
    'select_color': 'Select Color',
    'quantity': 'Quantity',
    'add_to_cart': 'Add to Cart',
    'buy_now': 'Buy Now',
    'colors': 'Colors',
    'currency': 'SYP',
    'no_results': 'No results',
    'search_error': 'Search error',
    'search_empty_query': 'Please enter a search query.',
    'search_failed': 'Search failed. Please try again.',
    'search_timeout': 'Search is taking too long. Please try again.',
    'search_no_connection': 'No connection. Check your network and retry.',
    'select_variant': 'Select variant',
    'select_color_size_first': 'Please choose a color and size first.',
    'combo_unavailable': 'Unavailable combo',
    'combo_unavailable_msg':
        'This color and size combination is not available. Please pick another.',
    'cart_error': 'Cart error',
    'cart_login_required': 'Please log in to use the cart.',
    'cart_added': 'Added',
    'cart_added_msg': 'Product added to cart successfully',
    'cart_add_failed': 'Could not add to cart. Please try again.',
    'cart_check_failed': 'Could not check the cart. Please try again.',
    'cart_clear_failed': 'Could not clear the cart. Please try again.',
    'cart_no_connection': 'No connection. Check your network and retry.',
    'cart_unchanged': 'Cart unchanged',
    'cart_kept_previous': "The previous store's items were kept.",
    'cart_different_store_title': 'Different store',
    'cart_clear_confirm':
        'Adding this item will clear your cart from the previous store. Do you want to continue?',
    'leave_store_title': 'Leave store?',
    'leave_store_clears_cart':
        'Leaving this store will clear the items currently in your cart. Are you sure you want to exit?',
    'cart_empty': 'Your cart is empty',
    'report_product_title': 'Report Product',
    'report_store_title': 'Report Store',
    'report_store_menu': 'Report Store',
    'report_product_reason_1': 'Inappropriate or unethical product',
    'report_product_reason_2': 'Misleading information or images',
    'report_product_reason_3': 'Price mismatch or fraud',
    'report_store_reason_1': 'Store content is inappropriate',
    'report_store_reason_2': 'Fraud or failure to fulfill orders',
    'report_store_reason_3': 'Improper treatment',
    'report_other': 'Other (enter reason)',
    'report_enter_reason': 'Enter the reason for your report...',
    'report_submit': 'Submit Report',
    'report_invalid_title': 'Cannot submit',
    'report_invalid_msg': 'Please select a reason and enter details.',
    'report_too_long_msg': 'The reason must be 255 characters or fewer.',
    'report_submitted_title': 'Report submitted',
    'report_submitted_msg': 'Your report has been submitted successfully.',
    'favorite': 'Favorite',
    'profile_page': 'Profile',
    'card_page': 'Card',
    'sold_out': 'Sold Out',
    'top_stores':'Top Stores',
    'top_rated_products':'Top Rated Products',
    'view_the_cart':'View The Cart',

    // ===================================================================
    // CART & ORDERS (Ranim)
    // ===================================================================
    '1': 'My Cart',
    '2': 'Total',
    '3': 'Delivery',
    '4': 'Sub Total',
    '5': 'Done!',
    '6': 'Your order was edited',
    '7': 'Save Changes',
    '8': 'Are you sure you want to delete this item?',
    '9': 'Delete',
    '10': 'My Order',
    '11': 'Order',
    '12': 'order date',
    '13': 'status',
    '14': 'Cancelled',
    '15': 'cancel',
    '16': 'All',
    '17': 'Process',
    '18': 'Preparing',
    '19': 'On the way',
    '20': 'Delivered',
    '21': 'Send The Request',
    '22': 'Order Information',
    '23': 'Number',
    '24': 'Address',
    '25': 'Add your notes',
    '26': 'Thank you for your order',
    '27': 'size',
    '28': 'color',
    '29': 'Select an area of sectors',
    '30': 'price',
    '31': 'size',
    '32': 'color',
    '33': 'Quantity',
    '34': 'You cancelled this order.',
    '35': 'Order details',
    '36': 'Review',
    '37': 'Write your review',
    '38': 'Send',
    '39': 'Cancel',
    '40': 'Thank You!',
    '41': 'Your review has been submitted',
    '42': 'Evaluated',
    '43': 'Rate now',
    '44': 'Rejected',
    '45': 'Reason',
    '46': 'No reason provided',
  };

  // =========================================================================
  // ARABIC
  // =========================================================================
  static Map<String, String> get _arabicKeys => {
    // ===================================================================
    // START / SPLASH
    // ===================================================================
    'start_desc': 'تسوّق معنا في متجرك المفضل',
    'start_button': 'ابدأ الآن',
    'start': 'ابدأ',

    // ===================================================================
    // AUTH
    // ===================================================================
    'have_account': 'لدي حساب بالفعل',
    'login': 'تسجيل الدخول',
    'create_account': 'إنشاء حساب',

    // Welcome
    'welcome': 'سعيدين بعودتك',
    'welcome_back': 'أهلاً بعودتك!',
    'hello_title': 'مرحباً!',

    // User Info
    'username': 'اسم المستخدم',
    'phone': 'رقم الهاتف',
    'number': 'رقمك',
    'e-mail': 'بريدك الإلكتروني',

    // Gender
    'male': 'ذكر',
    'female': 'أنثى',

    // Buttons
    'next': 'التالي',
    'cancel': 'إلغاء',
    'done': 'تم',
    'save': 'حفظ',
    'okay': 'حسناً',
    'retry': 'إعادة المحاولة',
    'continue': 'متابعة',
    'exit': 'خروج',

    // OTP / Verification
    'activation_code': 'أدخل رمز التفعيل',
    'verification_code': 'أدخل رمز التحقق',
    'send_again': 'إعادة الإرسال',
    'full_code': 'أدخل الكود كاملاً',

    // Errors
    'error': 'خطأ',
    'success': 'نجاح',
    'max_attempts': 'لقد تجاوزت عدد المحاولات.\nحاول لاحقاً',

    // Onboarding
    'hello1': 'أهلاً بك في عالمنا! خطوتك الأولى تبدأ من هنا.',
    'hello2': 'اكتشف تجربة فريدة مصممة خصيصاً لك.',
    'hello3': 'ابدأ رحلتك اليوم نحو تسوق أفضل وحياة أسهل.',

    // Password
    'pass': 'كلمة المرور',
    'forgot_password': 'هل نسيت كلمة السر؟',

    // Recovery Password
    'recovery_title': 'استعادة كلمة المرور',
    'recovery_desc': 'أدخل بريدك الالكتروني لإرسال رمز التحقق.',
    'email_method': 'البريد الإلكتروني',

    // New Password
    'password_title': 'تعيين كلمة مرور جديدة',
    'password_desc': 'أدخل كلمة مرور جديدة',
    'new_password': 'كلمة المرور الجديدة',
    'confirm_password': 'تأكيد كلمة المرور',

    // ===================================================================
    // SETTINGS
    // ===================================================================
    'settings': 'الإعدادات',
    'personal': 'المعلومات الشخصية',
    'account': 'الحساب',

    // Join Us
    'join_us': 'انضم إلينا كصاحب متجر',
    'join': 'طلب الانضمام',
    'fill_form': 'يرجى تعبئة النموذج لإرسال طلبك',
    'open': 'فتح النموذج',

    // Language
    'languages': 'اللغة',
    'english': 'الإنجليزية',
    'arabic': 'العربية',

    // Theme
    'theme': 'تغيير المظهر',

    // About
    'about_us': 'من نحن',
    'about': 'لمحة عن سـتـوريـا',
    'desc_about':
        'التطبيق الأول في سوريا الموجه لأصحاب المتاجر الإلكترونية الصغيرة، '
        'أو أولئك الذين يمتلكون حسابات على إنستغرام فقط لمتاجرهم. '
        'يمكنك الآن إضافة متجرك إلينا، وبذلك ستحصل على متجر إلكتروني خاص بك داخل التطبيق. '
        'كما قمنا بتوفير واجهات سهلة الاستخدام لتمكين المستخدمين من طلب كافة أنواع الملابس '
        'من هذه المتاجر الإلكترونية بأبسط الخطوات.\n'
        'في حال وجود أي شكاوى، يرجى التواصل معنا:',

    // Logout
    'log_out': 'تسجيل الخروج',
    'daialog_logout': 'أنت على وشك تسجيل الخروج من حسابك',

    // Validation
    'Please enter your full name': 'الرجاء إدخال الاسم الكامل',
    'Please enter your phone number': 'الرجاء إدخال رقم الهاتف',
    'phone_required': 'رقم الهاتف مطلوب',
    'phone_numbers_only': 'يجب أن يحتوي رقم الهاتف على أرقام فقط',
    'phone_length': 'رقم الهاتف يجب أن يكون 10 أرقام',
    'Please enter your email': 'الرجاء إدخال البريد الإلكتروني',
    'Please enter a valid email': 'الرجاء إدخال بريد إلكتروني صحيح',
    'Please enter a password': 'الرجاء إدخال كلمة المرور',
    'Password must be at least 6 characters':
        'كلمة المرور يجب أن تكون 6 محارف على الأقل',
    'Account created successfully! Please verify your email.':
        'تم إنشاء الحساب بنجاح! يرجى التحقق من بريدك الإلكتروني.',
    'Registration failed': 'فشل التسجيل',
    'An error occurred. Please try again.': 'حدث خطأ. يرجى المحاولة مرة أخرى.',
    'Verification successful!': 'تم التحقق بنجاح!',
    'Invalid OTP. Please try again.':
        'رمز التحقق غير صحيح. يرجى المحاولة مرة أخرى.',
    'OTP sent successfully!': 'تم إرسال رمز التحقق بنجاح!',
    'Failed to resend OTP.': 'فشل إعادة إرسال رمز التحقق.',

    // Loading
    'loading': 'جاري التحميل...',

    // Session
    'session_expired': 'انتهت الجلسة',
    'session_expired_message':
        'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى.',

    // Account Blocked
    'account_blocked': 'الحساب محظور',
    'account_blocked_message':
        'تم حظر حسابك من قبل الإدارة. يرجى التواصل مع الدعم للمزيد من المعلومات.',
    'account_deleted': 'الحساب محذوف',
    'account_deleted_message': 'تم حذف حسابك من قبل الإدارة.',
    'contact_support': 'للاستفسار، يرجى التواصل مع الدعم.',

    // Form Link
    'form_link_error': 'فشل في الحصول على رابط النموذج.',
    'invalid_server_response': 'استجابة خادم غير صالحة.',
    'form_link_not_found': 'رابط النموذج غير موجود.',
    'could_not_open_form': 'تعذر فتح رابط النموذج.',

    // Order Notifications
    'order_accepted': '✅ تم قبول الطلب',
    'order_accepted_message': 'تم قبول طلبك',
    'order_rejected': '❌ تم رفض الطلب',
    'order_rejected_message': 'تم رفض طلبك',
    'order_on_the_way': '🚚 الطلب في الطريق',
    'order_on_the_way_message': 'طلبك في الطريق إليك',
    'order_delivered': '📦 تم توصيل الطلب',
    'order_delivered_message': 'تم توصيل طلبك بنجاح',

    // ===================================================================
    // HOME / STORES / PRODUCTS
    // ===================================================================
    'home_title': 'ستوريا',
    'all_stores': ' جميع المتاجر',
    'stores': 'المتاجر',
    'see_all': 'عرض الجميع',
    'categories': 'الأقسام',
    'category_label': 'القسم',
    'category': 'الصنف',
    'Girl': 'فتاة',
    'Boy': 'ولد',
    'Men': 'رجالي',
    'Women': 'نسائي',
    'men': 'رجالي',
    'women': 'نسائي',
    'boys': 'أولاد',
    'girls': 'بنات',
    'sub_category': 'الفئة الفرعية',
    'select_category_first': 'اختر فئة أولاً',
    'shorts': 'شورت',
    'pants': 'بنطال',
    'no_items': 'لم يتم العثور على عناصر',
    'no_stores': 'لم يتم العثور على متاجر حالياً',
    'search': 'بحث...',
    'store_description': 'تسوق معنا في متجرك المفضل',
    'High_to_Low': 'من الأعلى إلى الأدنى',
    'Low_to_High': 'من الأدنى إلى الأعلى',
    'price': 'السعر',
    'Filter': 'تصفية',
    'tshirt': 'قميص',
    'jacket': 'جاكيت',
    'dress': 'فستان',
    'hoodie': 'هودي',
    'skirt': 'تنورة',
    'sweater': 'كنزة',
    'set': 'طقم',
    'abaya': 'عباية',
    'size': 'المقاس',
    'color': 'اللون',
    'all': 'الكل',
    'clear': 'مسح',
    'apply': 'تطبيق',
    'description': 'الوصف',
    'material': 'الخامة',
    'select_size': 'اختر المقاس',
    'select_color': 'اختر اللون',
    'quantity': 'الكمية',
    'add_to_cart': 'أضف إلى السلة',
    'buy_now': 'شراء الآن',
    'colors': 'ألوان',
    'currency': 'ل.س',
    'no_results': 'لا توجد نتائج',
    'search_error': 'خطأ في البحث',
    'search_empty_query': 'يرجى إدخال نص للبحث.',
    'search_failed': 'فشل البحث. يرجى المحاولة مرة أخرى.',
    'search_timeout': 'البحث يستغرق وقتاً طويلاً. يرجى المحاولة مرة أخرى.',
    'search_no_connection': 'لا يوجد اتصال. تحقق من الشبكة وأعد المحاولة.',
    'select_variant': 'اختر النوع',
    'select_color_size_first': 'يرجى اختيار لون ومقاس أولاً.',
    'combo_unavailable': 'مزيج غير متوفر',
    'combo_unavailable_msg':
        'هذا المزيج من اللون والمقاس غير متوفر. يرجى اختيار غيره.',
    'cart_error': 'خطأ في السلة',
    'cart_login_required': 'يرجى تسجيل الدخول لاستخدام السلة.',
    'cart_added': 'تمت الإضافة',
    'cart_added_msg': 'تمت إضافة المنتج إلى السلة بنجاح',
    'cart_add_failed': 'تعذّرت الإضافة إلى السلة. يرجى المحاولة مرة أخرى.',
    'cart_check_failed': 'تعذّر التحقق من السلة. يرجى المحاولة مرة أخرى.',
    'cart_clear_failed': 'تعذّر تفريغ السلة. يرجى المحاولة مرة أخرى.',
    'cart_no_connection': 'لا يوجد اتصال. تحقق من الشبكة وأعد المحاولة.',
    'cart_unchanged': 'السلة دون تغيير',
    'cart_kept_previous': 'تم الاحتفاظ بمنتجات المتجر السابق.',
    'cart_different_store_title': 'متجر مختلف',
    'cart_clear_confirm':
        'إضافة هذا المنتج ستفرّغ سلتك من المتجر السابق. هل تريد المتابعة؟',
    'leave_store_title': 'مغادرة المتجر؟',
    'leave_store_clears_cart':
        'مغادرة هذا المتجر ستفرّغ المنتجات الموجودة حالياً في سلتك. هل أنت متأكد من الخروج؟',
    'cart_empty': 'سلتك فارغة',
    'report_product_title': 'الإبلاغ عن منتج',
    'report_store_title': 'الإبلاغ عن المتجر',
    'report_store_menu': 'الإبلاغ عن المتجر',
    'report_product_reason_1': 'منتج مخالف أو غير أخلاقي',
    'report_product_reason_2': 'معلومات أو صور مضللة',
    'report_product_reason_3': 'سعر غير مطابق أو احتيال',
    'report_store_reason_1': 'محتوى المتجر مخالف',
    'report_store_reason_2': 'احتيال أو عدم التزام بالطلبات',
    'report_store_reason_3': 'معاملة غير لائقة',
    'report_other': 'سبب آخر (أدخل السبب)',
    'report_enter_reason': 'أدخل سبب الإبلاغ هنا...',
    'report_submit': 'إرسال البلاغ',
    'report_invalid_title': 'تعذّر الإرسال',
    'report_invalid_msg': 'يرجى اختيار سبب وإدخال التفاصيل.',
    'report_too_long_msg': 'يجب ألا يتجاوز السبب 255 حرفاً.',
    'report_submitted_title': 'تم إرسال البلاغ',
    'report_submitted_msg': 'تم إرسال بلاغك بنجاح.',
    'favorite': 'المفضلة',
    'profile_page': 'الملف الشخصي',
    'card_page': 'السلة',
    'sold_out': 'غير متوفر',
    'top_stores':'أفضل المتاجر',
    'top_rated_products':'المنتجات الأعلى تقييماً',
    'view_the_cart':'الذهاب إلى السلة',

    // ===================================================================
    // CART & ORDERS (Ranim)
    // ===================================================================ئ
    '1': 'سلتي',
    '2': 'المجموع',
    '3': 'التوصيل',
    '4': 'الحساب',
    '5': ' ارسال',
    '6': 'تم تعديل طلبك',
    '7': 'حفظ التعديلات ',
    '8': 'هل انت متاكد انك تريد حذف هذا المنتج؟',
    '9': 'حذف',
    '10': 'طلباتي',
    '11': 'الطلب',
    '12': 'تاريخ الطلب',
    '13': 'حالة الطلب',
    '14': 'تم الغاؤه',
    '15': 'الغاء',
    '16': 'الكل',
    '17': 'قيد المعالجة',
    '18': 'قيد التحضير',
    '19': 'جاري التوصيل',
    '20': 'تم التوصيل',
    '21': 'ارسال الطلب',
    '22': 'معلومات الطلب',
    '23': 'الرقم',
    '24': 'العنوان',
    '25': 'ادخل ملاحظاتك',
    '26': 'شكرا لطلبك ',
    '27': 'القياس',
    '28': 'اللون',
    '29': 'اختر منطقة من القطاعات',
    '30': 'السعر',
    '31': 'المقاس',
    '32': 'اللون',
    '33': 'الكمية',
    '34': 'انت قمت بالغاء الطلب ',
    '35': ' تفاصيل الطلب ',
    '36': 'تقييم',
    '37': 'اكتب تقييمك',
    '38': 'إرسال',
    '39': 'إلغاء',
    '40': 'شكراً لك!',
    '41': 'تم إرسال تقييمك',
    '42': 'تم التقييم',
    '43': 'قيم الآن',
    '44': 'مرفوض',
    '45': 'السبب',
    '46': 'لا يوجد سبب',
  };
}

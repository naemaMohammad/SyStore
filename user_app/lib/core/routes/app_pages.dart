import 'package:get/get.dart';
import 'package:user_app/core/binding/forgot_password_binding.dart';
import 'package:user_app/core/binding/login_binding.dart';
import 'package:user_app/core/binding/signup_binding.dart';
import 'package:user_app/core/binding/start_binding.dart';
import 'package:user_app/core/binding/verification_binding.dart';
import 'package:user_app/core/routes/app_routes.dart';
import 'package:user_app/view/screens/auth/forget_password.dart';
import 'package:user_app/view/screens/auth/login.dart';
import 'package:user_app/view/screens/auth/recovery_email.dart';
import 'package:user_app/view/screens/auth/signup.dart';
import 'package:user_app/view/screens/auth/verification.dart';
import 'package:user_app/view/screens/cart/Cart.dart';
import 'package:user_app/view/screens/home/MainLayout.dart';
import 'package:user_app/view/screens/orders/ShowOrder.dart';
import 'package:user_app/view/screens/orders/editOrder.dart';
import 'package:user_app/view/screens/orders/viewOrders.dart';
import 'package:user_app/view/screens/settings/about_us.dart';
import 'package:user_app/view/screens/settings/settings.dart';
import 'package:user_app/view/screens/start/hello.dart';
import 'package:user_app/view/screens/start/start.dart';

class AppPages {
  static final pages = [
    // =========================================================================
    // AUTH / START
    // =========================================================================
    GetPage(
      name: AppRoutes.start,
      page: () => const Start(),
      binding: StartBinding(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUp(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.verification,
      page: () {
        final args = Get.arguments;
        return CodeScreen(
          title: args?['title'] ?? 'hello_title',
          subtitle: args?['subtitle'] ?? 'activation_code',
          isRecovery: args?['isRecovery'] ?? false,
        );
      },
      binding: VerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const PasswordRecoveryScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const SetNewPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(name: AppRoutes.hello, page: () => const ImageSlider()),

    // =========================================================================
    // MAIN HOME
    // =========================================================================
    GetPage(
      name: AppRoutes.home,
      page: () => MainLayout(),
    ),

    // =========================================================================
    // SETTINGS
    // =========================================================================
    GetPage(
      name: AppRoutes.settings,
      page: () => const Settings(),
    ),
    GetPage(name: AppRoutes.aboutUs, page: () => const AboutUs()),

    // =========================================================================
    // ORDERS & CART
    // =========================================================================
    GetPage(
      name: AppRoutes.orders,
      page: () => const Myorder(),
    ),
    GetPage(
      name: AppRoutes.showOrder,
      page: () => const Showmycart(),
    ),
    GetPage(
      name: AppRoutes.editOrder,
      page: () => const Editorder(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const Order(),
    ),
  ];
}
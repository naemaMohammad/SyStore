// lib/core/routes/app_pages.dart
import 'package:get/get.dart';
import 'package:owner_app/core/binding/MainScaffoldBindng.dart';
import 'package:owner_app/core/binding/OrderdetailsBinding.dart';
import 'package:owner_app/core/binding/ReviewsBinding.dart';
import 'package:owner_app/core/binding/create_store_binding.dart';
import 'package:owner_app/core/binding/dashBinding.dart';
import 'package:owner_app/core/binding/delivery_price_binding.dart';
import 'package:owner_app/core/binding/forgot_password_binding.dart';
import 'package:owner_app/core/binding/login_binding.dart';
import 'package:owner_app/core/binding/orderBinding.dart';
import 'package:owner_app/core/binding/settings_binding.dart';
import 'package:owner_app/core/binding/signup_binding.dart';
import 'package:owner_app/core/binding/start_binding.dart';
import 'package:owner_app/core/binding/verification_binding.dart';
import 'package:owner_app/core/routes/app_routes.dart';
import 'package:owner_app/view/screen/auth/create_account.dart';
import 'package:owner_app/view/screen/auth/create_store.dart';
import 'package:owner_app/view/screen/auth/forget_password.dart';
import 'package:owner_app/view/screen/auth/login.dart';
import 'package:owner_app/view/screen/auth/recovery_email.dart';
import 'package:owner_app/view/screen/auth/verification.dart';
import 'package:owner_app/view/screen/dashbored/dashbored.dart';
import 'package:owner_app/view/screen/delivery/delivery_price.dart';
import 'package:owner_app/view/screen/order/order.dart';
import 'package:owner_app/view/screen/order/orderDetails.dart';
import 'package:owner_app/view/screen/reviews/reviews.dart';
import 'package:owner_app/view/screen/settings/settings.dart';
import 'package:owner_app/view/screen/start/start.dart';
import 'package:owner_app/view/widgets/home/main_scaffold.dart';

class AppPages {
  static final pages = [
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
      name: AppRoutes.createStore,
      page: () => const CreateStore(),
      binding: CreateStoreBinding(),
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
          isSignUp: args?['isSignUp'] ?? false,
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
    GetPage(
      name: AppRoutes.deliveryPrices,
      page: () => const DeliveryPricesScreen(isFromSettings: true),
      binding: DeliveryPriceBinding(),
    ),
    GetPage(
    name: AppRoutes.mainScaffold,
    page: () => const MainScaffold(),
    binding: MainScaffoldBinding(),
  
  ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const Settings(),
      binding: SettingsBinding(),
    ),
    
    GetPage(
      name: '/dash',
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
      GetPage(
      name: '/order',
      page: () => const OrdersView(),
      binding: OrdersBinding(),
    ),
      GetPage(
      name: '/orderdetails',
      page: () => const Orderdetails(),
      binding: Orderdetailsbinding(),
    ),
    GetPage(
      name: '/reviews',
      page: () =>const ReviewsScreen(),
      binding: Reviewsbinding(),
    ),
  ];
  
}
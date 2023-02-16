import 'package:get/get.dart';

import '../modules/about_hessa/bindings/about_hessa_binding.dart';
import '../modules/about_hessa/views/about_hessa_view.dart';
import '../modules/add_new_address/bindings/add_new_address_binding.dart';
import '../modules/add_new_address/views/add_new_address_view.dart';
import '../modules/add_new_dependent/bindings/add_new_dependent_binding.dart';
import '../modules/add_new_dependent/views/add_new_dependent_view.dart';
import '../modules/add_payment_way/bindings/add_payment_way_binding.dart';
import '../modules/add_payment_way/views/add_payment_way_view.dart';
import '../modules/addresses/bindings/addresses_binding.dart';
import '../modules/addresses/views/addresses_view.dart';
import '../modules/bottom_nav_bar/bindings/bottom_nav_bar_binding.dart';
import '../modules/bottom_nav_bar/views/bottom_nav_bar_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/connection_failed/bindings/connection_failed_binding.dart';
import '../modules/connection_failed/views/connection_failed_view.dart';
import '../modules/dependents/bindings/dependents_binding.dart';
import '../modules/dependents/views/dependents_view.dart';
import '../modules/edit_address/bindings/edit_address_binding.dart';
import '../modules/edit_address/views/edit_address_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/hessa_details/bindings/hessa_details_binding.dart';
import '../modules/hessa_details/views/hessa_details_view.dart';
import '../modules/hessa_teachers/bindings/hessa_teachers_binding.dart';
import '../modules/hessa_teachers/views/hessa_teachers_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login_or_sign_up/bindings/login_or_sign_up_binding.dart';
import '../modules/login_or_sign_up/views/login_or_sign_up_view.dart';
import '../modules/messages/bindings/messages_binding.dart';
import '../modules/messages/views/messages_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/order_hessa/bindings/order_hessa_binding.dart';
import '../modules/order_hessa/views/order_hessa_view.dart';
import '../modules/orders/bindings/orders_binding.dart';
import '../modules/orders/views/orders_view.dart';
import '../modules/preferred_teachers/bindings/preferred_teachers_binding.dart';
import '../modules/preferred_teachers/views/preferred_teachers_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile_information/bindings/profile_information_binding.dart';
import '../modules/profile_information/views/profile_information_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/static_page/bindings/static_page_binding.dart';
import '../modules/static_page/views/static_page_view.dart';
import '../modules/teacher_details/bindings/teacher_details_binding.dart';
import '../modules/teacher_details/views/teacher_details_view.dart';
import '../modules/technical_support/bindings/technical_support_binding.dart';
import '../modules/technical_support/views/technical_support_view.dart';
import '../modules/verify_account/bindings/verify_account_binding.dart';
import '../modules/verify_account/views/verify_account_view.dart';
import '../modules/verify_otp/bindings/verify_otp_binding.dart';
import '../modules/verify_otp/views/verify_otp_view.dart';
import '../modules/wallet/bindings/wallet_binding.dart';
import '../modules/wallet/views/wallet_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.LOGIN_OR_SIGN_UP,
      page: () => const LoginOrSignUpView(),
      binding: LoginOrSignUpBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.CONNECTION_FAILED,
      page: () => const ConnectionFailedView(),
      binding: ConnectionFailedBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAV_BAR,
      page: () => const BottomNavBarView(),
      binding: BottomNavBarBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.MESSAGES,
      page: () => const MessagesView(),
      binding: MessagesBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => const OrdersView(),
      binding: OrdersBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.ORDER_HESSA,
      page: () => const OrderHessaView(),
      binding: OrderHessaBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.DEPENDENTS,
      page: () => const DependentsView(),
      binding: DependentsBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.ADD_NEW_DEPENDENT,
      page: () => const AddNewDependentView(),
      binding: AddNewDependentBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.TECHNICAL_SUPPORT,
      page: () => const TechnicalSupportView(),
      binding: TechnicalSupportBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.HESSA_TEACHERS,
      page: () => const HessaTeachersView(),
      binding: HessaTeachersBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.HESSA_DETAILS,
      page: () => const HessaDetailsView(),
      binding: HessaDetailsBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.TEACHER_DETAILS,
      page: () => const TeacherDetailsView(),
      binding: TeacherDetailsBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.ABOUT_HESSA,
      page: () => const AboutHessaView(),
      binding: AboutHessaBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.WALLET,
      page: () => const WalletView(),
      binding: WalletBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.ADD_PAYMENT_WAY,
      page: () => const AddPaymentWayView(),
      binding: AddPaymentWayBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.STATIC_PAGE,
      page: () => const StaticPageView(),
      binding: StaticPageBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => const VerifyOtpView(),
      binding: VerifyOtpBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.PROFILE_INFORMATION,
      page: () => ProfileInformationView(),
      binding: ProfileInformationBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.VERIFY_ACCOUNT,
      page: () => const VerifyAccountView(),
      binding: VerifyAccountBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.PREFERRED_TEACHERS,
      page: () => const PreferredTeachersView(),
      binding: PreferredTeachersBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.ADDRESSES,
      page: () => const AddressesView(),
      binding: AddressesBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.ADD_NEW_ADDRESS,
      page: () => const AddNewAddressView(),
      binding: AddNewAddressBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.EDIT_ADDRESS,
      page: () => const EditAddressView(),
      binding: EditAddressBinding(),
    ),
  ];
}

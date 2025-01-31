import 'package:get/get.dart';

import '../modules/add_widget/bindings/add_widget_binding.dart';
import '../modules/add_widget/views/add_widget_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/paywall/bindings/paywall_binding.dart';
import '../modules/paywall/views/paywall_view.dart';
import '../modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: _Paths.ADD_WIDGET,
        page: () => const AddWidgetView(),
        binding: AddWidgetBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: _Paths.SETTINGS,
        page: () => const SettingsView(),
        binding: SettingsBinding(),
        transition: Transition.noTransition),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.PAYWALL,
      page: () => const PaywallView(),
      binding: PaywallBinding(),
    ),
  ];
}

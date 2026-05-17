import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/lana/settings_controller.dart';
import 'package:user_app/view/lana/settings/widgets/language_toggle.dart';
import 'package:user_app/view/lana/settings/widgets/settings_item.dart';
import 'package:user_app/view/lana/settings/widgets/theme_toggle.dart';

class AccountSection extends StatelessWidget {
  AccountSection({super.key});

  final controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Text(
          'account'.tr,
        ),

        SettingsListItem(
          title: 'languages'.tr,

          trailingWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => LanguageButton(
                  title: "EN",
                  isSelected:
                      Get.locale?.languageCode ==
                          'en',

                  onTap: () =>
                      controller.changeLanguage(
                    'en',
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Obx(
                () => LanguageButton(
                  title: "AR",
                  isSelected:
                      Get.locale?.languageCode ==
                          'ar',

                  onTap: () =>
                      controller.changeLanguage(
                    'ar',
                  ),
                ),
              ),
            ],
          ),
        ),

        Divider(),

        SettingsListItem(
          title: 'theme'.tr,

          trailingWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => ThemeButton(
                  icon: Icons.light_mode,

                  isSelected:
                      !controller.isDark.value,

                  onTap: () =>
                      controller.changeTheme(
                    false,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Obx(
                () => ThemeButton(
                  icon: Icons.dark_mode,

                  isSelected:
                      controller.isDark.value,

                  onTap: () =>
                      controller.changeTheme(
                    true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
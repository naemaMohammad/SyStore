import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_app/controller/home/main_layout_controller.dart';
import 'package:user_app/controller/settings/settings_controller.dart';
import 'package:user_app/view/screens/settings/about_us.dart';
import 'package:user_app/view/widgets/buttons/language_toggle.dart';
import 'package:user_app/view/widgets/buttons/theme_toggle.dart';
import 'package:user_app/view/widgets/dialogs/app_dialog.dart';
import 'package:user_app/view/widgets/settings_widgets/editable_field_card.dart';
import 'package:user_app/view/widgets/settings_widgets/settings_item.dart';


class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 66,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          onPressed: () => Get.find<MainLayoutController>().changeTab(0),
        ),

        title: Text(
          'settings'.tr,
          style: TextStyle(
            fontFamily: 'Raleway',
            fontFamilyFallback: ['Cairo'],
            fontWeight: FontWeight.w700,
            fontSize: 23,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).dividerColor.withOpacity(0.15),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(
          () => ListView(
            children: [
              const SizedBox(height: 10),
              // PERSONAL
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'personal'.tr,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Raleway',
                    fontFamilyFallback: ['Cairo'],
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              EditableFieldCard(
                icon: Icons.person,
                controller: controller.nameController,
                hint: 'username'.tr,
                onSave: () {
                  controller.updateProfile();
                },
              ),
              const SizedBox(height: 15),

              EditableFieldCard(
                icon: Icons.phone,
                controller: controller.phoneController,
                hint: 'number'.tr,
                isPhone: true,
                onSave: () {
                  controller.updateProfile();
                },
              ),
              const SizedBox(height: 15),

              // ACCOUNT
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "account".tr,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Raleway',
                    fontFamilyFallback: ['Cairo'],
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ),

              // JOIN US
              SettingsListItem(
                title: 'join_us'.tr,
                trailingWidget: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  AppDialog.show(
                    context: context,
                    title: 'join'.tr,
                    message: 'fill_form'.tr,
                    confirmText: 'open'.tr,
                    confirmColor: const Color.fromARGB(255, 109, 56, 128),
                    icon: Icons.group_add,
                    onConfirm: () {
                      controller.openFormLink();
                    },
                  );
                },
              ),
              Divider(color: Colors.grey.shade300),

              // LANGUAGE
              SettingsListItem(
                title: 'languages'.tr,
                trailingWidget: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LangButton(
                      title: "EN",
                      isSelected: Get.locale?.languageCode == 'en',
                      onTap: () {
                        final box = GetStorage();
                        box.write('lang', 'en');
                        Get.updateLocale(const Locale('en'));
                        Get.forceAppUpdate();
                      },
                    ),
                    const SizedBox(width: 8),
                    LangButton(
                      title: "AR",
                      isSelected: Get.locale?.languageCode == 'ar',
                      onTap: () {
                        final box = GetStorage();
                        box.write('lang', 'ar');
                        Get.updateLocale(const Locale('ar'));
                        Get.forceAppUpdate();
                      },
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey.shade300),

              // THEME
              SettingsListItem(
                title: 'theme'.tr,
                trailingWidget: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ThemeButton(
                      icon: Icons.light_mode,
                      isSelected: !Get.isDarkMode,
                      onTap: () {
                        final box = GetStorage();
                        box.write('theme', 'light');
                        Get.changeThemeMode(ThemeMode.light);
                        Get.forceAppUpdate();
                      },
                    ),
                    const SizedBox(width: 10),
                    ThemeButton(
                      icon: Icons.dark_mode,
                      isSelected: Get.isDarkMode,
                      onTap: () {
                        final box = GetStorage();
                        box.write('theme', 'dark');
                        Get.changeThemeMode(ThemeMode.dark);
                        Get.forceAppUpdate();
                      },
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey.shade300),

              // ABOUT US
              SettingsListItem(
                title: 'about_us'.tr,
                trailingWidget: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  Get.to(() => const AboutUs());
                },
              ),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 20),

              // LOGOUT
              controller.isLoggingOut.value
                  ? const Center(child: CircularProgressIndicator())
                  : GestureDetector(
                      onTap: () {
                        AppDialog.show(
                          context: context,
                          title: '',
                          message: 'daialog_logout'.tr,
                          confirmText: 'log_out'.tr,
                          confirmColor: Theme.of(context).colorScheme.tertiary,
                          icon: Icons.power_settings_new,
                          onConfirm: () {
                            controller.logout();
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'log_out'.tr,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'NunitoSans',
                            fontFamilyFallback: ['Tajawal'],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

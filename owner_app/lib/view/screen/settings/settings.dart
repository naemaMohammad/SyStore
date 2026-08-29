// lib/view/lana/settings/settings.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:owner_app/controller/settings/settings_controller.dart';
import 'package:owner_app/view/screen/delivery/delivery_price.dart';
import 'package:owner_app/view/widgets/buttons/language_toggle.dart';
import 'package:owner_app/view/widgets/buttons/theme_toggle.dart';
import 'package:owner_app/view/widgets/dialogs/app_dialog.dart';
import 'package:owner_app/view/widgets/settings_widgets/editable_field_card.dart';
import 'package:owner_app/view/widgets/settings_widgets/settings_item.dart';


class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SettingsController>()) {
      Get.put(SettingsController());
    }
    final controller = Get.find<SettingsController>();

    bool isDark = Get.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 66,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'settings'.tr,
          style: TextStyle(
            fontFamily: 'Raleway',
            fontFamilyFallback: ['Cairo'],
            fontWeight: FontWeight.w700,
            fontSize: 25,
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
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 10),
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
                hint: 'enter_name'.tr,
                onSave: controller.saveName,
              ),
              const SizedBox(height: 15),

              // ✅ رقم الهاتف
              EditableFieldCard(
                icon: Icons.phone,
                controller: controller.phoneController,
                hint: 'enter_phone'.tr,
                isPhone: true,
                onSave: controller.savePhone,
              ),
              const SizedBox(height: 15),

              // ✅ رابط التواصل الاجتماعي (جديد)
              EditableFieldCard(
                icon: Icons.link,
                controller: controller.socialMediaController,
                hint: 'social_media_link'.tr,
                onSave: controller.saveSocialMedia,
              ),
              const SizedBox(height: 15),

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

              // PRICE DELIVERY
              SettingsListItem(
                title: 'price_delivery'.tr,
                trailingWidget: Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  Get.to(
                    () => const DeliveryPricesScreen(isFromSettings: true),
                    transition: Transition.fade,
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
                      isSelected: !isDark,
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
                      isSelected: isDark,
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
              const SizedBox(height: 10),

              // LOGOUT
              controller.isLoggingOut.value
                  ? const Center(child: CircularProgressIndicator())
                  : GestureDetector(
                      onTap: () {
                        AppDialog.show(
                          context: context,
                          title: '',
                          message: 'dialog_logout'.tr,
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
              const SizedBox(height: 10),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 10),

              // DELETE ACCOUNT
              controller.isDeleting.value
                  ? const Center(child: CircularProgressIndicator())
                  : GestureDetector(
                      onTap: () {
                        AppDialog.show(
                          context: context,
                          title: 'dialog_delete'.tr,
                          message: 'desc_delete'.tr,
                          confirmText: 'delete'.tr,
                          confirmColor: Theme.of(context).colorScheme.tertiary,
                          icon: Icons.delete_outline,
                          onConfirm: () {
                            controller.deleteAccount();
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'delete_account'.tr,
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

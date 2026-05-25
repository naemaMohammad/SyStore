import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_app/view/lana/hello/start.dart';
import 'package:user_app/view/lana/settings/about_us.dart';
import 'package:user_app/view/lana/widgets/appBar/appbar.dart';
import 'package:user_app/view/lana/widgets/buttons/language_toggle.dart';
import 'package:user_app/view/lana/widgets/buttons/theme_toggle.dart';
import 'package:user_app/view/lana/widgets/dialogs/app_dialog.dart';
import 'package:user_app/view/lana/widgets/settings_widgets/editable_field_card.dart';
import 'package:user_app/view/lana/widgets/settings_widgets/settings_item.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController nameController = TextEditingController(
    text: "Lana abo Al-Qasab",
  );
  final TextEditingController phoneController = TextEditingController();
  bool isDark = Get.isDarkMode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SettingsAppBar(title: 'settings'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
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
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
            ),
            const SizedBox(height: 10),
            EditableFieldCard(
              icon: Icons.person,
              controller: nameController,
              hint: "Enter your name",
            ),
            const SizedBox(height: 15),
            EditableFieldCard(
              icon: Icons.phone,
              controller: phoneController,
              hint: "No phone number",
              isPhone: true,
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
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
            ),
            // JOIN US
            SettingsListItem(
              title: 'join_us'.tr,
              onTap: () {
                AppDialog.show(
                  context: context,
                  title: 'join'.tr,
                  message: 'fill_form'.tr,
                  confirmText: 'open'.tr,
                  confirmColor: const Color(0xFF613372),
                  icon: Icons.group_add,
                  onConfirm: () {},
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
                      setState(() {
                        isDark = false;
                      });
                      box.write('theme', 'light');
                      Get.changeThemeMode(ThemeMode.light);
                    },
                  ),
                  const SizedBox(width: 10),
                  ThemeButton(
                    icon: Icons.dark_mode,
                    isSelected: isDark,
                    onTap: () {
                      final box = GetStorage();
                      setState(() {
                        isDark = true;
                      });
                      box.write('theme', 'dark');
                      Get.changeThemeMode(ThemeMode.dark);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AboutUs()),
                );
              },
            ),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 20),
            // LOGOUT
            GestureDetector(
              onTap: () {
                AppDialog.show(
                  context: context,
                  title: '',
                  message: 'daialog_logout'.tr,
                  confirmText: 'log_out'.tr,
                  confirmColor: Theme.of(context).colorScheme.tertiary,
                  icon: Icons.power_settings_new,
                  onConfirm: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Start()),
                    );
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
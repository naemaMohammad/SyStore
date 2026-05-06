import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_app/view/lana/about_us.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController nameController = TextEditingController(
    text: "Lana abo Al-Qasab",
  );
  TextEditingController phoneController = TextEditingController();
  bool isEditing = false;
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 66,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          onPressed: () => Navigator.pop(context),
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
                BoxShadow(color: Colors.grey.shade300, blurRadius: 1),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
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
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  fontFamily: 'Raleway',
                  fontFamilyFallback: ['Cairo'],
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildCard(
              child: Row(
                children: [
                  _iconBox(Icons.person),
                  const SizedBox(width: 20),
                  Expanded(
                    child: isEditing
                        ? TextField(controller: nameController, autofocus: true)
                        : Text(
                            nameController.text,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                              fontFamily: 'Raleway',
                              fontFamilyFallback: ['Cairo'],
                            ),
                          ),
                  ),
                  IconButton(
                    icon: Icon(isEditing ? Icons.check : Icons.edit, size: 25),
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            _buildCard(
              child: Row(
                children: [
                  _iconBox(Icons.phone),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      phoneController.text.isEmpty
                          ? "No phone number"
                          : phoneController.text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontFamily: 'Raleway',
                        fontFamilyFallback: ['Cairo'],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
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
                  fontFamily: 'Raleway',
                  fontFamilyFallback: ['Cairo'],
                ),
              ),
            ),
            _buildListItem(
              'join_us'.tr,
              onTap: () {
                showAppDialog(
                  context: context,
                  title: 'join'.tr,
                  message: 'fill_form'.tr,
                  confirmText: 'open'.tr,
                  confirmColor: Theme.of(context).colorScheme.secondary,
                  icon: Icons.group_add,
                  onConfirm: () {
                    // Get.to(() => JoinFormPage());
                  },
                );
              },
            ),
            _divider(),
            _buildListItem(
              'languages'.tr,
              trailingWidget: Text(
                Get.locale?.languageCode == 'ar' ? "العربية" : "English",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'NunitoSans',
                  fontFamilyFallback: ['Tajawal'],
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierColor: Colors.grey.withOpacity(0.3),
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'languages'.tr,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Raleway',
                                    fontFamilyFallback: ['Cairo'],
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                _languageItem(
                                  context,
                                  title: "English",
                                  isSelected: Get.locale?.languageCode == 'en',
                                  onTap: () {
                                    final box = GetStorage();
                                    box.write('lang', 'en');
                                    Get.updateLocale(const Locale('en'));
                                    Get.forceAppUpdate();
                                    Navigator.pop(context);
                                  },
                                ),
                                const SizedBox(height: 10),
                                _languageItem(
                                  context,
                                  title: "العربية",
                                  isSelected: Get.locale?.languageCode == 'ar',
                                  onTap: () {
                                    final box = GetStorage();
                                    box.write('lang', 'ar');
                                    Get.updateLocale(const Locale('ar'));
                                    Get.forceAppUpdate();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.language,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            _divider(),
            _buildListItem(
              'theme'.tr,
              trailingWidget: Switch(
                value: isDark,
                onChanged: (value) {
                  setState(() {
                    isDark = value;
                  });
                  Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                },
              ),
            ),
            _divider(),
            _buildListItem(
              'about_us'.tr,
              trailingWidget: Icon(
                Get.locale?.languageCode == 'ar'
                    ? Icons.arrow_forward_ios
                    : Icons.arrow_forward_ios,
                size: 18,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AboutUs()),
                );
              },
            ),
            _divider(),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                showAppDialog(
                  context: context,
                  title: '',
                  message: 'daialog_logout'.tr,
                  confirmText: 'log_out'.tr,
                  confirmColor: Theme.of(context).colorScheme.tertiary,
                  icon: Icons.power_settings_new,
                  onConfirm: () {},
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
                    fontFamily: 'Raleway',
                    fontFamilyFallback: ['Cairo'],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _iconBox(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 25),
    );
  }

  Widget _buildListItem(
    String title, {
    Widget? trailingWidget,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                  ),
                ),
              ),
            ),
            if (trailingWidget != null) trailingWidget,
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(color: Colors.grey.shade300, height: 8);
  }

  void showAppDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    required VoidCallback onConfirm,
    required Color confirmColor,
    required IconData icon,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.grey.withOpacity(0.3),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$title\n$message",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontFamily: 'Raleway',
                        fontFamilyFallback: ['Cairo'],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'cancel'.tr,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.color,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'NunitoSans',
                                  fontFamilyFallback: ['Tajawal'],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              onConfirm();
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: confirmColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                confirmText,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.color,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'NunitoSans',
                                  fontFamilyFallback: ['Tajawal'],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: confirmColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.white, size: 35),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _languageItem(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.15)
              : Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.language,
              size: 20,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.bodyMedium?.color,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}

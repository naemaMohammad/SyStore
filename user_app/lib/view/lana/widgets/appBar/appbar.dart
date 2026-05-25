import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const SettingsAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
      toolbarHeight: 66,
      elevation: 0,

      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color:
              Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color,
        ),
        onPressed: () => Navigator.pop(context),
      ),

      title: Text(
        title.tr,
        style: TextStyle(
          fontFamily: 'Raleway',
          fontFamilyFallback: ['Cairo'],
          fontWeight: FontWeight.w700,
          fontSize: 23,
          color:
              Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color,
        ),
      ),

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(6),
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);
}
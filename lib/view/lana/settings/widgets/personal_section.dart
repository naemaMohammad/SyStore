import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/lana/settings_controller.dart';
import 'package:user_app/view/lana/settings/widgets/settings_card.dart';
import '../widgets/settings_icon_box.dart';

class PersonalSection extends StatelessWidget {
  PersonalSection({super.key});

  final controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'personal'.tr,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.color
                ?.withOpacity(0.7),
          ),
        ),

        const SizedBox(height: 15),

        SettingsCard(
          child: Row(
            children: [
              SettingsIconBox(
                icon: Icons.person,
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Obx(
                  () => controller.isEditing.value
                      ? TextField(
                          controller:
                              controller.nameController,
                        )
                      : Text(
                          controller
                              .nameController.text,
                        ),
                ),
              ),

              IconButton(
                icon: Obx(
                  () => Icon(
                    controller.isEditing.value
                        ? Icons.check
                        : Icons.edit,
                  ),
                ),
                onPressed:
                    controller.toggleEdit,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
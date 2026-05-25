import 'package:flutter/material.dart';
import 'package:user_app/view/lana/widgets/settings_widgets/settings_icon_box.dart';
import 'settings_card.dart';

class EditableFieldCard extends StatefulWidget {
  final IconData icon;
  final TextEditingController controller;
  final String hint;
  final bool isPhone;

  const EditableFieldCard({
    super.key,
    required this.icon,
    required this.controller,
    required this.hint,
    this.isPhone = false,
  });

  @override
  State<EditableFieldCard> createState() =>
      _EditableFieldCardState();
}

class _EditableFieldCardState
    extends State<EditableFieldCard> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Row(
        children: [
          IconBox(icon: widget.icon),

          const SizedBox(width: 20),

          Expanded(
            child: isEditing
                ? TextField(
                    controller: widget.controller,
                    autofocus: true,
                    keyboardType: widget.isPhone
                        ? TextInputType.phone
                        : TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hint,
                    ),
                  )
                : Text(
                    widget.controller.text.isEmpty
                        ? widget.hint
                        : widget.controller.text,
                  ),
          ),

          IconButton(
            icon: Icon(
              isEditing
                  ? Icons.check
                  : Icons.edit,
            ),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
    );
  }
}
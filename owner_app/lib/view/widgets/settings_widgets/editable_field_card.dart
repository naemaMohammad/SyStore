// lib/view/lana/widgets/settings_widgets/editable_field_card.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:owner_app/view/widgets/settings_widgets/settings_icon_box.dart';
import 'settings_card.dart';

class EditableFieldCard extends StatefulWidget {
  final IconData icon;
  final TextEditingController controller;
  final String hint;
  final bool isPhone;
  final VoidCallback? onSave;

  const EditableFieldCard({
    super.key,
    required this.icon,
    required this.controller,
    required this.hint,
    this.isPhone = false,
    this.onSave,
  });

  @override
  State<EditableFieldCard> createState() => _EditableFieldCardState();
}

class _EditableFieldCardState extends State<EditableFieldCard> {
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
                ? TextFormField(
                    controller: widget.controller,
                    autofocus: true,
                    keyboardType: widget.isPhone
                        ? TextInputType.phone
                        : TextInputType.text,
                    textInputAction: TextInputAction.done,
                    inputFormatters: widget.isPhone
                        ? [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ]
                        : null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hint,
                    ),
                    onFieldSubmitted: (_) {
                      _saveAndClose();
                    },
                  )
                : Text(
                    widget.controller.text.trim().isEmpty
                        ? widget.hint
                        : widget.controller.text.trim(),
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: _saveAndClose,
          ),
        ],
      ),
    );
  }

  void _saveAndClose() {
    FocusScope.of(context).unfocus();
    setState(() {
      isEditing = !isEditing;
    });
    if (!isEditing && widget.onSave != null) {
      widget.onSave!();
    }
  }
}
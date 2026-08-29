import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/core/theme/theme.dart';


Future<void> showReportBottomSheet({
  required BuildContext context,
  required String title,
  required List<String> predefinedReasons,
  required Future<bool> Function(String reason) onSubmit,
  String? otherReasonLabel,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => _ReportSheet(
      title: title,
      predefinedReasons: predefinedReasons,
      otherReasonLabel: otherReasonLabel ?? 'report_other'.tr,
      onSubmit: onSubmit,
    ),
  );
}

class _ReportSheet extends StatefulWidget {
  const _ReportSheet({
    required this.title,
    required this.predefinedReasons,
    required this.otherReasonLabel,
    required this.onSubmit,
  });

  final String title;
  final List<String> predefinedReasons;
  final String otherReasonLabel;
  final Future<bool> Function(String reason) onSubmit;

  @override
  State<_ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<_ReportSheet> {

  int? _selectedIndex;
  final TextEditingController _detailsController = TextEditingController();
  bool _submitting = false;

  int get _otherIndex => widget.predefinedReasons.length;

  bool get _isOtherSelected => _selectedIndex == _otherIndex;

  String? get _resolvedReason {
    if (_selectedIndex == null) return null;
    if (_isOtherSelected) {
      final text = _detailsController.text.trim();
      return text.isEmpty ? null : text;
    }
    return widget.predefinedReasons[_selectedIndex!];
  }

  Future<void> _submit() async {
    final reason = _resolvedReason;
    if (reason == null) {
      Get.snackbar(
        'report_invalid_title'.tr,
        'report_invalid_msg'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (reason.length > 255) {
      Get.snackbar(
        'report_invalid_title'.tr,
        'report_too_long_msg'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    setState(() => _submitting = true);
    final ok = await widget.onSubmit(reason);
    if (!mounted) return;
    setState(() => _submitting = false);
    if (ok) {
      Navigator.of(context).pop();
    }
   
  }

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.heading(),
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              ...List.generate(widget.predefinedReasons.length, (i) {
                return _reasonTile(
                  label: widget.predefinedReasons[i],
                  selected: _selectedIndex == i,
                  onTap: () => setState(() => _selectedIndex = i),
                  isDark: isDark,
                );
              }),
              _reasonTile(
                label: widget.otherReasonLabel,
                selected: _isOtherSelected,
                onTap: () => setState(() => _selectedIndex = _otherIndex),
                isDark: isDark,
              ),
              if (_isOtherSelected) ...[
                const SizedBox(height: 8),
                TextFormField(
                  controller: _detailsController,
                  maxLength: 255,
                  maxLines: 3,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'report_enter_reason'.tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _submitting
                          ? null
                          : () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(
                          color: isDark ? Colors.white24 : Colors.black26,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'cancel'.tr,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (_submitting || _resolvedReason == null)
                          ? null
                          : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF532564),
                        disabledBackgroundColor: const Color(0xFF532564)
                            .withOpacity(0.4),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _submitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'report_submit'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _reasonTile({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selected
                  ? const Color(0xFF532564)
                  : (isDark ? Colors.white38 : Colors.black38),
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

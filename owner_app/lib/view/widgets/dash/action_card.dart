import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final RxInt value;
  final IconData icon;
  final Color cardColor;
  final Color textColor;
  final Color secondaryTextColor;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.cardColor,
    required this.textColor,
    required this.secondaryTextColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        height: 88,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 11,
                        fontFamily: 'NunitoSans',
                        fontFamilyFallback: ['Tajawal'],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value.value.toString(),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

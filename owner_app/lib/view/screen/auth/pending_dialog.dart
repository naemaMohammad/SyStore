import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class PendingDialog extends StatefulWidget {
  const PendingDialog({super.key});

  @override
  State<PendingDialog> createState() => _PendingDialogState();
}

class _PendingDialogState extends State<PendingDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              // CARD
              Container(
                width: 350,
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'pending'.tr,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Raleway',
                        fontFamilyFallback: ['Cairo'],
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'request_store'.tr,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        fontFamily: 'NunitoSans',
                        fontFamilyFallback: ['Tajawal'],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // ✅ شريط تحميل متحرك يمين ويسار
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Stack(
                          children: [
                            // الخلفية
                            Container(
                              width: double.infinity,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            // الجزء المتحرك
                            Positioned(
                              left: _animation.value *
                                  (MediaQuery.of(context).size.width - 40),
                              child: Container(
                                width: 30,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              // TOP CIRCLE
              Positioned(
                top: -45,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
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
                      color: Colors.grey.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.pending,
                      color: Theme.of(context).primaryColor,
                      size: 48,
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:user_app/view/widgets/viewOrder/dialogFunctionForDelete.dart';

class Cartproductcard extends StatelessWidget {
  final String image;
  final String title;
  final int price;
  final String size;
  final String color;
  final int qty;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const Cartproductcard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.size,
    required this.color,
    required this.qty,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 8,
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: GestureDetector(
              onTap: () {
                showAppDialog(
                  context: context,
                  title: '',
                  message: '8'.tr,
                  confirmText: '9'.tr,
                  confirmColor: const Color.fromARGB(255, 229, 106, 98),
                  icon: Icons.delete,
                  onConfirm: onDelete,
                );
              },
              child: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),

          Row(
            children: [
              Image.network(
                image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image_not_supported),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                        fontFamilyFallback: ['Cairo'],
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),

                    Text(
                      "${"30".tr}: $price ${'currency'.tr}",
                      style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'NunitoSans',
                        fontFamilyFallback: ['Tajawal'],
                      ),
                    ),

                    Text(
                      "${"31".tr}: $size",
                      style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontFamilyFallback: ['Tajawal'],
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),

                    Text(
                      "${"32".tr}: $color",
                      style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontFamilyFallback: ['Tajawal'],
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),

                    Text(
                      "${"33".tr}: $qty",
                      style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontFamilyFallback: ['Tajawal'],
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: onRemove,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Theme.of(
                              context,
                            ).secondaryHeaderColor,
                            child: Icon(
                              Icons.remove,
                              size: 16,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            qty.toString(),
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontFamilyFallback: ['Tajawal'],
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: onAdd,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Theme.of(
                              context,
                            ).secondaryHeaderColor,
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

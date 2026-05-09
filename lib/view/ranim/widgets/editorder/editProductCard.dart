import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:user_app/view/ranim/widgets/myOrder/dialogFunctionForDelete.dart';

class EditProductCard extends StatelessWidget {
  final String image;
  final String title;
  final int price;
  final String size;
  final String color;
  final int qty;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const EditProductCard({
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
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: (){
                 showAppDialog(
    context: context,
    title: '',
    message: 'Are you sure you want to delete this item?',
    confirmText: 'Delete',
    confirmColor: const Color.fromARGB(255, 229, 106, 98),
    icon: Icons.delete,
    onConfirm: () {
      print('Item deleted');
    },
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
              Image.asset(image, width: 80, height: 80),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyMedium?.color,)),

                    Text("$price \$",
                        style: const TextStyle(color: Colors.green)),

                    Text(
  "size $size",
  style: TextStyle(
    color: Theme.of(context).textTheme.bodySmall?.color,
  ),
),

Text(
  "color $color",
  style: TextStyle(
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
  backgroundColor: Theme.of(context).secondaryHeaderColor,
  child: Icon(
    Icons.remove,
    size: 16,
    color: Theme.of(context).textTheme.bodyMedium?.color,
  ),
),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
  qty.toString(),
  style: TextStyle(
    color: Theme.of(context).textTheme.bodyMedium?.color,
  ),
),
                        ),

                        GestureDetector(
                          onTap: onAdd,
                          child:CircleAvatar(
  radius: 12,
  backgroundColor: Theme.of(context).secondaryHeaderColor,
  child: Icon(
    Icons.add,
    size: 16,
    color: Theme.of(context).textTheme.bodyMedium?.color,
  ),
),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
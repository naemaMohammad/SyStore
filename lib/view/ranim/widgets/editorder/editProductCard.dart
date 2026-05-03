import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
                AwesomeDialog(
                context: context,
                dialogType: DialogType.question,
                animType: AnimType.bottomSlide,
                btnCancelOnPress: () {},
                descTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                desc: 'Are you sure you want to \n delete this product ?',
                btnOkOnPress: () {},
                btnOkText: "Delete",
                btnCancelColor: Colors.black,
                btnOkColor: const Color.fromARGB(255, 83, 82, 84),
                dismissOnTouchOutside: true,
                // ignore: deprecated_member_use
                barrierColor: Colors.black.withOpacity(0.8),
              ).show();
              },
              child: const Icon(Icons.delete, color: Color.fromARGB(255, 133, 21, 13)),
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
                        style: const TextStyle(fontWeight: FontWeight.bold)),

                    Text("$price \$",
                        style: const TextStyle(color: Colors.green)),

                    Text("size $size"),
                    Text("color $color"),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        GestureDetector(
                          onTap: onRemove,
                          child: const CircleAvatar(
                            radius: 12,
                            child: Icon(Icons.remove, size: 16),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(qty.toString()),
                        ),

                        GestureDetector(
                          onTap: onAdd,
                          child: const CircleAvatar(
                            radius: 12,
                            child: Icon(Icons.add, size: 16),
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
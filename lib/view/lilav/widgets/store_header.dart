import 'package:flutter/material.dart';

class StoreHeader extends StatelessWidget {
  const StoreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark =
    Theme.of(context).brightness == Brightness.dark;
  return Stack(
    clipBehavior: Clip.none,
    children: [
      // 1. (Cover Image)
      Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/store_cover.jpg'), 
            fit: BoxFit.cover,
            
          ),
        ),
      ),
      
   // 2. back botton
      Positioned(
        top: 10,
        left: 10,
        child: CircleAvatar(
         backgroundColor: isDark
    ? Colors.black.withOpacity(0.5)
    : Colors.white.withOpacity(0.7),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: isDark
                     ? Colors.white
                        : Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    ],
  );
}
  }

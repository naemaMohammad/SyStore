// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:user_app/core/theme/color.dart';
// import 'package:user_app/core/theme/theme.dart';
// import 'package:user_app/view/lilav/widgets/AdsCarousel.dart';
// import 'package:user_app/view/lilav/widgets/search_bar.dart';

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
        
//         toolbarHeight: 40,
//         backgroundColor:AppColors.primary ,
//         centerTitle: true ,
//         title:Padding(
//         padding:EdgeInsets.only(bottom: 20),
//         child:
//          Text('STORIA',
//         style: TextStyle(color: Colors.white,
//         fontFamily: AppFonts.heading(),
//         fontSize: 27),),) ,
//         leading: Icon(Icons.circle_notifications, color: Colors.white,size: 27,),
//       ),


//       body:  Padding(
//   padding: const EdgeInsets.only(top: 18, left:40.5, right: 40.5),
//   child: Column(
//     children: [
//        MySearchBar(),
//       // SizedBox(
//       //   width: 436,
//       //   height: 36,
//       //   child: TextField(
//       //     decoration: InputDecoration(
//       //       prefixIcon: Icon(Icons.search, size: 25, color: Color(0xFFBDBDBD)),
//       //       contentPadding: EdgeInsets.symmetric(horizontal: 12),
//       //       enabledBorder: OutlineInputBorder(
//       //         borderRadius: BorderRadius.circular(100),
//       //         borderSide: BorderSide(
//       //           color: Color(0xFFBDBDBD),
//       //           width: 1,
//       //         ),
//       //       ),
//       //       focusedBorder: OutlineInputBorder(
//       //         borderRadius: BorderRadius.circular(100),
//       //         borderSide: BorderSide(
//       //           color: Color(0xFFBDBDBD),
//       //           width: 1,
//       //         ),
//       //       ),
//       //     ),
//       //   ),
       
//       // ),
//        SizedBox(height: 20),
//        // AdsCarousel(),
//     ],
//   ),
   
// ),
 
//     );
//   }
// }
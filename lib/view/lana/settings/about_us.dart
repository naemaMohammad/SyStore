import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 66,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'about_us'.tr,
          style: TextStyle(
            fontFamily: 'Raleway',
            fontFamilyFallback: ['Cairo'],
            fontWeight: FontWeight.w700,
            fontSize: 23,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 1),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('assets/images/logo.png', height: 240)),
            SizedBox(height: 20),
            Text(
              textAlign: TextAlign.start,
              'about'.tr,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,
                fontFamily: 'Raleway',
                fontFamilyFallback: ['Cairo'],
              ),
            ),
            SizedBox(height: 15),
            Text(
              'desc_about'.tr,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontFamily: 'NunitoSans',
                fontFamilyFallback: ['Tajawal'],
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {
                print("Email clicked");
              },
              borderRadius: BorderRadius.circular(10),
              child: Row(
                children: [
                  Icon(Icons.email_outlined, size: 35),
                  SizedBox(width: 15),
                  Text(
                    "company@email.com",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontFamily: 'NunitoSans',
                      fontFamilyFallback: ['Tajawal'],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                print("Phone clicked");
              },
              borderRadius: BorderRadius.circular(10),
              child: Row(
                children: [
                  Icon(Icons.phone, size: 35),
                  SizedBox(width: 15),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      "+963 999 999 999",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontFamily: 'NunitoSans',
                        fontFamilyFallback: ['Tajawal'],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

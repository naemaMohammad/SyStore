import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  final String email = 'storiacompany57@gmail.com';
  final String phone = '+963939150257';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          onPressed: () => Get.back(),
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
                BoxShadow(
                  color: Theme.of(context).dividerColor.withOpacity(0.15),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('assets/images/logo.png', height: 240)),
            const SizedBox(height: 20),
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
            const SizedBox(height: 15),
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
            const SizedBox(height: 15),
            InkWell(
              onTap: () => _launchEmail(),
              borderRadius: BorderRadius.circular(10),
              child: Row(
                children: [
                  Icon(Icons.email_outlined, size: 35),
                  const SizedBox(width: 15),
                  Text(
                    email,
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
            const SizedBox(height: 10),
            InkWell(
              onTap: () => _launchWhatsApp(),
              borderRadius: BorderRadius.circular(10),
              child: Row(
                children: [
                  Icon(Icons.phone, size: 35),
                  const SizedBox(width: 15),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      phone,
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

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Storia%20Support&body=Hello%20Storia%20Team',
    );
    try {
      print('📧 Opening email: $emailUri');
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri, mode: LaunchMode.externalApplication);
      } else {
        final String emailUrl = 'mailto:$email';
        final Uri fallbackUri = Uri.parse(emailUrl);
        print('📧 Fallback: $fallbackUri');
        if (await canLaunchUrl(fallbackUri)) {
          await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
        } else {
          Get.snackbar(
            'error'.tr,
            'Cannot open email app. Please send manually to $email'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      print('Email Error: $e');
      Get.snackbar(
        'error'.tr,
        'Cannot open email app. Please send manually to $email'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _launchWhatsApp() async {
    final String cleanPhone = phone.replaceAll('+', '');
    final Uri whatsappUri = Uri.parse('https://wa.me/$cleanPhone');

    print('📱 Opening WhatsApp: $whatsappUri');

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      final Uri phoneUri = Uri(scheme: 'tel', path: phone);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        Get.snackbar(
          'error'.tr,
          'Cannot open WhatsApp.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}

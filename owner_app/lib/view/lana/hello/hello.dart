import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:owner_app/view/lana/settings/settings.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<String> images = [
    'assets/images/hello1.jpg',
    'assets/images/hello2.jpg',
    'assets/images/hello3.jpg',
  ];

  final List<String> texts = ['hello1'.tr, 'hello2'.tr, 'hello3'.tr];

  void nextPage() {
    if (currentPage < images.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Settings()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  SizedBox.expand(
                    child: Image.asset(images[index], fit: BoxFit.cover),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 140,
                    left: 20,
                    right: 20,
                    child: Text(
                      texts[index],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'NunitoSans',
                        fontFamilyFallback: ['Tajawal'],
                        color: Color(0xFFF3F3F3),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          if (currentPage != images.length - 1)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 👈 بالنص
                children: List.generate(
                  images.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: currentPage == i ? 30 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentPage == i
                          ? Theme.of(context).primaryColor
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          if (currentPage == images.length - 1)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    nextPage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'start'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'NunitoSans',
                      fontFamilyFallback: ['Cairo'],
                      color: Color(0xFFF3F3F3),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

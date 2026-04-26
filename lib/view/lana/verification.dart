import 'package:flutter/material.dart';
import 'package:user_app/view/lana/hello.dart';

class CodeScreen extends StatefulWidget {
  const CodeScreen({super.key});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final List<TextEditingController> controllers = List.generate(
    5,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());

  void onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 4) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }
  }

  Widget buildCodeBox(int index) {
    return Container(
      width: 50,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (value) => onChanged(value, index),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          /// نفس الخلفية تبع SignUp
          Positioned.fill(
            child: Image.asset('assets/images/STORIA4.png', fit: BoxFit.cover),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 230),

                /// نفس الكارد الأبيض
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),

                        /// TITLE
                        Center(
                          child: Text(
                            "Hello, Lana !! ",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Raleway-VariableFont_wght',
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        Center(
                          child: Text(
                            "Type your code",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w300,
                              fontFamily:
                                  'NunitoSans-VariableFont_YTLC,opsz,wdth,wght',
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        /// CODE BOXES
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                            (index) => buildCodeBox(index),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              String code = controllers
                                  .map((e) => e.text)
                                  .join();
                              print(code);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ImageSlider(),
                                ),
                              );
                            },
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily:
                                    'NunitoSans-VariableFont_YTLC,opsz,wdth,wght',
                                color: Color(0xFFF3F3F3),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// SEND AGAIN
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // إعادة إرسال الكود
                            },
                            child: Text(
                              'Send Again',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                fontFamily:
                                    'NunitoSans-VariableFont_YTLC,opsz,wdth,wght',
                                color: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.color,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

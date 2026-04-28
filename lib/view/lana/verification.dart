import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_app/view/lana/hello.dart';
import 'package:user_app/view/lana/settings.dart';

class CodeScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool isSignUp;

  const CodeScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSignUp,
  });

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
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
    Future.delayed(Duration.zero, () {
      focusNodes[0].requestFocus();
    });
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
          Positioned.fill(
            child: Image.asset('assets/images/STORIA4.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: 4,
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
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Raleway-VariableFont_wght',
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.subtitle,
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
                        const SizedBox(height: 30),
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
                              if (widget.isSignUp) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ImageSlider(),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Settings(),
                                  ),
                                );
                              }
                            },
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 100,
                              vertical: 20,
                            ),
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
                        const SizedBox(height: 5),
                        TextButton(
                          onPressed: () {
                            print('send code otp again');
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

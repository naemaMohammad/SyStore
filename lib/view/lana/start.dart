import 'package:flutter/material.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/view/lana/login.dart';
import 'package:user_app/view/lana/signup.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: AppColors.b,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 130),
              Image.asset('images/Logo .png', width: 211, height: 215),
              SizedBox(height: 30),
              Text(
                'STOREIA',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Raleway-VariableFont_wght',
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Shop with us at your favorite store',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  fontFamily: 'NunitoSans-VariableFont_YTLC,opsz,wdth,wght',
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              SizedBox(height: 60),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                child: Text(
                  'Let\'s get started',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'NunitoSans-VariableFont_YTLC,opsz,wdth,wght',
                    color: Color(0xFFF3F3F3),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20),
                  Text(
                    'I already have an account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'NunitoSans-VariableFont_YTLC,opsz,wdth,wght',
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_circle_right,
                      color: AppColors.primary,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

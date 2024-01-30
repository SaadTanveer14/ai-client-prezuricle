import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/services/const_information.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/material.dart';
import '../authentication/log_in.dart';
import '../authentication/sign_up.dart';

class WelComeScreen extends StatefulWidget {
  const WelComeScreen({Key? key}) : super(key: key);

  @override
  State<WelComeScreen> createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelComeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          padding: const EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              Container(
                height: 290,
                width: 330,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(isDark ? darkWelcomeImage : welcomeImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              Text(
                'Create a free account',
                maxLines: 1,
                style: kTextStyle.copyWith(
                  color: isDark ? darkTitleColor : lightTitleColor,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Lorem ipsum dolor sit amet consectetur. nunc sit massa sagittis duis',
                maxLines: 3,
                textAlign: TextAlign.center,
                style: kTextStyle.copyWith(
                  color: isDark ? darkGreyTextColor : lightGreyTextColor,
                ),
              ),
              const SizedBox(height: 40.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: kButtonStyle,
                  onPressed: () {
                    setState(
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Create An Account',
                    style: kTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(10)
                ),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: kButtonStyle.copyWith(
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondaryContainer),
                  ),
                  onPressed: () {
                    setState(
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogIn(),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Log In',
                    style: kTextStyle.copyWith(color: isDark ? darkTitleColor : lightTitleColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:chat_gpt/screen/authentication/sign_up.dart';
import 'package:chat_gpt/screen/home/home.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;
import '../../services/repositories.dart';
import '../widgets/appbar_widgets.dart';
import 'forgot_password.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool hidePassword = true;
  bool isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 1.0,
        shadowColor: Theme.of(context).colorScheme.shadow,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: ArrowBack(isDark: isDark),
        centerTitle: true,
        title: TitleText(
          isDark: isDark,
          text: lang.S.of(context).logIn,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang.S.of(context).welcome,
                style: kTextStyle.copyWith(
                  color: isDark ? darkTitleColor : lightTitleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                'Use your credentials below and login to your account',
                style: kTextStyle.copyWith(
                  color: isDark ? darkGreyTextColor : lightGreyTextColor,
                ),
              ),
              const SizedBox(height: 40.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                cursorColor: isDark ? darkTitleColor : lightTitleColor,
                textInputAction: TextInputAction.next,
                controller: emailController,
                style: kTextStyle.copyWith(color: isDark?darkTitleColor:lightTitleColor),
                decoration: kInputDecoration.copyWith(
                  labelText: lang.S.of(context).email,
                  labelStyle: kTextStyle.copyWith(
                      color: isDark ? darkTitleColor : lightTitleColor),
                  hintText: 'Enter your email',
                  hintStyle: kTextStyle.copyWith(
                      color: isDark ? darkGreyTextColor : lightGreyTextColor),
                  focusColor: kTitleColor,
                  fillColor: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                cursorColor: kTitleColor,
                keyboardType: TextInputType.visiblePassword,
                obscureText: hidePassword,
                controller: passwordController,
                textInputAction: TextInputAction.done,
                style: kTextStyle.copyWith(color: isDark?darkTitleColor:lightTitleColor),
                decoration: kInputDecoration.copyWith(
                  border: const OutlineInputBorder(),
                  labelText: lang.S.of(context).password,
                  labelStyle: kTextStyle.copyWith(
                      color: isDark ? darkTitleColor : lightTitleColor),
                  hintText: 'Enter your password',
                  hintStyle: kTextStyle.copyWith(
                      color: isDark ? darkGreyTextColor : lightGreyTextColor),
                  fillColor: Theme.of(context).colorScheme.secondaryContainer,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                      color: isDark ? darkGreyTextColor : lightGreyTextColor,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    checkColor: Colors.white,
                    visualDensity: const VisualDensity(horizontal: -4),
                    value: isChecked,
                    onChanged: (val) {
                      setState(
                        () {
                          isChecked = val!;
                        },
                      );
                    },
                  ),
                  Text(
                    lang.S.of(context).remember,
                    style: kTextStyle.copyWith(
                      color: isDark ? darkGreyTextColor : lightGreyTextColor,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor, // Text Color
                    ),
                    child: Text(
                      lang.S.of(context).forgotPass,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: kButtonStyle,
                  onPressed: () async {
                    EasyLoading.show(status: "Signing In");
                    try {
                      await ApiService()
                          .signIn(emailController.text, passwordController.text)
                          .then((value) async {
                        Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
                          builder: (context) => const Home(),
                        ), (route) => false);
                      });
                    } catch (e) {
                      EasyLoading.showError(
                          e.toString().replaceAll("Exception:", ""));
                    }
                  },
                  child: Text(
                    lang.S.of(context).logIn,
                    style: kTextStyle.copyWith(
                        color: kWhite, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // const SizedBox(height: 40.0),
              // Center(
              //   child: Text(
              //     lang.S.of(context).or,
              //     style: kTextStyle.copyWith(
              //       color: isDark ? darkGreyTextColor : lightGreyTextColor,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //       onTap: () => Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const ForgotPassword(),
              //         ),
              //       ),
              //       child: Container(
              //         height: 40,
              //         width: 60,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(8.0),
              //           color: Theme.of(context).colorScheme.secondaryContainer,
              //           boxShadow: [
              //             BoxShadow(
              //               color: Theme.of(context).colorScheme.shadow,
              //               spreadRadius: 1.0,
              //               blurRadius: 4.0,
              //               offset: const Offset(0, 0),
              //             ),
              //           ],
              //         ),
              //         child: const Icon(
              //           FontAwesomeIcons.google,
              //           color: primaryColor,
              //           size: 21,
              //         ),
              //       ),
              //     ),
              //     const SizedBox(width: 10.0),
              //     Container(
              //       height: 40,
              //       width: 60,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(8.0),
              //         color: Theme.of(context).colorScheme.secondaryContainer,
              //         boxShadow: [
              //           BoxShadow(
              //             color: Theme.of(context).colorScheme.shadow,
              //             spreadRadius: 1.0,
              //             blurRadius: 4.0,
              //             offset: const Offset(0, 0),
              //           ),
              //         ],
              //       ),
              //       child: const Icon(
              //         Icons.facebook_rounded,
              //         color: primaryColor,
              //         size: 25,
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(width: 30.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignUp(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: lang.S.of(context).noAc,
              style: kTextStyle.copyWith(
                color: isDark ? darkGreyTextColor : lightGreyTextColor,
              ),
              children: [
                TextSpan(
                  text: lang.S.of(context).signUpHere,
                  style: kTextStyle.copyWith(
                    color: primaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

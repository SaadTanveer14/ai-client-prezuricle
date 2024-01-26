import 'package:chat_gpt/screen/authentication/otp_verification.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../services/repositories.dart';
import '../widgets/appbar_widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

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
          text: lang.S.of(context).forgotPass,
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
                lang.S.of(context).forgotPass,
                style: kTextStyle.copyWith(
                  color: isDark ? darkTitleColor : lightTitleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                'Enter your email address and we will send you code',
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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: kButtonStyle,
                  onPressed: () async {
                    EasyLoading.show(status: "Sending OTP");
                    try {
                      await ApiService()
                          .forgotPassword(emailController.text)
                          .then((value) => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => OtpVerification(email: emailController.text)),
                              (route) => false));
                    } catch (e) {
                      EasyLoading.showError(
                          e.toString().replaceAll("Exception:", ""));
                    }
                  },
                  child: Text(
                    lang.S.of(context).continueButton,
                    style: kTextStyle.copyWith(
                        color: kWhite, fontWeight: FontWeight.bold),
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

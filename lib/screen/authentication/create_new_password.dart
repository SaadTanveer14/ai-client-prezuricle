import 'package:chat_gpt/screen/authentication/log_in.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../services/repositories.dart';
import '../widgets/appbar_widgets.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({Key? key, required this.otp, required this.email}) : super(key: key);
  final String otp;
  final String email;

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool hidePassword = false;
  bool hideNewPassword = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
          text: lang.S.of(context).newPass,
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
                lang.S.of(context).setNewPass,
                style: kTextStyle.copyWith(
                  color: isDark ? darkTitleColor : lightTitleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                'Reset your password to recovery and log in your account',
                style: kTextStyle.copyWith(
                  color: isDark ? darkGreyTextColor : lightGreyTextColor,
                ),
              ),
              const SizedBox(height: 40.0),
              TextFormField(
                cursorColor: kTitleColor,
                keyboardType: TextInputType.visiblePassword,
                obscureText: hidePassword,
                controller: passwordController,
                textInputAction: TextInputAction.done,
                style: kTextStyle.copyWith(color: isDark?darkTitleColor:lightTitleColor),
                decoration: kInputDecoration.copyWith(
                  border: const OutlineInputBorder(),
                  labelText: lang.S.of(context).newPassword,
                  labelStyle: kTextStyle.copyWith(color: isDark ? darkTitleColor : lightTitleColor),
                  hintText: 'Enter new password',
                  hintStyle: kTextStyle.copyWith(color: isDark ? darkGreyTextColor : lightGreyTextColor),
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
              const SizedBox(height: 20.0),
              TextFormField(
                cursorColor: kTitleColor,
                keyboardType: TextInputType.visiblePassword,
                obscureText: hideNewPassword,
                controller: confirmPasswordController,
                textInputAction: TextInputAction.done,
                style: kTextStyle.copyWith(color: isDark?darkTitleColor:lightTitleColor),
                decoration: kInputDecoration.copyWith(
                  border: const OutlineInputBorder(),
                  labelText: lang.S.of(context).confirmPass,
                  labelStyle: kTextStyle.copyWith(color: isDark ? darkTitleColor : lightTitleColor),
                  hintText: 're-enter password',
                  hintStyle: kTextStyle.copyWith(color: isDark ? darkGreyTextColor : lightGreyTextColor),
                  fillColor: Theme.of(context).colorScheme.secondaryContainer,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hideNewPassword = !hideNewPassword;
                      });
                    },
                    icon: Icon(
                      hideNewPassword ? Icons.visibility_off : Icons.visibility,
                      color: isDark ? darkGreyTextColor : lightGreyTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: kButtonStyle,
                  onPressed: () async {
                    if(passwordController.text != confirmPasswordController.text){
                      EasyLoading.showError("Password doesn\'t match");
                    }else{
                      EasyLoading.show(status: "Resetting Password");
                      try {
                        await ApiService()
                            .resetPassword(widget.otp,widget.email,passwordController.text)
                            .then((value) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LogIn()),
                                (route) => false));
                      } catch (e) {
                        EasyLoading.showError(
                            e.toString().replaceAll("Exception:", ""));
                      }
                    }
                  },
                  child: Text(
                    lang.S.of(context).continueButton,
                    style: kTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
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

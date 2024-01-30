import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../services/repositories.dart';
import '../home/home.dart';
import '../widgets/appbar_widgets.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool hidePassword = false;
  bool hideNewPassword = false;
  bool hideOldPassword = false;
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leadingWidth: 10,
        elevation: 1.0,
        shadowColor: Theme.of(context).colorScheme.shadow,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: ArrowBack(isDark: isDark),
        centerTitle: true,
        title: TitleText(
          isDark: isDark,
          text: lang.S.of(context).changePass,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
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
                'Change your password to recovery and log in your account',
                style: kTextStyle.copyWith(
                  color: isDark ? darkGreyTextColor : lightGreyTextColor,
                ),
              ),
              const SizedBox(height: 40.0),
              TextFormField(
                cursorColor: kTitleColor,
                keyboardType: TextInputType.visiblePassword,
                obscureText: hideOldPassword,
                controller: currentPasswordController,
                textInputAction: TextInputAction.done,
                style: kTextStyle.copyWith(color: isDark?darkTitleColor:lightTitleColor),
                decoration: kInputDecoration.copyWith(
                  border: const OutlineInputBorder(),
                  labelText: lang.S.of(context).oldPass,
                  labelStyle: kTextStyle.copyWith(color: isDark ? darkTitleColor : lightTitleColor),
                  hintText: 'Enter old password',
                  hintStyle: kTextStyle.copyWith(color: isDark ? darkGreyTextColor : lightGreyTextColor),
                  fillColor: Theme.of(context).colorScheme.secondaryContainer,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hideOldPassword = !hideOldPassword;
                      });
                    },
                    icon: Icon(
                      hideOldPassword ? Icons.visibility_off : Icons.visibility,
                      color: isDark ? darkGreyTextColor : lightGreyTextColor,
                    ),
                  ),
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
                  labelText: lang.S.of(context).newPass,
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
                  onPressed: () async{
                    if(passwordController.text != confirmPasswordController.text){
                      EasyLoading.showError("Password doesn\'t match");
                    }else{
                      EasyLoading.show(status: "Changing Password");
                      try {
                        await ApiService()
                            .changePassword(currentPasswordController.text,passwordController.text)
                            .then((value) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Home()),
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

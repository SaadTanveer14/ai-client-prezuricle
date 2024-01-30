import 'dart:async';

import 'package:chat_gpt/screen/authentication/create_new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pinput/pinput.dart';

import '../../services/repositories.dart';
import '../../theme/theme.dart';
import '../widgets/appbar_widgets.dart';
import '../widgets/constant.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  int _secondsRemaining = 60;
  Timer? _timer;
  String code = '';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

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
          text: 'OTP',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verification',
                style: kTextStyle.copyWith(
                  color: isDark ? darkTitleColor : lightTitleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0,
                ),
              ),
              const SizedBox(height: 5.0),
              RichText(
                text: TextSpan(
                  text: '6-digits pin has been sent to your email address,',
                  style: kTextStyle.copyWith(
                    color: isDark ? darkGreyTextColor : lightGreyTextColor,
                  ),
                  children: [
                    TextSpan(
                      text: widget.email,
                      style: kTextStyle.copyWith(
                        color: isDark ? darkTitleColor : lightTitleColor,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40.0),
              Center(
                child: Pinput(
                    length: 6,
                    focusedPinTheme: PinTheme(
                      height: 52,
                      width: 45,
                      textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primaryColor),
                      ),
                    ),
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    defaultPinTheme: PinTheme(
                        height: 52,
                        width: 45,
                        textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: lightGreyTextColor),
                        )),
                    onCompleted: (pin) {
                      code = pin;
                    }),
              ),
              const SizedBox(height: 25),
              Center(
                child: Text(
                  '00:$_secondsRemaining',
                  style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn’t receive code? ',
                    style: kTextStyle.copyWith(color: isDark ? darkGreyTextColor : lightGreyTextColor),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: _secondsRemaining <= 0
                        ? () async{
                            setState(() {
                              _secondsRemaining = 60;
                              _startTimer();
                            });
                              EasyLoading.show(status: "Sending OTP");
                              try {
                                await ApiService()
                                    .forgotPassword(widget.email);
                              } catch (e) {
                                EasyLoading.showError(
                                    e.toString().replaceAll("Exception:", ""));
                              }
                            }
                        : () {},
                    child: Text(
                      'Resend Code',
                      style: kTextStyle.copyWith(fontWeight: FontWeight.bold, color: _secondsRemaining <= 0 ? primaryColor : Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    backgroundColor: primaryColor,
                    textStyle: kTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () async {
                    EasyLoading.show(status: "Verifying OTP");
                    try {
                      await ApiService()
                          .verifyOtp(code,widget.email)
                          .then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CreateNewPassword(otp: code,email: widget.email,)),
                              (route) => false));
                    } catch (e) {
                      EasyLoading.showError(
                          e.toString().replaceAll("Exception:", ""));
                    }
                  },
                  child: const Text('Verify'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

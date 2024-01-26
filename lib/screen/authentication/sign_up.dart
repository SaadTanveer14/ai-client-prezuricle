import 'dart:io';

import 'package:chat_gpt/screen/authentication/log_in.dart';
import 'package:chat_gpt/screen/home/home.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/services/repositories.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/appbar_widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool hidePassword = true;
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;
  File imageFile = File('No File');
  String imagePath = 'No Data';
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
          text: lang.S.of(context).signUp,
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
                lang.S.of(context).createAcc,
                style: kTextStyle.copyWith(
                  color: isDark ? darkTitleColor : lightTitleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                'Let’s us know what your name, email, and your password',
                style: kTextStyle.copyWith(
                  color: isDark ? darkGreyTextColor : lightGreyTextColor,
                ),
              ),
              const SizedBox(height: 40.0),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          // ignore: sized_box_for_whitespace
                          child: Container(
                            height: 200.0,
                            width: MediaQuery.of(context).size.width - 80,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      pickedImage = await _picker.pickImage(
                                          source: ImageSource.gallery);
                                      setState(() {
                                        imageFile = File(pickedImage!.path);
                                        imagePath = pickedImage!.path;
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.photo_library_rounded,
                                          size: 60.0,
                                          color: primaryColor,
                                        ),
                                        Text(
                                          "Gallery",
                                          style: GoogleFonts.poppins(
                                            fontSize: 20.0,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 40.0,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      pickedImage = await _picker.pickImage(
                                          source: ImageSource.camera);
                                      setState(() {
                                        imageFile = File(pickedImage!.path);
                                        imagePath = pickedImage!.path;
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.camera,
                                          size: 60.0,
                                          color: lightGreyTextColor,
                                        ),
                                        Text(
                                          "Camera",
                                          style: GoogleFonts.poppins(
                                            fontSize: 20.0,
                                            color: lightGreyTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: imagePath == 'No Data'
                              ? const DecorationImage(
                                  image: AssetImage('images/image1.png'),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: FileImage(imageFile),
                                  fit: BoxFit.cover,
                                ),
                          border: Border.all(color: primaryColor),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        child: const Icon(
                          IconlyBold.camera,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: nameController,
                cursorColor: isDark ? darkTitleColor : lightTitleColor,
                style: kTextStyle.copyWith(color: isDark?darkTitleColor:lightTitleColor),
                textInputAction: TextInputAction.next,
                decoration: kInputDecoration.copyWith(
                  labelText: lang.S.of(context).name,
                  labelStyle: kTextStyle.copyWith(
                      color: isDark ? darkTitleColor : lightTitleColor),
                  hintText: 'Enter your name',
                  hintStyle: kTextStyle.copyWith(
                      color: isDark ? darkGreyTextColor : lightGreyTextColor),
                  focusColor: kTitleColor,
                  fillColor: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.phone,
                cursorColor: isDark ? darkTitleColor : lightTitleColor,
                style: kTextStyle.copyWith(color: isDark?darkTitleColor:lightTitleColor),
                controller: phoneController,
                textInputAction: TextInputAction.next,
                decoration: kInputDecoration.copyWith(
                  labelText: "Phone Number",
                  labelStyle: kTextStyle.copyWith(
                      color: isDark ? darkTitleColor : lightTitleColor),
                  hintText: 'Enter your phone number',
                  hintStyle: kTextStyle.copyWith(
                      color: isDark ? darkGreyTextColor : lightGreyTextColor),
                  focusColor: kTitleColor,
                  fillColor: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                cursorColor: isDark ? darkTitleColor : lightTitleColor,
                style: kTextStyle.copyWith(color: isDark?darkTitleColor:lightTitleColor),
                controller: emailController,
                textInputAction: TextInputAction.next,
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
                  labelText: "Password",
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
              const SizedBox(height: 20.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: kButtonStyle,
                  onPressed: () async {
                    EasyLoading.show(status: "Signing Up");
                    try {
                      await ApiService()
                          .signUp(
                              nameController.text,
                              emailController.text,
                              phoneController.text,
                              passwordController.text,
                              imagePath)
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
                    lang.S.of(context).createAcc,
                    style: kTextStyle.copyWith(
                        color: kWhite, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // const SizedBox(height: 10.0),
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
              //         FontAwesomeIcons.google,
              //         color: primaryColor,
              //         size: 21,
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
              // const SizedBox(width: 30.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LogIn(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: lang.S.of(context).haveAcc,
                style: kTextStyle.copyWith(
                  color: isDark ? darkGreyTextColor : lightGreyTextColor,
                ),
                children: [
                  TextSpan(
                    text: lang.S.of(context).logInHere,
                    style: kTextStyle.copyWith(
                      color: primaryColor,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

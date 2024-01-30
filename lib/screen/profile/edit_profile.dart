import 'dart:io';
import 'package:chat_gpt/model/profile_information_model.dart';
import 'package:chat_gpt/provider/home_screen_provider.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/services/config.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/repositories.dart';
import '../home/home.dart';
import '../widgets/appbar_widgets.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.profile}) : super(key: key);
  final ProfileInformationModel profile;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;
  File imageFile = File('No File');
  String imagePath = 'No Data';
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    nameController.text = widget.profile.data?.name ?? "";
    phoneController.text = widget.profile.data?.phone ?? "";
    emailController.text = widget.profile.data?.email ?? "";
    super.initState();
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
          text: lang.S.of(context).edit,
        ),
        // actions: [
        //   PopupMenuButton(
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(6.0),
        //     ),
        //     padding: EdgeInsets.zero,
        //     itemBuilder: (BuildContext context) => [
        //       PopupMenuItem(
        //         onTap: () {
        //           // Navigator.push(context, MaterialPageRoute(builder: (context)=>),);
        //         },
        //         child: Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Icon(
        //               FeatherIcons.edit,
        //               color: isDark ? darkIconColor : lightIconColor,
        //               size: 16.0,
        //             ),
        //             const SizedBox(width: 10.0),
        //             Text(
        //               lang.S.of(context).edit,
        //               style: kTextStyle.copyWith(color: kTitleColor),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //     onSelected: (value) {
        //       Navigator.pushNamed(context, '$value');
        //     },
        //     child: Icon(
        //       Icons.more_vert,
        //       color: isDark ? darkTitleColor : lightTitleColor,
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
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
                                          const Duration(milliseconds: 100), () {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                          const Duration(milliseconds: 100), () {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                              ? !(widget.profile.data?.image ?? "").endsWith("g") ?DecorationImage(
                              image: AssetImage("images/no-avatar.png"),
                              fit: BoxFit.cover) : DecorationImage(
                              image: NetworkImage(
                                  Config.webSiteUrl + (widget.profile.data?.image ?? "")),
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
                style: kTextStyle.copyWith(color : isDark?darkTitleColor:lightTitleColor),
                cursorColor: isDark ? darkTitleColor : lightTitleColor,
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
                style: kTextStyle.copyWith(color : isDark?darkTitleColor:lightTitleColor),
                cursorColor: isDark ? darkTitleColor : lightTitleColor,
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
                style: kTextStyle.copyWith(color : isDark?darkTitleColor:lightTitleColor),
                cursorColor: isDark ? darkTitleColor : lightTitleColor,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer(
          builder: (_, ref, watch) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: kButtonStyle,
                    onPressed: () async {
                      EasyLoading.show(status: "Updating Profile");
                      try {
                        await ApiService()
                            .updateProfile(
                                nameController.text,
                                emailController.text,
                                phoneController.text,
                                imagePath)
                            .then((value) {
                          ref.refresh(profileProvider);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => Home()),
                              (route) => false);
                        });
                      } catch (e) {
                        EasyLoading.showError(
                            e.toString().replaceAll("Exception:", ""));
                      }
                    },
                    child: Text(
                      lang.S.of(context).update,
                      style: kTextStyle.copyWith(
                          color: kWhite, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )),
    );
  }
}

import 'package:chat_gpt/model/profile_information_model.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../services/config.dart';
import '../authentication/change_password.dart';
import '../widgets/appbar_widgets.dart';
import 'edit_profile.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key, required this.profile}) : super(key: key);
  final ProfileInformationModel profile;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
          text: lang.S.of(context).profile,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(
                      profile: widget.profile,
                    ),
                  ),
                );
              },
              child: PopupMenuButton(
                color: Theme.of(context).colorScheme.secondaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(
                              profile: widget.profile,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FeatherIcons.edit,
                            color:
                                isDark ? darkGreyTextColor : lightGreyTextColor,
                            size: 16.0,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            lang.S.of(context).edit,
                            style: kTextStyle.copyWith(
                              color:
                                  isDark ? darkGreyTextColor : lightGreyTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                child: Icon(
                  Icons.more_vert,
                  color: isDark ? darkTitleColor : lightTitleColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              Center(
                child: Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: !(widget.profile.data?.image ?? "").endsWith("g") ?DecorationImage(
                          image: AssetImage("images/no-avatar.png"),
                          fit: BoxFit.cover) : DecorationImage(
                          image: NetworkImage(
                              Config.webSiteUrl + (widget.profile.data?.image ?? "")),
                          fit: BoxFit.cover),
                      border: Border.all(color: primaryColor)),
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.S.of(context).name,
                      textAlign: TextAlign.start,
                      style: kTextStyle.copyWith(
                        color: isDark ? darkGreyTextColor : lightGreyTextColor,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      widget.profile.data?.name ?? "",
                      textAlign: TextAlign.start,
                      style: kTextStyle.copyWith(
                        color: isDark ? darkTitleColor : lightTitleColor,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      lang.S.of(context).email,
                      textAlign: TextAlign.start,
                      style: kTextStyle.copyWith(
                        color: isDark ? darkGreyTextColor : lightGreyTextColor,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      widget.profile.data?.email ?? "",
                      textAlign: TextAlign.start,
                      style: kTextStyle.copyWith(
                        color: isDark ? darkTitleColor : lightTitleColor,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      lang.S.of(context).phone,
                      textAlign: TextAlign.start,
                      style: kTextStyle.copyWith(
                        color: isDark ? darkGreyTextColor : lightGreyTextColor,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      widget.profile.data?.phone ?? "",
                      textAlign: TextAlign.start,
                      style: kTextStyle.copyWith(
                        color: isDark ? darkTitleColor : lightTitleColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePassword(),
                      ),
                    );
                  },
                  contentPadding: const EdgeInsets.only(left: 10.0),
                  leading: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEF4444),
                    ),
                    child: const Icon(
                      IconlyBold.password,
                      color: kWhite,
                    ),
                  ),
                  title: Text(
                    lang.S.of(context).password,
                    textAlign: TextAlign.start,
                    style: kTextStyle.copyWith(
                      color: isDark ? darkTitleColor : lightTitleColor,
                    ),
                  ),
                  trailing: Icon(
                    IconlyLight.arrowRight2,
                    color: isDark ? darkIconColor : lightGreyTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:chat_gpt/screen/home/home.dart';
import 'package:chat_gpt/services/const_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/admob.dart';
import '../../theme/theme.dart';
import '../language/language_provider.dart';
import '../widgets/constant.dart';
import 'onboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Admob admob = Admob();
  @override
  void initState() {
    super.initState();
    setLanguage();
    init();
  }
  void setLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String selectedLanguage = prefs.getString('savedLanguage') ?? 'English';
    selectedLanguage == 'English'
        ? context.read<LanguageChangeProvider>().changeLocale("en")
        : selectedLanguage == "Swahili"
        ? context.read<LanguageChangeProvider>().changeLocale("sw")
        : selectedLanguage == 'Arabic'
        ? context.read<LanguageChangeProvider>().changeLocale("ar")
        : selectedLanguage == 'Spanish'
        ? context.read<LanguageChangeProvider>().changeLocale("es")
        : selectedLanguage == 'Hindi'
        ? context.read<LanguageChangeProvider>().changeLocale("hi")
        : selectedLanguage == 'France'
        ? context.read<LanguageChangeProvider>().changeLocale("fr")
        : selectedLanguage == "Bengali"
        ? context.read<LanguageChangeProvider>().changeLocale("bn")
        : selectedLanguage == "Turkish"
        ? context.read<LanguageChangeProvider>().changeLocale("tr")
        : selectedLanguage == "Chinese"
        ? context.read<LanguageChangeProvider>().changeLocale("zh")
        : selectedLanguage == "Japanese"
        ? context.read<LanguageChangeProvider>().changeLocale("ja")
        : selectedLanguage == "Romanian"
        ? context.read<LanguageChangeProvider>().changeLocale("ro")
        : selectedLanguage == "Germany"
        ? context.read<LanguageChangeProvider>().changeLocale("de")
        : selectedLanguage == "Vietnamese"
        ? context.read<LanguageChangeProvider>().changeLocale("vi")
        : selectedLanguage == "Italian"
        ? context.read<LanguageChangeProvider>().changeLocale("it")
        : selectedLanguage == "Thai"
        ? context.read<LanguageChangeProvider>().changeLocale("th")
        : selectedLanguage == "Portuguese"
        ? context.read<LanguageChangeProvider>().changeLocale("pt")
        : selectedLanguage == "Hebrew"
        ? context.read<LanguageChangeProvider>().changeLocale("he")
        : selectedLanguage == "Polish"
        ? context.read<LanguageChangeProvider>().changeLocale("pl")
        : selectedLanguage == "Hungarian"
        ? context.read<LanguageChangeProvider>().changeLocale("hu")
        : selectedLanguage == "Finland"
        ? context.read<LanguageChangeProvider>().changeLocale("fi")
        : selectedLanguage == "Korean"
        ? context.read<LanguageChangeProvider>().changeLocale("ko")
        : selectedLanguage == "Malay"
        ? context.read<LanguageChangeProvider>().changeLocale("ms")
        : selectedLanguage == "Indonesian"
        ? context.read<LanguageChangeProvider>().changeLocale("id")
        : selectedLanguage == "Ukrainian"
        ? context.read<LanguageChangeProvider>().changeLocale("uk")
        : selectedLanguage == "Bosnian"
        ? context
        .read<LanguageChangeProvider>()
        .changeLocale("bs")
        : selectedLanguage == "Greek"
        ? context
        .read<LanguageChangeProvider>()
        .changeLocale("el")
        : selectedLanguage == "Dutch"
        ? context
        .read<LanguageChangeProvider>()
        .changeLocale("nl")
        : selectedLanguage == "Urdu"
        ? context
        .read<LanguageChangeProvider>()
        .changeLocale("ur")
        : selectedLanguage == "Sinhala"
        ? context
        .read<LanguageChangeProvider>()
        .changeLocale("si")
        : selectedLanguage == "Persian"
        ? context
        .read<LanguageChangeProvider>()
        .changeLocale("fa")
        : selectedLanguage == "Serbian"
        ? context
        .read<
        LanguageChangeProvider>()
        .changeLocale("sr")
        : selectedLanguage == "Khmer"
        ? context
        .read<
        LanguageChangeProvider>()
        .changeLocale("km")
        : selectedLanguage == "Lao"
        ? context
        .read<
        LanguageChangeProvider>()
        .changeLocale("lo")
        : selectedLanguage ==
        "Russian"
        ? context
        .read<
        LanguageChangeProvider>()
        .changeLocale(
        "ru")
        : selectedLanguage ==
        "Kannada"
        ? context
        .read<
        LanguageChangeProvider>()
        .changeLocale(
        "kn")
        : selectedLanguage ==
        "Marathi"
        ? context.read<LanguageChangeProvider>().changeLocale("mr")
        : selectedLanguage == "Tamil"
        ? context.read<LanguageChangeProvider>().changeLocale("ta")
        : selectedLanguage == "Afrikaans"
        ? context.read<LanguageChangeProvider>().changeLocale("af")
        : selectedLanguage == "Czech"
        ? context.read<LanguageChangeProvider>().changeLocale("cs")
        : selectedLanguage == "Swedish"
        ? context.read<LanguageChangeProvider>().changeLocale("sv")
        : selectedLanguage == "Slovak"
        ? context.read<LanguageChangeProvider>().changeLocale("sk")
        : selectedLanguage == "Swahili"
        ? context.read<LanguageChangeProvider>().changeLocale("sw")
        : selectedLanguage == "Burmese"
        ? context.read<LanguageChangeProvider>().changeLocale("my")
        : selectedLanguage == "Albanian"
        ? context.read<LanguageChangeProvider>().changeLocale("sq")
        : selectedLanguage == "Danish"
        ? context.read<LanguageChangeProvider>().changeLocale("da")

        : selectedLanguage == "Azerbaijani"
        ? context.read<LanguageChangeProvider>().changeLocale("az")
        : selectedLanguage == "Kazakh"
        ? context.read<LanguageChangeProvider>().changeLocale("kk")
        : selectedLanguage == "Croatian"
        ? context.read<LanguageChangeProvider>().changeLocale("hr")
        : selectedLanguage == "Nepali"
        ? context.read<LanguageChangeProvider>().changeLocale("ne")
        : context.read<LanguageChangeProvider>().changeLocale("en");
    // selectedLanguage == 'Arabic' ? isArabic = true : isArabic = false;
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    newSelect = prefs.getBool('newSelect') ?? false;
    String token = prefs.getString("token") ?? "";
    admob.createRewardedAd();
    await Future.delayed(const Duration(seconds: 2)).then(
      (value) async {
        if(token.isEmpty || token == ""){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OnBoard(),
            ),
          );
        }else{
          Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
            builder: (context) => const Home(),
          ), (route) => false);

        }
      }
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            // Container(
            //   height: MediaQuery.of(context).size.height/2.5,
            //   width: double.infinity,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('images/splashLogo.png'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            SvgPicture.asset(svgLogo,height: MediaQuery.of(context).size.height/2.5,
              width: double.infinity,),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

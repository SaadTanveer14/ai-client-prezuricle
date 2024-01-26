import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home.dart';
import '../widgets/appbar_widgets.dart';
import 'language_provider.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {

  List<String> languageList = [
    'English',
    'Hindi',
    'Arabic',
    'Chinese',
    'Spanish',
    'French',
    'Japanese',
    'Romanian',
    'Turkish',
    'Italian',
    'German',
    'Bangla',
    'Vietnamese',
    'Thai',
    'Portuguese',
    'Hebrew',
    'Polish',
    'Hungarian',
    'Finland',
    'Korean',
    'Malay',
    'Indonesian',
    'Ukrainian',
    'Bosnian',
    'Greek',
    'Dutch',
    'Urdu',
    'Sinhala',
    'Persian',
    'Serbian',
    'Khmer',
    'Lao',
    'Russian',
    'Kannada',
    'Marathi',
    'Tamil',
    'Afrikaans',
    'Czech',
    'Swedish',
    'Slovak',
    'Swahili',
    'Albanian',
    'Danish',
    'Azerbaijani',
    'Kazakh',
    'Croatian',
    'Nepali',
    // 'Burmese'
  ];
  String isSelected = 'English';
  List<String> baseFlagsCode = [
    'us',
    'in',
    'sa',
    'cn',
    'es',
    'fr',
    'jp',
    'ro',
    'tr',
    'it',
    'de',
    'BD',
    'VN',
    'TH',
    'PT',
    'IL',
    'PL',
    'HU',
    'FI',
    'KR',
    'MY',
    'ID',
    'UA',
    'BA',
    'GR',
    'NL',
    'Pk',
    'LK',
    'IR',
    'RS',
    'KH',
    'LA',
    'RU',
    'IN',
    'IN',
    'IN',
    'ZA',
    'CZ',
    'SE',
    'SK',
    'SK',
    'AL',
    'DK',
    'AZ',
    'KZ',
    'HR',
    'NP',
    // 'MM'
  ];

  Future<void> saveData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedLanguage', data);
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    isSelected = prefs.getString('savedLanguage') ?? isSelected;
    setState(() {});
  }

  Future<void> saveDataOnLocal({required String key, required String type, required dynamic value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (type == 'bool') prefs.setBool(key, value);
    if (type == 'string') prefs.setString(key, value);
  }

  @override
  void initState() {
    getData();
    isSelected;
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
          text: lang.S.of(context).language,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                itemCount: languageList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.shadow,
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            isSelected = languageList[i];
                            isSelected == 'Hindi'
                                ? context.read<LanguageChangeProvider>().changeLocale("hi")
                                : isSelected == 'Arabic'
                                ? context.read<LanguageChangeProvider>().changeLocale("ar")
                                : isSelected == 'Chinese'
                                ? context.read<LanguageChangeProvider>().changeLocale("zh")
                                : isSelected == 'Spanish'
                                ? context.read<LanguageChangeProvider>().changeLocale("es")
                                : isSelected == 'French'
                                ? context.read<LanguageChangeProvider>().changeLocale("fr")
                                : isSelected == 'Japanese'
                                ? context.read<LanguageChangeProvider>().changeLocale("ja")
                                : isSelected == 'Romanian'
                                ? context.read<LanguageChangeProvider>().changeLocale("ro")
                                : isSelected == 'Turkish'
                                ? context.read<LanguageChangeProvider>().changeLocale("tr")
                                : isSelected == 'Italian'
                                ? context.read<LanguageChangeProvider>().changeLocale("it")
                                : isSelected == 'German'
                                ? context.read<LanguageChangeProvider>().changeLocale("de")
                                : isSelected == "Bangla"
                                ? context.read<LanguageChangeProvider>().changeLocale("bn")
                                : isSelected == "Vietnamese"
                                ? context.read<LanguageChangeProvider>().changeLocale("vi")
                                : isSelected == "Thai"
                                ? context.read<LanguageChangeProvider>().changeLocale("th")
                                : isSelected == "Portuguese"
                                ? context.read<LanguageChangeProvider>().changeLocale("pt")
                                : isSelected == "Hebrew"
                                ? context.read<LanguageChangeProvider>().changeLocale("he")
                                : isSelected == "Polish"
                                ? context.read<LanguageChangeProvider>().changeLocale("pl")
                                : isSelected == "Hungarian"
                                ? context.read<LanguageChangeProvider>().changeLocale("hu")
                                : isSelected == "Finland"
                                ? context.read<LanguageChangeProvider>().changeLocale("fi")
                                : isSelected == "Korean"
                                ? context.read<LanguageChangeProvider>().changeLocale("ko")
                                : isSelected == "Malay"
                                ? context.read<LanguageChangeProvider>().changeLocale("ms")
                                : isSelected == "Indonesian"
                                ? context.read<LanguageChangeProvider>().changeLocale("id")
                                : isSelected == "Ukrainian"
                                ? context.read<LanguageChangeProvider>().changeLocale("uk")
                                : isSelected == "Bosnian"
                                ? context.read<LanguageChangeProvider>().changeLocale("bs")
                                : isSelected == "Greek"
                                ? context
                                .read<LanguageChangeProvider>()
                                .changeLocale("el")
                                : isSelected == "Dutch"
                                ? context
                                .read<LanguageChangeProvider>()
                                .changeLocale("nl")
                                : isSelected == "Urdu"
                                ? context
                                .read<LanguageChangeProvider>()
                                .changeLocale("ur")
                                : isSelected == "Sinhala"
                                ? context
                                .read<LanguageChangeProvider>()
                                .changeLocale("si")
                                : isSelected == "Persian"
                                ? context
                                .read<LanguageChangeProvider>()
                                .changeLocale("fa")
                                : isSelected == "Serbian"
                                ? context
                                .read<LanguageChangeProvider>()
                                .changeLocale("sr")
                                : isSelected == "Khmer"
                                ? context
                                .read<
                                LanguageChangeProvider>()
                                .changeLocale("km")
                                : isSelected == "Lao"
                                ? context
                                .read<
                                LanguageChangeProvider>()
                                .changeLocale("lo")
                                : isSelected == "Russian"
                                ? context
                                .read<
                                LanguageChangeProvider>()
                                .changeLocale("ru")
                                : isSelected == "Kannada"
                                ? context
                                .read<
                                LanguageChangeProvider>()
                                .changeLocale(
                                "kn")
                                : isSelected ==
                                "Marathi"
                                ? context
                                .read<
                                LanguageChangeProvider>()
                                .changeLocale(
                                "mr")
                                : isSelected ==
                                "Tamil"
                                ? context
                                .read<LanguageChangeProvider>()
                                .changeLocale("ta")
                                : isSelected == "Afrikaans"
                                ? context.read<LanguageChangeProvider>().changeLocale("af")
                                : isSelected == "Czech"
                                ? context.read<LanguageChangeProvider>().changeLocale("cs")
                                : isSelected == "Swedish"
                                ? context.read<LanguageChangeProvider>().changeLocale("sv")
                                : isSelected == "Slovak"
                                ? context.read<LanguageChangeProvider>().changeLocale("sk")
                                : isSelected == "Swahili"
                                ? context.read<LanguageChangeProvider>().changeLocale("sw")
                                : isSelected == "Albanian"
                                ? context.read<LanguageChangeProvider>().changeLocale("sq")
                                : isSelected == "Danish"
                                ? context.read<LanguageChangeProvider>().changeLocale("da")
                                : isSelected == "Azerbaijani"
                                ? context.read<LanguageChangeProvider>().changeLocale("az")
                                : isSelected == "Kazakh"
                                ? context.read<LanguageChangeProvider>().changeLocale("kk")
                                : isSelected == "Croatian"
                                ? context.read<LanguageChangeProvider>().changeLocale("hr")
                                : isSelected == "Nepali"
                                ? context.read<LanguageChangeProvider>().changeLocale("ne")
                                : isSelected == "Burmese"
                                ? context.read<LanguageChangeProvider>().changeLocale("my")
                                : context.read<LanguageChangeProvider>().changeLocale("en");
                              saveDataOnLocal(key: 'savedLanguage', type: 'string', value: isSelected);
                              saveData(isSelected);

                            // isSelected == 'Arabic' ? isRtl = true : isRtl = false;
                          });
                        },
                        contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        leading: Flag.fromString(
                          baseFlagsCode[i],
                          height: 25,
                          width: 30,
                        ),
                        title: Text(
                          languageList[i],
                          textAlign: TextAlign.start,
                          style: kTextStyle.copyWith(
                            color: isDark ? darkTitleColor : lightTitleColor,
                          ),
                        ),
                        trailing: Icon(
                          isSelected == languageList[i] ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                          color: isSelected == languageList[i] ? primaryColor : lightGreyTextColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Text(lang.S.of(context).homeButtonTitle)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              )
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home()));
            },
            child: Text(
              lang.S.of(context).save,
              style: kTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:chat_gpt/screen/language/language_provider.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:chat_gpt/screen/splash%20screen/splash_screen.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart' as pro;
import 'generated/l10n.dart' as lang;
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String savedTheme = prefs.getString('theme') ?? 'system';
  savedTheme == 'light' ? _themeManager.toggleTheme(false) : _themeManager.toggleTheme(true);
  savedTheme == 'dark' ? _themeManager.toggleTheme(true) : _themeManager.toggleTheme(false);
  savedTheme == 'system' ? _themeManager.toggleTheme(false) : null;
  MobileAds.instance.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return pro.ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context) => LanguageChangeProvider(),
      child: Builder(
        builder: (context) => MaterialApp(
          locale: pro.Provider.of<LanguageChangeProvider>(context, listen: true).currentLocale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          title: 'Chat Gpt',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: _themeManager.themeMode,
          home: const SplashScreen(),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) =>),);
      },
      contentPadding: const EdgeInsets.only(left: 10.0),
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF00A6FF),
        ),
        child: const Icon(
          Icons.sunny,
          color: kWhite,
        ),
      ),
      title: Text(
        lang.S.of(context).theme,
        textAlign: TextAlign.start,
        style: kTextStyle.copyWith(
          color: widget.isDark ? darkTitleColor : lightTitleColor,
        ),
      ),
      trailing: Transform.scale(
        scale: 0.8,
        child: Switch(
          inactiveTrackColor: primaryColor.withOpacity(0.3),
          inactiveThumbColor: primaryColor,
          value: _themeManager.themeMode == ThemeMode.dark,
          onChanged: (newValue) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            newValue ? await prefs.setString('theme', 'dark') : await prefs.setString('theme', 'light');

            setState(() {
              _themeManager.toggleTheme(newValue);
            });
          },
        ),
      ),
    );
  }
}

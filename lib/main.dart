import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_1/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.dark;
  Locale _locale = Locale('en');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo",
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
          : MyAppThemeConfig.light().getTheme(_locale.languageCode),
      home: MyHomePage(
        toggleThemeMode: () {
          setState(() {
            if (themeMode == ThemeMode.dark) {
              themeMode = ThemeMode.light;
            } else {
              themeMode = ThemeMode.dark;
            }
          });
        },
        selectedLanguageChanged: (_Language language) {
          setState(() {
            _locale = language == _Language.en ? Locale('en') : Locale('fa');
          });
        },
      ),
    );
  }
}

class MyAppThemeConfig {
  static const String faPrimaryFontFamily = "kalameh";
  final Color primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
    : primaryTextColor = Colors.white,
      secondaryTextColor = Colors.white70,
      surfaceColor = Color(0x0dffffff),
      backgroundColor = Color.fromARGB(255, 30, 30, 30),
      appBarColor = Colors.black,
      brightness = Brightness.dark;

  MyAppThemeConfig.light()
    : primaryTextColor = Colors.grey.shade900,
      secondaryTextColor = Colors.grey.shade900.withOpacity(0.8),
      surfaceColor = Color(0x0d000000),
      backgroundColor = Colors.white,
      appBarColor = Color.fromARGB(255, 235, 235, 235),
      brightness = Brightness.light;

  ThemeData getTheme(String languageCode) {
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      iconTheme: const IconThemeData(color: Colors.white70),
      dividerColor: surfaceColor,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: surfaceColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(primaryColor),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        foregroundColor: primaryTextColor,
        titleTextStyle: GoogleFonts.lato(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: languageCode == 'en' ? enPrimaryTextTheme : faPrimaryTextTheme,
    );
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(
    TextTheme(
      bodyLarge: TextStyle(fontSize: 15, color: primaryTextColor),
      bodyMedium: TextStyle(fontSize: 13, color: secondaryTextColor),
      bodySmall: TextStyle(fontSize: 12, color: secondaryTextColor),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
    ),
  );

  TextTheme get faPrimaryTextTheme => TextTheme(
    bodyLarge: TextStyle(
      fontSize: 15,
      color: primaryTextColor,
      fontFamily: faPrimaryFontFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: 13,
      color: secondaryTextColor,
      fontFamily: faPrimaryFontFamily,
      height: 1.5,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: secondaryTextColor,
      fontFamily: faPrimaryFontFamily,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.bold,
      color: primaryTextColor,
      fontFamily: faPrimaryFontFamily,
      fontSize: 18,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: primaryTextColor,
      fontFamily: faPrimaryFontFamily,
    ),
  );
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(_Language _language) selectedLanguageChanged;
  const MyHomePage({
    super.key,
    required this.toggleThemeMode,
    required this.selectedLanguageChanged,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum _SkillType { photoshop, xd, illustrator, uiux, figma }

class _MyHomePageState extends State<MyHomePage> {
  _SkillType _skill = _SkillType.photoshop;
  _Language _language = _Language.en;

  void updateSelectedSkill(_SkillType skillType) {
    setState(() {
      this._skill = skillType;
    });
  }

  void updateSelectedLanguage(_Language language) {
    widget.selectedLanguageChanged(language);
    setState(() {
      this._language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        // you can omit style here because appBarTheme.titleTextStyle is set,
        // but if you want to use textTheme you can:
        title: Text(
          localization.profileTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(CupertinoIcons.chat_bubble),
          ),
          InkWell(
            onTap: widget.toggleThemeMode,
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(CupertinoIcons.ellipsis_vertical),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      8,
                    ), // use BorderRadius.circular
                    child: Image.asset(
                      "assets/images/profile.avif",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          localization.job,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.location_circle,
                              size: 16,
                              // use iconTheme or explicit color from textTheme
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.color,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              localization.location,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    CupertinoIcons.heart,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 15),
              child: Text(
                localization.summary,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization.selectedLang,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  CupertinoSlidingSegmentedControl<_Language>(
                    groupValue: _language,
                    thumbColor: Theme.of(context).primaryColor,
                    children: {
                      _Language.en: Text(localization.enLang),
                      _Language.fa: Text(localization.faLang),
                    },
                    onValueChanged: (value) => updateSelectedLanguage(value!),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 12, 32, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    localization.skills,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 2),
                  Icon(CupertinoIcons.chevron_down, size: 12),
                ],
              ),
            ),

            Center(
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                runSpacing: 8,
                children: [
                  Skills(
                    image: "assets/images/ps.webp",
                    title: "Photoshop",
                    shadowColor: Colors.blue,
                    isActive: _skill == _SkillType.photoshop,
                    type: _SkillType.photoshop,
                    ontap: () {
                      updateSelectedSkill(_SkillType.photoshop);
                    },
                  ),
                  Skills(
                    image: "assets/images/xd.png",
                    title: "Adobe XD",
                    shadowColor: Colors.pink,
                    isActive: _skill == _SkillType.xd,
                    type: _SkillType.xd,
                    ontap: () {
                      updateSelectedSkill(_SkillType.xd);
                    },
                  ),
                  Skills(
                    image: "assets/images/ai.jpg",
                    title: "Illustrator",
                    shadowColor: Colors.orange,
                    isActive: _skill == _SkillType.illustrator,
                    type: _SkillType.illustrator,
                    ontap: () {
                      updateSelectedSkill(_SkillType.illustrator);
                    },
                  ),
                  Skills(
                    image: "assets/images/uiux.webp",
                    title: "UI UX",
                    shadowColor: Colors.amber,
                    isActive: _skill == _SkillType.uiux,
                    type: _SkillType.uiux,
                    ontap: () {
                      updateSelectedSkill(_SkillType.uiux);
                    },
                  ),
                  Skills(
                    image: "assets/images/figma.jpg",
                    title: "Figma",
                    shadowColor: Colors.deepPurple,
                    isActive: _skill == _SkillType.figma,
                    type: _SkillType.figma,
                    ontap: () {
                      updateSelectedSkill(_SkillType.figma);
                    },
                  ),
                ],
              ),
            ),

            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 12, 32, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        localization.info,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(CupertinoIcons.chevron_down, size: 12),
                    ],
                  ),
                  SizedBox(height: 12),

                  TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(CupertinoIcons.at),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(CupertinoIcons.lock),
                    ),
                  ),
                  SizedBox(height: 4),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        localization.label,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Skills extends StatelessWidget {
  final _SkillType type;
  final String image;
  final String title;
  final Color shadowColor;
  final bool isActive;
  final Function() ontap;
  const Skills({
    super.key,
    required this.image,
    required this.title,
    required this.shadowColor,
    required this.isActive,
    required this.type,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: ontap,
      child: Container(
        width: 110,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(16),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor.withOpacity(0.5),
                          blurRadius: 20,
                        ),
                      ],
                    )
                  : null,
              child: Image.asset(image, width: 40, height: 40),
            ),
            SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}

enum _Language { fa, en }

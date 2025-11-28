import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyAppThemeConfig {
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;

  MyAppThemeConfig({
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.surfaceColor,
    required this.backgroundColor,
    required this.appBarColor,
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

enum _SkillType { photoshop, xd, illustrator, uiux, figma }

class _MyAppState extends State<MyApp> {
  _SkillType _skill = _SkillType.photoshop;

  void updateSelectedSkill(_SkillType skillType) {
    setState(() {
      this._skill = skillType;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.latoTextTheme()
        .apply(bodyColor: Colors.white, displayColor: Colors.white)
        .copyWith(
          bodyLarge: TextStyle(fontSize: 15, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 13, color: Colors.white70),
          bodySmall: TextStyle(fontSize: 12, color: Colors.white60),
          headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );

    Color surfaceColor = Color(0x0dffffff);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.pink.shade400,
        scaffoldBackgroundColor: const Color.fromARGB(255, 30, 30, 30),

        // Icon color globally
        iconTheme: const IconThemeData(color: Colors.white70),

        // Divider Theme
        // dividerTheme: DividerThemeData(
        //   color: Colors.white70,
        //   indent: 25,
        //   endIndent: 25,
        // ),
        dividerColor: surfaceColor,

        // apply text theme
        textTheme: textTheme,

        // input theme
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: surfaceColor,
        ),

        //button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.pink.shade400),
          ),
        ),

        // make AppBar title color explicit so it's always visible
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.white70),
        ),
      ),

      // Use a Builder so the context here is a descendant of MaterialApp and sees the theme.
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              // you can omit style here because appBarTheme.titleTextStyle is set,
              // but if you want to use textTheme you can:
              title: Text(
                "Curriculum Vitae",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(CupertinoIcons.chat_bubble),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(CupertinoIcons.ellipsis_vertical),
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
                                "Amirhossein Aarabi",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                "Product & Print Designer",
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
                                    "Tehran, Iran",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
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
                      "HTTP fetching at runtime, ideal for development. Can also be used in production to reduce app size Font file caching, on device file systemFont bundling in assets. Matching font files found in assets are prioritized over HTTP fetching. Useful for offline-first apps.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),

                  Divider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 12, 32, 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Skills",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
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
                              "Personal Information",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
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
                              "Save",
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
        },
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

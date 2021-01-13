import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/ui/screens/expense_screen.dart';

import 'ui/controllers/expense_controller.dart';

void main() async {
  await GetStorage
      .init(); // before building the app  you need to initialize GetStorage

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appdata = GetStorage(); // instance of GetStorage

  final ChangeThemeController _changeThemeController =
      Get.put(ChangeThemeController());

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = appdata.read('darkmode');
    _changeThemeController.setDarkTheme(isDarkMode);
    return Obx(
      () => GetMaterialApp(
        title: 'Expense App',
        debugShowCheckedModeBanner: false,
        theme: _changeThemeController.getIsDarkMode
            ? ThemeData.dark().copyWith(
                primaryColor: Colors.deepPurpleAccent,
                accentColor: Colors.amber,

                textTheme: TextTheme(
                  headline6: GoogleFonts.robotoCondensed(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1.0,
                  ),
                  headline5: GoogleFonts.robotoCondensed(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1.0,
                  ),
                  headline4: GoogleFonts.robotoCondensed(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1.0,
                  ),
                ),
                appBarTheme: AppBarTheme(
                  elevation: 0.0,
                  color: Colors.black54,

                ),)
            : ThemeData.light().copyWith(
          primaryColor: Colors.deepPurpleAccent,
          accentColor: Colors.amber,
          appBarTheme: AppBarTheme(
            elevation: 0.0,
          ),
          textTheme: TextTheme(
                  headline6: GoogleFonts.robotoCondensed(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1.0,
                  ),
                  headline5: GoogleFonts.robotoCondensed(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    letterSpacing: 1.0,
                  ),
                  headline4: GoogleFonts.robotoCondensed(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
        initialRoute: LoginScreen.routeNamed,
        getPages: [
          GetPage(
            name: LoginScreen.routeNamed,
            page: () => LoginScreen(),
          ),
        ],
      ),
    );
  }
}

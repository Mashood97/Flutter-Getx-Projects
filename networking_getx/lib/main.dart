import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:networking_getx/ui/controllers/post_controller.dart';
import 'package:networking_getx/ui/screens/add_post.dart';
import 'package:networking_getx/ui/screens/post_screen.dart';

void main() {
  Get.put(PostController());
  runApp(MyApp());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.amber.shade50,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
        textTheme: TextTheme(
          headline6: GoogleFonts.raleway(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
          headline5: GoogleFonts.raleway(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
          headline4: GoogleFonts.raleway(
            color: Colors.black,
            fontSize: 26.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.amber.shade50,
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 40.0,
          )
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.amber,
          textTheme: ButtonTextTheme.primary,
        ),
        canvasColor: Colors.amber.shade50,
      ),
      initialRoute: PostScreen.routeNamed,
      getPages: [
        GetPage(
          name: PostScreen.routeNamed,
          page: () => PostScreen(),
        ),
        GetPage(
          name: AddPost.routeNamed,
          page: () => AddPost(),
        ),
      ],
    );
  }
}

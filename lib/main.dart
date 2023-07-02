import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gorentcar/Login_register/login.dart';
import 'package:gorentcar/Login_register/register.dart';
import 'package:gorentcar/admin/dashboardadminScreen.dart';
import 'package:gorentcar/controller/controller.dart';
import 'package:gorentcar/homeUser/homeview.dart';
import 'package:gorentcar/menuedit/menuedit.dart';
import 'package:gorentcar/admin/profileadminScreen.dart';
import 'package:gorentcar/menutambahBarang/tambahMobil.dart';
import 'package:gorentcar/screen/datareservasi.dart';
import 'package:gorentcar/screen/detailbarang.dart';
import 'package:gorentcar/screen/verifikasiktp.dart';
// import 'Login_register/login.dart';

// import 'package:gorentcar/controller/controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
      routes: {
        '/loginPage': (context) => LoginPage(),
        '/userHome': (context) => const controllerhome(),
        '/adminHome': (context) => ProfileAdminScreen(),
        '/register': (context) => RegistrationPage(),
        '/detailbrg':(context) => DetailBarangScreen(),
        '/datareservasi':(context) => DataReservasiScreen(),
        '/verifikasiktp':(context) => VerifikasiKtpScreen(),
        '/dashboardAdmin':(context) => DashboardAdminScreen(),
        '/insertMobil':(context) => tambahMobil(),
        '/menuEdit':(context) => menuEdit()
      },
    );
  }
}

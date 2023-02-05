import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pomodolo/data/sharedpreference/sharedPreferencesData.dart';
import 'package:pomodolo/screen/auth/login_screen.dart';
import 'package:pomodolo/screen/auth/register_screen.dart';
import 'package:pomodolo/screen/home_screen.dart';
import 'package:pomodolo/screen/lounge_screen.dart';
import 'package:pomodolo/shared/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

void main() async {
  //_setupTimeZone();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Constant.primaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyAppHome(),
    );
  }
}

class MyAppHome extends StatefulWidget {
  const MyAppHome({super.key});

  @override
  State<MyAppHome> createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  String _authStatus = 'Unknown';
  Future<void> initPlugin() async {
    final TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    setState(() => _authStatus = '$status');
    // If the system can show an authorization request dialog
    if (status == TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      await showCustomTrackingDialog(context);
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      final TrackingStatus status =
          await AppTrackingTransparency.requestTrackingAuthorization();
      setState(() => _authStatus = '$status');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  Future<void> versionCheck() async {
    //アプリのバージョンを取得
    final info = await PackageInfo.fromPlatform();
    final currentVersion = Version.parse(info.version);
    print('今のバージョン$currentVersion');

    //Firestoreからアップデートしたいバージョンを取得
    final doc = await FirebaseFirestore.instance
        .collection('config')
        .doc('GFtr9GyeYHg1BEszyCUT')
        .get();
    final newVersion =
        Version.parse(doc.data()!['ios_force_app_version'].toString());

    //バージョンを比較し、現在のバージョンの方が低ければダイアログを出す
    if (currentVersion < newVersion) {
      print('hhhehehhe');
      showUpdateDialog(context);
    }
  }

  bool _isSignedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
    initPlugin();
    versionCheck();
  }

  getUserLoggedInStatus() async {
    await SharedPreferencesData().getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isSignedIn ? const LoungeScreen() : const LogInScreen(),
    );
  }

  Future<void> showCustomTrackingDialog(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ユーザー様へ'),
          content: const Text(
            'このアプリでは取得したトラッキングデータを、 '
            'お客様に合わせたご提案等のサービスの'
            '改善や向上をを目的として分析、使用させて'
            'いただきます。',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('続ける'),
            ),
          ],
        ),
      );
}

void showUpdateDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      const title = 'バージョン更新のお知らせ';
      const message = '新しいバージョンのアプリが利用可能です。ストアより更新版を入手して、ご利用下さい。';
      const btnLabel = '今すぐ更新';
      return AlertDialog(
        title: const Text(title),
        content: const Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text(
              btnLabel,
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              if (await canLaunchUrl(Constant().appStoreURL)) {
                await launchUrl(
                  Constant().appStoreURL,
                );
              } else {
                throw Error();
              }
            },
          ),
        ],
      );
    },
  );
}

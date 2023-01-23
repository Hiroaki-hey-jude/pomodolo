import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodolo/data/firebase/auth.dart';
import 'package:pomodolo/screen/auth/login_screen.dart';
import 'package:pomodolo/screen/lounge_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage('assets/background.JPG'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoungeScreen()),
                      );
                    },
                    child: const Text('Lounge'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Auth().signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LogInScreen()),
                          (route) => false);
                    },
                    child: const Text('room'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

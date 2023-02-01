import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodolo/screen/auth/register_screen.dart';
import 'package:pomodolo/shared/constant.dart';

import '../../state/login_state/login_state.dart';
import '../widgets/widgets.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final formKey = GlobalKey<FormState>();
  double deviceHeight = 0;
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        deviceHeight = MediaQuery.of(context).size.height;
        final notifier = ref.watch(loginStateProvider.notifier);
        final state = ref.watch(loginStateProvider);
        return state.isLoading
            ? Stack(
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
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(
                  FocusNode(),
                ),
                child: Stack(
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
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(
                                30, deviceHeight / 4.8, 30, 0),
                            child: Column(
                              children: [
                                const Text(
                                  'POMODORO\nROOM',
                                  style: TextStyle(
                                    color: Constant.whiteColor,
                                    fontSize: 35,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Constant.whiteColor,
                                    ),
                                    color: Constant.whiteColor.withOpacity(0.3),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(0, 10))
                                    ],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: emailEditingController,
                                        decoration:
                                            textInputDecoration.copyWith(
                                                labelText: "Email",
                                                prefixIcon: const Icon(
                                                  Icons.email,
                                                  color: Constant.blackColor,
                                                )),

                                        // check tha validation
                                        validator: (val) {
                                          return RegExp(
                                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(val!)
                                              ? null
                                              : "Please enter a valid email";
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      TextFormField(
                                        controller: passwordEditingController,
                                        obscureText: true,
                                        decoration:
                                            textInputDecoration.copyWith(
                                                labelText: "Password",
                                                prefixIcon: const Icon(
                                                  Icons.lock,
                                                  color: Constant.blackColor,
                                                )),
                                        validator: (val) {
                                          if (val!.length < 6) {
                                            return "Password must be at least 6 characters";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                          child: const Text(
                                            'ログイン',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            notifier.login(
                                              context,
                                              formKey,
                                              emailEditingController.text,
                                              passwordEditingController.text,
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Text.rich(
                                        TextSpan(
                                          text: "アカウントを持っていませんか? ",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '登録',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  decoration:
                                                      TextDecoration.underline),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  nextScreen(context,
                                                      const RegisterScreen());
                                                },
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}

// class LogInScreen extends ConsumerWidget {
//   const LogInScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(loginStateProvider);
//     final notifier = ref.watch(loginStateProvider.notifier);
//     final double deviceHeight = MediaQuery.of(context).size.height;
//     final double deviceWidth = MediaQuery.of(context).size.width;
//     final formKey = GlobalKey<FormState>();
//     final TextEditingController emailEditingController =
//         TextEditingController();
//     final TextEditingController passwordEditingController =
//         TextEditingController();
//     return Scaffold(
//       body: state.isLoading
//           ? Center(
//               child: CircularProgressIndicator(
//                 color: Theme.of(context).primaryColor,
//               ),
//             )
//           : GestureDetector(
//               onTap: () => FocusScope.of(context).requestFocus(
//                 FocusNode(),
//               ),
//               child: Stack(
//                 children: [
//                   Container(
//                     decoration: const BoxDecoration(
//                       color: Colors.black,
//                       image: DecorationImage(
//                         image: AssetImage('assets/background.JPG'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   SafeArea(
//                     child: SingleChildScrollView(
//                       child: Container(
//                         alignment: Alignment.center,
//                         padding:
//                             EdgeInsets.fromLTRB(30, deviceHeight / 5.8, 30, 0),
//                         child: Column(
//                           children: [
//                             const Text(
//                               'POMODORO\nROOM',
//                               style: TextStyle(
//                                 color: Constant.whiteColor,
//                                 fontSize: 35,
//                               ),
//                             ),
//                             const SizedBox(height: 30),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 5, horizontal: 10),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   width: 1,
//                                   color: Constant.whiteColor,
//                                 ),
//                                 color: Constant.whiteColor.withOpacity(0.3),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                       color: Colors.black12,
//                                       blurRadius: 10.0,
//                                       spreadRadius: 1.0,
//                                       offset: Offset(0, 10))
//                                 ],
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(10),
//                                   topRight: Radius.circular(10),
//                                   bottomLeft: Radius.circular(10),
//                                   bottomRight: Radius.circular(10),
//                                 ),
//                               ),
//                               child: Column(
//                                 children: [
//                                   TextFormField(
//                                     controller: emailEditingController,
//                                     decoration: textInputDecoration.copyWith(
//                                         labelText: "Email",
//                                         prefixIcon: const Icon(
//                                           Icons.email,
//                                           color: Constant.blackColor,
//                                         )),

//                                     // check tha validation
//                                     validator: (val) {
//                                       return RegExp(
//                                                   r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                               .hasMatch(val!)
//                                           ? null
//                                           : "Please enter a valid email";
//                                     },
//                                   ),
//                                   const SizedBox(height: 15),
//                                   TextFormField(
//                                     controller: passwordEditingController,
//                                     obscureText: true,
//                                     decoration: textInputDecoration.copyWith(
//                                         labelText: "Password",
//                                         prefixIcon: const Icon(
//                                           Icons.lock,
//                                           color: Constant.blackColor,
//                                         )),
//                                     validator: (val) {
//                                       if (val!.length < 6) {
//                                         return "Password must be at least 6 characters";
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                   const SizedBox(height: 20),
//                                   SizedBox(
//                                     width: double.infinity,
//                                     child: ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                           backgroundColor: Colors.white,
//                                           elevation: 0,
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(30))),
//                                       child: const Text(
//                                         'ログイン',
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       onPressed: () {
//                                         notifier.login(
//                                           context,
//                                           formKey,
//                                           emailEditingController.text,
//                                           passwordEditingController.text,
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   const SizedBox(height: 15),
//                                   Text.rich(
//                                     TextSpan(
//                                       text: "アカウントを持っていませんか? ",
//                                       style: const TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 14,
//                                       ),
//                                       children: <TextSpan>[
//                                         TextSpan(
//                                           text: '登録',
//                                           style: const TextStyle(
//                                               color: Colors.black,
//                                               decoration:
//                                                   TextDecoration.underline),
//                                           recognizer: TapGestureRecognizer()
//                                             ..onTap = () {
//                                               nextScreen(context,
//                                                   const RegisterScreen());
//                                             },
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(height: 10),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 15),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

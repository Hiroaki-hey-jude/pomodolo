import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodolo/screen/auth/login_screen.dart';
import 'package:pomodolo/state/register_state/register_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/constant.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  double deviceHeight = 0;
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final notifier = ref.watch(registerStateProvider.notifier);
        final state = ref.watch(registerStateProvider);
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
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
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
                              30, deviceHeight / 5.8, 30, 0),
                          child: Column(
                            children: [
                              const Text(
                                'POMODORO\nCHAT',
                                style: TextStyle(
                                  color: Constant.whiteColor,
                                  fontSize: 35,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Constant.whiteColor),
                                  color: Constant.whiteColor.withOpacity(0.3),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(0, 10)),
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
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: '利用規約',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 228, 168, 144),
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () async {
                                                  final Uri _url = Uri.parse(
                                                      'https://cut-primula-dac.notion.site/27bc1799880d49c7877e6f2f0e348296');
                                                  if (!await launchUrl(_url)) {
                                                  } else {
                                                    throw 'このURLにはアクセスできません';
                                                  }
                                                }),
                                          const TextSpan(
                                              text: 'と',
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: 'プライバシーポリシー',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 228, 168, 144),
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () async {
                                                  final Uri _url = Uri.parse(
                                                      'https://cut-primula-dac.notion.site/8d53f61435014ba689333c514befb566');
                                                  if (!await launchUrl(_url)) {
                                                  } else {
                                                    throw 'このURLにはアクセスできません';
                                                  }
                                                }),
                                          const TextSpan(
                                            text: 'に\n同意して始める',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: nameEditingController,
                                      decoration: textInputDecoration.copyWith(
                                          labelText: "Name",
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: Constant.blackColor,
                                          )),
                                      // check tha validation
                                      validator: (val) {
                                        if (val!.isNotEmpty) {
                                          return null;
                                        } else {
                                          return 'Name cannot be empty';
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller: emailEditingController,
                                      decoration: textInputDecoration.copyWith(
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
                                      decoration: textInputDecoration.copyWith(
                                          labelText: "Password",
                                          prefixIcon: const Icon(Icons.lock,
                                              color: Constant.blackColor)),
                                      validator: (val) {
                                        if (val!.length < 6) {
                                          return "Password must be at least 6 characters";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 250,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              elevation: 0,
                                              side: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                          child: const Text(
                                            "アカウント作成",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                    return AlertDialog(
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        side: BorderSide(
                                                          color: Colors.white,
                                                          width: 3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                      backgroundColor: Colors
                                                          .black
                                                          .withOpacity(0.5),
                                                      title: const Text(
                                                        '利用規約に同意してアカウントを作成する',
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            notifier.register(
                                                              context,
                                                              formKey,
                                                              nameEditingController
                                                                  .text,
                                                              emailEditingController
                                                                  .text,
                                                              passwordEditingController
                                                                  .text,
                                                            );
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    79,
                                                                    121,
                                                                    193),
                                                          ),
                                                          child: const Text(
                                                              '同意する'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5),
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              print('hihi');
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      79,
                                                                      121,
                                                                      193),
                                                            ),
                                                            child: const Text(
                                                                'キャンセル'),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                                });
                                          }),
                                    ),
                                    const SizedBox(height: 15),
                                    Text.rich(
                                      TextSpan(
                                        text: "アカウントをまだお持ちでないですか？ ",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 14),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'ログイン',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  decoration:
                                                      TextDecoration.underline),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  nextScreen(
                                                    context,
                                                    const LogInScreen(),
                                                  );
                                                })
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 35),
                            ],
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              );
      }),
    );
  }
}

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends ConsumerState<RegisterScreen> {

//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormState>();
//     final state = ref.watch(registerStateProvider);
//     final notifier = ref.watch(registerStateProvider.notifier);
//     final double deviceHeight = MediaQuery.of(context).size.height;
//     final double deviceWidth = MediaQuery.of(context).size.width;
//     final TextEditingController nameEditingController = TextEditingController();
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
//               onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
//               child: SafeArea(
//                   child: SingleChildScrollView(
//                 child: Container(
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.fromLTRB(30, deviceHeight / 6.8, 30, 0),
//                   child: Column(
//                     children: [
//                       const Text(
//                         'POMODORO\nROOM',
//                         style: TextStyle(
//                           color: Constant.whiteColor,
//                           fontSize: 35,
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 5,
//                           horizontal: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                               width: 1, color: Constant.whiteColor),
//                           color: Constant.whiteColor.withOpacity(0.3),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Colors.black12,
//                                 blurRadius: 10.0,
//                                 spreadRadius: 1.0,
//                                 offset: Offset(0, 10)),
//                           ],
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(10),
//                             topRight: Radius.circular(10),
//                             bottomLeft: Radius.circular(10),
//                             bottomRight: Radius.circular(10),
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             RichText(
//                               textAlign: TextAlign.center,
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                       text: '利用規約',
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Color.fromARGB(
//                                             255, 228, 168, 144),
//                                       ),
//                                       recognizer: TapGestureRecognizer()
//                                         ..onTap = () async {
//                                           final Uri _url = Uri.parse(
//                                               'https://cut-primula-dac.notion.site/4581a5ada23945d7a11862cb9140a34e');
//                                           if (!await launchUrl(_url)) {
//                                           } else {
//                                             throw 'このURLにはアクセスできません';
//                                           }
//                                         }),
//                                   const TextSpan(
//                                       text: 'と',
//                                       style: TextStyle(color: Colors.black)),
//                                   TextSpan(
//                                       text: 'プライバシーポリシー',
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Color.fromARGB(
//                                             255, 228, 168, 144),
//                                       ),
//                                       recognizer: TapGestureRecognizer()
//                                         ..onTap = () async {
//                                           final Uri _url = Uri.parse(
//                                               'https://cut-primula-dac.notion.site/b07b0b0a444847f2990172e9dddef2d2');
//                                           if (!await launchUrl(_url)) {
//                                           } else {
//                                             throw 'このURLにはアクセスできません';
//                                           }
//                                         }),
//                                   const TextSpan(
//                                     text: 'に\n同意して始める',
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             TextFormField(
//                               controller: nameEditingController,
//                               decoration: textInputDecoration.copyWith(
//                                   labelText: "Name",
//                                   prefixIcon: const Icon(
//                                     Icons.person,
//                                     color: Constant.blackColor,
//                                   )),
//                               // check tha validation
//                               validator: (val) {
//                                 if (val!.isNotEmpty) {
//                                   return null;
//                                 } else {
//                                   return 'Name cannot be empty';
//                                 }
//                               },
//                             ),
//                             const SizedBox(height: 15),
//                             TextFormField(
//                               controller: emailEditingController,
//                               decoration: textInputDecoration.copyWith(
//                                   labelText: "Email",
//                                   prefixIcon: const Icon(
//                                     Icons.email,
//                                     color: Constant.blackColor,
//                                   )),
//                               // check tha validation
//                               validator: (val) {
//                                 return RegExp(
//                                             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                         .hasMatch(val!)
//                                     ? null
//                                     : "Please enter a valid email";
//                               },
//                             ),
//                             const SizedBox(height: 15),
//                             TextFormField(
//                               controller: passwordEditingController,
//                               obscureText: true,
//                               decoration: textInputDecoration.copyWith(
//                                   labelText: "Password",
//                                   prefixIcon: const Icon(Icons.lock,
//                                       color: Constant.blackColor)),
//                               validator: (val) {
//                                 if (val!.length < 6) {
//                                   return "Password must be at least 6 characters";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             SizedBox(
//                               width: 250,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.white,
//                                     elevation: 0,
//                                     side: BorderSide(
//                                         color: Colors.black, width: 1),
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(30))),
//                                 child: const Text(
//                                   "アカウント作成",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 16),
//                                 ),
//                                 onPressed: () {
//                                   notifier.register(
//                                     context,
//                                     nameEditingController.text,
//                                     emailEditingController.text,
//                                     passwordEditingController.text,
//                                   );
//                                 },
//                               ),
//                             ),
//                             const SizedBox(height: 15),
//                             Text.rich(
//                               TextSpan(
//                                 text: "アカウントをまだお持ちでないですか？ ",
//                                 style: const TextStyle(
//                                     color: Colors.black, fontSize: 14),
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                       text: 'ログイン',
//                                       style: const TextStyle(
//                                           color: Colors.black,
//                                           decoration:
//                                               TextDecoration.underline),
//                                       recognizer: TapGestureRecognizer()
//                                         ..onTap = () {
//                                           nextScreen(
//                                             context,
//                                             const LogInScreen(),
//                                           );
//                                         })
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 35),
//                     ],
//                   ),
//                 ),
//               )),
//             ),
//     );
//     ;
//   }
// }

// class RegisterScreen extends ConsumerWidget {
//   const RegisterScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final formKey = GlobalKey<FormState>();
//     final state = ref.watch(registerStateProvider);
//     final notifier = ref.watch(registerStateProvider.notifier);
//     final double deviceHeight = MediaQuery.of(context).size.height;
//     final double deviceWidth = MediaQuery.of(context).size.width;
//     final TextEditingController nameEditingController = TextEditingController();
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
//               onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
//               child: SafeArea(
//                   child: SingleChildScrollView(
//                 child: Form(
//                   key: formKey,
//                   child: Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.fromLTRB(30, deviceHeight / 6.8, 30, 0),
//                     child: Column(
//                       children: [
//                         const Text(
//                           'POMODORO\nROOM',
//                           style: TextStyle(
//                             color: Constant.whiteColor,
//                             fontSize: 35,
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                                 width: 1, color: Constant.whiteColor),
//                             color: Constant.whiteColor.withOpacity(0.3),
//                             boxShadow: const [
//                               BoxShadow(
//                                   color: Colors.black12,
//                                   blurRadius: 10.0,
//                                   spreadRadius: 1.0,
//                                   offset: Offset(0, 10)),
//                             ],
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(10),
//                               topRight: Radius.circular(10),
//                               bottomLeft: Radius.circular(10),
//                               bottomRight: Radius.circular(10),
//                             ),
//                           ),
//                           child: Column(
//                             children: [
//                               RichText(
//                                 textAlign: TextAlign.center,
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                         text: '利用規約',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Color.fromARGB(
//                                               255, 228, 168, 144),
//                                         ),
//                                         recognizer: TapGestureRecognizer()
//                                           ..onTap = () async {
//                                             final Uri _url = Uri.parse(
//                                                 'https://cut-primula-dac.notion.site/4581a5ada23945d7a11862cb9140a34e');
//                                             if (!await launchUrl(_url)) {
//                                             } else {
//                                               throw 'このURLにはアクセスできません';
//                                             }
//                                           }),
//                                     const TextSpan(
//                                         text: 'と',
//                                         style: TextStyle(color: Colors.black)),
//                                     TextSpan(
//                                         text: 'プライバシーポリシー',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Color.fromARGB(
//                                               255, 228, 168, 144),
//                                         ),
//                                         recognizer: TapGestureRecognizer()
//                                           ..onTap = () async {
//                                             final Uri _url = Uri.parse(
//                                                 'https://cut-primula-dac.notion.site/b07b0b0a444847f2990172e9dddef2d2');
//                                             if (!await launchUrl(_url)) {
//                                             } else {
//                                               throw 'このURLにはアクセスできません';
//                                             }
//                                           }),
//                                     const TextSpan(
//                                       text: 'に\n同意して始める',
//                                       style: TextStyle(color: Colors.black),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               TextFormField(
//                                 controller: nameEditingController,
//                                 decoration: textInputDecoration.copyWith(
//                                     labelText: "Name",
//                                     prefixIcon: const Icon(
//                                       Icons.person,
//                                       color: Constant.blackColor,
//                                     )),
//                                 // check tha validation
//                                 validator: (val) {
//                                   if (val!.isNotEmpty) {
//                                     return null;
//                                   } else {
//                                     return 'Name cannot be empty';
//                                   }
//                                 },
//                               ),
//                               const SizedBox(height: 15),
//                               TextFormField(
//                                 controller: emailEditingController,
//                                 decoration: textInputDecoration.copyWith(
//                                     labelText: "Email",
//                                     prefixIcon: const Icon(
//                                       Icons.email,
//                                       color: Constant.blackColor,
//                                     )),
//                                 // check tha validation
//                                 validator: (val) {
//                                   return RegExp(
//                                               r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                           .hasMatch(val!)
//                                       ? null
//                                       : "Please enter a valid email";
//                                 },
//                               ),
//                               const SizedBox(height: 15),
//                               TextFormField(
//                                 controller: passwordEditingController,
//                                 obscureText: true,
//                                 decoration: textInputDecoration.copyWith(
//                                     labelText: "Password",
//                                     prefixIcon: const Icon(Icons.lock,
//                                         color: Constant.blackColor)),
//                                 validator: (val) {
//                                   if (val!.length < 6) {
//                                     return "Password must be at least 6 characters";
//                                   } else {
//                                     return null;
//                                   }
//                                 },
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               SizedBox(
//                                 width: 250,
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.white,
//                                       elevation: 0,
//                                       side: BorderSide(
//                                           color: Colors.black, width: 1),
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(30))),
//                                   child: const Text(
//                                     "アカウント作成",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 16),
//                                   ),
//                                   onPressed: () {
//                                     // notifier.register(
//                                     //   context,
//                                     //   formKey,
//                                     //   nameEditingController.text,
//                                     //   emailEditingController.text,
//                                     //   passwordEditingController.text,
//                                     // );
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(height: 15),
//                               Text.rich(
//                                 TextSpan(
//                                   text: "アカウントをまだお持ちでないですか？ ",
//                                   style: const TextStyle(
//                                       color: Colors.black, fontSize: 14),
//                                   children: <TextSpan>[
//                                     TextSpan(
//                                         text: 'ログイン',
//                                         style: const TextStyle(
//                                             color: Colors.black,
//                                             decoration:
//                                                 TextDecoration.underline),
//                                         recognizer: TapGestureRecognizer()
//                                           ..onTap = () {
//                                             nextScreen(
//                                               context,
//                                               const LogInScreen(),
//                                             );
//                                           })
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 35),
//                       ],
//                     ),
//                   ),
//                 ),
//               )),
//             ),
//     );
//   }
// }

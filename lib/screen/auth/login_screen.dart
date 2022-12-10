import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/login_state/login_state.dart';

class LogInScreen extends ConsumerWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginStateProvider);
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: state.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
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
                  SingleChildScrollView(
                    child: Form(
                      key: state.formKey,
                      child: Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.fromLTRB(30, deviceHeight / 4.8, 30, 0),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                            ),
                            Text('ss'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

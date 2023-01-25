import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pomodolo/shared/constant.dart';

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplacement(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

const textInputDecoration = InputDecoration(
  labelStyle:
      TextStyle(color: Constant.whiteColor, fontWeight: FontWeight.w300),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.whiteColor, width: 2),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.whiteColor, width: 2),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.whiteColor, width: 2),
  ),
);

const textInputDecorationPopUp = InputDecoration(
  labelStyle:
      TextStyle(color: Constant.whiteColor, fontWeight: FontWeight.w300),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.blackColor, width: 2),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.blackColor, width: 2),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.blackColor, width: 2),
  ),
);

Widget profilePicturesWidget(String id) {
  return SizedBox(
    height: 50,
    width: 50,
    child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          String originalImgURL = snapshot.data!.get('profilePic') as String !=
                  ''
              ? snapshot.data!.get('profilePic') as String
              : 'https://msp.c.yimg.jp/images/v2/FUTi93tXq405grZVGgDqGx5cm8knTLo61O84kVTxOan841a30-aIJSoqkmlQNsP4-Qv0KVqX9M9vYFUiwJk7Td3V7vPM0KOdWqrUituYvtnSar9x6L84qPLmIBtWCypFJz0KXlr7qn7fBK3IAzXNoKqa8nXN1Pz9ov4LKOTDRDV8wVWo1nQMCGO9E4o6K36McUAylQDeTQRNF9Op3JfY2iTFAun4IWDGV3qwbY8bHxZl4xSjUUv4fCzYvGjh2ca9bpeFmXd2K-uN80LrsmWEALH9sYrv73X1ZPxpgNLPBEe_7WG2Ffw6G1V4ZRj10gSJAhhlIWmL3Dppp79xAsruIw==/800px-Solid_blue.svg.png?errorImage=false';
          print(originalImgURL);
          return CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(originalImgURL),
          );
        }),
  );
}

Widget goalPomoWidget(String id) {
  return Container(
    width: 70,
    child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          return Text(
            '${snapshot.data!.get('currentNumOfPomo')}/${snapshot.data!.get('goalPomo')}ポモ',
            style: TextStyle(fontWeight: FontWeight.bold),
          );
        }),
  );
}

showDialogForStart(BuildContext context) {
  
}


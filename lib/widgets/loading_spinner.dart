import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:agendamento_vacina/utils/colors.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50,),
        Center(
          child: SpinKitFadingCircle(
            color: AppColor.circuitsColor,
            size: 75.0,
          )
        )
      ]
    );
  }
}
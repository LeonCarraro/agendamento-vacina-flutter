import 'package:flutter/material.dart';

import 'package:agendamento_vacina/utils/colors.dart';

class Step extends StatelessWidget {
  final String title;

  const Step({
    Key key,
    this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title",
          style: TextStyle(
            fontSize: 15,
            color: AppColor.setsColor,
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }
}

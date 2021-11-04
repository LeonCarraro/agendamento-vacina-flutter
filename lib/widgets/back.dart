import 'package:flutter/material.dart';

import 'package:agendamento_vacina/utils/colors.dart';

class Back extends StatelessWidget {
  final String title;

  const Back({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: AppColor.homePageIcons,
        ),
        Text(
          "$title",
          style: TextStyle(
            fontSize: 15,
            color: AppColor.homePageSubtitle,
            fontWeight: FontWeight.w700
          ),
        )
      ],
    );
  }
}

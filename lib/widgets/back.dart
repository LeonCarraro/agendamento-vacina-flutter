import 'package:flutter/material.dart';

import 'package:agendamento_vacina/utils/colors.dart';

class Back extends StatelessWidget {
  final String title;
  final Function onTap;

  const Back({
    Key key,
    this.title,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
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
      )
    );
  }
}

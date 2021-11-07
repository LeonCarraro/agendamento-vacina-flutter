import 'package:flutter/material.dart';

import 'package:agendamento_vacina/utils/colors.dart';

class PageTitle extends StatelessWidget {
  final String title;

  const PageTitle({
    Key key,
    @required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            "$title",
            style: TextStyle(
            fontSize: 20,
            color: AppColor.homePageTitle,
            fontWeight: FontWeight.w700
            ),
          )
        ),
      ],
    );
  }
}

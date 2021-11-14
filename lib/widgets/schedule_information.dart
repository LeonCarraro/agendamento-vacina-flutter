import 'package:flutter/material.dart';

import 'package:agendamento_vacina/utils/colors.dart';

class ScheduleInformation extends StatelessWidget {
  final String title;
  final String description;

  const ScheduleInformation({
    Key key,
    @required this.title,
    @required this.description
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: RichText(
            text: TextSpan(
              style: TextStyle(height: 1.2),
              children: [
                TextSpan(
                  text: "$title: ",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.circuitsColor,
                    fontWeight: FontWeight.w500
                  ),
                ),
                TextSpan(
                  text: "$description",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.setsColor,
                    fontWeight: FontWeight.w500
                  ),
                )
              ]
            )
          ),
        ),
      ]
    );
  }
}

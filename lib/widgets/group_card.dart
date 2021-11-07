import 'package:flutter/material.dart';

import 'package:agendamento_vacina/utils/colors.dart';

class GroupCard extends StatelessWidget {
  final String title;
  final String description;

  const GroupCard({
    Key key,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColor.homePagePlanColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(38.5),
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title\n",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.homePageTitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "$description",
                  style: TextStyle(
                    color: AppColor.homePageTitle,
                  ),
                )
              ]
            )
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            onPressed: () => {
              print('Escolheu um grupo de idade')
            },
          )
        ],
      )
    );
  }
}

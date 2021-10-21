import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:agendamento_vacina/utils/colors.dart';
import 'package:agendamento_vacina/widgets/groud_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List data = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    DefaultAssetBundle.of(context).loadString("json/group_data.json").then((response) => {
      data = json.decode(response)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 25, left: 25, right: 25,),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: AppColor.homePageIcons,
                  ),
                  Text(
                    "Voltar",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColor.homePageSubtitle,
                      fontWeight: FontWeight.w700
                    ),
                  )
                ],
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Text(
                    "Passo 01 de 03",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColor.setsColor,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Escolha o grupo pertencente a sua idade",
                      style: TextStyle(
                      fontSize: 20,
                      color: AppColor.homePageTitle,
                      fontWeight: FontWeight.w700
                      ),
                    )
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.gradientFirst.withOpacity(0.8),
                      AppColor.gradientSecond.withOpacity(0.9)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Já fez o seu agendamento?",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.homePageContainerTextSmall,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "Toque aqui para consultar ou agendar uma nova data!",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.homePageContainerTextSmall
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      return GroupCard(
                        title: data[index]["title"],
                        description: data[index]["description"],
                      );
                    },
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}

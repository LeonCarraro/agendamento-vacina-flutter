import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:agendamento_vacina/utils/colors.dart';
import 'package:agendamento_vacina/widgets/group_card.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/back.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/step.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/page_title.dart' as CustomWidget;

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
              CustomWidget.Back(title: "Inicio"),
              SizedBox(height: 30,),
              CustomWidget.Step(title: "Passo 01 de 03"),
              SizedBox(height: 10,),
              CustomWidget.PageTitle(title: "Escolha o grupo pertencente a sua idade"),
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
                      return CustomWidget.GroupCard(
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

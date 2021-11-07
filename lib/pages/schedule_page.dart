import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:agendamento_vacina/utils/colors.dart';
import 'package:agendamento_vacina/pages/health_posts_page.dart';
import 'package:agendamento_vacina/widgets/back.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/step.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/page_title.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/group_card.dart' as CustomWidget;

class SchedulePage extends StatefulWidget {
  SchedulePage({Key key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  Future findSchedules() async => 
      await Future.delayed(Duration(seconds: 1), () async {
        String response = await rootBundle.loadString('json/schedule_data.json');
        return json.decode(response);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 25, left: 25, right: 25,),
          child: Column(
            children: [
              SizedBox(height: 30,),
              CustomWidget.Back(title: "Voltar", onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HealthPostsPage()))
              }),
              SizedBox(height: 30,),
              CustomWidget.Step(title: "Passo 04 de 04"),
              SizedBox(height: 10,),
              CustomWidget.PageTitle(title: "Escolha o horário da vacinação"),
              SizedBox(height: 30,),
              
              SizedBox(height: 10,),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder(
                    future: findSchedules(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            return CustomWidget.GroupCard(
                              title: snapshot.data[index]["dayOfWeek"] + "  -  " + snapshot.data[index]["dayOfMonth"],
                              description: snapshot.data[index]["schedule"],
                              extraLine: false,
                              nextPage: null,
                            );
                          },
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(height: 50,),
                            Center(
                              child: CircularProgressIndicator()
                            )
                          ]
                        );
                      }
                    }
                  ),
                ]
              ),
            ]
          )
        )
      )
    );
  }
}
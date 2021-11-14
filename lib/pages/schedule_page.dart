import 'dart:convert';

import 'package:agendamento_vacina/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:agendamento_vacina/utils/colors.dart';
import 'package:agendamento_vacina/pages/health_posts_page.dart';
import 'package:agendamento_vacina/pages/success_sheduling_page.dart';
import 'package:agendamento_vacina/models/schedule.dart';
import 'package:agendamento_vacina/widgets/back.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/step.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/page_title.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/group_card.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/loading_spinner.dart' as CustomWidget;

class SchedulePage extends StatefulWidget {
  final int id;
  final int groupId;
  final bool hasSchedule;
  final int healthPostId;
  final String healthPostAddress;

  SchedulePage({
    Key key, 
    @required this.id, 
    @required this.groupId,
    @required this.healthPostId,
    @required this.healthPostAddress, 
    @required this.hasSchedule}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  Future future;

  initState() {
    super.initState();
    future = findSchedules();
  }

  Future findSchedules() async => 
      await Future.delayed(Duration(seconds: 1), () async {
        final response = await http.get("http://192.168.100.8:8080/v1/api/schedules", headers: {
        "Accept": "application/json; charset=utf-8",
        "Content-type":"application/json; charset=utf-8"
      });

        return json.decode(response.body);
      });

  void schedule(int scheduleId) async {
    final Schedule schedule = new Schedule(widget.id, widget.groupId, widget.healthPostId, scheduleId);

    try {
      final response = await http.post("http://192.168.100.8:8080/v1/api/vaccines-application", body: schedule.toJson(), headers: {
        "Accept": "application/json; charset=utf-8",
        "Content-type":"application/json; charset=utf-8"
      });

      if (response.statusCode == 403) {
        setState(() {
          // TODO: Implementar tratamento de erro
        });
      } else if (response.statusCode == 201) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SuccessSchedulingPage(vaccineApplicatonId: json.decode(response.body)['id'],)));
      }
    } catch (e) {
      setState(() {
          // TODO: Implementar tratamento de erro
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 25, left: 15, right: 15,),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    CustomWidget.Back(title: "Voltar", onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                        HealthPostsPage(id: widget.id, groupId: widget.groupId, hasSchedule: widget.hasSchedule,)))
                    }),
                    SizedBox(height: 30,),
                    CustomWidget.Step(title: "Passo 04 de 04"),
                    SizedBox(height: 10,),
                    CustomWidget.PageTitle(title: "Escolha o horário da vacinação"),
                    SizedBox(height: 30,),
                  ],
                )
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 40),
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
                          Radius.circular(0)
                        )
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Local selecionado",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.homePageContainerTextSmall,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                              Icon(
                                Icons.location_on_outlined,
                                size: 40,
                                color: AppColor.homePageContainerTextSmall,
                              ),
                              Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                              Flexible(
                                child: Text(
                                  widget.healthPostAddress,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColor.homePageContainerTextSmall
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.only(top: 0, left: 25, right: 25,),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FutureBuilder(
                          future: future,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (_, index) {
                                  return CustomWidget.GroupCard(
                                    title: snapshot.data[index]["dayOfWeek"] + "  -  " + Utils.formatDate(snapshot.data[index]["dayOfMonth"]),
                                    description: snapshot.data[index]["schedule"],
                                    extraLine: false,
                                    validation: () => {
                                      schedule(snapshot.data[index]["id"])
                                    }
                                  );
                                },
                              );
                            } else {
                              return CustomWidget.LoadingSpinner();
                            }
                          }
                        ),
                      ]
                    ),
                  ],
                )
              )
            ]
          )
        )
      )
    );
  }
}

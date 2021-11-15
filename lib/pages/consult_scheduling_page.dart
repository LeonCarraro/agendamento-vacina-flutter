import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:brasil_fields/brasil_fields.dart';

import 'package:agendamento_vacina/utils/colors.dart';
import 'package:agendamento_vacina/utils/utils.dart';
import 'package:agendamento_vacina/widgets/back.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/step.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/page_title.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/group_card.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/schedule_information.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/loading_spinner.dart' as CustomWidget;
import 'package:agendamento_vacina/pages/groups_page.dart';

class ConsultSchedulingPage extends StatefulWidget {
  final int vaccineApplicationId;

  ConsultSchedulingPage({Key key, @required this.vaccineApplicationId}) : super(key: key);

  @override
  _ConsultSchedulingPageState createState() => _ConsultSchedulingPageState();
}

class _ConsultSchedulingPageState extends State<ConsultSchedulingPage> {
  int id;
  String name;
  String cpf;
  String healthPost;
  String address;
  String schedule;
  String ageGroup;

  Future future;

  @override
  void initState() {
    super.initState();
    future = findById();
  }

  Future findById() async {
    try {
      final response = await http.get("http://192.168.100.8:8080/v1/api/vaccines-application/" + widget.vaccineApplicationId.toString(), headers: {
        "Accept": "application/json; charset=utf-8",
        "Content-type":"application/json; charset=utf-8"
      });

      if (response.statusCode == 200) {
        setState(() {
          final dynamic responseObject = json.decode(response.body);
          id = responseObject['user']['id'];
          name = responseObject['user']['name'];
          cpf = responseObject['user']['cpf'];
          healthPost = responseObject['healthPost']['title'];
          address = responseObject['healthPost']['address'];
          ageGroup = responseObject['ageGroup']['title'];
          schedule = 
            Utils.formatDate(responseObject['schedule']['dayOfMonth']) + ' - ' + 
            responseObject['schedule']['schedule'] + ' (' + 
            responseObject['schedule']['dayOfWeek'] + ')';
        });
      }

      return response;
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
                    padding: EdgeInsets.only(top: 28, left: 18, right: 18,),
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        CustomWidget.Back(title: "Voltar", onTap: () => {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupsPage(id: id, hasSchedule: true,)))
                        }),
                    SizedBox(height: 30,),
                    CustomWidget.PageTitle(title: "Consultar informações do agendamento"),
                    SizedBox(height: 30,),
                    FutureBuilder(
                      future: future,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              CustomWidget.ScheduleInformation(title: "Nome", description: name),
                              SizedBox(height: 8,),
                              CustomWidget.ScheduleInformation(
                                title: "CPF", 
                                description: cpf == null ? "Houve um problema ao obter o CPF" : UtilBrasilFields.obterCpf(cpf)
                              ),
                              SizedBox(height: 8,),
                              CustomWidget.ScheduleInformation(title: "Grupo", description: ageGroup),
                              SizedBox(height: 8,),
                              CustomWidget.ScheduleInformation(title: "Local", description: healthPost),
                              SizedBox(height: 8,),
                              CustomWidget.ScheduleInformation(title: "Endereço", description: address),
                              SizedBox(height: 8,),
                              CustomWidget.ScheduleInformation(title: "Horário", description: schedule),
                              SizedBox(height: 30,),
                              GestureDetector(
                                onTap: () => {
                                  Alert(
                                    context: context,
                                    style: AlertStyle(
                                      animationType: AnimationType.fromTop,
                                      isCloseButton: false,
                                      isOverlayTapDismiss: false,
                                      animationDuration: Duration(milliseconds: 500),
                                      backgroundColor: AppColor.homePageBackground,
                                    ),
                                    type: AlertType.warning,
                                    title: "Cancelar agendamento?",
                                    desc: "Você pode reagendar novamente a qualquer momento!",
                                    buttons: [
                                      DialogButton(
                                        color: AppColor.gradientFirst,
                                        child: Text(
                                          "Continuar",
                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                        ),
                                        onPressed: () => {
                                          Navigator.pop(context),
                                        },
                                        width: 125,
                                      ),
                                      DialogButton(
                                        color: AppColor.error,
                                        child: Text(
                                          "Cancelar",
                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                        ),
                                        onPressed: () => {
                                          Navigator.pop(context),
                                        },
                                        width: 125,
                                      ),
                                    ],
                                  ).show()
                                },
                                child: Container(
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
                                        "Não poderá comparecer?",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.homePageContainerTextSmall,
                                          fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        "Toque aqui para cancelar seu agendamento!",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: AppColor.homePageContainerTextSmall
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return CustomWidget.LoadingSpinner();
                        }
                      },
                    ),
                  ],
                )
              ),
            ]
          )
        )
      )
    );
  }
}

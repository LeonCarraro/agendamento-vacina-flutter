import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:agendamento_vacina/utils/colors.dart';
import 'package:agendamento_vacina/pages/home_page.dart';
import 'package:agendamento_vacina/widgets/back.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/step.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/page_title.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/group_card.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/loading_spinner.dart' as CustomWidget;
import 'package:agendamento_vacina/pages/health_posts_page.dart';

class GroupsPage extends StatefulWidget {
  final String cpf;

  GroupsPage({Key key, @required this.cpf}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  Future findGroups() async => 
      await Future.delayed(Duration(seconds: 1), () async {
        final response = await http.get("http://192.168.100.8:8080/v1/api/age-groups", headers: {
        "Accept": "application/json; charset=utf-8",
        "Content-type":"application/json; charset=utf-8"
      });

        return json.decode(response.body);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 25, left: 15, right: 15,),
          child: Column(
            children: [
              SizedBox(height: 30,),
              CustomWidget.Back(title: "Início", onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()))
              }),
              SizedBox(height: 30,),
              CustomWidget.Step(title: "Passo 02 de 04"),
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
              SizedBox(height: 10,),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder(
                    future: findGroups(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            return CustomWidget.GroupCard(
                              title: snapshot.data[index]["title"],
                              description: snapshot.data[index]["description"],
                              extraLine: false,
                              nextPage: HealthPostsPage(cpf: widget.cpf, groupId: snapshot.data[index]["id"],),
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
          ),
        ),
      ),
    );
  }
}

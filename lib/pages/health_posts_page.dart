import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:agendamento_vacina/utils/colors.dart';
import 'package:agendamento_vacina/utils/theme.dart';
import 'package:agendamento_vacina/pages/groups_page.dart';
import 'package:agendamento_vacina/pages/schedule_page.dart';
import 'package:agendamento_vacina/widgets/back.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/step.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/page_title.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/group_card.dart' as CustomWidget;

class HealthPostsPage extends StatefulWidget {
  final String cpf;
  final int groupId;

  HealthPostsPage({Key key, @required this.cpf, @required this.groupId}) : super(key: key);

  @override
  _HealthPostsPageState createState() => _HealthPostsPageState();
}

class _HealthPostsPageState extends State<HealthPostsPage> {
  Future findHealthPosts() async => 
      await Future.delayed(Duration(seconds: 1), () async {
        final response = await http.get("http://192.168.100.8:8080/v1/api/health-posts", headers: {
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
          padding: EdgeInsets.only(top: 25, left: 25, right: 25,),
          child: Column(
            children: [
              SizedBox(height: 30,),
              CustomWidget.Back(title: "Voltar", onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupsPage(cpf: widget.cpf)))
              }),
              SizedBox(height: 30,),
              CustomWidget.Step(title: "Passo 03 de 04"),
              SizedBox(height: 10,),
              CustomWidget.PageTitle(title: "Escolha o posto de saúde"),
              SizedBox(height: 30,),
              Container(
                child: TextFormField(
                  onChanged: (String value) => {
                    // TODO: Implementar filtro
                    print('pesquisou por ' + value)
                  },
                  decoration: AppTheme().textInputSearchDecoration('Pesquisar'),
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              SizedBox(height: 10,),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder(
                    future: findHealthPosts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            return CustomWidget.GroupCard(
                              title: snapshot.data[index]["title"],
                              description: snapshot.data[index]["address"],
                              extraLine: true,
                              nextPage: SchedulePage(
                                cpf: widget.cpf, 
                                groupId: widget.groupId, 
                                healthPostId: snapshot.data[index]["id"], 
                                healthPostAddress: snapshot.data[index]["address"],),
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
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:agendamento_vacina/utils/colors.dart';
import 'package:agendamento_vacina/pages/groups_page.dart';
import 'package:agendamento_vacina/utils/theme.dart';
import 'package:agendamento_vacina/widgets/back.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/step.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/page_title.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/group_card.dart' as CustomWidget;

class HealthPostsPage extends StatefulWidget {
  HealthPostsPage({Key key}) : super(key: key);

  @override
  _HealthPostsPageState createState() => _HealthPostsPageState();
}

class _HealthPostsPageState extends State<HealthPostsPage> {
  Future findHealthPosts() async => 
      await Future.delayed(Duration(seconds: 1), () async {
        String response = await rootBundle.loadString('json/health_post_data.json');
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupsPage()))
              }),
              SizedBox(height: 30,),
              CustomWidget.Step(title: "Passo 03 de 04"),
              SizedBox(height: 10,),
              CustomWidget.PageTitle(title: "Escolha o posto de saúde"),
              SizedBox(height: 30,),
              Container(
                child: TextFormField(
                  onChanged: (String value) => {
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
            ],
          ),
        ),
      ),
    );
  }
}

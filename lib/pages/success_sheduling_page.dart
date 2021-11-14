import 'package:flutter/material.dart';

import 'package:agendamento_vacina/utils/colors.dart';
import 'package:agendamento_vacina/utils/theme.dart';
import 'package:agendamento_vacina/pages/consult_scheduling_page.dart';

class SuccessSchedulingPage extends StatefulWidget {
  final int vaccineApplicatonId;

  SuccessSchedulingPage({Key key, @required this.vaccineApplicatonId}) : super(key: key);

  @override
  _SuccessSchedulingPageState createState() => _SuccessSchedulingPageState();
}

class _SuccessSchedulingPageState extends State<SuccessSchedulingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 25, left: 15, right: 15,),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Stack(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColor.backgroundIconBox.withOpacity(0.25),
                          AppColor.backgroundIconBox.withOpacity(0.25),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25)
                      )
                    ),
                    child: 
                  Icon(
                    Icons.check,
                    size: 80,
                    color: AppColor.defaultIcon,
                  ),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Text(
                "Agendamento\n realizado com\n sucesso.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: AppColor.homePageTitle,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 40,),
              Container(
                child: ElevatedButton(
                  style: AppTheme().buttonStyle(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                    child: Text(
                      "Consultar meu agendamento".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConsultSchedulingPage(vaccineApplicationId: widget.vaccineApplicatonId)))
                  }
                ),
              ),
            ]
          )
        )
      )
    );
  }
}
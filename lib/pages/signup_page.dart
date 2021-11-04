import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

import 'package:agendamento_vacina/utils/colors.dart';
import 'package:agendamento_vacina/utils/theme.dart';
import 'package:agendamento_vacina/widgets/back.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/step.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/page_title.dart' as CustomWidget;
import 'package:agendamento_vacina/pages/groups_page.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
              },),
              SizedBox(height: 30,),
              CustomWidget.Step(title: "Passo 02 de 03"),
              SizedBox(height: 10,),
              CustomWidget.PageTitle(title: "Realize o pré cadastro"),
              SizedBox(height: 30,),
              Container(
                child: TextFormField(
                  decoration: AppTheme().textInputDecoration('Nome completo'),
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              SizedBox(height: 30,),
              Container(
                child: TextFormField(
                  decoration: AppTheme().textInputDecoration("E-mail"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if((val.isNotEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                      return "Digite um e-mail valido!";
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(height: 30,),
              Container(
                child: TextFormField(
                  decoration: AppTheme().textInputDecoration("CPF"),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Container(
                child: TextFormField(
                  decoration: AppTheme().textInputDecoration("Celular"),
                  keyboardType: TextInputType.phone,
                  validator: (val) {
                    if((val.isNotEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val)){
                      return "Digite um numero de celular valido!";
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(height: 30,),
              Container(
                child: TextFormField(
                  obscureText: true,
                  decoration: AppTheme().textInputDecoration("Senha"),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Digite uma senha!";
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

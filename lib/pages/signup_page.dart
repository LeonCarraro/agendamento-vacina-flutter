import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:brasil_fields/brasil_fields.dart';

import 'package:agendamento_vacina/utils/colors.dart';
import 'package:agendamento_vacina/utils/theme.dart';
import 'package:agendamento_vacina/utils/regex.dart';
import 'package:agendamento_vacina/pages/home_page.dart';
import 'package:agendamento_vacina/pages/groups_page.dart';
import 'package:agendamento_vacina/widgets/back.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/step.dart' as CustomWidget;
import 'package:agendamento_vacina/widgets/page_title.dart' as CustomWidget;

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
          padding: EdgeInsets.only(top: 25, left: 15, right: 15,),
          child: Column(
            children: [
              SizedBox(height: 30,),
              CustomWidget.Back(title: "Voltar", onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()))
              },),
              SizedBox(height: 30,),
              CustomWidget.Step(title: "Passo 01 de 04"),
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
              SizedBox(height: 20,),
              Container(
                child: TextFormField(
                  decoration: AppTheme().textInputDecoration("E-mail"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if((val.isNotEmpty) && !RegExp(AppRegex.email).hasMatch(val)){
                      return "Digite um e-mail valido!";
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(height: 20,),
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
              SizedBox(height: 20,),
              Container(
                child: TextFormField(
                  decoration: AppTheme().textInputDecoration("Data de nascimento"),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DataInputFormatter(),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child: TextFormField(
                  decoration: AppTheme().textInputDecoration("Celular"),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  validator: (val) {
                    if((val.isNotEmpty) && !RegExp(AppRegex.phone).hasMatch(val)){
                      return "Digite um numero de celular valido!";
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(height: 20,),
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
              SizedBox(height: 20,),
              Container(
                child: TextFormField(
                  obscureText: true,
                  decoration: AppTheme().textInputDecoration("Confirmação de senha"),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Confirme a sua senha!";
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(height: 30,),
              Container(
                child: ElevatedButton(
                  style: AppTheme().buttonStyle(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: Text(
                      "Registrar".toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () => {
                    // TODO: Corrigir cpf: null
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupsPage(cpf: null)))
                  }
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}

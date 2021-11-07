import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

import 'package:agendamento_vacina/utils/colors.dart';
import 'package:agendamento_vacina/utils/theme.dart';
import 'package:agendamento_vacina/models/login.dart';
import 'package:agendamento_vacina/pages/signup_page.dart';
import 'package:agendamento_vacina/pages/groups_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final loginModel = new Login();

  final formKey = GlobalKey<FormState>();
  
  String errorMsg;

  Future<void> login() async {
    try {
      final response = await http.post("http://192.168.100.8:8080/v1/api/login", body: loginModel.toJson(), headers: {
        "Accept": "application/json; charset=utf-8",
        "Content-type":"application/json; charset=utf-8"
      });

      if (response.statusCode == 403) {
        setState(() {
          errorMsg = jsonDecode(response.body)['message'];
        });
      } else if (response.statusCode == 200) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupsPage(cpf: jsonDecode(response.body)['cpf'])));
      }
    } catch (e) {
      setState(() {
        errorMsg = "Houve um problema no servidor!";
      });
    }
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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              Text(
                "Consultar meu agendamento",
                style: TextStyle(
                fontSize: 20,
                color: AppColor.homePageTitle,
                fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 30,),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        onSaved: (String value) => {
                          loginModel.cpf = CPFValidator.strip(value)
                        },
                        decoration: AppTheme().textInputDecoration("CPF"),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        validator: (val) {
                          if (!CPFValidator.isValid(val) || val.isEmpty) {
                            return "Digite um CPF valido!";
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: TextFormField(
                        onSaved: (String value) => {
                          loginModel.password = value
                        },
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
              if (errorMsg != null) SizedBox(height: 30.0),
              if (errorMsg != null) Text(
                  errorMsg,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.error,
                    fontWeight: FontWeight.w500
                  ),
                ),
              SizedBox(height: 30.0),
              Container(
                child: ElevatedButton(
                  style: AppTheme().buttonStyle(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: Text(
                      "Entrar".toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () => {
                    setState(() {
                      errorMsg = null;
                    }),

                    if (formKey.currentState.validate()) {
                      formKey.currentState.save(),
                      login(),
                    }
                  }
                ),
              ),
              SizedBox(height: 15.0),
              GestureDetector(
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupPage()))
                },
                child: Text(
                  "Registre-se agora!",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColor.homePageTitle,
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}

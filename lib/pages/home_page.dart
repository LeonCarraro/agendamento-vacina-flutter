import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:brasil_fields/brasil_fields.dart';

import 'package:agendamento_vacina/utils/colors.dart';
import 'package:agendamento_vacina/utils/theme.dart';
import 'package:agendamento_vacina/pages/signup_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  onPressed: () => {}
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
              )
            ],
          ),
        )
      )
    );
  }
}
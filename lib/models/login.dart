import 'dart:convert';

class Login {
  String cpf;
  String password;

  String toJson() => jsonEncode({
    "cpf": cpf,
    "password": password,
  });
}

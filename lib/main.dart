import 'package:flutter/material.dart';

import 'package:agendamento_vacina/pages/groups_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agendamento para vacinação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GroupsPage(),
    );
  }
}

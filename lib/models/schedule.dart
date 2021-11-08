import 'dart:convert';

class Schedule {
  String cpf;
  int groupId;
  int healthPostId;
  int scheduleId;

  Schedule(String cpf, int groupId, int healthPostId, int scheduleId) {
    this.cpf = cpf;
    this.groupId = groupId;
    this.healthPostId = healthPostId;
    this.scheduleId = scheduleId;
  }

  String toJson() => jsonEncode({
    "cpf": cpf,
    "groupId": groupId,
    "healthPostId": healthPostId,
    "scheduleId": scheduleId,
  });
}

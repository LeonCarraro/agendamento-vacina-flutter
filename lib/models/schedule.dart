import 'dart:convert';

class Schedule {
  int id;
  int groupId;
  int healthPostId;
  int scheduleId;

  Schedule(int id, int groupId, int healthPostId, int scheduleId) {
    this.id = id;
    this.groupId = groupId;
    this.healthPostId = healthPostId;
    this.scheduleId = scheduleId;
  }

  String toJson() => jsonEncode({
    "id": id,
    "groupId": groupId,
    "healthPostId": healthPostId,
    "scheduleId": scheduleId,
  });
}

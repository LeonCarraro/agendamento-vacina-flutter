import 'dart:convert';

class Schedule {
  int userId;
  int groupId;
  int healthPostId;
  int scheduleId;

  Schedule(int userId, int groupId, int healthPostId, int scheduleId) {
    this.userId = userId;
    this.groupId = groupId;
    this.healthPostId = healthPostId;
    this.scheduleId = scheduleId;
  }

  String toJson() => jsonEncode({
    "userId": userId,
    "groupId": groupId,
    "healthPostId": healthPostId,
    "scheduleId": scheduleId,
  });
}

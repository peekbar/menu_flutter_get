import 'package:json_annotation/json_annotation.dart';

import 'package:uuid/uuid.dart';

import 'weekday.dart';

part 'opening_hours.g.dart';

@JsonSerializable()
class OpeningHours {
  @JsonKey(name: 'id', required: true)
  final String id;

  @JsonKey(name: 'days', required: true)
  final Set<Weekday> days;

  @JsonKey(name: 'hours', required: true)
  final String hours;

  OpeningHours({required this.id, required this.days, required this.hours});

  factory OpeningHours.fromJson(Map<String, dynamic> json) => _$OpeningHoursFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningHoursToJson(this);

  OpeningHours copy() => OpeningHours(id: const Uuid().v4(), days: days.toSet(), hours: hours);
}

import 'dart:developer';

class TimeSlotModel {
  TimeSlotModel({
    required this.isOpen,
    required this.timeSlots,
    required this.timezone,
    this.nextOpenDay,
  });
  late final bool isOpen;
  late final String timezone;
  late final List<List<DateTime>> timeSlots;
  String? nextOpenDay;

  TimeSlotModel.fromJson(Map json) {
    isOpen = json['is_open'];
    timeSlots = (json['time_slots'] as List).isEmpty
        ? []
        : (json['time_slots'] as List)
            .map(
              (e) => (e as List).map((e) {
                log(DateTime.parse((e as String).substring(0, 19)).toString(),
                    name: "Time slot model substring time");
                log(e.substring(19), name: "Time slot model time zone");
                return DateTime.parse((e as String).substring(0, 19));
              }).toList(),
            )
            .toList();
    timezone = (json['time_slots'] as List).isEmpty
        ? ""
        : ((((json['time_slots'] as List).first) as List).first as String)
            .substring(19);
    nextOpenDay = json['next_open_day'] ?? "";
    log(nextOpenDay!);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['is_open'] = isOpen;
    _data['time_slots'] = timeSlots;
    _data['next_open_day'] = nextOpenDay;
    return _data;
  }
}

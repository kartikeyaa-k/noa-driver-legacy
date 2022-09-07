class DriverLocationStatus {
  final int? driverId;
  final String? previousLatitued;
  final String? previousLongitued;
  final String? latitued;
  final String? longitued;

  DriverLocationStatus({
    this.driverId,
    this.previousLatitued,
    this.previousLongitued,
    this.latitued,
    this.longitued,
  });

  DriverLocationStatus.fromJson(Map<String, dynamic> json)
      : driverId = json['driverId'] as int?,
        previousLatitued = json['previousLatitued'] as String?,
        previousLongitued = json['previousLongitued'] as String?,
        latitued = json['latitued'] as String?,
        longitued = json['longitued'] as String?;

  Map<String, dynamic> toJson() => {
    'driverId' : driverId,
    'previousLatitued' : previousLatitued,
    'previousLongitued' : previousLongitued,
    'latitued' : latitued,
    'longitued' : longitued
  };
}
import 'package:flutter/foundation.dart';

class Train {
  Train({
    @required this.id,
    @required this.origin,
    @required this.destination,
    @required this.arrival,
    @required this.departure,
    @required this.departurePlatform,
    @required this.arrivalPlatform,
  });

  Train.fromDto(Map<String, dynamic> dto) {
    print(dto.toString());
    id = dto['Trainno'];
    origin = dto['OrignStation'];
    destination = dto['DestinationStation'];
    arrival = dto['ArrivalTime'];
    departure = dto['DepartureTime'];
    arrivalPlatform = int.parse(dto['DestPlatform']);
    departurePlatform = int.parse(dto['Platform']);
  }

  String id, origin, destination, arrival, departure;
  int arrivalPlatform, departurePlatform;

  String get departurePlatformString {
    return departurePlatform > 0 ? departurePlatform.toString() : 'Unknown';
  }

  String get arrivalPlatformString {
    return departurePlatform > 0 ? departurePlatform.toString() : 'Unknown';
  }
}
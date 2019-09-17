import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../api/constants.dart';

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
    id = dto['Trainno'];
    origin = dto['OrignStation'];
    destination = dto['DestinationStation'];
    arrival = DateFormat(apiDateFormat).parse(dto['ArrivalTime']);
    departure = DateFormat(apiDateFormat).parse(dto['DepartureTime']);
    arrivalPlatform = int.parse(dto['DestPlatform']);
    departurePlatform = int.parse(dto['Platform']);
  }

  String id, origin, destination;
  DateTime arrival, departure;
  int arrivalPlatform, departurePlatform;

  String get departurePlatformString {
    return departurePlatform > 0 ? departurePlatform.toString() : 'Unknown';
  }

  String get arrivalPlatformString {
    return departurePlatform > 0 ? departurePlatform.toString() : 'Unknown';
  }

  String get departureTime {
    return DateFormat('HH:mm').format(departure);
  }

  String get arrivalTime {
    return DateFormat('HH:mm').format(arrival);
  }
}

class TrainRoute {
  TrainRoute({
    @required this.trains
  });

  final List<Train> trains;

  bool get isDirect {
    return trains.length == 1;
  }
}

class Station {
  Station({
    @required this.id,
    @required this.name
  });

  final String id;
  final String name;
}
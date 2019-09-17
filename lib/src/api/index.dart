import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

import '../data/data_models.dart';
import './constants.dart';

class TrainAPI {
  static Future<List<TrainRoute>> fetchRoutes({@required String origin, @required String destination, DateTime time}) async {
    time ??= DateTime.now();
    final String formattedDate = DateFormat(apiDateFormat).format(time);

    final Map<String, String> requestParams = {
      'date': formattedDate,
      'origin': origin,
      'destination': destination,
      'hours': numberOfHoursToFetch.toString()
    };
    final Uri url = Uri.https(serverUrl, schedulePath, requestParams);
    final http.Response response = await http.get(url);
    // final String response = await rootBundle.loadString('response.json');
    final Map<String, dynamic> responseJson = jsonDecode(response.body);
    // final Map<String, dynamic> responseJson = jsonDecode(response);
    final List<dynamic> rawTrains = TrainAPI._extractRawTrains(responseJson);

    return rawTrains.map<TrainRoute>(
      (dynamic dtoRoute) => TrainRoute(trains: dtoRoute.map<Train>(
          (dynamic dtoTrain) => Train.fromDto(dtoTrain)
        ).toList()
      )
    ).toList();
    // return rawTrains.map<List<Train>>(
    //   (dynamic dtoRoute) => dtoRoute.map<Train>(
    //     (dynamic dtoTrain) => Train.fromDto(dtoTrain)
    //   ).toList()
    // ).toList();
  }

  static Future<List<Station>> fetchStations() async {
    final String response = await rootBundle.loadString('assets/stations.json');
    final Map<String, dynamic> responseJson = jsonDecode(response);
    final List<dynamic> stationData = responseJson['Stations']['Station'];
    return stationData.map<Station>((dynamic stationDto) => Station.fromDto(stationDto)).toList();
  }


  static List<dynamic> _extractRawTrains(Map<String, dynamic> json) {
    final List<dynamic> response = <dynamic>[];
    if (json['LUZ']['Directs'] != null) {
      response.addAll(
        json['LUZ']['Directs']['Direct'].map(
          (dynamic rawRoute) => <dynamic>[rawRoute['train']]
        ).toList()
      );
    }
    if (json['LUZ']['Indirects'] != null) {
      response.addAll(
        json['LUZ']['Indirects']['Indirect'].map(
          (dynamic rawRoute) => rawRoute['train']
        ).toList()
      );
    }
    return response;
  }
}

import 'package:flutter/material.dart';
import '../data/data_models.dart';

typedef OnStationPicked = void Function(Station station);

class StationPicker extends StatelessWidget {
  const StationPicker({
    @required this.stationsList,
    @required this.initialStation,
    @required this.onStationPicked
  });

  final List<Station> stationsList;
  final Station initialStation;
  final OnStationPicked onStationPicked;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      )
    );
  }
}
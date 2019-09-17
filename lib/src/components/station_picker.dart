import 'package:flutter/material.dart';
import '../data/data_models.dart';

typedef OnStationPicked = void Function(Station station);

class StationPicker extends StatelessWidget {
  StationPicker({
    @required this.stationsList,
    @required this.selectedStation,
    @required this.onStationPicked
  });

  final List<Station> stationsList;
  Station selectedStation;
  final OnStationPicked onStationPicked;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0,),
      child: Container(
        height: 160,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedStation.id,
              items: stationsList.map((Station station) =>
                DropdownMenuItem<String>(
                  value: station.id,
                  child: Text(station.name)
                )
              ).toList(),
              onChanged: (String stationId) => onStationPicked(stationsList.firstWhere((Station s) => s.id == stationId))
            ),
          ]
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';
import '../data/data_models.dart';

class RouteCard extends StatelessWidget {
  const RouteCard({
    @required this.route
  });

  final TrainRoute route;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Next Train'
            ),
            Text(
              '${route.trains.first.departureTime}',
              style: TextStyle(fontSize: 60),
            ),
            Text(
              '${route.trains.last.arrivalTime}'
            )
          ],
        ),
      )
    );
  }
}
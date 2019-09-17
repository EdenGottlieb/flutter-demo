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
      margin: const EdgeInsets.symmetric(vertical: 8.0,),
      child: Container(
        height: 160,
        width: MediaQuery.of(context).size.width * 0.8,
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
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './src/api/index.dart';
import './src/components/route_card.dart';
import './src/components/station_picker.dart';
import './src/data/data_models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    _updateStations();
  }
  void _updateRoutes() {
    setState(() {
      isFetching = true;
    });
    TrainAPI.fetchRoutes(origin: departureStation.id, destination: arrivalStation.id).then((List<TrainRoute> result) {
      setState(() {
        isFetching = false;
        routes = result.where((TrainRoute r) => r.trains.first.departure.isAfter(DateTime.now())).toList();
      });
    });
  }
  void _updateStations() {
    TrainAPI.fetchStations().then((List<Station> fetchedStations) {
      setState(() {
        stations = fetchedStations;
        departureStation = fetchedStations[0];
        arrivalStation = fetchedStations[1];
      });
      _updateRoutes();
    });
  }
  List<TrainRoute> routes = <TrainRoute>[];
  List<Station> stations = <Station>[];
  Station departureStation;
  Station arrivalStation;
  bool isFetching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container (
          margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ...stations.isNotEmpty ? (
                  <Widget>[
                    StationPicker(
                      stationsList: stations,
                      selectedStation: departureStation,
                      onStationPicked: (Station station) {
                        setState(() {
                          departureStation = station;
                        });
                        _updateRoutes();
                      },
                    ),
                    StationPicker(
                      stationsList: stations,
                      selectedStation: arrivalStation,
                      onStationPicked: (Station station) {
                        setState(() {
                          arrivalStation = station;
                        });
                        _updateRoutes();
                      },
                    )
                  ]
                ) : const <Widget>[],
                if (isFetching) CupertinoActivityIndicator(),
                ...routes.map<RouteCard>((TrainRoute route) => RouteCard(route: route,))
              ],
            ),
          )
        )
      ),
    );
  }
}

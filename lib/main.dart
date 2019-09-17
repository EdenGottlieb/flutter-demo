import 'package:flutter/material.dart';
import './src/api/index.dart';
import './src/components/route_card.dart';
import './src/components/choose_station.dart';
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
    TrainAPI.fetchRoutes(origin: departureStation.id, destination: arrivalStation.id).then((List<TrainRoute> result) {
      setState(() {
        routes = result;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container (
          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ...(stations.isNotEmpty ? (
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
                ) : []),
                ...routes.map<RouteCard>((TrainRoute route) => RouteCard(route: route,))
              ],
            ),
          )
        )
      ),
    );
  }
}

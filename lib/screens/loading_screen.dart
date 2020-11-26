import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var data = await WeatherModel().fetchData();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(data);
      }));
  }

  @override
  Widget build(BuildContext context) {

    return SpinKitFoldingCube(
      color: Colors.white,
      size: 150.0,
    );
  }
}

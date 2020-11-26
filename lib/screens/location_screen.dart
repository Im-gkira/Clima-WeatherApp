import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.data);
  final data;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  var city;
  var id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.data);
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "ALERT!",
        desc: "Something Went Wrong.Try again!",
        buttons: [
          DialogButton(
            child: Text(
              "Reload",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      return;
    } else {
      temperature = weatherData['main']['temp'].round();
      city = weatherData['name'];
      id = weatherData['weather'][0]['id'];
    }
  }

  @override
  Widget build(BuildContext context) {

    ResponsiveWidgets.init(context,
      height: 1920, // Optional
      width: 1080, // Optional
      allowFontScaling: true, // Optional
    );

    return ResponsiveWidgets.builder(
      child: Scaffold(
        body: ContainerResponsive(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/location_bg.gif'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var data = await WeatherModel().fetchData();
                        updateUI(data);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }));
                        if(typedName!=0){
                          updateUI(await Networking().getCityLocation(typedName));
                          print(temperature);
                          print(city);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsResponsive.only(bottom: 40.0, left: 10.0),
                  child: Row(
                    children: <Widget>[
                      AutoSizeText(
                        temperature.toString() + '°C',
                        style: kTempTextStyle,
                      ),
                      AutoSizeText(
                        WeatherModel().getWeatherIcon(id),
                        style: kConditionTextStyle,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsResponsive.only(bottom: 100.0, right: 15.0),
                  child: AutoSizeText(
                    "${WeatherModel().getMessage(temperature)} in $city!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

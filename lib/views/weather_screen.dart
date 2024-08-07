import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  @override
  createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final double latitude = 44.34;
  final double longitude = 10.99;

  late Future<Weather> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = _weatherService.fetchWeather(latitude, longitude);
  }

  String getWeatherGif(String description) {
    if (description.contains('clear') || description.contains('sun')) {
      return 'assets/images/sun.gif';
    } else if (description.contains('cloud') || description.contains('cold')) {
      return 'assets/images/cold.gif';
    }
    return 'assets/images/default.gif';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima de la Ubicación'),
        backgroundColor: const Color(0xff0F539C),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<Weather>(
        future: _weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching weather'));
          } else if (snapshot.hasData) {
            final weather = snapshot.data!;
            return Center(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(getWeatherGif(weather.description)),
                      const SizedBox(height: 20),
                      Text(
                        '${weather.temperature} °C',
                        style: const TextStyle(fontSize: 48),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        weather.description,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Prob. de precipitaciones: ${weather.precipitation}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Humedad: ${weather.humidity}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Viento: ${weather.windSpeed} km/h',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

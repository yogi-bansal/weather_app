import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:weather_demo/weather_data.dart';
import 'current_weather.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Flutter Weather App'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

  ShowLocationData? weatherData;
  String? date;

  final mainViewProvider = Provider<Widget>((ref) {
    final dataWeather = ref.watch(configurationsProvider);
    return currentWeather(
        Icons.wb_sunny_rounded,
        ((dataWeather.value?.main.humidity.toString() ?? 'Loading') + 'F\u00B0'),
        date?.toString() ?? 'Loading',
        dataWeather.value?.name ?? 'Loading',
        dataWeather.value?.weather[0].main ?? 'Loading',
        '18:30', Icons.refresh, Colors.white, true, 50.0, () {
          configurationsProvider;
      }
    );
  });

  final listViewProvider = Provider<Widget>((ref) {
    final dataWeather = ref.watch(configurationsProvider);
    return Card(
      margin: const EdgeInsets.all(5),
      child: currentWeather(
          Icons.wb_sunny_rounded,
          ((dataWeather.value?.main.humidity.toString() ?? 'Loading') + 'F\u00B0'),
          date?.toString() ?? 'Loading',
          dataWeather.value?.name ?? 'Loading',
          dataWeather.value?.weather[0].main ?? 'Loading',
          '18:30', Icons.refresh, Colors.black, false, 15.0, null),
    );
  });


  final configurationsProvider = FutureProvider<ShowLocationData?>((ref) async {
    Response response;
    var dio = Dio();
    response = await dio.get('https://api.openweathermap.org/data/2.5/weather?q=Sirsa&appid=dd1bf84bb1791c24b2e268019fe90052');
    weatherData =  ShowLocationData.fromJson(response.data);
    var dt = DateTime.fromMillisecondsSinceEpoch(weatherData!.dt * 1000);
    date = DateFormat('MM/dd/yyyy').format(dt);
    //return weatherData;
    return ShowLocationData.fromJson(response.data);
  });

  class _MyHomePageState extends ConsumerState<MyHomePage> {
    @override
    void initState() {
      super.initState();
    //ref.read(configurationsProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Consumer(builder: (context, watch, child) {
            return watch.watch(mainViewProvider);
          }),
          SizedBox(
            height: 224,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Consumer(builder: (context, watch, child) {
                    return watch.watch(listViewProvider);
                  });
               }),
            ),
          )
        ],
      )
    );
  }
}


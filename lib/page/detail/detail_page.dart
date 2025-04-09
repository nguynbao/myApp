import 'package:my_first_app/apps/config/theme_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/weather.dart';
import 'package:my_first_app/page/detail/widget/detail_body.dart';
import 'package:my_first_app/providers/weather_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff1D6CF3), Color(0xff19D2FE)],
        ),
      ),
      child: FutureBuilder(
        future: context.read<WeatherProvider>().getWeatherDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<WeatherDetail> listdata = snapshot.data as List<WeatherDetail>;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: false,
              elevation: 0,
              title: Row(
                children: [
                  Icon(CupertinoIcons.location),
                  SizedBox(width: 10),
                  Text(
                    '${context.read<WeatherProvider>().cityName}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              actions: const [Icon(CupertinoIcons.search), SizedBox(width: 20)],
            ),
            body: DetailBody(listData: listdata),
          );
        },
      ),
    );
  }
}

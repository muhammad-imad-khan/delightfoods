import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'api_service.dart';

class CustomDashboard extends StatefulWidget {
  @override
  _CustomDashboardState createState() => _CustomDashboardState();
}

class _CustomDashboardState extends State<CustomDashboard> {
  final ApiService apiService = ApiService();
  Future<List<dynamic>>? _data;

  @override
  void initState() {
    super.initState();
    _data = apiService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('4 Cards Grid with Charts'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              padding: EdgeInsets.all(10.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChartCard(data: snapshot.data![index]),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class ChartCard extends StatelessWidget {
  final dynamic data;

  ChartCard({required this.data});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = [];
    for (var datum in data) {
      double x = datum['domain'] is int ? datum['domain'].toDouble() : datum['domain'];
      double y = datum['measure'] is int ? datum['measure'].toDouble() : datum['measure'];
      spots.add(FlSpot(x, y));
    }

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: spots,
          ),
        ],
      ),
    );
  }
}

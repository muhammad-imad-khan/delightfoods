import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'barModel.dart';

class BarChartYearly extends StatelessWidget {
  const BarChartYearly({Key? key}) : super(key: key);

  List<BarChartGroupData> _createSampleData() {
    final data = [
      BarModel("Jan", 20),
      BarModel("Feb", 5),
      BarModel("Mar", 24),
      BarModel("Apr", 34),
      BarModel("May", 64),
      BarModel("June", 9),
      BarModel("July", 20),
    ];

    return data
        .asMap()
        .map((index, barModel) {
          return MapEntry(
            index,
            BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: barModel.value.toDouble(),
                  color: Colors.green,
                  width: 30, // Corrected from colors to color
                ),
              ],
            ),
          );
        })
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders By Yearly"),
      ),
      body: Container(
        height: 300,
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            barGroups: _createSampleData(),
            borderData: FlBorderData(
              show: false,
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    const style = TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    );
                    Widget text;
                    switch (value.toInt()) {
                      case 0:
                        text = const Text('2018', style: style);
                        break;
                      case 1:
                        text = const Text('2019', style: style);
                        break;
                      case 2:
                        text = const Text('2020', style: style);
                        break;
                      case 3:
                        text = const Text('2021', style: style);
                        break;
                      case 4:
                        text = const Text('2022', style: style);
                        break;
                      case 5:
                        text = const Text('2023', style: style);
                        break;
                      case 6:
                        text = const Text('2024', style: style);
                        break;
                      default:
                        text = const Text('', style: style);
                        break;
                    }
                    return SideTitleWidget(child: text, space: 4, axisSide: meta.axisSide);
                  },
                  reservedSize: 28,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
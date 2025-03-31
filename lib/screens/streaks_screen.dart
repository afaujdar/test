import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../utilities/image_handling.dart';

class StreaksScreen extends StatefulWidget {
  const StreaksScreen({super.key});

  @override
  State<StreaksScreen> createState() => _StreaksScreenState();
}

class _StreaksScreenState extends State<StreaksScreen> {

  int todayStreak = 0;

  @override
  void initState() {
    fetchImages();
    super.initState();
  }






  Future<void> fetchImages() async {
    String today = DateTime.now().toIso8601String().split('T')[0];

    List<String> allTodayImages = await getImagesByDate(today);

    setState(() {
      todayStreak=allTodayImages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Streaks"),
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),

              const Text("Today's Goal: 3 streak days", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),

              const SizedBox(height: 20,),

              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.pink.shade800.withOpacity(.1),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Streak Days", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                      SizedBox(height: 10,),
                      Text("3", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              const Text("Daily Streak", style: TextStyle(fontSize: 25),),

              Text(todayStreak.toString(), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

              const SizedBox(height: 20,),

              Row(
                children: [
                  Text("Last 30 Days ", style: TextStyle(color: Colors.pink.shade800)),
                  const Text("+100%", style: TextStyle(color: Colors.green),)
                ],
              ),

              const SizedBox(height: 10,),

              SizedBox(
                width: double.maxFinite,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {
                                case 0:
                                  return Text('1D', style: TextStyle(fontSize: 12, color: Colors.pink.shade800, fontWeight: FontWeight.bold));
                                case 2:
                                  return Text('1W', style: TextStyle(fontSize: 12, color: Colors.pink.shade800, fontWeight: FontWeight.bold));
                                case 4:
                                  return Text('1M', style: TextStyle(fontSize: 12, color: Colors.pink.shade800, fontWeight: FontWeight.bold));
                                case 6:
                                  return Text('3M', style: TextStyle(fontSize: 12, color: Colors.pink.shade800, fontWeight: FontWeight.bold));
                                case 8:
                                  return Text('6M', style: TextStyle(fontSize: 12, color: Colors.pink.shade800, fontWeight: FontWeight.bold));
                                case 10:
                                  return Text('1Y', style: TextStyle(fontSize: 12, color: Colors.pink.shade800, fontWeight: FontWeight.bold));
                                default:
                                  return const SizedBox.shrink(); // Hide other labels
                              }
                            },


                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      minX: 0,
                      maxX: 10,
                      minY: 0,
                      maxY: 10,
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 3),
                            FlSpot(1, 7),
                            FlSpot(2, 5),
                            FlSpot(3, 8),
                            FlSpot(4, 6),
                            FlSpot(5, 3),
                            FlSpot(6, 7),
                            FlSpot(7, 5),
                            FlSpot(8, 8),
                            FlSpot(10, 5),
                          ],
                          isCurved: true,
                          color: Colors.pink.shade800,
                          barWidth: 2.0,
                          shadow: const Shadow(color: Colors.pink, blurRadius: 40, offset: Offset(0, 20)),
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              const Text("Keep it up! You're on a roll.", style: TextStyle(fontSize: 15),),

              const SizedBox(height: 20,),

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity, // Takes full available width
                    child: FilledButton.tonal(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.pink.shade800.withOpacity(.1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                      ),
                      child: const Text("Get Started",style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

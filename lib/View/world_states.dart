import 'package:covid_tracker_app/Model/WorldStatesModel.dart';
import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:covid_tracker_app/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this
  )..repeat();

  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {

    StateServices stateServices = StateServices();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder(
                future: stateServices.fetchWorldStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                        flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          )
                      );
                    }
                    else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(snapshot.data!.cases!.toString()),
                              "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                              "Deaths": double.parse(snapshot.data!.deaths!.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left
                            ),
                            animationDuration: const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                            child: Container(
                              height: 420,
                              child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: Column(
                                      children: [
                                        ResuableWidget(title: "Total Cases", value: snapshot.data!.cases!.toString()),
                                        ResuableWidget(title: "Deaths", value: snapshot.data!.deaths!.toString()),
                                        ResuableWidget(title: "Recovered", value: snapshot.data!.recovered!.toString()),
                                        ResuableWidget(title: "Active Cases", value: snapshot.data!.active!.toString()),
                                        ResuableWidget(title: "Critical Cases", value: snapshot.data!.critical!.toString()),
                                        ResuableWidget(title: "Today Cases", value: snapshot.data!.todayCases!.toString()),
                                        ResuableWidget(title: "Today Deaths", value: snapshot.data!.todayDeaths!.toString()),
                                        ResuableWidget(title: "Today Recovered", value: snapshot.data!.todayRecovered!.toString()),
                                        ResuableWidget(title: "Population", value: snapshot.data!.population!.toString()),
                                        ResuableWidget(title: "Tests", value: snapshot.data!.tests!.toString()),
                                        ResuableWidget(title: "Affected Countries", value: snapshot.data!.affectedCountries!.toString()),
                                      ],
                                    ),
                                  );
                                },

                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesListScreen()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Center(
                                child: Text("Track Countries"),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class ResuableWidget extends StatelessWidget {

  String title, value;

  ResuableWidget({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5,),
          const Divider(),
        ],
      ),
    );
  }
}

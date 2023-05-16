import 'package:covid_tracker_app/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  String name ;
  String image;
  int totalCases, totalDeaths, totalRecovered, active, critical,todayRecovered, tests;

  DetailScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.tests,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .06,),
                      ResuableWidget(title: 'Cases',value: widget.totalCases.toString(),),
                      ResuableWidget(title: 'Total Deaths',value: widget.totalDeaths.toString(),),
                      ResuableWidget(title: 'Total Recovered',value: widget.totalRecovered.toString(),),
                      ResuableWidget(title: 'Active Cases',value: widget.active.toString(),),
                      ResuableWidget(title: 'Critical Cases',value: widget.critical.toString(),),
                      ResuableWidget(title: 'Today Recovered',value: widget.todayRecovered.toString(),),
                      ResuableWidget(title: 'Tests',value: widget.tests.toString(),),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}

import 'package:ageCalculator/ad_manager.dart';
import 'package:ageCalculator/utils/age.dart';
import 'package:ageCalculator/utils/ui.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AgeCalculator());
}

class AgeCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        canvasColor: AppColors.canvasColor,
        colorScheme: ColorScheme.dark(
          primary: Color.fromRGBO(61, 213, 152, 1),
          onPrimary: Color.fromRGBO(33, 50, 58, 1),
          surface: Color.fromRGBO(61, 213, 152, 1),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> _initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  BannerAd _bannerAd;

  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.bottom);
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: AdManager.appId);
    // ignore: todo
    // TODO: Initialize _bannerAd
    _bannerAd = BannerAd(
        adUnitId: AdManager.bannerAdUnitId, // BannerAd.testAdUnitId,// 
        size: AdSize.banner,
    );
    // ignore: todo
    // TODO: Load a Banner Ad
    _loadBannerAd();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  void dispose() {
    // ignore: todo
    // TODO: Dispose BannerAd object
    _bannerAd?.dispose();

    super.dispose();
  }

  String age = '0';
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 13,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png',width: 120,),
              SizedBox(height: 10),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate:DateTime.now(),
                    );
                  if (picked != null && picked != selectedDate){
                    DateTime birthday = picked; // DateTime(1990, 1, 20);
                    DateTime today = DateTime.now(); //2020/1/24
                    AgeDuration _age;
                    _age = Age.dateDifference(fromDate: birthday, toDate: today, includeToDate: false);
                    setState(() {
                      age = _age.toString();
                      selectedDate = picked;
                    });
                  }
                }, 
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'Pick Your DOB',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).canvasColor
                    )
                  ),
                )
              ),
              SizedBox(height: 20),
              Text(
                'Selected Date : ' + selectedDate.month.toString() + '/' + selectedDate.day.toString() + '/' + selectedDate.year.toString(),
                style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white38)
              ),
              SizedBox(height: 30),
              Text(
                'Age : ' + age.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300,color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
            ],
          )
        )
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:tayeh/screens/filter_result_screen.dart';
import 'package:tayeh/widget/filter_result_listview_design.dart';
import 'package:tayeh/widget/home_list_view_design.dart';

class FilterScreen extends StatefulWidget {
  static const routName = '/filter';

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool isMale;
  double age = null;

  returnFilterProps() {
    FilterResultListViewDesign.foundChildAge = age;
    FilterResultListViewDesign.foundChildGender = isMale == null ? null : (isMale ? 'Male' : 'Female');
    Navigator.of(context).pushNamed(FilterResult.routName);
    //lostchildlistfilter, age, isMale
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Select age',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Slider(
                activeColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  setState(() {
                    age = value;
                  });
                },
                value: age == null ? 1 : age,
                min: 1,
                divisions: 14,
                max: 15,
              ),
              Container(
                height: 20,
                child: Text(
                  age == null ? 'Not selected' : '${age.round()}' + " year/s",
                  textAlign: TextAlign.end,
                ),
                width: MediaQuery.of(context).size.width - 45,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Gender',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ///////////////////////GenderSelection//////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = true;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2 - (25),
                      decoration: BoxDecoration(
                        color: isMale == true
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 1.5),
                        borderRadius: new BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        'Male',
                        style: TextStyle(
                            color: isMale == true
                                ? Colors.white
                                : Theme.of(context).primaryColor),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = false;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2 - (25),
                      decoration: BoxDecoration(
                          color: isMale == true || isMale == null
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 1.5),
                          borderRadius: new BorderRadius.all(
                            Radius.circular(50.0),
                          )),
                      child: Center(
                          child: Text(
                        'Female',
                        style: TextStyle(
                            color: isMale == true || isMale == null
                                ? Theme.of(context).primaryColor
                                : Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: returnFilterProps,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1.5),
                      borderRadius: new BorderRadius.all(
                        Radius.circular(50.0),
                      )),
                  child: Center(
                    child: Text(
                      'Apply filters',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    FilterResultListViewDesign.foundChildAge = null;
                    FilterResultListViewDesign.foundChildGender = null;
                    setState(() {
                      isMale = null;
                      age = null;
                    });

//                    Navigator.of(context).pop();
                  });
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1.5),
                      borderRadius: new BorderRadius.all(
                        Radius.circular(50.0),
                      )),
                  child: Center(
                    child: Text(
                      'Remove all filters',
                      style: TextStyle(
                          fontSize: 18, color: Theme.of(context).primaryColor),
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

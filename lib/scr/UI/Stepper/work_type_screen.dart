
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkType extends StatefulWidget {
  @override
  _WorkTypeState createState() => _WorkTypeState();
}

class _WorkTypeState extends State<WorkType>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(top: 90.0),
            child: Padding(
              padding: const EdgeInsets.only(left:55.0, right: 55.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text("Let Employers know what you're looking for.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23
                      ),
                    ),
                  ),
                  SizedBox(height: 60.0),
                  Text('Full Time, Part Time'),
                  SizedBox(height: 10.0),
                  DropdownButton<String>(
                    hint: Text('Please Select'),
                    items: <String>['Full Time', 'Part Time'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),

                ],
              ),
            )
        )
    );
  }

}
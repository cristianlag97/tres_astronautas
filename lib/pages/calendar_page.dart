import 'package:flutter/material.dart';
import 'package:tres_astronautras/ui/colors.dart';
import 'package:intl/intl.dart';
import 'package:tres_astronautras/widget/header.dart';


class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HeaderNasa(isSettings: true,),
            Container(
              height: MediaQuery.of(context).size.height *0.7,
              padding: const EdgeInsets.only(left: 18, bottom: 16),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Choose a date Range',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${startDate != null ? DateFormat("dd, MMM").format(startDate!) : '-'} / ${endDate != null ? DateFormat("dd, MMM").format(endDate!) : '-'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCustomDateRangePicker();
        },
        tooltip: 'choose date Range',
        child: const Icon(Icons.calendar_today_outlined, color: Colors.white),
      ),
    );
  }

  void showCustomDateRangePicker() {
    endDate = DateTime.now();
    startDate = DateTime.now();
    setState(() {
    });
  }
}
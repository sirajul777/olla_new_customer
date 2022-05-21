import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Components/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatePickerPage extends StatefulWidget {
  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  @override
  void initState() {
    super.initState();

    dateTime = getDateTime();
  }

  DateTime dateTime = DateTime.now();
  List<String> _month = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  Duration duration = Duration(hours: 1, minutes: 6, seconds: 30);

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
          border: Border.all(color: softGrey, width: 0.5),
          borderRadius: BorderRadius.circular(20.w)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // buildDatePicker(),
          // Text('Setup Date'),

          GestureDetector(
              onTap: () {
                Utils.showSheet(
                  context,
                  child: buildDatePicker(),
                  onClicked: () {
                    // Utils.showSheet(context, 'Selected "$value"');

                    Navigator.pop(context);
                  },
                );
              },
              child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.circular(20.w)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${dateTime.day}',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${_month[dateTime.month - 1]}',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${dateTime.year}',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ))),
          const SizedBox(height: 24),

          GestureDetector(
              onTap: () {
                Utils.showSheet(
                  context,
                  child: buildTimePicker(),
                  onClicked: () {
                    Navigator.pop(context);
                  },
                );
              },
              child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.circular(20.w)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Pukul ',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ),
                      dateTime.minute != 0
                          ? Text(
                              '${dateTime.hour}:${dateTime.minute}',
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w600),
                            )
                          : Text(
                              '${dateTime.hour}:${dateTime.minute}0',
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w600),
                            ),
                      // Text(''),
                    ],
                  ))),
        ],
      ),
    );
  }

  Widget buildDatePicker() => SizedBox(
        height: 240,
        width: ScreenUtil.defaultSize.width - 20,
        child: CupertinoDatePicker(
          minimumYear: 2022,
          maximumYear: DateTime.now().year + 3,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) => setState(() {
            this.dateTime = dateTime;
          }),
        ),
      );

  Widget buildTimePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.time,
          minuteInterval: 10,
          // use24hFormat: false,
          onDateTimeChanged: (timePick) =>
              setState(() => this.dateTime = timePick),
        ),
      );

  DateTime getDateTime() {
    var now = DateTime.now();

    return DateTime(now.year, now.month, now.day, now.hour, 0);
  }
}

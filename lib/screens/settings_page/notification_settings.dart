import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key key}) : super(key: key);

  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {

  TimeOfDay initTime = new TimeOfDay(hour: 7, minute: 0);
  bool isNotificationOn = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getIsNotificationOn();
    _getNotificationTime();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003640),
        title: Text("Notification"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xff107272),
        ),
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
              ),
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                title: Text("Daily Brief Notification"),
                subtitle: Text("This include your daily subjects, time, location and subject note"),
                trailing: Switch(
                  value: this.isNotificationOn,
                  onChanged: (value){
                    setState(() {
                      this.isNotificationOn = value;
                    });
                    _setIsNotificationOn(value);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
              ),
              child: ListTile(
                title: Text("Notification Time"),
                trailing: Text("${initTime.hour.toString().padLeft(2, "0")} : ${initTime.minute.toString().padLeft(2, "0")}"),
                onTap: ()async{
                  await _pickTime();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _setIsNotificationOn(bool value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isNotificationOn", value);
  }

  _setNotificationTime(TimeOfDay time) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("isNotificationTime", "${time.hour.toString().padLeft(2, "0")} : ${time.minute.toString().padLeft(2, "0")}");
  }

  _getNotificationTime() async{
    final prefs = await SharedPreferences.getInstance();
    String timeString = prefs.getString("isNotificationTime");
    if (timeString.isNotEmpty){
      setState(() {
        this.initTime = TimeOfDay(
            hour: int.parse(timeString.substring(0,2)),
            minute: int.parse(timeString.substring(5,7)));
      });
    }

  }



  _getIsNotificationOn() async{
    final prefs = await SharedPreferences.getInstance();
    bool value = true;
    try {
      value = prefs.getBool("isNotificationOn");
    } catch (e){
      value = true;
    }
    setState(() {
      this.isNotificationOn = value;
    });
  }

  _pickTime() async{
    TimeOfDay initTime = this.initTime;

    TimeOfDay selectedTime = await showTimePicker(
        context: context,
        initialTime: initTime
    );

    if(selectedTime != null){
      setState(() {
        this.initTime = selectedTime;
      });
      _setNotificationTime(selectedTime);
    }
  }
}

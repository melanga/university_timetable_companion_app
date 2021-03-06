import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intelij/screens/Seminar/seminar_screen.dart';
import 'package:flutter_intelij/screens/settings_page/notification_settings.dart';
import 'package:flutter_intelij/screens/subjectSelection/subject_selection.dart';
import 'package:flutter_intelij/screens/toDoList/screens/homepage.dart';
import 'package:flutter_intelij/services/auth.dart';

class SettingsPanel extends StatefulWidget {
  const SettingsPanel(this.userCategory, {Key key}) : super(key: key);

  final String userCategory;
  @override
  _SettingsPanelState createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  final List <String>settings = [
    'Task List',
    'Subjects',
    'Seminar & Workshops',
    'Notifications',
    'Log Out',
  ];

  double screenWidth, screenHeight;

  int selectedSetting;
  final AuthSevice _auth = AuthSevice();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      elevation: 16,
      child: Material(
        color: Color(0xFF012329),
        child: Container(
          child: Stack(
            children: [
              Positioned(
                left: 8.0,
                top: screenHeight*0.05,

                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.jpg'),
                              fit: BoxFit.contain
                          ),
                        ),
                      ),
                      Text('Timetable & Task Management \n System',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                        ),
                      ),
                    ],

                  ),
                ),
              ),


              Container(
                  margin: EdgeInsets.only(left: 10.0, top: screenHeight * 0.2,),
                child: ListView.builder(
                    itemCount: settings.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async{
                          if (index == 0){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Homepage())
                            );
                          } else if (index == 1){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SubjectSelection())
                            );
                          } else if (index == 2) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SeminarScreen(widget.userCategory))
                            );
                          }else if (index == 3){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NotificationSettings())
                            );
                          } else if (index == 4){
                            _auth.signOut();
                          }
                          setState(() {
                            selectedSetting = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            settings[index],
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: selectedSetting == index ? Colors.white : Colors.white70,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          )
        ),
      ),
    );
  }
}

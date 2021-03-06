import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intelij/screens/addSubject/subjectTimeSlot/subject_timeslot_popup_builder.dart';
import 'package:flutter_intelij/shared/hero_dialog_route.dart';
class SubjectTimeSlotBuilder extends StatefulWidget {
  const SubjectTimeSlotBuilder(this.subjectCode, {Key key}) : super(key: key);
  final String subjectCode;
  @override
  _SubjectTimeSlotBuilderState createState() => _SubjectTimeSlotBuilderState();
}

class _SubjectTimeSlotBuilderState extends State<SubjectTimeSlotBuilder> {
  @override
  Widget build(BuildContext context) {
    Stream data = FirebaseFirestore.instance.collection("SubjectTimeSlot").where('course_Code', isEqualTo: widget.subjectCode).snapshots();
    return StreamBuilder<QuerySnapshot>(
          stream: data,
          builder: (context, snapshot2){
            if (snapshot2.hasData){
              return ListView(
                physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: snapshot2.data.docs.map((doc2) {
                    return Padding(
                        padding: EdgeInsets.all(0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: Color(0xffa8cece),
                          child: ListTile(
                            title: Text(doc2.data()['day']),
                            subtitle: Text("${doc2.data()['start_Time']} to ${doc2.data()['end_Time']}"),
                            trailing: Text(doc2.data()['location']),
                            onTap: (){
                              Navigator.of(context).push(
                                HeroDialogRoute(
                                  builder: (context) => Center(
                                      child: EditSubjectTimeSlotPopupBuilder(doc2, widget.subjectCode)
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    );
                  }).toList(),
                );
            } else {
              return Text("no data");
            }
          }
      );
  }
}

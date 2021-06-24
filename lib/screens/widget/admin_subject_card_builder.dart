import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intelij/screens/addSubject/edit_subject_popup_builder.dart';
import 'package:flutter_intelij/shared/hero_dialog_route.dart';

class AdminSubjectCardBuilder{

  var adminSubjectCardBuilder = StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Subjects").snapshots(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          return ListView(
            children: snapshot.data.docs.map((doc) {
              return Hero(
                tag: doc.id,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: ListTile(
                      title: Text(doc.data()['subject_Name']),
                      subtitle: Text(doc.data()['start_date'].toDate()
                          .toString()
                          .substring(0, 10) + " to " + doc.data()['end_date']
                          .toDate().toString()
                          .substring(0, 10)),
                      trailing: Text(doc.id),
                      onTap: (){
                        Navigator.of(context).push(
                          HeroDialogRoute(
                            builder: (context) => Center(
                              child: EditSubjectPopUpBuilder(doc)
                            ),
                          ),
                        );
                      },
                    ),
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


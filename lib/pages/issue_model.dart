import 'package:cached_network_image/cached_network_image.dart';
import 'package:case_app/models/case.dart';
import 'package:case_app/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Issue extends StatefulWidget {

  final String issueId ;
  final String ownerId ;
  final String issue ;
  final String fullAddress ;
  final String resType ;
  final String city ;
  final String phone ;
  final String fullName ;
  final String fireType ;
  final String firePlace ;
  final String injuryCount ;
  final String injuryType ;



  Issue({this.issueId , this.ownerId , this.issue , this.city , this.fullAddress , this.resType , this.phone , this.fullName , this.fireType , this.firePlace , this.injuryCount , this.injuryType});

  factory Issue.fromDoc(DocumentSnapshot doc){
    return Issue(
      issueId: doc['issueId'],
      ownerId: doc['ownerId'],
      issue: doc['issue'],
      fullAddress: doc['fullAddress'],
      resType: doc['resType'],
      phone: doc['phone'],
      city: doc['city'],
      fullName: doc['fullName'],
      fireType: doc['fireType'],
      firePlace: doc['firePlace'],
      injuryCount: doc['injuryCount'],
      injuryType: doc['injuryType'],
    );
  }

  @override
  _IssueState createState() => _IssueState(
    issueId: this.issueId ,
    ownerId: this.ownerId ,
    issue: this.issue ,
    fullAddress: this.fullAddress ,
    resType: this.resType ,
    phone: this.phone ,
    fullName: this.fullName ,
    city: this.city ,
    fireType: this.fireType,
    firePlace: this.firePlace,
    injuryCount: this.injuryCount,
    injuryType: this.injuryType,
  );
}

class _IssueState extends State<Issue> {

  final String issueId ;
  final String ownerId ;
  final String issue ;
  final String fullAddress ;
  final String resType ;
  final String city ;
  final String phone ;
  final String fullName ;
  final String fireType ;
  final String firePlace ;
  final String injuryCount ;
  final String injuryType ;

  _IssueState({this.issueId , this.ownerId , this.issue , this.fullAddress , this.resType , this.phone , this.fullName , this.city, this.fireType , this.firePlace , this.injuryCount , this.injuryType});

  buildIssueTop(){
    return FutureBuilder(
      future: caseRef.document(ownerId).get(),
      builder: (context , snapShot){
        if(!snapShot.hasData){
          return CircularProgressIndicator() ;
        }
        Case caseA = Case.fromDocument(snapShot.data);
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(caseA.photoUrl),
          ),
          title: Text(
            fullName ,
            style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            phone ,
          ),
        );
      },
    );
  }
  buildIssueBody(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Issue : $issue') ,
        Text('City : $city') ,
        Text('Full Address : $fullAddress'),
        Text('Rescue Type : $resType') ,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildIssueTop() ,
        Padding(padding: EdgeInsets.only(left: 30), child: buildIssueBody(),) ,
        Divider(thickness: 2,),
        SizedBox(height: 15,)
      ],
    );
  }
}

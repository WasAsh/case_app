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
  final String phone ;
  final String displayName ;

  Issue({this.issueId , this.ownerId , this.issue , this.fullAddress , this.resType , this.phone , this.displayName});

  factory Issue.fromDoc(DocumentSnapshot doc){
    return Issue(
      issueId: doc['issueId'],
      ownerId: doc['ownerId'],
      issue: doc['issue'],
      fullAddress: doc['fullAddress'],
      resType: doc['resType'],
      phone: doc['phone'],
      displayName: doc['displayName'],
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
    displayName: this.displayName
  );
}

class _IssueState extends State<Issue> {

  final String issueId ;
  final String ownerId ;
  final String issue ;
  final String fullAddress ;
  final String resType ;
  final String phone ;
  final String displayName ;

  _IssueState({this.issueId , this.ownerId , this.issue , this.fullAddress , this.resType , this.phone , this.displayName});

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
            caseA.displayName ,
            style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            caseA.phone
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
        Text('Issue : $issue ') ,
        Text('Full Address : $fullAddress'),
        Text('Rescue Type : $resType') ,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildIssueTop() ,
        buildIssueBody() ,
        Divider(thickness: 2,),
        SizedBox(height: 15,)
      ],
    );
  }
}

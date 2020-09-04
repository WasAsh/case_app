import 'package:case_app/models/case.dart';
import 'package:case_app/pages/home.dart';
import 'package:case_app/pages/issue_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MyIssue extends StatefulWidget {

  final String caseId ;
  MyIssue({this.caseId}) ;

  @override
  _MyIssueState createState() => _MyIssueState();
}

class _MyIssueState extends State<MyIssue> {

  final String currentCaseId = currentCase.id ;
  bool isLoading = false ;
  int issuesCount = 0 ;
  List<Issue> issues = [] ;

  @override
  void initState() {
    super.initState();
    getMyIssues();
  }

  getMyIssues() async {
    setState(() {
      isLoading = true ;
    });
    QuerySnapshot snapshot  = await issueRef.orderBy('timestamp' , descending: true).getDocuments();
    setState(() {
      isLoading = false ;
      issuesCount = snapshot.documents.length ;
      issues = snapshot.documents.map((doc) => Issue.fromDoc(doc)).toList();
    });
  }

  buildMyIssues(){
    if(isLoading){
      return CircularProgressIndicator();
    }
    return Column(
        children: issues ,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طلباتي'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: <Widget>[
          buildMyIssues(),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:case_app/models/case.dart';
import 'package:case_app/pages/add_issue.dart';
import 'package:case_app/pages/my_issue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final caseRef = Firestore.instance.collection('case');
final issueRef = Firestore.instance.collection('issues') ;
final StorageReference storageRef = FirebaseStorage.instance.ref();
final DateTime timeStamp = DateTime.now();
Case currentCase ;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isAuth = false ;
  PageController pageViewController ;
  int pageIndex = 0;
  final _formKey = GlobalKey<FormState>();
  String phone , fullName ;

  //ensure that user signed in or not
  @override
  void initState() {
    super.initState();
    pageViewController = PageController();
    //1
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account) ;
    } , onError: (err){
      print('Error is $err') ;
    });
    //2
    googleSignIn.signInSilently(suppressErrors: false).then((account){
      handleSignIn(account);
    }).catchError((err){
      print('Error is $err');
    });
  }

  handleSignIn(GoogleSignInAccount account){
    if(account != null){
      createUserInFireStore() ;
      setState(() {
        isAuth = true ;
      });
    }else{
      setState(() {
        isAuth = false ;
      });
    }
  }

  login(){
    googleSignIn.signIn() ;
  }
  signOut(){
    googleSignIn.signOut() ;
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  //create user in firestore
  createUserInFireStore() async {
    final GoogleSignInAccount caseA = googleSignIn.currentUser ;
    DocumentSnapshot doc = await caseRef.document(caseA.id).get();

    if(!doc.exists){
//      await Navigator.push(context , MaterialPageRoute(builder: (context) => CreateAccount()));
      caseRef.document(caseA.id).setData({
        'id' : caseA.id ,
        'displayName' : caseA.displayName ,
        'fullName' : null,
        'photoUrl' : caseA.photoUrl ,
        'email' : caseA.email ,
        'phone' :  null,
        'timeStamp' : timeStamp ,
      });
      doc = await caseRef.document(caseA.id).get();
    }
    currentCase = Case.fromDocument(doc) ;
    print(currentCase.email) ;
  }

  //handle page changing
  onPageChanged(int index){
    setState(() {
      this.pageIndex = index ;
    });
  }

  onTap(int index){
    pageViewController.animateToPage(
      index ,
      duration: Duration(milliseconds: 300) ,
      curve: Curves.bounceInOut ,
    );
  }

  //offline info
  offlinePoliceInfo(){
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.white,
        barrierLabel: 'معلومات الشرطة',
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (_, __, ___) {
          return ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.asset(
                      'img/police.jpg',
                      height: 150,
                      fit:BoxFit.fill
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'تعمل الشرطة على خدمة المجتمع عن طريق اقامة دوريات في الشوارع لمنع قوع الجرائم،والمحاولة في مساعدة الاشخاص الذين يواجهون صعوبات معينه,وتُستدعَى الشرطة لفك الخلافات والبحث عن المطلوبين وكذلك تقديم المساعدة والعون لاصحاب الحوادث و الفيضانات والحرائق والكوارث بتأمين المسكن والمواصلات والبحث عن المفقودين' ,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.black ,
                    fontSize: 18 ,
                    decoration: TextDecoration.none ,
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
  offlineRiskInfo(){
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.white,
        barrierLabel: 'معلومات الكوارث',
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (_, __, ___) {
          return ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.asset(
                      'img/risk.jpg',
                      height: 150,
                      fit:BoxFit.fill
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'يتحتم على المواطنين في حالات الكوارث اتباع الاجراءات التالية' ,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.black ,
                        fontSize: 18 ,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                    Text(
                      'أولاً: مساعدة الجهات المعنية ومنهم الدفاع المدني للوصول إلى موقع الكارثة' ,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey ,
                        fontSize: 18 ,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                    Text(
                      'ثانياُ: مساعدة رجال الدفاع المدني في نقل المصابين من الموقع إلى سيارات الإسعاف' ,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey ,
                        fontSize: 18 ,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                    Text(
                      'ثالثاً: المساعدة في البحث عن المفقودين' ,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey ,
                        fontSize: 18 ,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                    Text(
                      'رابعاً: المساعدة في إزالة الأنقاض من مكان الحادث' ,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey ,
                        fontSize: 18 ,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                    Text(
                      'خامساً: المساعدة في بناء الخيم للمتضررين ونقل مواد الإغاثة' ,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey ,
                        fontSize: 18 ,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                    Text(
                      'سادساً: المساعدة في اخلاء المواطنين العاجزين عن الحركة' ,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey ,
                        fontSize: 18 ,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
    );
  }
  offlineFireInfo(){
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.white,
        barrierLabel: 'معلومات الكوارث',
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (_, __, ___) {
          return ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.asset(
                      'img/fire.jpg',
                      height: 150,
                      fit:BoxFit.fill
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'في حالة حدوث حريق ، اتبع الخطوات التالية' ,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.black ,
                        fontSize: 18 ,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                    Text(
                      'أولاً: استخدم النوافذ كطريق بديل للهروب' ,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey ,
                        fontSize: 18 ,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                    Text(
                      'ثانياُ: احرص على وضع مواد الملابس في أسفل الأبواب إذا كنت محاصراً وتعليق ورقة أو بطانية خارج النوافذ' ,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey ,
                        fontSize: 18 ,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                    Text(
                      'ثالثاً: الزحف منخفضاً تحت الدخان' ,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey ,
                        fontSize: 18 ,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                    Text(
                      'رابعاً: ضع نقطة اجتماع محددة مسبقًا ، خارج منزلك ، مثل منزل الجيران' ,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey ,
                        fontSize: 18 ,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                    Text(
                      'خامساً: في حريق شاهق ، لا تستخدم المصاعد مطلقًا. استخدم الدرج فقط' ,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey ,
                        fontSize: 18 ,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                    Text(
                      'سادساً: بمجرد الخروج ، ابق خارجا ولا تدخل المكان المحروق مهما كان السبب' ,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey ,
                        fontSize: 18 ,
                        decoration: TextDecoration.none ,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
    );
  }


  //draw widgets
  Scaffold buildAuthScreen(){
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: Text('الرئيسية'),
              centerTitle: true,
              backgroundColor: Colors.red,
              actions: <Widget>[
                RaisedButton.icon(
                  icon: Icon(Icons.cancel),
                  label: Text('تسجيل الخروج'),
                  onPressed: signOut,
                  color: Colors.red,
                ),
              ],
            ),
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30 , right: 10 , left: 10),
                  child: Text(
                    'مرحباً بك : من فضلك قم بتحديث ملفك الشخصي عند اول استخدام للتطبيق بواسطة الذهاب الى الصفحه المخصصة لذلك عن طريق' ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black ,
                      fontSize: 20 ,
                      fontWeight: FontWeight.bold ,
                    ),
                  ),
                ),
                FlatButton(
                  child: Text('تعديل البيانات' , style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                  onPressed: (){
                    showModalBottomSheet(
                        context: context ,
                        builder: (context){
                          return ListView(
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 25),
                                      child: Center(
                                        child: Text(
                                          'تعديل البيانات الشخصية' ,
                                          style: TextStyle(
                                            fontSize: 25 ,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Container(
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              TextFormField(
                                                autovalidate: true,
                                                validator: (val){
                                                  if(val.trim().length < 6 || val.isEmpty){
                                                    return('الرقم المدخل غير صحيح') ;
                                                  }else if(val.trim().length > 15){
                                                    return('الرقم المدخل غير صحيح') ;
                                                  }else{
                                                    return null ;
                                                  }
                                                },
                                                onSaved: (val) => phone = val,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  icon: Icon(Icons.phone) ,
                                                  labelText: 'رقم الهاتف' ,
                                                  labelStyle: TextStyle(fontSize: 12) ,
                                                  hintText: '01234567890' ,
                                                ),
                                              ),
                                              SizedBox(height: 10,) ,
                                              TextFormField(
                                                autovalidate: true,
                                                validator: (val){
                                                  if(val.trim().length < 6 || val.isEmpty){
                                                    return('الاحرف قليلة جدا') ;
                                                  }else if(val.trim().length > 30){
                                                    return('الاحرف كثيرة جدا') ;
                                                  }else{
                                                    return null ;
                                                  }
                                                },
                                                onSaved: (val) => fullName = val,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  icon: Icon(Icons.person) ,
                                                  labelText: 'الاسم بالكامل' ,
                                                  labelStyle: TextStyle(fontSize: 12) ,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        height: 50,
                                        width: 350,
                                        decoration: BoxDecoration(
                                          color: Colors.grey ,
                                          borderRadius: BorderRadius.circular(7) ,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'تأكيد' ,
                                            style: TextStyle(
                                              color: Colors.white ,
                                              fontSize: 15 ,
                                              fontWeight: FontWeight.bold ,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: (){
                                        final form = _formKey.currentState ;
                                        if(form.validate()){
                                          form.save() ;
//                                          SnackBar snackBar = SnackBar(content: Text('Welcome !'),);
//                                          _scaffoldKey.currentState.showSnackBar(snackBar) ;
                                          caseRef.document(currentCase.id).updateData({
                                            'fullName' : fullName,
                                            'phone' :  phone,
                                          });
                                          Timer(Duration(seconds: 1) , (){
                                            Navigator.pop(context) ;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ) ;
                        }
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10 , left: 10 , right: 10),
                  child: Container(
                    margin:EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      color: Colors.red,
                      child: InkWell(
                        onTap: (){
                          offlinePoliceInfo();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                              child: Image.asset(
                                  'img/police.jpg',
                                  height: 150,
                                  fit:BoxFit.fill
                              ),
                            ),
                            ListTile(
                              title: Center(
                                child: Text('حالات تستدعي الشرطة' , style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10 , left: 10 , right: 10),
                  child: Container(
                    margin:EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      color: Colors.red,
                      child: InkWell(
                        onTap: () {
                          offlineRiskInfo();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                              child: Image.asset(
                                  'img/risk.jpg',
                                  height: 150,
                                  fit:BoxFit.fill
                              ),
                            ),
                            ListTile(
                              title: Center(
                                child: Text('التعامل مع الكوارث' , style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10 , left: 10 , right: 10),
                  child: Container(
                    margin:EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      color: Colors.red,
                      child: InkWell(
                        onTap: () {
                          offlineFireInfo();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                              child: Image.asset(
                                  'img/fire.jpg',
                                  height: 150,
                                  fit:BoxFit.fill
                              ),
                            ),
                            ListTile(
                              title: Center(
                                child: Text('ارشادات الحرائق' , style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          AddIssue(currentCase: currentCase,),
          MyIssue(caseId: currentCase?.id,),
        ],
        controller: pageViewController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Colors.red,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back) , title: Text('الرئيسية' , style: TextStyle(fontSize: 13),)),
          BottomNavigationBarItem(icon: Icon(Icons.add) , title: Text('اضافة طلب' , style: TextStyle(fontSize: 13),)),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet) , title: Text('طلباتي' , style: TextStyle(fontSize: 13),)),
        ],
      ),
    );
  }

  Widget buildUnAuthScreen(){
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight ,
            end: Alignment.bottomLeft ,
            colors: [
              Colors.grey ,
              Colors.red.shade700,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '218 Rescue App' ,
              style: TextStyle(
                fontSize: 40 ,
                fontWeight: FontWeight.bold,
                color: Colors.black ,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              'تطبيق الحالة' ,
              style: TextStyle(
                fontSize: 20 ,
                fontWeight: FontWeight.bold,
                color: Colors.black38 ,
              ),
            ),
            SizedBox(height: 120,),
            Text(
              'تسجيل الدخول باستخدام حساب غوغل' ,
              style: TextStyle(
                fontSize: 20 ,
                fontWeight: FontWeight.bold,
                color: Colors.black ,
              ),
            ),
            GestureDetector(
              onTap: (){
                login();
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('img/google.png') ,
                      fit: BoxFit.cover ,
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}

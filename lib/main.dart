import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:customerglu_plugin/customerglu_plugin.dart";
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter SDK'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isRegistered = false;



  static const broadcast_channel = MethodChannel('CUSTOMERGLU_EVENTS');

  var userData = {
    'userId': "asd123asd", // Mandatory:any identifier to uniquely identify a user of your platform
    'firebaseToken': "FCM_TOKEN_OF_DEVICE", // for enabling Firebase Notifications
    'customAttributes':{ 
    // any custom key-value pairs, which may be used for targeting can be sent as customAttributes
    // segments can be created by applying filters on these customAttributes
    // campaigns can be launched on specific segments
    "orderCount":5,
    "city":"Mumbai"
    },
    'profile':{
    "firstName":"JaneDoe"
    }
  };

  void _DeepView() {
    broadcast_channel.setMethodCallHandler((call) async {
    switch (call.method) {
      case "CUSTOMERGLU_DEEPLINK_EVENT":
        print("CUSTOMERGLU_DEEPLINK_EVENT");
        print(call.arguments);
        break;
      case "CUSTOMERGLU_ANALYTICS_EVENT":
        print("CUSTOMERGLU_ANALYTICS_EVENT");
        print(call.arguments);

      break;
  }
  });
  }

void _userRegister() async {
  bool is_registered = await CustomergluPlugin.registerDevice(userData,loadCampaigns: true);

  setState(() {
    _isRegistered = is_registered;
  });

  if (is_registered) {
    Fluttertoast.showToast(
        msg: "User registered sucessfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  } else {
        Fluttertoast.showToast(
        msg: "Registration failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

void _clearData() {
  CustomergluPlugin.clearGluData();

      Fluttertoast.showToast(
        msg: "User data cleared",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
}


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            Container(
              margin: EdgeInsets.all(25),  
              child: FlatButton(  
                child: Text('Register User', style: TextStyle(fontSize: 20.0),),  
                onPressed: () {_userRegister();},  
              ),  
            ),
            Container(
              margin: EdgeInsets.all(25),  
              child: FlatButton(  
                child: Text('Clear Glu Data', style: TextStyle(fontSize: 20.0),),  
                onPressed: () {_clearData();},  
              ),  
            ),
            Container(
              margin: EdgeInsets.all(25),  
              child: FlatButton(  
                child: Text('Enable Analytics event', style: TextStyle(fontSize: 20.0),),  
                onPressed: () {CustomergluPlugin.enableAnalyticsEvent(true);},  
              ),  
            ),
            Container(
              margin: EdgeInsets.all(25),  
              child: FlatButton(  
                child: Text('Open Wallet', style: TextStyle(fontSize: 20.0),),  
                onPressed: () {CustomergluPlugin.openWallet(autoclosewebview: true);},  
              ),  
            ),
            Container(
              margin: EdgeInsets.all(25),  
              child: FlatButton(  
                child: Text('Load campaign by id', style: TextStyle(fontSize: 20.0),),  
                onPressed: () {CustomergluPlugin.loadCampaignById("CAMPAIGN_ID/TAG",autoclosewebview: true); _DeepView();},  
              ),  
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
        
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

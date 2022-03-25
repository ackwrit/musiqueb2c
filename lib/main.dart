import 'package:splashscreen/splashscreen.dart';

import 'package:animationb2c/detailMusique.dart';
import 'package:animationb2c/model/musique.dart';
import 'package:animationb2c/myWidgets/MyCustomPath.dart';
import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation animation;

  List<Musique> allMocceaux = [
    Musique(title: "Big Boss", singer: "Laura", type_music: "Rap", path: "https://firebasestorage.googleapis.com/v0/b/projetclassb2c3.appspot.com/o/09.AbuSimbel.mp3?alt=media&token=30e1026c-e4ce-48ab-b860-c1539fa4130a"),
    Musique(title: "Lord", singer: "Djino", type_music: "Electro", path: "https://firebasestorage.googleapis.com/v0/b/projetclassb2c3.appspot.com/o/14.Alibi.mp3?alt=media&token=d09610c6-3f02-4d29-b263-a0dba8b491dd",image:"assets/image/UxqjmuipUqmeiVSd4xHZO_4chSw.jpg" ),
    Musique(title: "Poreaux", singer: "Leslie", type_music: "Rnb", path: "https://firebasestorage.googleapis.com/v0/b/projetclassb2c3.appspot.com/o/16.Inheritance.mp3?alt=media&token=cd1d2a45-3b12-4331-83b2-a786b167f399",image: "assets/image/wnrv0DmECg_mmOv6p9HlqEIBdzk.jpg"),
    Musique(title: "Iphone", singer: "Claude", type_music: "Rap", path: "https://firebasestorage.googleapis.com/v0/b/projetclassb2c3.appspot.com/o/21.%20IWasn'tThinking.mp3?alt=media&token=b7b3211e-08c0-4456-9bc7-0ba56d8cdde5",album: "My Best Of")
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: Duration(seconds: 2),
        vsync: this,
    )..repeat();

    animation = Tween<double>(begin: 0,end:1).animate(controller);
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SplashScreen(
      seconds: 14,
      navigateAfterSeconds: Scaffold(

        body:Page(),


        backgroundColor: Colors.green,

      ),
      backgroundColor: Colors.red,
    );









  }



  Widget fondEcran(){
    return ClipPath(
      clipper: MyCustomPath(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/Warrior-Girl-fantasy-23124363-1024-768.jpg"),
            fit: BoxFit.fill
          )
        ),
      ),
    );
  }


  Widget Page(){
    return Stack(
      children: [
        fondEcran(),
        Container(
          padding: EdgeInsets.all(10),
          child:  bodyPage(),
        ),

      ],
    );
  }

  Widget bodyPage(){
    return GridView.builder(
      itemCount: allMocceaux.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 20,mainAxisSpacing: 10),
        itemBuilder: (context,index){
          return InkWell(
            child: Hero(
              tag: allMocceaux[index].title,
              child:  AnimatedBuilder(
                animation: animation,
                builder: (context,child){
                  return Transform.scale(
                    scale: animation.value,
                    child: child,
                  );

                },
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: (allMocceaux[index].image==null)?AssetImage("assets/image/indispo.jpeg"):AssetImage(allMocceaux[index].image!),
                          fit: BoxFit.fill
                      )
                  ),
                ),
              ),



            ),


            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return detailMusique(morceau: allMocceaux[index]);
                  }
              ));
            },
          );


        }
    );
  }
}

import 'package:animationb2c/detailMusique.dart';
import 'package:animationb2c/model/musique.dart';
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
  List<Musique> allMocceaux = [
    Musique(title: "Big Boss", singer: "Laura", type_music: "Rap", path: "assets/songs/03.ThePyramids.mp3"),
    Musique(title: "Lord", singer: "Djino", type_music: "Electro", path: "assets/songs/11.Suspects.mp3",image:"assets/image/UxqjmuipUqmeiVSd4xHZO_4chSw.jpg" ),
    Musique(title: "Poreaux", singer: "Leslie", type_music: "Rnb", path: "assets/songs/18.LetPoirotWork.mp3",image: "assets/image/wnrv0DmECg_mmOv6p9HlqEIBdzk.jpg"),
    Musique(title: "Iphone", singer: "Claude", type_music: "Rap", path: "assets/songs/23.Perhaps.mp3",album: "My Best Of")
  ];


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
      body: Container(
        padding: EdgeInsets.all(10),
        child: bodyPage(),
      ),

      backgroundColor: Colors.green,

    );



  }

  Widget bodyPage(){
    return GridView.builder(
      itemCount: allMocceaux.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 20,mainAxisSpacing: 10),
        itemBuilder: (context,index){
          return InkWell(
            child:  Container(
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: (allMocceaux[index].image==null)?AssetImage("assets/image/indispo.jpeg"):AssetImage(allMocceaux[index].image!),
                      fit: BoxFit.fill
                  )
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
import 'dart:async';

import 'package:animationb2c/model/musique.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class detailMusique extends StatefulWidget{
  Musique morceau;
  detailMusique({required Musique this.morceau});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailMusiqueState();
  }

}

class detailMusiqueState extends State<detailMusique>{
  //Variable
  double time =0;
  statut lecture = statut.stopped;
  Duration position = Duration(seconds: 0);
  Duration duree = Duration(seconds: 0);
  double volumeSound = 0.5;
  late StreamSubscription positionStream;
  late StreamSubscription stateStream;
  AudioPlayer audioPlayer = AudioPlayer();






  //






  //Méthode

  //Fonction de configuration
 configuration(){
   audioPlayer.setUrl(widget.morceau.path);
   positionStream = audioPlayer.onAudioPositionChanged.listen((event) {
     setState(() {
       position = event;
     });
   });

   audioPlayer.onDurationChanged.listen((event) {
     setState(() {
       duree = event;
     });
   });

   stateStream = audioPlayer.onPlayerStateChanged.listen((event) {
     if(event == statut.playing){
       setState(() async {
         duree = audioPlayer.getDuration() as Duration;
       });
     }
     else if(event == statut.stopped){
       setState(() {
         lecture = statut.stopped;
       });
     }
   },
     onError: (message){
     setState(() {
       lecture = statut.stopped;
       position = Duration(seconds: 0);
       duree = Duration(seconds: 0);
     });
     }
   );


 }
 ///
  ///
  ///
  // Fonction de lecture de la musique
  Future play () async{
    await audioPlayer.play(widget.morceau.path,position: position,volume: volumeSound);
  }
  /////////////



  ///////Fonction de pause de la musique
  Future pause() async{
   await audioPlayer.pause();
  }


  ///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configuration();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.morceau.title}"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: bodyPage(),
        ),
      ),

      backgroundColor: Colors.green,
    );
  }

  Widget bodyPage(){
    return Column(
      children: [
        //Image
        Hero(
          tag: widget.morceau.title,
          child: AnimatedContainer(
            duration: Duration(seconds: 5),
            height: (lecture == statut.stopped)?150:300,
            width: (lecture== statut.stopped)?150:400,
            curve: Curves.bounceInOut,
            decoration: BoxDecoration(
                borderRadius: (lecture == statut.stopped)?BorderRadius.circular(0):BorderRadius.circular(20),
                image: DecorationImage(
                    image: (widget.morceau.image==null)?AssetImage("assets/image/indispo.jpeg"):AssetImage(widget.morceau.image!),
                    fit: BoxFit.fill
                )
            ),
          ),
        ),


        //Titre - Album,
        Text("${widget.morceau.title} - ${widget.morceau.album}",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),


        // Chanteur
        Text("${widget.morceau.singer}",style: TextStyle(fontSize: 25),),

        //Icone
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Icone pour le recul de la musique
            IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.fast_rewind_rounded,size: 30,)
            ),

            /////////////////////////

            //Icone du Milieu
            (lecture == statut.stopped)?IconButton(
                onPressed: (){
                  setState(() {
                    lecture = statut.paused;
                    play();
                  });

                },
                icon: Icon(Icons.play_arrow_rounded,size: 40,)
            ): IconButton(
                onPressed: (){
                  setState(() {
                    lecture = statut.stopped;
                    pause();
                  });


                },
                icon: Icon(Icons.pause,size: 40,)
            ),


            ///////////


            //Icon pour avance rapide
            IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.fast_forward_rounded,size: 30,)
            ),
            //////////////
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(position.toString().substring(2,7)),
            Text(duree.toString().substring(2,7)),

          ],
        ),

        Slider(
          max: (duree == null)?0.0:duree.inSeconds.toDouble(),
            min: 0.0,
            value: position.inSeconds.toDouble(),
            activeColor: Colors.red,
            inactiveColor: Colors.grey,
            onChanged: (value){
              setState(() {
                Duration interval = Duration(seconds: value.toInt());
                position = interval;
                audioPlayer.play(widget.morceau.path,position: position,volume: volumeSound);


              });
            }
        ),

        //Ajouter les boutons de volume
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //baisser le volume
            IconButton(onPressed: (){
              if(volumeSound-0.1<=0){
                setState(() {
                  volumeSound = 0;
                  audioPlayer.setVolume(volumeSound);
                });
              }
              else
                {
                  setState(() {
                    volumeSound = volumeSound-0.1;
                    audioPlayer.setVolume(volumeSound);

                  });
                }

            },
                icon: Icon(Icons.volume_down_rounded)
            ),

            //Augmenter
            IconButton(
                onPressed: (){
                  if(volumeSound+0.1>=1){
                    setState(() {
                      volumeSound = 1;
                      audioPlayer.setVolume(volumeSound);
                    });
                  }
                  else
                    {
                      setState(() {
                        volumeSound = volumeSound+0.1;
                        audioPlayer.setVolume(volumeSound);
                      });
                    }

                },
                icon: Icon(Icons.volume_up_rounded)
            ),

          ],
        ),


        ///




        //Slider

      ],
    );
  }

}


enum statut{
  playing,
  stopped,
  paused,
  forward,
  rewind,
}
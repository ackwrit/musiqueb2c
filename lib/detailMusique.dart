import 'package:animationb2c/model/musique.dart';
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
  double time =0;
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
        Container(
          height: 300,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: (widget.morceau.image==null)?AssetImage("assets/image/indispo.jpeg"):AssetImage(widget.morceau.image!),
              fit: BoxFit.fill
            )
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
            IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.fast_rewind_rounded,size: 30,)
            ),
            IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.play_arrow_rounded,size: 40,)
            ),
            IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.fast_forward_rounded,size: 30,)
            ),
          ],
        ),

        Slider(
            value: time,
            activeColor: Colors.red,
            inactiveColor: Colors.grey,
            onChanged: (value){
              setState(() {
                time = value;
              });
            }
        )


        //Slider

      ],
    );
  }

}
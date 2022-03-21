

class Musique {
  late String title;
  late String singer;
  late String type_music;
  String? image;
  String? album;
  late String path;


  Musique({required String this.title,
    required String this.singer,
    required String this.type_music,
    String? this.image,
    String? this.album,
    required String this.path});


}
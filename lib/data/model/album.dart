import 'package:flutter/widgets.dart';
import 'package:inventory/data/model/album_track.dart';

class Album {
  String albumName;
  String year;
  String singerName;
  String albumImage;
  String artistImage;
  List<AlbumTrack> trackList;
  List<Color> colorPallete;

  Album(this.albumImage, this.albumName, this.singerName, this.trackList,
      this.year, this.artistImage, this.colorPallete);
}

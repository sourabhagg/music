import 'dart:developer';
import 'package:music/Models/list.dart';
import 'package:music/Models/data.dart';
import 'package:music/Models/lyrics.dart';
import 'package:http/http.dart' as http;
import 'package:music/Constants/constant.dart';
class DataService{

  Future homeFeed() async
  {
    //print("fetching tracks");
    try {
      var url = Uri.parse(ApiConstants.getTrackData);
      var response = await http.get(url);
      if(response.statusCode == 200)
      {
        AlbumData trackData = albumFromJson(response.body);
        List<albumList> trackList = trackData.message.body.trackList;
        List<Album> tracks=[];
        for(int i=0;i<trackList.length;i++) {
          Album track = trackList[i].track;
          if (track.hasLyrics == 1) {
            tracks.add(track);
            //print(track.toJson());
          }
        }
        tracks = tracks.toSet().toList();
        return tracks;
      }
    }
    catch(e)
    {
      //catch error
      log(e.toString());
    }
  }

  Future trackData(String trackId) async
  {
    print("fetching track details");
    try {
      var url = Uri.parse(ApiConstants.getTrackDetail+'&track_id=$trackId');
      var response = await http.get(url);
      if(response.statusCode == 200)
      {
        TrackInfo trackData = trackInfoFromJson(response.body);
        Track track = trackData.message.body.track;
        return track;
      }
    }
    catch(e)
    {
      //catch error
      log(e.toString());
    }
  }

  Future trackLyric(String trackId) async{
    try{
      String path = ApiConstants.getTrackLyric+'&track_id=$trackId';
      var url = Uri.parse(path);
      var response = await http.get(url);
      if(response.statusCode == 200)
      {
        TrackLyrics trackLyrics = trackLyricsFromJson(response.body);
        Lyrics lyrics = trackLyrics.message.body.lyrics;
        return lyrics;
      }
    }
    catch(e)
    {
      print("Error Occurred");
      log(e.toString());
    }
  }
}
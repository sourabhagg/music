import 'package:flutter/material.dart';
class ApiConstants{
  static String key = '45b8a94c66788d1456afe1851477457d';
  static String getTrackData = 'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=$key';
  static String getTrackDetail = 'https://api.musixmatch.com/ws/1.1/track.get?apikey=$key';
  static String getTrackLyric = 'https://api.musixmatch.com/ws/1.1/track.lyrics.get?apikey=$key';
}
import 'package:music/Screens/taskscreen.dart';
import 'package:flutter/material.dart';
import 'package:music/Models/list.dart';
class AlbumCard extends StatefulWidget {
  Album track;
  AlbumCard(this.track, {Key? key}) : super(key: key);

  @override
  _AlbumCardState createState() => _AlbumCardState();
}

class _AlbumCardState extends State<AlbumCard> {

  @override
  Widget build(BuildContext context) {
    Album _track = widget.track;
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (cxt)=>TrackScreen(_track.trackId.toString())));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        width: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple,
              Colors.deepPurple,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Album Name
            Text(_track.albumName.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
              maxLines: 1,
            ),
            const SizedBox(height: 10,),
            Text(_track.artistName.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
              maxLines: 1,
            ),
            const SizedBox(height: 10,),
            Align(
                alignment: Alignment.bottomRight,
                child: Text('AlbumId : ' + _track.trackId.toString(),style: const TextStyle(fontSize: 10,color: Colors.white),)),
          ],
        ),
      ),
    );
  }
}

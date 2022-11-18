import 'package:music/Models/data.dart';
import 'package:music/Models/lyrics.dart';
import 'package:music/utils/dataservice.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class TrackScreen extends StatefulWidget {
  String trackId;
  TrackScreen(this.trackId,{Key? key}) : super(key: key);

  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {

  late Track track;
  late Lyrics lyrics;
  bool isLoading = true;
  bool isLyrics = false;
  bool online = true;

  void setLoadingFalse()
  {
    setState(() {
      isLoading = false;
    });
  }

  void setLyricsLoadingTrue()
  {
    setState(() {
      isLyrics = true;
    });
  }

  void getTracks(String trackId)
  async {
    DataService().trackData(trackId).then((value){
      track = value;
      setLoadingFalse();
    });
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void getLyrics(String trackId)
  async {
    DataService().trackLyric(trackId).then((value){
      if(value != null)
      {
        lyrics = value;
        setLyricsLoadingTrue();
      }
    });
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void initState() {
    // TODO: implement initState
    getTracks(widget.trackId);
    getLyrics(widget.trackId);
    super.initState();
  }

  void checkInternet() async{
    online = await InternetConnectionChecker().hasConnection;
    print('InternetConnection status is ' + online.toString());
    if(online)
    {
      getTracks(widget.trackId);
      getLyrics(widget.trackId);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkInternet();
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Data'),
      ),
      body: !online ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error,color: Colors.red,),
            const SizedBox(height: 5,),
            const Text('No Internet Connection available'),
            ElevatedButton(
                onPressed: (){
                  checkInternet();
                },
                child: Text('Retry')),
          ],
        ),
      ) :
      isLoading ?
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 10,),
            Text('Fetching track data')
          ],
        ),
      )
          :
      SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(track.trackName,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
              const SizedBox(height: 10,),
              Text(track.artistName,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
              const SizedBox(height: 10,),
              if(isLyrics)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2,vertical: 10),
                  padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.topCenter,
                          child: Text('Lyrics',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                      SizedBox(height: 10,),
                      Text(lyrics.lyricsBody,style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

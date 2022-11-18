import 'dart:async';
import 'package:music/Screens/homecard.dart';
import 'package:music/Models/list.dart';
import 'package:music/widgets/drawer.dart';
import 'package:music/utils/dataservice.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool online = false;
  List<Album> _albums = [];
  bool isLoading = true;

  void setLoadingFalse()
  {
    setState(() {
      isLoading = false;
    });
  }

  void getTracks()
  async {
    DataService().homeFeed().then((value){
      _albums = value;
      setLoadingFalse();
      print("data found");
    });
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void checkInternet() async{
    online = await InternetConnectionChecker().hasConnection;
    print('InternetConnection status is ' + online.toString());
    if(online)
    {getTracks();}
  }

  @override
  void initState() {
    // TODO: implement initState
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkInternet();
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Tracks'),
      ),
      body: !online ?
      Center(
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
      )
          :
      isLoading ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 10,),
            Text('Fetching data please wait')
          ],
        ),)
          : _albums.isEmpty ?
      const Center(child: Text('No albums Found'),) :
      ListView.builder(
          itemCount: _albums.length,
          itemBuilder: (cxt,index){
            Album _album = _albums[index];
            return AlbumCard(_album);
          }),
      drawer: MyDrawer(),
    );
  }
}
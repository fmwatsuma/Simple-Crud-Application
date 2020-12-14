import 'package:flutter/material.dart';
import 'album.dart';
import 'api.dart';
class DeleteAlbum extends StatefulWidget {
  DeleteAlbum({Key key}) : super(key: key);
  @override
  _DeleteAlbumState createState() => _DeleteAlbumState();
}

class _DeleteAlbumState extends State<DeleteAlbum> {
    Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = API.fetchAlbum();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delete Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Delete Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              // If the connection is done,
              // check for response data or an error.
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${snapshot.data?.title ?? 'Deleted'}'),
                      ElevatedButton(
                        child: Text('Delete Data'),
                        onPressed: () {
                          setState(() {
                            _futureAlbum = API.deleteAlbum(snapshot.data.id.toString());
                          });
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  
      
    
  }
}
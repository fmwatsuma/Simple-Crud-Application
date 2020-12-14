import 'package:flutter/material.dart';
import 'album.dart';
import 'api.dart';
class UpdateAlbum extends StatefulWidget {
  UpdateAlbum({Key key}) : super(key: key);

  @override
  _UpdateAlbumState createState() {
    return _UpdateAlbumState();
  }
}

class _UpdateAlbumState extends State<UpdateAlbum> {
  final TextEditingController _controller = TextEditingController();
  Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = Api.fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Update Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(snapshot.data.title),
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(hintText: 'Enter Title'),
                      ),
                      ElevatedButton(
                        child: Text('Update Data'),
                        onPressed: () {
                          setState(() {
                            _futureAlbum = Api.updateAlbum(_controller.text);
                          });
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}


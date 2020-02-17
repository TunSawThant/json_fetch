import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:json_fetch/model/json_fetch.dart';
import 'package:json_fetch/services/api_services.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  JsonFetch jsonFetch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<JsonFetch>(
        future: ApiService().fetchData(),
          builder: (c,s){
          if(s.connectionState==ConnectionState.done){
            if(s.hasData){
              jsonFetch=s.data;

              return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: jsonFetch.results.length,
                  itemBuilder: (context, index) {
                    return _buildImageColumn(jsonFetch.results[index]);
                    // return _buildRow(data[index]);
                  }
              );
            }
            else{
              return Center(child: Text('${s.error}'),);
            }
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          }
      ),
    );
  }
  Widget _buildImageColumn(Result data) => Container(
    decoration: BoxDecoration(
        color: Colors.white54
    ),
    margin: const EdgeInsets.all(4),
    child: Column(
      children: [
        new CachedNetworkImage(
          imageUrl:'${data.urls.small}' ,
          placeholder: (context, url) => new CircularProgressIndicator(),
          errorWidget: (context, url, error) => new Icon(Icons.error),
          fadeOutDuration: new Duration(seconds: 1),
          fadeInDuration: new Duration(seconds: 3),
        ),
        _buildRow(data)
      ],
    ),
  );

  Widget _buildRow(Result item) {
    return ListTile(
      title: Text('${item.description}'
      ),
      subtitle: Text("Likes: " + '${item.likes}.toString()'),
    );
  }
}

import 'package:cust/models/movie.dart';
import 'package:cust/providers/moviesprovider.dart';
import 'package:cust/screens/ProductDetails.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  static const String route = '/home';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<Movieprovider>(context, listen: false)
        .fetchData()
        .then((_) => _isLoading = false)
        .catchError((onError) => print(onError));

    super.initState();
  }

  Widget slider(id, title, imageUrl) {
    return Builder(
      builder: (innerContext) => GestureDetector(
          onTap: () {
            print(id);
            Navigator.push(
              innerContext,
              MaterialPageRoute(builder: (_) => ProductDetails(id)),
            ).then((id) =>
                Provider.of<Movieprovider>(context, listen: false).delete(id));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Stack(
              children: [
                GestureDetector(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      print(id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetails(id)),
                      );
                    }),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.black54,
                          Theme.of(context).primaryColor.withOpacity(0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0, 0.5]),
                  ),
                ),
                Positioned(
                  bottom: 45,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
  /*

  Widget detailCard(id, tile, imageUrl) {
    return Builder(
      builder: (innerContext) => FlatButton(
        onPressed: () {
          print(id);
          Navigator.push(
            innerContext,
            MaterialPageRoute(builder: (_) => ProductDetails(id)),
          ).then(
              (id) => Provider.of<Movieprovider>(context, listen: false).delete(id));
        },
        child: Stack(
          children: [
            Expanded(
                    
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      
                      child: Hero(
                        tag: id,
                        child: Image.network(imageUrl, fit: BoxFit.fill),
                      ),
                    ),
                  ),
            
            
          ],
        ),
      ),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    List<Movie> prodList =
        Provider.of<Movieprovider>(context, listen: true).productsList;

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      drawer: (Drawer(
        child: SafeArea(
            child: Column(
          children: [
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              tileColor: Colors.black,
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        )),
      )),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : (prodList.isEmpty
              ? Center(
                  child:
                      Text('No movies Added.', style: TextStyle(fontSize: 22)))
              : RefreshIndicator(
                  onRefresh: () async =>
                      await Provider.of<Movieprovider>(context, listen: false)
                          .fetchData(),
                  child: ListView(
                    children: prodList
                        .map(
                          (item) => slider(item.id, item.title, item.imageUrl),
                        )
                        .toList(),
                  ),
                )),
    );
  }
}

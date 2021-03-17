import 'package:cust/models/movie.dart';
import 'package:cust/providers/moviesprovider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ProductDetails extends StatefulWidget {
  static const String route = '/home';
  final String id;

  ProductDetails(this.id);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    List<Movie> prodList = Provider.of<Movieprovider>(context, listen: true).productsList;

    var filteredItem = prodList.firstWhere((element) => element.id == widget.id, orElse: () => null);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: filteredItem == null ? null : Text(filteredItem.title),
          actions: [
           // FlatButton(onPressed: ()=> Provider.of<Products>(context, listen: false).updateData(id), child: Text("Update Data"))
          ],
      ),
     
      body: filteredItem == null
          ? null
          : ListView(
              children: [
                SizedBox(height: 10),
                buildContainer(filteredItem.imageUrl, filteredItem.id),
                SizedBox(height: 10),
                buildCard(filteredItem.description)
                
              ],
            ),
      
    );
  }

  Container buildContainer(String image, String id) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Hero(
          tag: id,
          child: Image.network(image),
        ),
      ),
    );
  }

   buildCard( String desc) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        child:  Text(
                desc,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
      ),
    );
           
          
        
  }
}

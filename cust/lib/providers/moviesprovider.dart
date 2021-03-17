
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cust/models/movie.dart';


class Movieprovider with ChangeNotifier {
  List<Movie> productsList = [];



  Future<void> fetchData() async {
    const url = "https://eccproject-88b47-default-rtdb.firebaseio.com/movie.json";
    try {
      final http.Response res = await http.get(url);
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      extractedData.forEach((prodId, prodData) {
        final prodIndex =
            productsList.indexWhere((element) => element.id == prodId);
        if (prodIndex >= 0) {
          productsList[prodIndex] = Movie(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            movietime:  prodData['movietime'],
            imageUrl: prodData['imageUrl'],
            numberofseats:prodData['numberofseats'],

          );
        } else {
          productsList.add(Movie(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
           movietime:  prodData['movietime'],
            imageUrl: prodData['imageUrl'],
            numberofseats:prodData['numberofseats'],
          ));
        }
      });

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
  
  
/*
  Future<void> updateData(String id) async {
    final url = "https://flutter-app-568d3.firebaseio.com/product/$id.json";

    final prodIndex = productsList.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      await http.patch(url,
          body: json.encode({
            "title": "new title 4",
            "description": "new description 2",
            "price": 199.8,
            "imageUrl":
                "https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg",
          }));

      productsList[prodIndex] = (
        id: id,
        title: "new title 4",
        description: "new description 2",
        price: 199.8,
        imageUrl:
            "https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg",
      );

      notifyListeners();
    } else {
      print("...");
    }
  }
  */

  Future<void> add(
      {String id,
      String title,
      String description,
      String movietime,
      String nubmberofseats,
      String imageUrl}) async {
    const url = "https://ecommerceapp-5a9bb-default-rtdb.firebaseio.com/movie.json";
    try {
      http.Response res = await http.post(url,
          body: json.encode({
            "title": title,
            "description": description,
            "movietime": movietime,
            "imageUrl": imageUrl,
            "nubmberofseats":nubmberofseats,
          }));
      print(json.decode(res.body));

      productsList.add(Movie(
        id: json.decode(res.body)['name'],
        title: title,
        description: description,
        movietime: movietime,
        numberofseats:nubmberofseats ,
        imageUrl: imageUrl,
      ));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
  

  Future<void> delete(String id) async {
    final url = "https://ecommerceapp-5a9bb-default-rtdb.firebaseio.com/movie/$id.json";

    final prodIndex = productsList.indexWhere((element) => element.id == id);
    var prodItem = productsList[prodIndex];
    productsList.removeAt(prodIndex);
    notifyListeners();

    var res = await http.delete(url);
    if (res.statusCode >= 400) {
      productsList.insert(prodIndex, prodItem);
      notifyListeners();
      print("Could not deleted item");
    } else {
      prodItem = null;
      print("Item deleted");
    }
  }
  
  
}

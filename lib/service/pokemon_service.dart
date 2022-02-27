import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PokemonService {

  int _code = 0;

  // int _page = 0;
  // int _limit = 10;
  // bool _hasNextPage = true;
  // bool _isFirstLoadRunning = false;
  // bool _isLoadMoreRunning = false;
  // List _posts = [];

  Future<List<dynamic>> getPokemonList(page) async {
    print("page $page");
    await dotenv.load(fileName: ".env");
    String _baseUrl = dotenv.env['URL_API'].toString();
    String _baseUrlComplemento = '/pokemon?limit=10&offset=$page';

    try {
      final response = await http.get(Uri.parse(_baseUrl + _baseUrlComplemento),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      // body: json.encode(data)
      );
      final preRes = json.decode(response.body);
      final List response2 = preRes['results'];
      // int code => response.statusCode;
      _code = response.statusCode;

      return (response2);
      // return jsonDecode(response2) as List;
      
    } catch (e) {
      return [];
    }

  }
  
  int get getCode => _code;


  //toma la imagen desde la web
  // Future<String> getPokemonImagen(url) async {
  //   String _baseUrl = url;

  //   try {
  //     final response = await http.get(Uri.parse(_baseUrl),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       },
  //     );
  //     final preRes = json.decode(response.body);
  //     var response2 = (preRes['sprites']['other']['official-artwork']['front_default']);
  //     // final List response2 = preRes['sprites']['other']['official-artwork'];
  //     // print(preRes['sprites']['other']['official-artwork']);
  //     // print("response2 $response2");
  //     return (response2);

  //   } catch (e) {
  //     print(e);
  //     return '';
  //   }
  // }
}
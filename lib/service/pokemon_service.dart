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

  Future<String> getPokemonDetails(id) async {
    await dotenv.load(fileName: ".env");
    String _baseUrl = dotenv.env['URL_API'].toString();
    String _baseUrlComplemento = '/pokemon/$id';

    final response = await http.get(Uri.parse(_baseUrl + _baseUrlComplemento),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    // body: json.encode(data)
    );

    return response.body;
  }
}
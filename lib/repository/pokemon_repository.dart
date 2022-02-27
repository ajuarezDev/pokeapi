import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke/models/pokemon.dart';
import 'package:poke/service/pokemon_service.dart';

class PokemonRespository {

  int _code = 0;
  final PokemonService pokemonService;

  PokemonRespository({required this.pokemonService});
  
  // int page = 100;

  Future<List<Pokemon>> fetchPokemon(page) async{
    final pokemonList = await pokemonService.getPokemonList(page);
    _code = pokemonService.getCode;

    return pokemonList.map((e) => Pokemon.fromJson(e)).toList();
  }

  int get getCode => _code;
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke/models/pokemon.dart';
import 'package:poke/service/pokemon_service.dart';

class PokemonRespository {

  int _code = 0;
  final PokemonService pokemonService;

  PokemonRespository({required this.pokemonService});

  Future<List<Pokemon>> fetchPokemon() async{
    final pokemonList = await pokemonService.getPokemonList();
    _code = pokemonService.getCode;

    return pokemonList.map((e) => Pokemon.fromJson(e)).toList();
  }

  int get getCode => _code;
}
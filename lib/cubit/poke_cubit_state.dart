// import 'package:equatable/equatable.dart';

import 'package:poke/models/pokemon.dart';
import 'package:poke/models/pokemon_details.dart';

abstract class PokemonState {}

class InitialState extends PokemonState{}

class PokemonLoaded extends PokemonState{

  final List<Pokemon> pokemon;

  PokemonLoaded({required this.pokemon});
}

class PokemonImagenLoaded extends PokemonState{

  final List<PokemonDetails> pokemon;

  PokemonImagenLoaded({required this.pokemon});
}

class PokemonLoading extends PokemonState{
  final List<Pokemon> oldPokemon;
  final bool isFirstFetch;

  PokemonLoading(this.oldPokemon,{this.isFirstFetch=false});

}

class PokemonError extends PokemonState{}

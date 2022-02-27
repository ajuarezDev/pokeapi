// import 'package:equatable/equatable.dart';

import 'package:poke/models/pokemon.dart';

abstract class PokemonState {}

// class InitialState extends PokemonState {
  
//   @override 
//   List<Object> get props => [];
// }


// class WelcomeState extends PokemonState {
//   @override 
//   List<Object> get props => [];
// }

// class PokemonLoaded extends PokemonState{}


class InitialState extends PokemonState{}
class PokemonLoaded extends PokemonState{

  final List<Pokemon> pokemon;

  PokemonLoaded({required this.pokemon});
}

class PokemonError extends PokemonState{}

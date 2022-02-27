import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke/cubit/poke_cubit_state.dart';
import 'package:poke/repository/pokemon_repository.dart';

class PokeCubits extends Cubit<PokemonState> {
  // PokeCubits() : super(InitialState()){
  // }

  final PokemonRespository pokemonRespository;
  PokeCubits({required this.pokemonRespository}) : super(InitialState());


  fetchPokemon (){
    pokemonRespository.fetchPokemon().then((pokemon) {
      
      // print();

      if (pokemonRespository.getCode == 200){
        emit(PokemonLoaded(pokemon: pokemon));
      }else{
        emit(PokemonError());
      }

    });
  }

}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke/cubit/poke_cubit_state.dart';
import 'package:poke/models/pokemon.dart';
import 'package:poke/repository/pokemon_repository.dart';

class PokeCubits extends Cubit<PokemonState> {
  // PokeCubits() : super(InitialState()){
  // }

  final PokemonRespository pokemonRespository;
  PokeCubits({required this.pokemonRespository}) : super(InitialState());

  int page = 0;


  loadPokemon(){
    if (state is PokemonLoading) return;
    
    final currentState = state;

    var oldPokemon = <Pokemon>[];

    if (currentState is PokemonLoaded){
      oldPokemon = currentState.pokemon;
    } 

    emit(PokemonLoading(oldPokemon, isFirstFetch:  page == 1));
    pokemonRespository.fetchPokemon(page).then((newPokemon) {
      
      if (pokemonRespository.getCode == 200){
        page+=10;

        final pokemon =(state as PokemonLoading).oldPokemon;
        pokemon.addAll(newPokemon);
        emit(PokemonLoaded(pokemon: pokemon));
      }else{
        emit(PokemonError());
      }
    });

  }

}
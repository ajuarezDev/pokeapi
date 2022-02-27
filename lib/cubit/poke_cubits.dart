import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:poke/cubit/poke_cubit_state.dart';
import 'package:poke/models/pokemon.dart';
import 'package:poke/repository/pokemon_repository.dart';
import 'package:flutter/services.dart';

class PokeCubits extends Cubit<PokemonState> {
  // PokeCubits() : super(InitialState()){
  // }

  final PokemonRespository pokemonRespository;
  PokeCubits({required this.pokemonRespository}) : super(InitialState());
  
  

  int page = 0;
  String _url = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/';
  

  valideConexion() async{
    // ConnectivityResult _connectionStatus = ConnectivityResult.none;
    // final Connectivity _connectivity = Connectivity();
    // try {
    //   result = await _connectivity.checkConnectivity();
    // } on PlatformException catch (e) {
    //   developer.log('Couldn\'t check connectivity status', error: e);
    //   return;
    // }


    // print("valida conexion $result");
  }


  loadPokemon(){
    valideConexion();
    if (state is PokemonLoading) {
      return;
    } 
    
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

  // url() async{
  //    await dotenv.load(fileName: ".env");
  //   String baseUrl = dotenv.env['URL_IMAGEN'].toString();
  //   _url = baseUrl;
  //   // return _baseUrl;
  // }

  String get getUrl => _url;


  




  

}
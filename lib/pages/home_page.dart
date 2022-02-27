

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke/cubit/poke_cubit_logics.dart';
import 'package:poke/cubit/poke_cubits.dart';
import 'package:poke/repository/pokemon_repository.dart';
import 'package:poke/service/pokemon_service.dart';
import 'package:poke/views/home_view.dart';



class HomePage extends StatelessWidget {


  HomePage({Key? key}) : super(key: key);
  
  
  @override
  
  Widget build(BuildContext context) {
    PokemonRespository pokemonRespository;
    pokemonRespository = PokemonRespository(pokemonService: PokemonService()); 

     return BlocProvider<PokeCubits>(
      create: (context) => PokeCubits(pokemonRespository: pokemonRespository),
      child: const HomeView(),
    );
  }
}
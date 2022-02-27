import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke/cubit/poke_cubit_state.dart';
import 'package:poke/cubit/poke_cubits.dart';
import 'package:poke/views/home_view.dart';
import 'package:poke/views/load_view.dart';

class PokeCubitLogics extends StatefulWidget {
  const PokeCubitLogics({Key? key}) : super(key: key);

  @override 
  _PokeCubitLogicsState createState() => _PokeCubitLogicsState();

}

class _PokeCubitLogicsState extends State<PokeCubitLogics>{
  @override 

  Widget build(BuildContext context) {
    
    return Scaffold(
      body: BlocBuilder<PokeCubits, PokemonState>(
        builder: (context, state){
          if (state is PokemonLoaded){
            return HomeView();
          }else{
            return LoadView();
          }
        },
      ),

    );  
    
  }
}


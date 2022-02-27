
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke/cubit/poke_cubit_state.dart';
import 'package:poke/cubit/poke_cubits.dart';
import 'package:poke/ui/colors.dart';
import 'package:poke/ui/name.dart';
import 'package:poke/views/load_error_view.dart';
import 'package:poke/views/load_view.dart';


// const _barColor = ThemeColor.barColor;
// const _textName = TextEncabezado.name;

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
  
    return  Scaffold(
      appBar: AppBar(
        title: TextEncabezado.name,
        backgroundColor: ThemeColor.barColor,
      ),
      body: _PageView(),
      
    );
  }
}


class _PageView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    var main = BlocProvider.of<PokeCubits>(context).fetchPokemon();

    return BlocBuilder<PokeCubits, PokemonState>(
      builder: (context, state){

        if (state is PokemonError){
          return const LoadErrorView();
        }

        
          return const LoadView();
        if (state is! PokemonLoaded){
        }

        

        final pokemon = (state as PokemonLoaded).pokemon;

        // print(pokemon);


        return  SingleChildScrollView(
          child: Column(
            children: pokemon.map((e) => _pokemon(e, context)).toList(),
          ),
        );
      },
    );
  }

  Widget _pokemon(pokemon, context){
    return Card(
      // key: const Key("${pokemon.name}"), 
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey)
          )
        ),
        child: Row(
          children: [
            Text(pokemon.name),
          ],
        ),
      )
    );
  }
}


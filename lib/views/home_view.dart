
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke/cubit/poke_cubit_state.dart';
import 'package:poke/cubit/poke_cubits.dart';
import 'package:poke/models/pokemon.dart';
import 'package:poke/ui/colors.dart';
import 'package:poke/ui/name.dart';
import 'package:poke/views/load_error_view.dart';
import 'package:poke/views/load_view.dart';


// const _barColor = ThemeColor.barColor;
// const _textName = TextEncabezado.name;

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PokeCubits>(context).loadPokemon();

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
  
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge){
        if (scrollController.position.pixels != 0){
          BlocProvider.of<PokeCubits>(context).loadPokemon();

        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    setupScrollController(context);
    return BlocBuilder<PokeCubits, PokemonState>(
      builder: (context, state){

        if (state is PokemonError){
          return const LoadErrorView();
        }

        if (state is PokemonLoading && state.isFirstFetch){ 
          return const LoadView();
        }

        List<Pokemon> pokemon = [];
        bool isLoading = false;

        if (state is PokemonLoading){
          pokemon = state.oldPokemon;
          isLoading = true;
        }else if (state is PokemonLoaded) {
          pokemon = state.pokemon;
        }

        return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index){
            if (index < pokemon.length){
              return _pokemon(pokemon[index], context);
            }else{
              Timer(Duration(milliseconds: 30), (){
                scrollController.jumpTo(
                  scrollController.position.maxScrollExtent
                );
              });
              return const LoadView();
            }
          }, 
          separatorBuilder: (context, index){
            return const Divider(
              color: Colors.red,
            );
          }, 
          itemCount: pokemon.length + (isLoading ? 1: 0),
        );

      //   final pokemon = (state as PokemonLoaded).pokemon;

      //   return  SingleChildScrollView(
      //     child: Column(
      //       children: pokemon.map((e) => _pokemon(e, context)).toList(),
      //     ),
      //   );
      },
    );
  }

  Widget _pokemon(Pokemon pokemon, BuildContext context){

    var url = pokemon.url;
    print(url);

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


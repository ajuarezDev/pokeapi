
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
              Timer(const Duration(milliseconds: 30), (){
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
      },
    );
  }

  Widget _pokemon(Pokemon pokemon, BuildContext context){

    String url = pokemon.url;
    String name = pokemon.name;

    BlocProvider.of<PokeCubits>(context).loadImagen(url);
    // var imagen = BlocProvider.of<PokeCubits>(context, listen: true);



    // String imageurl = imagen.getImagen;
    // print(imageurl);
    return  Card(
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Expanded(
          //   flex: 1,
          //     child: Container(
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: NetworkImage(""),
          //           fit: BoxFit.fill),
          //     ),
          //   )
          // ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text('$name', style: TextStyle(
                          color: Colors.teal[400],
                          fontSize: 14,
                        ),
                          maxLines: 2)
                        ,
                      ),
                      
                    ],
                  ),
                  SizedBox(height: 10,),
                  // Expanded(
                  //   child: Row(
                  //     children: [
                  //       Icon(LineIcons.mapMarked, color: Colors.teal[400],),
                  //       SizedBox(width: 10,),
                  //       Expanded(
                  //         child: Text('$direccion', style: TextStyle(color: Color(0xfff303030)), maxLines: 2,),
                  //       ),
                        
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),    
        ],
      )
    );

  }
}


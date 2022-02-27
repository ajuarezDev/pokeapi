
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke/cubit/poke_cubit_state.dart';
import 'package:poke/cubit/poke_cubits.dart';
import 'package:poke/models/pokemon.dart';
import 'package:poke/ui/colors.dart';
import 'package:poke/ui/name.dart';
import 'package:poke/views/load_error_view.dart';
import 'package:poke/views/load_view.dart';
import 'package:cross_connectivity/cross_connectivity.dart';


class HomeView extends StatelessWidget {

  // HomeView({Key? key}) : super(key: key);
  
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge){
        print(scrollController.position.pixels);
          BlocProvider.of<PokeCubits>(context).loadPokemon();
        // if (scrollController.position.pixels != 0){

        // }
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<PokeCubits>(context).loadPokemon();

    return  Scaffold(
      appBar: AppBar(
        title: TextEncabezado.name,
        backgroundColor: ThemeColor.barColor,
      ),
      body: loadingPoke(),
    );
  }

  Widget loadingPoke () {

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

        return ConnectivityBuilder(
          builder: (context, isConnected, status) =>
            isConnected == false ? LoadErrorView() 
            : ListView.separated(
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
                  color: Colors.white,
                  height: 1.0,
                );
              }, 
              itemCount: pokemon.length + (isLoading ? 1: 0),
            )
          
        
        );

        // return 
      },
    );
  }
  
  Widget _pokemon(Pokemon pokemon, BuildContext context) {

    String urlPoke = pokemon.url;
    String name = pokemon.name;
    List part = urlPoke.split("/");
    String nameImage = "${part[6].toString()}.png";

    var imagen = BlocProvider.of<PokeCubits>(context, listen: true);
    String url = imagen.getUrl;
    String urlImagen = "$url$nameImage";
    String nameUpper = name[0].toUpperCase()+name.substring(1);
    String numberPoke = part[6].padLeft(3, '0');

    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          // color: Colors.redAccent,
          height: 100,
                decoration:  BoxDecoration(
                  color: Color(0xFFd94256),
                  borderRadius: BorderRadius.circular(20)

                  // borderRadius: BorderRadius.circular(15),
                  
                ),
                child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              // scale: 0.1,
                              // alignment: Alignment(6, 1), 
                              image: AssetImage('assets/images/pokeball.png'),
                              fit:BoxFit.fitWidth
                            ),
                          ),
                          // height: 75,
                          // width: 75,
                          child: FadeInImage(
                            placeholder: AssetImage('assets/gif/loading.gif'),
                            image: NetworkImage(urlImagen),
                            // fit: BoxFit.cover,
                            height: 10.0,
                            width: 10.0,
                          ),
                        ),  
                          
                          
                          // Image.network("$urlImagen",
                          // ),
                        // )
                      
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(nameUpper, style: const TextStyle(
                        color:  Color(0xFFfefcfc),
                        fontSize: 25,
                        ),
                      ),
                      
                      ),
                      Expanded(
                        child : Padding(
                        padding: EdgeInsets.only(top: 55, left: 0),
                          child: Text("#$numberPoke", 
                          style: TextStyle(
                            color: Color(0xFFe2707f),
                            fontSize: 31,
                          )
                        ),
                      ) 
                      
                      ),
                    ],
                  ),
                    // color: Colors.transparent,
                    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    // shadowColor: Colors.grey,
                    // child: Text('$nameUpper'))
                
              )
      )
    ) ;


  }
}





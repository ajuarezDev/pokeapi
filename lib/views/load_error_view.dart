
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke/cubit/poke_cubits.dart';
import 'package:poke/ui/colors.dart';
import 'package:poke/ui/name.dart';


// const _barColor = ThemeColor.barColor;
// const _textName = TextEncabezado.name;

class LoadErrorView extends StatelessWidget {
  const LoadErrorView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
  
    return  Scaffold(
      
      body:Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: _PageView(),
                  height: 550,

                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: 200,
                child: ImagenError(),
              ),
            ],
          )),
      
    );
  }
}


class _PageView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Form(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          children: [
            TextError(),
            TextError2(),
            ButtonRefresh(),
            // ImagenError(),

          ],
        )
      ),
    );
  }
}

class TextError extends StatelessWidget {
  // Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return const Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child:  Text("Something went wrong",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.grey,
        )
      )
    );
  }
}

class TextError2 extends StatelessWidget {
  // Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return const Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child:  Text("please try again later", 
        style: TextStyle(
          // fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.grey,
        ),
      )
    );
  }
}

class ButtonRefresh extends StatelessWidget {
  // Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
      left: 20.0, right: 20.0, top: 5.0, bottom: 0.0),
      child: Ink (  
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [ThemeColor.barColor, ThemeColor.barColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(25.0)
        ),
        child :  Container(
          width: double.infinity,
          child:  TextButton(
            child: const Text("Try Again Now",
              style:  TextStyle(fontSize: 18.0, color: Colors.white)
            ),
            style: TextButton.styleFrom(
              primary: Colors.white,
              padding: const EdgeInsets.only(left: 18.0, right: 18.0,bottom: 14.0,top: 14.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
              )
            ),
            onPressed:  () async {
              BlocProvider.of<PokeCubits>(context).loadPokemon();
            },
          )
        ),
        // color: Colors.orange
      ), 
    );
  }
}



class ImagenError extends StatelessWidget {
  // Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: Image.asset("assets/images/notfound.png",
        height: 100.0,
        width: 100.0,
      ),
    );
  }
}

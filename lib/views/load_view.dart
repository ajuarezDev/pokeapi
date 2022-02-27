
import 'package:flutter/material.dart';


// const _barColor = ThemeColor.barColor;
// const _textName = TextEncabezado.name;

class LoadView extends StatelessWidget {
  const LoadView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
  
    return  Center(
      child: Column(
        children: <Widget>[
          _PageView(),
        ],
      )
    );
  }
}

class _PageView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Center(
      child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 0),
          children: [
            ImagenLoading(),
            TextoLoading(),
          ],
        )
    );
  }
}

class TextoLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return const Padding(
      padding:  EdgeInsets.symmetric(horizontal: 150.0, vertical: 10),
      child:  Text("Loading...",
        style: TextStyle(
          fontSize: 25,
          color: Colors.black,
        )
      )
    );
  }
}


class ImagenLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: 75,
      child: Image.asset("assets/gif/loading.gif",
        height: 75.0,
        width: 75.0,
      ),
    );
  }
}

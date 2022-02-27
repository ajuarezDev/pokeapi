class PokemonDetails {
  String urlImagen;

  PokemonDetails({
    required this.urlImagen,
  });

  PokemonDetails.fromJson(Map json ) : 
    urlImagen = json['urlImagen'];


  Map<String, dynamic> toMap() =>{
    'urlImagen': urlImagen,
  };
}
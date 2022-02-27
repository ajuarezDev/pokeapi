class Pokemon {
  String name;
  String url;

  Pokemon({
    required this.name,
    required this.url,
  });

  Pokemon.fromJson(Map json ) : 
    name = json['name'],
    url = json['url'];

}
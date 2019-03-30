import 'dart:ui';

import 'package:meta/meta.dart';

class Peoples {
  final int id;
  final String name;
  final String word;
  final String dob;
  final String age;
  final String note;
  final String quotes;
  final String image;
  final Color color;
  final String work;
  final List<String> photoUrls;

  const Peoples( {
    this.photoUrls,
    @required this.color,
    @required this.name,
    @required this.image,
    @required this.age,
    @required this.dob,
    @required this.id,
    @required this.note,
    @required this.quotes,
    @required this.word,
    @required this.work,
    // @required this.photoUrls,
  })
      : assert(color != null),
        assert(image != null),
        assert(name != null),
        assert(age != null),
        assert(dob != null),
        assert(id != null),
        assert(note != null),
        assert(quotes != null),
        assert(work != null),
  //   assert(photoUrls !=null),
        assert(word != null);
  String get asset =>"assets/images/$image.png";
  bool get isDark => color.computeLuminance() < 0.6;
}
final List<Peoples> peoples= [
  Peoples(
      id:1,
      name: 'Rubén Lpez.',
      age: "22",
      dob: '28.Ene.97',
      note: "Soy desarrollador de aplicaciones.",
      quotes: "Estoy trabajando en Esupport para ofrecer mayor"
          "velocidad en las tareas diarias.",
      word: "Tener éxito es hacer lo que te gusta.",
      work:"Diseñador",
      image: "psi",
      photoUrls: ["assets/images/captain.png","assets/images/psi.png","assets/pimage/1.png",
      " assets/pimage/dvm1.jpg",
      ],
      color: Color.fromRGBO(234, 188, 48, 1.0)),


  Peoples(
      id:2,
      name: 'Iván Hdez',
      age: "22",
      dob: '15.Dic.96',
      note: "Lider de Esupport "
          " ",
      quotes: " ",
      word: "I´m Batman",
      image: "batman",
      work: "Líder",
      photoUrls: ["assets/images/captain.png","assets/pimage/1.png","assets/pimage/2.png","assets/pimage/3.png",],
      color: Color.fromRGBO(136, 91, 61, 1.0)),


  Peoples(
      id:3,
      name: 'Sergio R.',
      age: "22",
      dob: '17.May.96',
      note: "Soy desarrollador de aplicaciones."
          " ",
      quotes: " ",
      word: " ",
      image: "barackobama",
      work: "Diseñador",
      photoUrls: ["assets/images/captain.png","assets/images/captain.png","assets/images/captain.png","assets/images/captain.png",],
      color: Color.fromRGBO(167, 163, 156, 1.0)),


  Peoples(
      id:4,
      name: 'Marisela G.ª',
      age: "22",
      dob: '11.Jun.96',
      note: "Soy desarrollador de aplicaciones.",
      quotes: " ",
      word: "",
      image: "mujer-maravilla",
      work: "Analísta",
      photoUrls: ["assets/images/mujer-maravilla.png","assets/images/mujer-maravilla.png","assets/images/mujer-maravilla.png","assets/images/mujer-maravilla.png",],
      color: Color.fromRGBO(200, 76, 42, 1.0)),


  Peoples(
      id:5,
      name: 'Efraín Dguez.',
      age: "23",
      dob: '24.Ago.95',
      note: "Soy desarrollador de aplicaciones."
          "  ",
      quotes: " ",
      word: " "
          " ",
      image: "mickjagger",
      work: "Analista",
      photoUrls: ["assets/images/captain.png","assets/images/captain.png","assets/images/captain.png","assets/images/captain.png",],
      color: Color.fromRGBO(237, 142, 47, 1.0)),


  Peoples(
      id:6,
      name: 'Shaggy Rogers',
      age: "28",
      dob: '03.Jul.90',
      note: "!Zoinks!",
      quotes: " ",
      word: "Usaré menos de mi 1% de poder.",
      image: "shaggy-rogers",
      work: "Detective",
      photoUrls: ["assets/pimage/271.png","assets/images/shaggy-power.png","assets/images/009.png","assets/images/shaggy-15.png",],
      color: Color.fromRGBO(88, 90, 59, 1.0)),

  /*
  Peoples(
      id:7,
      name: 'Nikolatesla',
      age: "98",
      dob: '1.12.1890',
      note: "helloo divyam",
      quotes: "hoo",
      word: "",
      image: "nikolatesla",
      work: "inventer",
      photoUrls: ["assets/images/captain.png","assets/pimage/1.png","assets/pimage/2.png","assets/pimage/3.png",],
      color: Color.fromRGBO(121, 118, 114, 1.0)),
  Peoples(
      id:8,
      name: 'Batman',
      age: "58",
      dob: '1.12.1890',
      note: "fight in dark",
      quotes: "hoo",
      word: "",
      image: "batman",
      work: "hero",
      photoUrls: ["assets/images/captain.png","assets/pimage/1.png","assets/pimage/2.png","assets/pimage/3.png",],
      color: Color.fromRGBO(136, 91, 61, 1.0)),
  */
];
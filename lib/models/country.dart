class Country{
  /// Constructor
  Country();

  String _selected='1';

  /// list of countries
  final List<Map> _myJson = [
    {"id": '1', "image": "assets/images/egypt.png", "name": "Egypt"},
    {"id": '2', "image": "assets/images/am.png", "name": "US"},
    {"id": '3', "image": "assets/images/china.png", "name": "China"},
    {"id": '4', "image": "assets/images/eng.png", "name": "UK"},
    {"id": '5', "image": "assets/images/india.png", "name": "India"},
    {"id": '6', "image": "assets/images/fr.jpg", "name": "Fra"},
    {"id": '7', "image": "assets/images/ger.png", "name": "Germ"},
    {"id": '8', "image": "assets/images/imarat.png", "name": "UAE"},
    {"id": '9', "image": "assets/images/sauid.png", "name": "SA"},
    {"id": '10', "image": "assets/images/jur.png", "name": "JUR"},
    {"id": '11', "image": "assets/images/itali.png", "name": "Itali"},
    {"id": '12', "image": "assets/images/jap.png", "name": "Japan"},
    {"id": '13', "image": "assets/images/spain.png", "name": "Spain"},
    {"id": '14', "image": "assets/images/turk.png", "name": "Turkish"},

  ];

/// getter and setter
  set selected(String value) {
    _selected = value;
  }

  String get selected => _selected;

  List<Map> get myJson => _myJson;
}
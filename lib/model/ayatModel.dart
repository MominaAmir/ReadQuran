class Ayatmodel {
  final String? arText;
  final String? ayatrans;
  final int? suNum;
  final String? suName;

  Ayatmodel({this.arText, this.ayatrans, this.suNum, this.suName});

  factory Ayatmodel.fromJSON(List<dynamic> jsonData) {
  String? arText;
  String? ayatrans;
  int? suNum;
  String? suName;

  for (var item in jsonData) {
    var edition = item['edition']['identifier'];
    if (edition == 'quran-uthmani') {
      arText = item['text'];
      suNum = item['surah']['number'];
      suName = item['surah']['englishName'];
    } else if (edition == 'en.asad') {
      ayatrans = item['text'];
    }
  }

  return Ayatmodel(
    arText: arText,
    ayatrans: ayatrans,
    suNum: suNum,
    suName: suName,
  );
}
}


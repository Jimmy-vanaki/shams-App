class ReportModel {
  String status;
  List<SerialModel> serials;

  ReportModel({
    required this.status,
    required this.serials,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      status: json['status'],
      serials: List<SerialModel>.from(
          json['serials'].map((serial) => SerialModel.fromJson(serial))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'serials': serials.map((serial) => serial.toJson()).toList(),
    };
  }
}

class SerialModel {
  int id;
  int rePrint;
  String? serial;
  String? code;
  String? code1;
  String? code2;
  String? code3;
  String? code4;
  int dateTime;
  String sellType;
  String title;
  int cardId;
  String photo;
  String companyTitle;
  String photoUrl;
  String printDate;
  int? cardPrice;

  SerialModel({
    required this.id,
    required this.rePrint,
    this.serial,
    this.code,
    this.code1,
    this.code2,
    this.code3,
    this.code4,
    this.cardPrice,
    required this.dateTime,
    required this.sellType,
    required this.title,
    required this.cardId,
    required this.photo,
    required this.companyTitle,
    required this.photoUrl,
    required this.printDate,
  });

  factory SerialModel.fromJson(Map<String, dynamic> json) {
    return SerialModel(
      id: json['id'],
      rePrint: json['re_print'],
      serial: json['serial'],
      code: json['code'],
      code1: json['code1'],
      code2: json['code2'],
      code3: json['code3'],
      code4: json['code4'],
      dateTime: json['date_time'],
      sellType: json['sell_type'],
      title: json['title'],
      cardId: json['card_id'],
      photo: json['photo'],
      companyTitle: json['company_title'],
      photoUrl: json['photo_url'],
      printDate: json['print_date'],
      cardPrice: json['card_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      're_print': rePrint,
      'serial': serial,
      'code': code,
      'code1': code1,
      'code2': code2,
      'code3': code3,
      'code4': code4,
      'date_time': dateTime,
      'sell_type': sellType,
      'title': title,
      'card_id': cardId,
      'photo': photo,
      'company_title': companyTitle,
      'photo_url': photoUrl,
      'print_date': printDate,
      'card_price': cardPrice,
    };
  }
}

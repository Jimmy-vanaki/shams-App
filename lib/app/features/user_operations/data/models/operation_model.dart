class OperationModel {
  String status;
  List<Datum> data;

  OperationModel({
    required this.status,
    required this.data,
  });

  factory OperationModel.fromJson(Map<String, dynamic> json) => OperationModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  int userId;
  String? deviceToken;
  int dateTime;
  Name? name;
  int? deposit;
  int? inventory;
  CategoryTitle? categoryTitle;
  CompanyTitle? companyTitle;
  int? numCount;
  int? serialCount;
  DateTime? printDate;

  Datum({
    required this.id,
    required this.userId,
    this.deviceToken,
    required this.dateTime,
    this.name,
    this.deposit,
    this.inventory,
    this.categoryTitle,
    this.companyTitle,
    this.numCount,
    this.serialCount,
    this.printDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        deviceToken: json["device_token"],
        dateTime: json["date_time"],
        name: json["name"] != null ? nameValues.map[json["name"]] : null,
        deposit: json["deposit"],
        inventory: json["inventory"],
        categoryTitle: json["category_title"] != null
            ? categoryTitleValues.map[json["category_title"]]
            : null,
        companyTitle: json["company_title"] != null
            ? companyTitleValues.map[json["company_title"]]
            : null,
        numCount: json["num_count"],
        serialCount: json["serial_count"],
        printDate: json["print_date"] == null
            ? null
            : DateTime.parse(json["print_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "device_token": deviceToken,
        "date_time": dateTime,
        "name": nameValues.reverse[name],
        "deposit": deposit,
        "inventory": inventory,
        "category_title": categoryTitleValues.reverse[categoryTitle],
        "company_title": companyTitleValues.reverse[companyTitle],
        "num_count": numCount,
        "serial_count": serialCount,
        "print_date": printDate?.toIso8601String(),
      };
}

enum CategoryTitle { ASIACELL_5000_IQD }

final categoryTitleValues =
    EnumValues({" ASIACELL_5000IQD": CategoryTitle.ASIACELL_5000_IQD});

enum CompanyTitle { ASIA_CELL }

final companyTitleValues = EnumValues({"AsiaCell": CompanyTitle.ASIA_CELL});

enum Name { EHAB }

final nameValues = EnumValues({"ehab": Name.EHAB});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

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
  int dateTime;
  String? deviceToken;
  String? categoryTitle;
  CompanyTitle? companyTitle;
  int? numCount;
  int? inventory;
  int? serialCount;
  DateTime? printDate;
  int? userPrice;
  int? agentPrice;
  int? parentAgentPrice;
  int? categoryPrice;
  String? name; // نام کاربر یا عملیات
  int? deposit; // مبلغ واریزی

  Datum({
    required this.id,
    required this.userId,
    required this.dateTime,
    this.deviceToken,
    this.categoryTitle,
    this.companyTitle,
    this.numCount,
    this.inventory,
    this.serialCount,
    this.printDate,
    this.userPrice,
    this.agentPrice,
    this.parentAgentPrice,
    this.categoryPrice,
    this.name,
    this.deposit,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        dateTime: json["date_time"] ?? 0,
        deviceToken: json["device_token"] ?? "",
        categoryTitle: json["category_title"] ?? "",
        companyTitle: json["company_title"] != null
            ? companyTitleValues.map[json["company_title"]]
            : null,
        numCount: json["num_count"] ?? 0,
        inventory: json["inventory"] ?? 0,
        serialCount: json["serial_count"] ?? 0,
        printDate: json["print_date"] != null
            ? DateTime.tryParse(json["print_date"])
            : null,
        userPrice: json["user_price"] ?? 0,
        agentPrice: json["agent_price"] ?? 0,
        parentAgentPrice: json["parent_agent_price"] ?? 0,
        categoryPrice: json["category_price"] ?? 0,
        name: json["name"] ?? "",
        deposit: json["deposit"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "date_time": dateTime,
        "device_token": deviceToken ?? "",
        "category_title": categoryTitle ?? "",
        "company_title": companyTitle != null
            ? companyTitleValues.reverse[companyTitle]
            : "",
        "num_count": numCount ?? 0,
        "inventory": inventory ?? 0,
        "serial_count": serialCount ?? 0,
        "print_date": printDate?.toIso8601String() ?? "",
        "user_price": userPrice ?? 0,
        "agent_price": agentPrice ?? 0,
        "parent_agent_price": parentAgentPrice ?? 0,
        "category_price": categoryPrice ?? 0,
        "name": name ?? "",
        "deposit": deposit ?? 0,
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

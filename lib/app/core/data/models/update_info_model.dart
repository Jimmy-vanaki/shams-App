class UpdateInfoModel {
  String? status;
  User? user;
  String? totalSales;
  int? loggedIn;
  String? namePhotoUrl;
  List<Company>? companies;
  List<AsiacellCategory>? asiacellCategories;

  UpdateInfoModel({
    this.status,
    this.user,
    this.totalSales,
    this.loggedIn,
    this.namePhotoUrl,
    this.companies,
    this.asiacellCategories,
  });

  factory UpdateInfoModel.fromJson(Map<String, dynamic> json) =>
      UpdateInfoModel(
        status: json["status"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        totalSales: json["total_sales"],
        loggedIn: json["logged_in"],
        namePhotoUrl: json["name_photo_url"],
        companies: json["companies"] == null
            ? null
            : List<Company>.from(
                json["companies"].map((x) => Company.fromJson(x))),
        asiacellCategories: json["asiacell_categories"] == null
            ? null
            : List<AsiacellCategory>.from(json["asiacell_categories"]
                .map((x) => AsiacellCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user?.toJson(),
        "total_sales": totalSales,
        "logged_in": loggedIn,
        "name_photo_url": namePhotoUrl,
        "companies": companies == null
            ? null
            : List<dynamic>.from(companies!.map((x) => x.toJson())),
        "asiacell_categories": asiacellCategories == null
            ? null
            : List<dynamic>.from(asiacellCategories!.map((x) => x.toJson())),
      };
}

class AsiacellCategory {
  int? id;
  int? parentId;
  Type? type;
  String? title;
  int? price;
  String? img; // New field for img
  String? description;
  int? show2Site;
  int? idShow;
  String? photoUrl; // New field for photo_url
  AgentPrice? agentPrice;

  AsiacellCategory({
    this.id,
    this.parentId,
    this.type,
    this.title,
    this.price,
    this.img, // Initialize img field
    this.description,
    this.show2Site,
    this.idShow,
    this.photoUrl, // Initialize photoUrl field
    this.agentPrice,
  });

  factory AsiacellCategory.fromJson(Map<String, dynamic> json) =>
      AsiacellCategory(
        id: json["id"],
        parentId: json["parent_id"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        title: json["title"],
        price: json["price"],
        img: json["img"], // Parse img from JSON
        description: json["description"],
        show2Site: json["show2site"],
        idShow: json["id_show"],
        photoUrl: json["photo_url"], // Parse photo_url from JSON
        agentPrice: json["agent_price"] == null
            ? null
            : AgentPrice.fromJson(json["agent_price"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "type": type == null ? null : typeValues.reverse[type],
        "title": title,
        "price": price,
        "img": img, // Include img in toJson
        "description": description,
        "show2site": show2Site,
        "id_show": idShow,
        "photo_url": photoUrl, // Include photo_url in toJson
        "agent_price": agentPrice?.toJson(),
      };
}

class AgentPrice {
  int? price;
  int? cardCategoryId;

  AgentPrice({
    this.price,
    this.cardCategoryId,
  });

  factory AgentPrice.fromJson(Map<String, dynamic> json) => AgentPrice(
        price: json["price"],
        cardCategoryId: json["card_category_id"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "card_category_id": cardCategoryId,
      };
}

enum Type { BILL, BUNDLE, TOPUP }

final typeValues =
    EnumValues({"bill": Type.BILL, "bundle": Type.BUNDLE, "topup": Type.TOPUP});

class Company {
  int? id;
  String? title;
  String? photo;
  String? logoUrl;
  CardDetails? cardDetails;

  Company({
    this.id,
    this.title,
    this.photo,
    this.logoUrl,
    this.cardDetails,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        title: json["title"],
        photo: json["photo"],
        logoUrl: json["logo_url"],
        cardDetails: json["card_details"] == null
            ? null
            : CardDetails.fromJson(json["card_details"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "photo": photo,
        "logo_url": logoUrl,
        "card_details": cardDetails?.toJson(),
      };
}

class CardDetails {
  int? id;
  int? companyId;
  String? cardHeader;
  String? cardFooter;
  int? pageHeight;
  String? photoUrl;

  CardDetails({
    this.id,
    this.companyId,
    this.cardHeader,
    this.cardFooter,
    this.pageHeight,
    this.photoUrl,
  });

  factory CardDetails.fromJson(Map<String, dynamic> json) => CardDetails(
        id: json["id"],
        companyId: json["company_id"],
        cardHeader: json["card_header"],
        cardFooter: json["card_footer"],
        pageHeight: json["page_height"],
        photoUrl: json["photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "card_header": cardHeader,
        "card_footer": cardFooter,
        "page_height": pageHeight,
        "photo_url": photoUrl,
      };
}

class User {
  int? id;
  String? lang;
  String? name;
  String? officeOwner;
  String? delegate;
  int? totalBalance;
  String? username;
  String? password;
  String? codeNumber;
  int? cityId;
  int? companyId;
  int? agentId;
  String? posUsername;
  String? mobile;
  String? description;
  String? address;
  int? deviceId;
  int? active;
  int? loggedIn;
  String? firebaseToken;
  String? firebaseDevice;
  dynamic deletedAt;
  String? photoUrl;
  Agent? agent;

  User({
    this.id,
    this.lang,
    this.name,
    this.officeOwner,
    this.delegate,
    this.totalBalance,
    this.username,
    this.password,
    this.codeNumber,
    this.cityId,
    this.companyId,
    this.agentId,
    this.posUsername,
    this.mobile,
    this.description,
    this.address,
    this.deviceId,
    this.active,
    this.loggedIn,
    this.firebaseToken,
    this.firebaseDevice,
    this.deletedAt,
    this.photoUrl,
    this.agent,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        lang: json["lang"],
        name: json["name"],
        officeOwner: json["office_owner"],
        delegate: json["delegate"],
        totalBalance: json["total_balance"],
        username: json["username"],
        password: json["password"],
        codeNumber: json["code_number"],
        cityId: json["city_id"],
        companyId: json["company_id"],
        agentId: json["agent_id"],
        posUsername: json["pos_username"],
        mobile: json["mobile"],
        description: json["description"],
        address: json["address"],
        deviceId: json["device_id"],
        active: json["active"],
        loggedIn: json["logged_in"],
        firebaseToken: json["firebase_token"],
        firebaseDevice: json["firebase_device"],
        deletedAt: json["deleted_at"],
        photoUrl: json["photo_url"],
        agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lang": lang,
        "name": name,
        "office_owner": officeOwner,
        "delegate": delegate,
        "total_balance": totalBalance,
        "username": username,
        "password": password,
        "code_number": codeNumber,
        "city_id": cityId,
        "company_id": companyId,
        "agent_id": agentId,
        "pos_username": posUsername,
        "mobile": mobile,
        "description": description,
        "address": address,
        "device_id": deviceId,
        "active": active,
        "logged_in": loggedIn,
        "firebase_token": firebaseToken,
        "firebase_device": firebaseDevice,
        "deleted_at": deletedAt,
        "photo_url": photoUrl,
        "agent": agent?.toJson(),
      };
}

class Agent {
  int? id;
  int? parentId;
  String? lang;
  String? name;
  String? photo;
  String? appPhoto;
  String? email;
  int? feature;
  int? cityId;
  String? access;
  String? description;
  String? primaryColor;
  String? onPrimaryColor;
  dynamic alrabeaToken;
  int? masalBalance;
  int? numberPrint;
  int? timePrint;
  int? numberCardEdition;
  int? accessAllAgent;
  int? limitAgentPrint;
  int? active;
  dynamic deletedAt;
  String? appPhotoUrl;
  int? maxReprints;
  String? supportText;

  Agent({
    this.id,
    this.parentId,
    this.lang,
    this.name,
    this.photo,
    this.appPhoto,
    this.email,
    this.feature,
    this.cityId,
    this.access,
    this.description,
    this.primaryColor,
    this.onPrimaryColor,
    this.alrabeaToken,
    this.masalBalance,
    this.numberPrint,
    this.timePrint,
    this.numberCardEdition,
    this.accessAllAgent,
    this.limitAgentPrint,
    this.active,
    this.deletedAt,
    this.appPhotoUrl,
    this.maxReprints,
    this.supportText,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        id: json["id"],
        parentId: json["parent_id"],
        lang: json["lang"],
        name: json["name"],
        photo: json["photo"],
        appPhoto: json["app_photo"],
        email: json["email"],
        feature: json["feature"],
        cityId: json["city_id"],
        access: json["access"],
        description: json["description"],
        primaryColor: json["primary_color"],
        onPrimaryColor: json["on_primary_color"],
        alrabeaToken: json["alrabea_token"],
        masalBalance: json["masal_balance"],
        numberPrint: json["number_print"],
        timePrint: json["time_print"],
        numberCardEdition: json["number_card_edition"],
        accessAllAgent: json["access_all_agent"],
        limitAgentPrint: json["limit_agent_print"],
        active: json["active"],
        deletedAt: json["deleted_at"],
        appPhotoUrl: json["app_photo_url"],
        maxReprints: json["max_reprints"],
        supportText: json["support_txt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "lang": lang,
        "name": name,
        "photo": photo,
        "app_photo": appPhoto,
        "email": email,
        "feature": feature,
        "city_id": cityId,
        "access": access,
        "description": description,
        "primary_color": primaryColor,
        "on_primary_color": onPrimaryColor,
        "alrabea_token": alrabeaToken,
        "masal_balance": masalBalance,
        "number_print": numberPrint,
        "time_print": timePrint,
        "number_card_edition": numberCardEdition,
        "access_all_agent": accessAllAgent,
        "limit_agent_print": limitAgentPrint,
        "active": active,
        "deleted_at": deletedAt,
        "app_photo_url": appPhotoUrl,
        "max_reprints": maxReprints,
        "supportText": supportText,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
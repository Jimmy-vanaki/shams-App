class HomeModel {
  String status;
  List<Company> companies;
  List<Slider> sliders;
  List<AsiacellCategory>? asiacellCategories;

  HomeModel({
    required this.status,
    required this.companies,
    required this.sliders,
    this.asiacellCategories,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        companies: List<Company>.from(
            json["companies"].map((x) => Company.fromJson(x))),
        sliders:
            List<Slider>.from(json["sliders"].map((x) => Slider.fromJson(x))),
        asiacellCategories: json["asiacell_categories"] == null
            ? null
            : List<AsiacellCategory>.from(json["asiacell_categories"]
                .map((x) => AsiacellCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "companies": List<dynamic>.from(companies.map((x) => x.toJson())),
        "sliders": List<dynamic>.from(sliders.map((x) => x.toJson())),
        "asiacell_categories": asiacellCategories == null
            ? null
            : List<dynamic>.from(asiacellCategories!.map((x) => x.toJson())),
      };
}

class Company {
  int id;
  String title;
  String logoUrl;

  Company({
    required this.id,
    required this.title,
    required this.logoUrl,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        title: json["title"],
        logoUrl: json["logo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "logo_url": logoUrl,
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

class Slider {
  int id;
  String title;
  String? cityId; // ممکن است null باشد
  String link;
  String photoUrl;

  Slider({
    required this.id,
    required this.title,
    this.cityId,
    required this.link,
    required this.photoUrl,
  });

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        id: json["id"],
        title: json["title"],
        cityId: json["city_id"],
        link: json["link"],
        photoUrl: json["photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "city_id": cityId,
        "link": link,
        "photo_url": photoUrl,
      };
}

enum Type { BILL, BUNDLE, TOPUP }

final typeValues =
    EnumValues({"bill": Type.BILL, "bundle": Type.BUNDLE, "topup": Type.TOPUP});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

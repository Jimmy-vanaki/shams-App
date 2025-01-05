class HomeModel {
  String status;
  List<Company> companies;
  List<Slider> sliders;

  HomeModel({
    required this.status,
    required this.companies,
    required this.sliders,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        companies: List<Company>.from(
            json["companies"].map((x) => Company.fromJson(x))),
        sliders:
            List<Slider>.from(json["sliders"].map((x) => Slider.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "companies": List<dynamic>.from(companies.map((x) => x.toJson())),
        "sliders": List<dynamic>.from(sliders.map((x) => x.toJson())),
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

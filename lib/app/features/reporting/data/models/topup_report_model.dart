class TopupReportModel {
  String status;
  List<Transaction> transactions;

  TopupReportModel({
    required this.status,
    required this.transactions,
  });

  factory TopupReportModel.fromJson(Map<String, dynamic> json) =>
      TopupReportModel(
        status: json["status"],
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class Transaction {
  int id;
  int userId;
  String transactionType;
  double transactionId;
  int asiacellProductId;
  String asiacellProductTitle;
  int price;
  String mobile;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.transactionType,
    required this.transactionId,
    required this.asiacellProductId,
    required this.asiacellProductTitle,
    required this.price,
    required this.mobile,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        userId: json["user_id"],
        transactionType: json["transaction_type"],
        transactionId: json["transaction_id"]?.toDouble(),
        asiacellProductId: json["asiacell_product_id"],
        asiacellProductTitle: json["asiacell_product_title"],
        price: json["price"],
        mobile: json["mobile"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "transaction_type": transactionType,
        "transaction_id": transactionId,
        "asiacell_product_id": asiacellProductId,
        "asiacell_product_title": asiacellProductTitle,
        "price": price,
        "mobile": mobile,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

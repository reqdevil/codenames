// ignore_for_file: file_names

AccessToken tokenFromJson(Map<String, dynamic> json) =>
    AccessToken.fromJson(json);

class AccessToken {
  final String token;
  final DateTime expirationDate;

  AccessToken({
    required this.token,
    required this.expirationDate,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
        token: json["token"],
        expirationDate: DateTime.parse(json["expiration"]),
      );
}

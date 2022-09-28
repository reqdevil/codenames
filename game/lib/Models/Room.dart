// ignore_for_file: file_names

Room roomFromJson(Map<String, dynamic> json) => Room.fromJson(json);

class Room {
  final int id;
  final String roomName;
  final bool isActive;

  Room({
    required this.id,
    required this.roomName,
    required this.isActive,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["roomId"] ?? json["id"],
        roomName: json["roomName"],
        isActive: json["isActive"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "roomName": roomName,
      };
}

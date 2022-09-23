// ignore_for_file: file_names

Room roomFromJson(Map<String, dynamic> json) => Room.fromJson(json);

class Room {
  final int id;
  final String roomName;

  Room({
    required this.id,
    required this.roomName,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        roomName: json["roomName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "roomName": roomName,
      };
}

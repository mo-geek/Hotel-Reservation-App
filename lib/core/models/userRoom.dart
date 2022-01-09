import 'dart:math';

class UserRoomFields {
  static List<String> getUserRoomFields = [idUser, idRoom];

  static const String idUser = 'UserId';
  static const String idRoom = 'RoomId';
}

class UserRoom {
  final int idUser;
  final int idRoom;

  const UserRoom({
    required this.idUser,
    required this.idRoom,
  });

  UserRoom copy({
    int? idUser,
    int? idRoom,
  }) =>
      UserRoom(
        idUser: idUser ?? this.idUser,
        idRoom: idRoom ?? this.idRoom,
      );

  static UserRoom fromJson(Map<String, Object?> map) {
    return UserRoom(
      idUser: map[UserRoomFields.idUser] as int,
      idRoom: map[UserRoomFields.idRoom] as int,
    );
  }

  Map<String, Object?> toJson() {
    var map = <String, Object?>{};
    map = {
      UserRoomFields.idUser: idUser,
      UserRoomFields.idRoom: idRoom,
    };
    return map;
  }
}

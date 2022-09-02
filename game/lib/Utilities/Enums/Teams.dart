// ignore_for_file: file_names

enum Teams {
  blue,
  red,
  white,
  black,
}

Teams getTeamWithId(int id) {
  switch (id) {
    case 1:
      return Teams.red;
    case 2:
      return Teams.blue;
    case 3:
      return Teams.black;
    default: // 0
      return Teams.white;
  }
}

// ignore_for_file: file_names, constant_identifier_names

import 'package:flutter/material.dart';

// URLs
const String GAME_HUB = "http://10.0.2.2:25528/gamesocket";

const String SIGN = "User/Sign";
const String LOGIN = "User/Login";

const String GET_ALL_WORDS = "Word/GetAllWords";
const String GET_PLAY_WORDS = "Word/GetPlayWords";

const String FIND_ROOM = "Room/FindRoom";
const String CREATE_ROOM = "Room/CreateRoom";
const String JOIN_ROOM = "Room/JoinRoom";
const String DELETE_ROOM = "Room/DeleteRoom";

const String START_GAME = "Game/StartGame";

ValueNotifier<bool> visible = ValueNotifier<bool>(true);

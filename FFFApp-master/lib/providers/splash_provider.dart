import 'package:flutter/material.dart';
import 'package:FFF/data/repositories/splash_repo.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo splashRepo;

  SplashProvider({required this.splashRepo});

  Future<bool> initConfig(GlobalKey<ScaffoldMessengerState> globalKey) async {
    return true;
  }

  Future<bool> removeSharedData() {
    return splashRepo.removeSharedData();
  }
}

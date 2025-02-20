import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/models/settings_model.dart';
import 'package:twitter_clone_2025/repos/settings_repo.dart';

class SettingsViewModel extends ChangeNotifier {
  final SettingsRepository _repository;
  SettingsViewModel(this._repository);

  late final SettingsModel _model = SettingsModel(
    darkmode: _repository.isDarkmode(),
  );

  bool get darkmode => _model.darkmode;
  void setDarkmode(bool value) {
    _repository.setDarkmode(value);
    _model.darkmode = value;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterIntakeProvider extends ChangeNotifier {
  int _waterIntake = 0;
  int _dailyGoals = 8; 
  final List<int> _dailyGoalOptions = [8, 10, 12];

  int get waterIntake => _waterIntake;
  int get dailyGoals => _dailyGoals;
  List<int> get dailyGoalOptions => _dailyGoalOptions;

  bool get goalReached => waterIntake >= dailyGoals;

  Future<void> setDailyGoals(int newGoals) async {
    if (_dailyGoalOptions.contains(newGoals)) {
      _dailyGoals = newGoals;
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setInt('dailyGoals', newGoals);
      notifyListeners();
    }
  }

  Future<void> incrementWaterIntake() async {
    if (_waterIntake < _dailyGoals) {
      _waterIntake++;
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setInt('waterIntake', _waterIntake);
      notifyListeners();
    }
  }

  Future<void> resetWaterIntake() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _waterIntake = 0;
    pref.setInt('waterIntake', _waterIntake);
    notifyListeners();
  }

  Future<void> loadPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _waterIntake = pref.getInt('waterIntake') ?? 0;
    _dailyGoals = pref.getInt('dailyGoals') ?? _dailyGoalOptions.first;
    notifyListeners();
  }
}

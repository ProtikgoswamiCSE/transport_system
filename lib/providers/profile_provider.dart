import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';
import 'dart:convert';

class ProfileProvider with ChangeNotifier {
  ProfileModel? _profile;
  final SharedPreferences _prefs;

  ProfileProvider(this._prefs) {
    _loadProfile();
  }

  ProfileModel? get profile => _profile;

  Future<void> _loadProfile() async {
    final profileJson = _prefs.getString('profile');
    if (profileJson != null) {
      final Map<String, dynamic> profileMap = json.decode(profileJson);
      _profile = ProfileModel(
        name: profileMap['name'] ?? '______ _______',
        email: profileMap['email'] ?? '_____________@diu.edu.bd',
        phone: profileMap['phone'] ?? '+880 1234 567890',
        address: profileMap['address'] ?? 'Daffodil Smart City, Ashulia',
        bloodGroup: profileMap['bloodGroup'] ?? 'O+',
        studentId: profileMap['studentId'] ?? '221-15-5841',
        department: profileMap['department'] ?? 'CSE, DIU',
        profileImagePath: profileMap['profileImagePath'] ?? '',
        trips: profileMap['trips'] ?? 0,
        rating: profileMap['rating'] ?? 4.8,
        points: profileMap['points'] ?? 0,
      );
      notifyListeners();
    } else {
      // Set default profile if none exists
      _profile = ProfileModel(
        name: '______ _______',
        email: '_____________@diu.edu.bd',
        phone: '+880 1234 567890',
        address: 'Daffodil Smart City, Ashulia',
        bloodGroup: 'O+',
        studentId: '221-15-5841',
        department: 'CSE, DIU',
        profileImagePath: '',
        trips: 0,
        rating: 4.8,
        points: 0,
      );
      await _saveProfile();
    }
  }

  Future<void> updateProfile(ProfileModel newProfile) async {
    _profile = newProfile;
    await _saveProfile();
    notifyListeners();
  }

  Future<void> _saveProfile() async {
    if (_profile != null) {
      final profileMap = {
        'name': _profile!.name,
        'email': _profile!.email,
        'phone': _profile!.phone,
        'address': _profile!.address,
        'bloodGroup': _profile!.bloodGroup,
        'studentId': _profile!.studentId,
        'department': _profile!.department,
        'profileImagePath': _profile!.profileImagePath,
        'trips': _profile!.trips,
        'rating': _profile!.rating,
        'points': _profile!.points,
      };
      await _prefs.setString('profile', json.encode(profileMap));
    }
  }
}

class ProfileModel {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String bloodGroup;
  final String studentId;
  final String department;
  final String profileImagePath;
  final int trips;
  final double rating;
  final int points;

  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.bloodGroup,
    required this.studentId,
    required this.department,
    required this.profileImagePath,
    required this.trips,
    required this.rating,
    required this.points,
  });

  ProfileModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? bloodGroup,
    String? studentId,
    String? department,
    String? profileImagePath,
    int? trips,
    double? rating,
    int? points,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      studentId: studentId ?? this.studentId,
      department: department ?? this.department,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      trips: trips ?? this.trips,
      rating: rating ?? this.rating,
      points: points ?? this.points,
    );
  }
}

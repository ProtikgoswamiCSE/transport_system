import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transport_system/providers/profile_provider.dart';
import 'package:transport_system/models/profile_model.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transport_system/screen/Driver_main.dart';

class DProfileScreen extends StatefulWidget {
  const DProfileScreen({super.key});

  @override
  State<DProfileScreen> createState() => _DProfileScreenState();
}

class _DProfileScreenState extends State<DProfileScreen> {
  bool _isEditing = false;
  File? _profileImage;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _bloodGroupController;
  late TextEditingController _transportIdController;
  late TextEditingController _busNoController;
  late TextEditingController _tripsController;
  late TextEditingController _ratingController;
  late TextEditingController _pointsController;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadLoginData();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('driver_profile_image');
    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  Future<void> _loadLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('driver_name') ?? '';
    final phone = prefs.getString('driver_phone') ?? '';
    final bloodGroup = prefs.getString('driver_blood_group') ?? '';
    final transportId = prefs.getString('driver_transport_id') ?? '';
    final busNo = prefs.getString('driver_bus_no') ?? '';
    final email = prefs.getString('driver_email') ?? '';
    final address = prefs.getString('driver_address') ?? '';
    final trips = prefs.getInt('driver_trips') ?? 0;
    final rating = prefs.getDouble('driver_rating') ?? 0.0;
    final points = prefs.getInt('driver_points') ?? 0;

    setState(() {
      _nameController.text = name;
      _phoneController.text = phone;
      _bloodGroupController.text = bloodGroup;
      _transportIdController.text = transportId;
      _busNoController.text = busNo;
      _emailController.text = email;
      _addressController.text = address;
      _tripsController.text = trips.toString();
      _ratingController.text = rating.toString();
      _pointsController.text = points.toString();
    });
  }

  void _initializeControllers() {
    final profile = context.read<ProfileProvider>().profile;
    _nameController = TextEditingController(text: profile?.name);
    _emailController = TextEditingController(text: profile?.email);
    _phoneController = TextEditingController(text: profile?.phone);
    _addressController = TextEditingController(text: profile?.address);
    _bloodGroupController = TextEditingController(text: profile?.bloodGroup);
    _transportIdController = TextEditingController();
    _busNoController = TextEditingController();
    _tripsController = TextEditingController(text: profile?.trips.toString());
    _ratingController = TextEditingController(text: profile?.rating.toString());
    _pointsController = TextEditingController(text: profile?.points.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _bloodGroupController.dispose();
    _transportIdController.dispose();
    _busNoController.dispose();
    _tripsController.dispose();
    _ratingController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('driver_name', _nameController.text);
      await prefs.setString('driver_phone', _phoneController.text);
      await prefs.setString('driver_blood_group', _bloodGroupController.text);
      await prefs.setString('driver_transport_id', _transportIdController.text);
      await prefs.setString('driver_bus_no', _busNoController.text);

      // Save profile image path if it exists
      if (_profileImage != null) {
        await prefs.setString('driver_profile_image', _profileImage!.path);
      }

      final newProfile = ProfileModel(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        bloodGroup: _bloodGroupController.text,
        studentId: _transportIdController.text,
        department: _busNoController.text,
        profileImagePath: _profileImage?.path ?? '',
        trips: int.parse(_tripsController.text),
        rating: double.parse(_ratingController.text),
        points: int.parse(_pointsController.text),
      );

      context.read<ProfileProvider>().updateProfile(newProfile);
      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DApp()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildProfileStats(),
            _buildProfileSections(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.3,
        20,
        MediaQuery.of(context).size.width * 0.3,
        20,
      ),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.12,
                backgroundColor: Colors.white,
                backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? Icon(
                        Icons.person,
                        size: MediaQuery.of(context).size.width * 0.12,
                        color: Colors.green,
                      )
                    : null,
              ),
              if (_isEditing)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.green,
                        size: MediaQuery.of(context).size.width * 0.06,
                      ),
                      onPressed: _pickImage,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            _nameController.text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            _emailController.text,
            style: TextStyle(
              color: Colors.white70,
              fontSize: MediaQuery.of(context).size.width * 0.035,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStats() {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(25),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Trips', _tripsController, Icons.directions_bus),
          _buildStatItem('Rating', _ratingController, Icons.star),
          _buildStatItem('Points', _pointsController, Icons.card_giftcard),
        ],
      ),
    );
  }

  Widget _buildStatItem(
      String label, TextEditingController controller, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.green[700],
          size: MediaQuery.of(context).size.width * 0.08,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        _isEditing
            ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: TextFormField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green[700]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Colors.green[700]!, width: 2),
                    ),
                  ),
                ),
              )
            : Text(
                controller.text,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: MediaQuery.of(context).size.width * 0.03,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSections() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildPersonalInfoSection(),
          const SizedBox(height: 20),
          _buildSection(
            'Travel Information',
            [
              _buildInfoItem(
                  Icons.history, 'Recent Trips', 'View your recent trips'),
              _buildInfoItem(
                  Icons.favorite, 'Saved Routes', 'View your saved routes'),
              _buildInfoItem(
                  Icons.star, 'Favorite Drivers', 'View your favorite drivers'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: _toggleEditMode,
              icon: Icon(_isEditing ? Icons.save : Icons.edit,
                  color: Colors.green[700]),
              label: Text(
                _isEditing ? 'Save' : 'Edit',
                style: TextStyle(color: Colors.green[700]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildEditableItem(
                  Icons.person,
                  'Full Name',
                  _nameController,
                  _isEditing,
                ),
                _buildEditableItem(
                  Icons.phone,
                  'Phone Number',
                  _phoneController,
                  _isEditing,
                ),
                _buildEditableItem(
                  Icons.bloodtype,
                  'Blood Group',
                  _bloodGroupController,
                  _isEditing,
                ),
                _buildEditableItem(
                  Icons.badge,
                  'Transport ID',
                  _transportIdController,
                  _isEditing,
                ),
                _buildEditableItem(
                  Icons.directions_bus,
                  'Bus Number',
                  _busNoController,
                  _isEditing,
                ),
                _buildEditableItem(
                  Icons.location_on,
                  'Address',
                  _addressController,
                  _isEditing,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditableItem(
    IconData icon,
    String label,
    TextEditingController controller,
    bool isEditing,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: isEditing
          ? TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                prefixIcon: Icon(icon, color: Colors.green[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.green[700]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.green[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.green[700]!, width: 2),
                ),
                labelStyle: TextStyle(color: Colors.green[700]),
              ),
            )
          : ListTile(
              leading: Icon(icon, color: Colors.green[700]),
              title: Text(label),
              subtitle: Text(controller.text),
            ),
    );
  }

  void _toggleEditMode() {
    if (_isEditing) {
      _saveProfile();
    } else {
      setState(() {
        _isEditing = true;
      });
    }
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[700]),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
      // Save the image path to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('driver_profile_image', image.path);
    }
  }
}

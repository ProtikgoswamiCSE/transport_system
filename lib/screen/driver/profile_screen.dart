import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  final _nameController = TextEditingController(text: '______ _______');
  final _emailController =
      TextEditingController(text: '_____________@diu.edu.bd');
  final _phoneController = TextEditingController(text: '+880 1234 567890');
  final _addressController =
      TextEditingController(text: 'Daffodil Smart City, Ashulia');
  final _studentIdController = TextEditingController(text: '221-15-5841');
  final _departmentController = TextEditingController(text: 'CSE, DIU');
  final _tripsController = TextEditingController(text: '0');
  final _ratingController = TextEditingController(text: '4.8');
  final _pointsController = TextEditingController(text: '0');
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _studentIdController.dispose();
    _departmentController.dispose();
    _tripsController.dispose();
    _ratingController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DApp()),
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
                  Icons.email,
                  'Email',
                  _emailController,
                  _isEditing,
                ),
                _buildEditableItem(
                  Icons.phone,
                  'Phone Number',
                  _phoneController,
                  _isEditing,
                ),
                _buildEditableItem(
                  Icons.location_on,
                  'Address',
                  _addressController,
                  _isEditing,
                ),
                _buildEditableItem(
                  Icons.badge,
                  'Student ID',
                  _studentIdController,
                  _isEditing,
                ),
                _buildEditableItem(
                  Icons.school,
                  'Department',
                  _departmentController,
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
      if (_formKey.currentState!.validate()) {
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
    }
  }
}

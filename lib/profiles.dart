import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile/styles.dart';
import 'package:profile/help_support.dart';
import 'package:profile/contact_admin.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool onDuty = true;
  bool darkMode = false;
  bool enableLocation = true;
  bool autoSync = false;
  bool notifications = true;

  final _nameCtrl = TextEditingController(text: 'Ethan Carter');
  final _designationCtrl = TextEditingController(text: 'Senior Inspector');
  final _departmentCtrl = TextEditingController(text: 'Building Safety');
  final _emailCtrl = TextEditingController(text: 'e.carter@city.gov');
  final _mobileCtrl = TextEditingController(text: '(555) 123-4567');

  @override
  Widget build(BuildContext context) {
    const double hPad = 16.0;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.transparent),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    darkMode
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    size: 20,
                    color: AppColors.darkblue,
                  ),
                  const SizedBox(width: 6),
                  Switch(
                    value: darkMode,
                    onChanged: (val) => setState(() => darkMode = val),
                    activeColor: Colors.white,
                    activeTrackColor: AppColors.darkblue,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(hPad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profileCard(),

            const SizedBox(height: 20),

            const SizedBox(height: 20),
            _sectionTitle('APP PREFERENCES'),
            _infoCard([
              _switchRow(
                'Notifications',
                notifications,
                (val) => setState(() => notifications = val),
              ),
              _switchRow(
                'Enable Location Access',
                enableLocation,
                (val) => setState(() => enableLocation = val),
              ),
              _switchRow(
                'Auto Sync Data',
                autoSync,
                (val) => setState(() => autoSync = val),
              ),
              ListTile(
                title: Text(
                  'Storage Usage',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Text(
                  '1.2 GB',
                  style: GoogleFonts.poppins(
                    color: AppColors.darkblue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ]),

            const SizedBox(height: 20),
            _sectionTitle('APP UTILITIES'),
            _infoCard([
              _arrowRow(
                'Sync History',
                Icons.sync,
                onTap: () {
                  // ScaffoldMessenger.of(
                  //   context,
                  // ).showSnackBar(const SnackBar(content: Text('Data synced')));
                },
              ),
              _arrowRow('Download Logs/Reports', Icons.download, onTap: () {}),
              _arrowRow(
                'Terms & Privacy Policy',
                Icons.privacy_tip,
                onTap: () {},
              ),
              _arrowRow(
                'Help & Support',
                Icons.help_outline,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
                  );
                },
              ),
              _arrowRow(
                'Contact Admin/IT Support',
                Icons.headset_mic,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ContactAdminScreen()),
                  );
                },
              ),
            ]),

            const SizedBox(height: 20),
            _logoutButton(context),

            const SizedBox(height: 8),
            Center(
              child: Text(
                'Version 1.2.3',
                style: GoogleFonts.poppins(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- PROFILE CARD (Centered avatar and info pills) ---
  Widget _profileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.darkblue.withOpacity(0.2),
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage('assets/inspector.png'),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _nameCtrl.text,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  _infoPill(Icons.badge_outlined, _designationCtrl.text),
                  _infoPill(Icons.apartment_outlined, _departmentCtrl.text),
                  _infoPill(Icons.email_outlined, _emailCtrl.text),
                  _infoPill(Icons.phone_outlined, _mobileCtrl.text),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkblue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('View My Reports clicked')),
                    );
                  },
                  child: Text(
                    'View My Reports →',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(Icons.edit, color: AppColors.darkblue),
              tooltip: 'Edit details',
              onPressed: () => _openEditSheet(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoPill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.extralightblue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.darkblue),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: AppColors.darkblue,
            ),
          ),
        ],
      ),
    );
  }

  

  

  // --- Edit bottom sheet ---
  void _openEditSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Edit Details',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _buildTextField('Full Name', _nameCtrl, Icons.person_outline),
              _buildTextField(
                'Designation',
                _designationCtrl,
                Icons.badge_outlined,
              ),
              _buildTextField(
                'Department',
                _departmentCtrl,
                Icons.apartment_outlined,
              ),
              _buildTextField(
                'Email',
                _emailCtrl,
                Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(
                'Mobile',
                _mobileCtrl,
                Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.darkblue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkblue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Profile updated successfully'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkblue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Save Changes',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.darkblue),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.darkblue.withOpacity(0.8)),
          ),
        ),
      ),
    );
  }

  // --- Generic Builders ---
  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey,
      ),
    ),
  );

  Widget _infoCard(List<Widget> children) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children:
          children.expand((w) => [w, const Divider(height: 1)]).toList()
            ..removeLast(),
    ),
  );

  Widget _switchRow(String label, bool value, Function(bool) onChanged) =>
      ListTile(
        title: Text(
          label,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.darkblue,
        ),
      );

  Widget _arrowRow(
    String label,
    IconData icon, {
    required VoidCallback onTap,
  }) => ListTile(
    leading: Icon(icon, color: Colors.grey[700]),
    title: Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    onTap: onTap,
  );

  Widget _logoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.logout_rounded, size: 22),
          label: Text(
            'Logout',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0xFFFFEBEE),
            foregroundColor: Colors.red.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: Colors.red.shade200, width: 1),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          ),
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Logged out')));
          },
        ),
      ),
    );
  }
}

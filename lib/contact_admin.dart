import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile/styles.dart';

class ContactAdminScreen extends StatefulWidget {
  const ContactAdminScreen({super.key});

  @override
  State<ContactAdminScreen> createState() => _ContactAdminScreenState();
}

class _ContactAdminScreenState extends State<ContactAdminScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionCtrl = TextEditingController();
  String _problemType = 'App is Slow';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Back',
        ),
        title: Text(
          'Contact Admin & Support',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _selfServiceCard(context),
            const SizedBox(height: 16),
            _ticketForm(context),
            const SizedBox(height: 16),
            _urgentContacts(context),
          ],
        ),
      ),
    );
  }

  // Section: Get Help Faster (self-service)
  Widget _selfServiceCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.extralightblue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.lightbulb_outline, color: AppColors.darkblue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get Help Faster',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                Text(
                  'Search FAQs or quick guides for instant answers.',
                  style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 12.5),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'View FAQs',
              style: GoogleFonts.poppins(color: AppColors.darkblue, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  // Section: Submit a Support Ticket (form)
  Widget _ticketForm(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(14),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Submit a Support Ticket', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Text('Type of Problem', style: GoogleFonts.poppins(fontSize: 12.5, color: Colors.grey[700], fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            _problemTypeDropdown(),
            const SizedBox(height: 12),
            Text('Describe the Problem', style: GoogleFonts.poppins(fontSize: 12.5, color: Colors.grey[700], fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            _multilineDescription(),
            const SizedBox(height: 10),
            _attachButton(),
            const SizedBox(height: 10),
            _diagnosticInfoBox(),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkblue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: _submitTicket,
                child: Text('Submit Ticket', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _problemTypeDropdown() {
    const items = <String>[
      'App is Slow',
      'Data Sync Issue',
      'Login Problem',
      'Feature Request',
      'Other',
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _problemType,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: items
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  ))
              .toList(),
          onChanged: (v) => setState(() => _problemType = v ?? _problemType),
        ),
      ),
    );
  }

  Widget _multilineDescription() {
    return TextFormField(
      controller: _descriptionCtrl,
      maxLines: 5,
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Please describe the problem' : null,
      style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: 'Please provide as much detail as possible...',
        hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.darkblue.withOpacity(0.8)),
        ),
      ),
    );
  }

  Widget _attachButton() {
    return SizedBox(
      height: 44,
      child: OutlinedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Attachment picker not implemented in this demo')),
          );
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.darkblue),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: const Icon(Icons.attach_file, size: 18, color: AppColors.darkblue),
        label: Text('Attach Photo or Screenshot', style: GoogleFonts.poppins(color: AppColors.darkblue, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _diagnosticInfoBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Diagnostic Info (App Version, User ID, Device Model) will be automatically attached.',
              style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }

  // Section: For Urgent Issues
  Widget _urgentContacts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('For Urgent Issues', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _contactCard(
              icon: Icons.call,
              title: 'Call Support',
              subtitle: '555-123-4567',
              caption: 'Available Mon-Fri, 8 AM - 5 PM',
              onTap: () {},
            )),
            const SizedBox(width: 12),
            Expanded(child: _contactCard(
              icon: Icons.email_outlined,
              title: 'Email Support',
              subtitle: 'support@laplatacity.gov',
              caption: '',
              onTap: () {},
            )),
          ],
        ),
      ],
    );
  }

  Widget _contactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String caption,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.extralightblue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.darkblue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: GoogleFonts.poppins(color: AppColors.darkblue, fontWeight: FontWeight.w600)),
                  if (caption.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(caption, style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 12)),
                  ]
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14),
          ],
        ),
      ),
    );
  }

  void _submitTicket() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ticket submitted')),
    );
    _descriptionCtrl.clear();
  }
}



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile/styles.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  final List<String> _allFaqs = const <String>[
    'How do I force a data sync?',
    'What happens if my device is offline?',
    'How to issue a violation',
    'How to reschedule an inspection',
    'How to add photos to a case?',
    'How to annotate a photo?',
    'How to update my profile details?',
    'How to enable location access?',
    'How to export or share a report?',
    'Why are my push notifications not arriving?',
    'How to clear cached data safely?',
    'How to change app theme (dark/light)?',
    'How to work fully offline and sync later?',
    'How to contact admin/IT support?',
  ];

  String _query = '';
  

  List<String> get _filteredFaqs {
    if (_query.trim().isEmpty) {
      return _allFaqs;
    }
    final q = _query.toLowerCase();
    return _allFaqs.where((f) => f.toLowerCase().contains(q)).toList();
  }

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
          'Help & Support',
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
            _searchBox(),
            const SizedBox(height: 14),
            Text(
              'Frequently Asked Questions',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 6),
            _faqList(),
            const SizedBox(height: 16),
            _statusAnnouncementsCard(),
            //const SizedBox(height: 12),
            //_quickGuidesCard(),
          ],
        ),
      ),
    );
  }

  Widget _searchBox() {
    return TextField(
      controller: _searchCtrl,
      onChanged: (v) => setState(() => _query = v),
      style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: 'Search help (e.g., offline, add photo, reschedule)...',
        hintStyle: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 14),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
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

  Widget _faqList() {
    final faqs = _filteredFaqs;
    if (faqs.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'No results. Try a different keyword.',
          style: GoogleFonts.poppins(color: Colors.grey[700]),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 360, // roughly 6+ tiles visible depending on device density
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: faqs.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final q = faqs[index];
          return ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.grey),
            title: Text(q, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => _openGuideModal(q, _mockStepsFor(q)),
          );
        },
      ),
    );
  }

  // Permanent System Status (no announcements)
  Widget _statusAnnouncementsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.extralightblue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.satellite_alt_outlined, color: AppColors.darkblue, size: 20),
            ),
            title: Text(
              'System Status',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            subtitle: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Text('All Systems Operational', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _statusRow('Central Server', true),
                _statusRow('GIS Mapping', true),
                _statusRow('Image Uploads', true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusRow(String label, bool isOnline) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isOnline ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label, style: GoogleFonts.poppins()),
          ),
          Text(isOnline ? 'Online' : 'Offline', style: GoogleFonts.poppins(color: isOnline ? Colors.green : Colors.red)),
        ],
      ),
    );
  }

  

  // Card 2: Quick App Guides (expandable)
  /*Widget _quickGuidesCard() {
    final guides = <String>[
      'How to Issue a Violation',
      'Using the Offline Data Manager',
      'How to Annotate a Photo',
      'How to Reschedule an Inspection',
      'How to Add Notes to a Case',
      'How to Export a Report',
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: _guidesExpanded,
          onExpansionChanged: (v) => setState(() => _guidesExpanded = v),
          leading: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.extralightblue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.school_outlined, color: AppColors.darkblue, size: 20),
          ),
          title: Text('App Guides & Tutorials', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          trailing: Icon(_guidesExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right),
          children: [
            const Divider(height: 1),
            ...guides.map((g) => ListTile(
                  title: Text(g, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  trailing: const Icon(Icons.open_in_new, size: 18),
                  onTap: () => _openGuideModal(g, _mockStepsFor(g)),
                )),
          ],
        ),
      ),
    );
  }*/

  void _openGuideModal(String title, List<String> steps) {
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
              Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              ...steps.map((s) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline, color: AppColors.darkblue, size: 18),
                        const SizedBox(width: 8),
                        Expanded(child: Text(s, style: GoogleFonts.poppins(height: 1.4))),
                      ],
                    ),
                  )),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text('Close', style: GoogleFonts.poppins(color: AppColors.darkblue, fontWeight: FontWeight.w600)),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<String> _mockStepsFor(String title) {
    return <String>[
      'Open the relevant case from your dashboard.',
      'Tap the + button to start the action.',
      'Fill in the required details and attach photos if needed.',
      'Review your entries and tap Save.',
      'Sync your changes when you have a stable connection.',
    ];
  }
}



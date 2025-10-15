import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile/styles.dart';

class TermsPrivacyScreen extends StatefulWidget {
  const TermsPrivacyScreen({super.key});

  @override
  State<TermsPrivacyScreen> createState() => _TermsPrivacyScreenState();
}

class _TermsPrivacyScreenState extends State<TermsPrivacyScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          'Terms & Privacy',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(color: Colors.white),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.darkblue,
              labelColor: AppColors.darkblue,
              unselectedLabelColor: Colors.grey[600],
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: 'Terms of Service'),
                Tab(text: 'Privacy Policy'),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _documentView(
                  lastUpdated: 'October 1, 2025',
                  titleSections: const [
                    _Section('1. Introduction',
                        'These Terms of Service govern your use of the City Inspector mobile application. By using the app, you agree to these terms.'),
                    _Section('2. User Responsibilities',
                        'You agree to use the app in accordance with city policies and applicable law, to protect sensitive data, and to report issues promptly.'),
                    _Section('3. Acceptable Use',
                        'Do not attempt to access unauthorized data, disrupt services, or reverse engineer the app.'),
                    _Section('4. Changes to the Service',
                        'We may update features from time to time to improve performance, reliability, and security.'),
                  ],
                ),
                _documentView(
                  lastUpdated: 'October 1, 2025',
                  titleSections: const [
                    _Section('1. Introduction',
                        'This Privacy Policy explains how we collect, use, and protect your information when using the City Inspector app.'),
                    _Section('2. Data We Collect',
                        'We may collect account details, device identifiers, location (with consent), usage analytics, and logs necessary to provide support.'),
                    _Section('3. How We Use Data',
                        'Data is used to provide core functionality, improve app reliability, support operations, and comply with legal obligations.'),
                    _Section('4. Your Choices',
                        'You can manage permissions in your device settings. Contact admin to request data access or deletion where applicable.'),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 44,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[400]!),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  foregroundColor: Colors.black87,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PDF download not implemented in this demo')),
                  );
                },
                icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
                label: Text('Download as PDF', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _documentView({
    required String lastUpdated,
    required List<_Section> titleSections,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.extralightblue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.article_outlined, color: AppColors.darkblue, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Official Document',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.blueGrey[800]),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    'Last Updated: $lastUpdated',
                    style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            const SizedBox(height: 14),
            ...List.generate(titleSections.length, (i) {
              final s = titleSections[i];
              return Padding(
                padding: EdgeInsets.only(bottom: i == titleSections.length - 1 ? 0 : 12),
                child: _sectionCard(
                  index: i + 1,
                  title: s.title,
                  body: s.body,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({
    required int index,
    required String title,
    required String body,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.extralightblue,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: GoogleFonts.poppins(
                color: AppColors.darkblue,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey[900],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: GoogleFonts.poppins(
                    height: 1.7,
                    fontSize: 13.5,
                    color: Colors.blueGrey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section {
  final String title;
  final String body;
  const _Section(this.title, this.body);
}



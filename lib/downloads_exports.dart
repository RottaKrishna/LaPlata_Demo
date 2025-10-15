import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile/styles.dart';

class DownloadsExportsScreen extends StatefulWidget {
  const DownloadsExportsScreen({super.key});

  @override
  State<DownloadsExportsScreen> createState() => _DownloadsExportsScreenState();
}

enum _DownloadsTab { reports, logs }

class _DownloadsExportsScreenState extends State<DownloadsExportsScreen> {
  _DownloadsTab _tab = _DownloadsTab.reports;
  bool _multiSelect = false;
  final Set<int> _selectedReportIds = <int>{};
  final TextEditingController _searchCtrl = TextEditingController();
  DateTime? _logsStart;
  DateTime? _logsEnd;

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
          'Downloads & Exports',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          _segmentedControl(),
          const SizedBox(height: 12),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _tab == _DownloadsTab.reports
                  ? _reportsView()
                  : _logsView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _segmentedControl() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            _segmentButton(
              label: 'Inspection Reports',
              selected: _tab == _DownloadsTab.reports,
              onTap: () => setState(() {
                _tab = _DownloadsTab.reports;
                _multiSelect = false;
                _selectedReportIds.clear();
              }),
            ),
            const SizedBox(width: 6),
            _segmentButton(
              label: 'Activity Logs',
              selected: _tab == _DownloadsTab.logs,
              onTap: () => setState(() {
                _tab = _DownloadsTab.logs;
                _multiSelect = false;
                _selectedReportIds.clear();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _segmentButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.darkblue : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // --- Reports View ---
  Widget _reportsView() {
    final reports = List.generate(10, (i) => i);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(child: _searchBar()),
              const SizedBox(width: 10),
              SizedBox(
                height: 36,
                child: OutlinedButton(
                  onPressed: () => setState(() => _multiSelect = !_multiSelect),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    side: BorderSide(color: _multiSelect ? AppColors.darkblue : Colors.grey[400]!),
                    foregroundColor: _multiSelect ? AppColors.darkblue : Colors.black87,
                  ),
                  child: Text(
                    _multiSelect ? 'Cancel' : 'Select',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _filtersRow(),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: reports.length,
            itemBuilder: (context, i) => _reportCard(
              id: reports[i],
              address: '123${i} Main St, La Plata, MD',
              dateType: '2025-09-1${i}  •  Safety Inspection',
              status: i % 3 == 0 ? 'PASSED' : (i % 3 == 1 ? 'FAILED' : 'PENDING'),
            ),
          ),
        ),
        if (_multiSelect && _selectedReportIds.isNotEmpty)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkblue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Exporting ${_selectedReportIds.length} reports as ZIP...')),
                  );
                },
                icon: const Icon(Icons.download_rounded, size: 18),
                label: Text('Export Selected (${_selectedReportIds.length})', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              ),
            ),
          ),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 40,
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Search by address, permit #...',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                border: InputBorder.none,
                isDense: true,
              ),
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filtersRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _filterChip('Date Range'),
          const SizedBox(width: 8),
          _filterChip('Status: Passed'),
          const SizedBox(width: 8),
          _filterChip('Status: Failed'),
        ],
      ),
    );
  }

  Widget _filterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12.5)),
    );
  }

  Widget _reportCard({
    required int id,
    required String address,
    required String dateType,
    required String status,
  }) {
    final selected = _selectedReportIds.contains(id);
    final statusColor = status == 'PASSED'
        ? Colors.green[600]
        : status == 'FAILED'
            ? Colors.red[600]
            : Colors.orange[700];
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.extralightblue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.description_outlined, color: AppColors.darkblue),
        ),
        title: Text(address, style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        subtitle: Text(dateType, style: GoogleFonts.poppins(color: Colors.blueGrey[700])),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor!.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: statusColor.withOpacity(0.3)),
              ),
              child: Text(status, style: GoogleFonts.poppins(color: statusColor, fontWeight: FontWeight.w700, fontSize: 11)),
            ),
            if (_multiSelect) ...[
              const SizedBox(height: 6),
              Checkbox(
                value: selected,
                onChanged: (v) => setState(() {
                  if (v == true) {
                    _selectedReportIds.add(id);
                  } else {
                    _selectedReportIds.remove(id);
                  }
                }),
              ),
            ]
          ],
        ),
        onTap: _multiSelect
            ? () => setState(() {
                  if (selected) {
                    _selectedReportIds.remove(id);
                  } else {
                    _selectedReportIds.add(id);
                  }
                })
            : null,
      ),
    );
  }

  // --- Logs View ---
  Widget _logsView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.extralightblue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.info_outline, color: AppColors.darkblue),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Generate a detailed, timestamped log of your app activity for security audits and troubleshooting.',
                    style: GoogleFonts.poppins(color: Colors.blueGrey[700], height: 1.4),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(child: _dateSelector('Start Date', _logsStart, (d) => setState(() => _logsStart = d))),
              const SizedBox(width: 10),
              Expanded(child: _dateSelector('End Date', _logsEnd, (d) => setState(() => _logsEnd = d))),
            ],
          ),
        ),
        const Spacer(),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkblue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Generating activity log...')),
                );
              },
              child: Text('Generate & Export Log', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
            ),
          ),
        )
      ],
    );
  }

  Widget _dateSelector(String label, DateTime? value, ValueChanged<DateTime?> onChanged) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? now,
          firstDate: DateTime(now.year - 3),
          lastDate: DateTime(now.year + 3),
        );
        onChanged(picked);
      },
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(
                    value == null ? 'Select' : _fmtDate(value),
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const Icon(Icons.calendar_today_outlined, size: 18),
          ],
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }
}



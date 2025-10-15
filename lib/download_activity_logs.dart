import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile/styles.dart';

class DownloadActivityLogsScreen extends StatefulWidget {
  const DownloadActivityLogsScreen({super.key});

  @override
  State<DownloadActivityLogsScreen> createState() => _DownloadActivityLogsScreenState();
}

class _DownloadActivityLogsScreenState extends State<DownloadActivityLogsScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  String _logType = 'Full Activity';

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
          'Download Activity Logs',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoCard(),
                  const SizedBox(height: 16),
                  Text('Quick Exports', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  _quickExportsRow(),
                  const SizedBox(height: 16),
                  Text('Generate Custom Log', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  _customLogCard(),
                ],
              ),
            ),
          ),
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
                onPressed: _onGenerate,
                child: Text('Generate & Export Log', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
              'This tool creates a detailed, timestamped log of your actions within the application. These logs are used for security audits and technical support.',
              style: GoogleFonts.poppins(color: Colors.blueGrey[700], height: 1.45),
            ),
          )
        ],
      ),
    );
  }

  Widget _quickExportsRow() {
    return Row(
      children: [
        Expanded(child: _quickExportChip('Last 24 Hours', () => _quickRange(days: 1))),
        const SizedBox(width: 8),
        Expanded(child: _quickExportChip('Last 7 Days', () => _quickRange(days: 7))),
        const SizedBox(width: 8),
        Expanded(child: _quickExportChip('Last 30 Days', () => _quickRange(days: 30))),
      ],
    );
  }

  Widget _quickExportChip(String label, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _customLogCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _dateField('Start Date', _startDate, (d) => setState(() => _startDate = d))),
              const SizedBox(width: 10),
              Expanded(child: _dateField('End Date', _endDate, (d) => setState(() => _endDate = d))),
            ],
          ),
          const SizedBox(height: 12),
          _logTypeDropdown(),
        ],
      ),
    );
  }

  Widget _dateField(String label, DateTime? value, ValueChanged<DateTime?> onChanged) {
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
        height: 48,
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
                  Text(value == null ? 'Select' : _fmtDate(value), style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const Icon(Icons.calendar_today_outlined, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _logTypeDropdown() {
    const types = <String>['Full Activity', 'Login History', 'Data Sync History'];
    return Builder(
      builder: (ctx) {
        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _showLogTypeMenu(ctx, types),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _logType,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showLogTypeMenu(BuildContext context, List<String> types) async {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final fieldOffset = renderBox.localToGlobal(Offset.zero);
    final fieldSize = renderBox.size;
    final screenSize = MediaQuery.of(context).size;

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        fieldOffset.dx,
        fieldOffset.dy + fieldSize.height,
        screenSize.width - (fieldOffset.dx + fieldSize.width),
        screenSize.height - (fieldOffset.dy + fieldSize.height),
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      constraints: BoxConstraints(
        minWidth: fieldSize.width,
        maxWidth: fieldSize.width,
        maxHeight: 260,
      ),
      elevation: 6,
      items: types
          .map((e) => PopupMenuItem<String>(
                value: e,
                child: Text(e, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              ))
          .toList(),
    );

    if (selected != null && selected != _logType) {
      setState(() => _logType = selected);
    }
  }

  void _quickRange({required int days}) {
    final now = DateTime.now();
    setState(() {
      _endDate = now;
      _startDate = now.subtract(Duration(days: days));
    });
  }

  void _onGenerate() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Generating activity log...')),
    );
  }

  String _fmtDate(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }
}



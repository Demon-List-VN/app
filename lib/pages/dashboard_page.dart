import 'package:flutter/widgets.dart';
import 'package:gdvn/widgets/floating_page_header.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(
        16,
        floatingPageHeaderContentTopPadding(context),
        16,
        24,
      ),
      itemCount: 30,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF888888).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Mục ${index + 1}', style: const TextStyle(fontSize: 15)),
        ),
      ),
    );
  }
}

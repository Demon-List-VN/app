import 'package:flutter/cupertino.dart';
import 'package:forui/forui.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Giới thiệu'),
        prefixes: [
          FHeaderAction.back(
            onPress: () => Navigator.maybePop(context),
            semanticsLabel: 'Quay lại',
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            FCard(
              title: const Text('GDVN'),
              subtitle: const Text(
                'Ứng dụng Flutter với điều hướng nhiều tầng, sidebar và tìm kiếm nhanh được dựng bằng ForUI.',
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FBadge(child: const Text('v1.0.0')),
                  FBadge(variant: .secondary, child: const Text('Flutter')),
                  FBadge(variant: .outline, child: const Text('ForUI')),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Điểm nhấn',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            FTileGroup(
              children: [
                FTile(
                  prefix: const Icon(CupertinoIcons.sidebar_left),
                  title: const Text('Sidebar mới'),
                  subtitle: const Text(
                    'Mở nhanh mục Giới thiệu từ cạnh trái màn hình.',
                  ),
                ),
                FTile(
                  prefix: const Icon(CupertinoIcons.search),
                  title: const Text('Tìm kiếm nhanh'),
                  subtitle: const Text(
                    'Truy cập các điểm đến quan trọng chỉ với vài ký tự.',
                  ),
                ),
                FTile(
                  prefix: const Icon(CupertinoIcons.moon_fill),
                  title: const Text('Giao diện linh hoạt'),
                  subtitle: const Text(
                    'Hỗ trợ theo hệ thống, chế độ sáng và tối trong Cài đặt.',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

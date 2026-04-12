import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import 'package:gdvn/widgets/submit_sheet.dart';

Future<void> showSubmitLevelChallengeSheet(BuildContext context) async {
  await showSubmitSheet(
    context,
    icon: FIcons.trophy,
    title: 'Nộp level challenge',
    subtitle:
        'Flow này cũng mở trong sheet 90% chiều cao để giữ trải nghiệm liền mạch từ action sheet.',
    placeholderTitle: 'Form đề xuất challenge level',
    placeholderDescription:
        'Giữ chỗ cho thông tin level, độ khó, creator, link tham khảo và các tiêu chí duyệt challenge mới.',
    dialogTitle: 'Dialog placeholder cho challenge',
    dialogDescription:
        'Dùng dialog này làm chỗ đặt xác nhận gửi đề xuất, cảnh báo thiếu dữ liệu hoặc trạng thái review sau này.',
  );
}

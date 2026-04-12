import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import 'package:gdvn/widgets/submit_sheet.dart';

Future<void> showSubmitRecordSheet(BuildContext context) async {
  await showSubmitSheet(
    context,
    icon: FIcons.fileText,
    title: 'Nộp bản ghi',
    subtitle:
        'Sheet này thay cho trang riêng và giữ kiểu trình bày gần với bottom sheet hiện có.',
    placeholderTitle: 'Form nộp bản ghi',
    placeholderDescription:
        'Giữ chỗ cho các field như tên người chơi, link video, thông tin level và phần validation trước khi submit thật.',
    dialogTitle: 'Dialog placeholder cho bản ghi',
    dialogDescription:
        'Thay nội dung này bằng dialog xác nhận submit, báo lỗi hoặc thông báo thành công khi form thật được hoàn thiện.',
  );
}

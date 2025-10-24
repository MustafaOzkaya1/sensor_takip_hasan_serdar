// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '传感器追踪应用';

  @override
  String get controlPanel => '控制面板';

  @override
  String get bluetoothOff => '蓝牙已关闭。请开启。';

  @override
  String get temperatureData => '温度\n数据';

  @override
  String get pressureData => '压力\n数据';

  @override
  String get humidity => '湿度';

  @override
  String get demoMode => '演示模式';

  @override
  String get esp32Connected => 'ESP32已连接';

  @override
  String get settings => '设置';

  @override
  String get language => '语言';

  @override
  String get language_tr => '土耳其语';

  @override
  String get language_en => '英语';

  @override
  String get language_de => '德语';

  @override
  String get language_zh => '中文';

  @override
  String get esp32Controls => 'ESP32 控制';

  @override
  String get scanAndConnect => '扫描并连接';

  @override
  String get disconnect => '断开连接';

  @override
  String get restartESP32 => '重启 ESP32';

  @override
  String get clearErrors => '清除错误';

  @override
  String get connected => '已连接';

  @override
  String get notConnected => '未连接';

  @override
  String get toggle => '开/关';
}

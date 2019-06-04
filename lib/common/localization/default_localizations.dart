import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:bpms_app/common/style/bpms_string_base.dart';
import 'package:bpms_app/common/style/bpms_string_en.dart';
import 'package:bpms_app/common/style/bpms_string_zh.dart';

///自定义多语言实现
class BPMSLocalizations {
  final Locale locale;

  BPMSLocalizations(this.locale);

  ///根据不同 locale.languageCode 加载不同语言对应
  ///BPMSStringEn和BPMSStringZh都继承了BPMSStringBase
  static Map<String, BPMSStringBase> _localizedValues = {
    'en': new BPMSStringEn(),
    'zh': new BPMSStringZh(),
  };

  BPMSStringBase get currentLocalized {
    return _localizedValues[locale.languageCode];
  }

  ///通过 Localizations 加载当前的 BPMSLocalizations
  ///获取对应的 BPMSStringBase
  static BPMSLocalizations of(BuildContext context) {
    return Localizations.of(context, BPMSLocalizations);
  }
}

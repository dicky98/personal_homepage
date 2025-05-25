import 'dart:convert';
import 'package:flutter/services.dart';
import 'models.dart';

class DataService {
  static DataService? _instance;
  PersonalInfo? _personalInfo;

  DataService._();

  static DataService get instance {
    _instance ??= DataService._();
    return _instance!;
  }

  /// 加载个人信息数据
  Future<PersonalInfo> loadPersonalInfo() async {
    if (_personalInfo != null) {
      return _personalInfo!;
    }

    try {
      final String jsonString = await rootBundle.loadString('lib/data/personal_info.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      _personalInfo = PersonalInfo.fromJson(jsonData);
      return _personalInfo!;
    } catch (e) {
      // 如果加载失败，返回默认数据
      return _getDefaultPersonalInfo();
    }
  }

  /// 获取默认个人信息（作为备用）
  PersonalInfo _getDefaultPersonalInfo() {
    return const PersonalInfo(
      name: '你的名字',
      title: 'Flutter 开发者 | 前端工程师',
      description: '欢迎来到我的个人首页！我是一名热爱技术的开发者，专注于Flutter和Web开发。',
      avatarPath: '',
      skills: [
        'Flutter',
        'Dart',
        'JavaScript',
        'React',
        'Node.js',
        'Git',
      ],
      contact: ContactInfo(
        email: 'your@email.com',
        github: 'https://github.com/yourusername',
        linkedin: 'https://linkedin.com/in/yourprofile',
      ),
    );
  }

  /// 清除缓存，强制重新加载数据
  void clearCache() {
    _personalInfo = null;
  }
}

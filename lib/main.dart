import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/data_service.dart';
import 'data/models.dart';

void main() {
  runApp(const PersonalHomepage());
}

class PersonalHomepage extends StatelessWidget {
  const PersonalHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '个人首页',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
          displayMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.white70),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white60),
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  PersonalInfo? _personalInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final personalInfo = await DataService.instance.loadPersonalInfo();
      if (mounted) {
        setState(() {
          _personalInfo = personalInfo;
          _isLoading = false;
        });
        _animationController.forward();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _animationController.forward();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
              Color(0xFF6B73FF),
            ],
          ),
        ),
        child: SafeArea(
          child: _isLoading 
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : _personalInfo == null
              ? const Center(
                  child: Text(
                    '加载失败',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              : FadeTransition(
                  opacity: _fadeAnimation,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60),
                          
                          // 头像
                          _buildAvatar(),
                          
                          const SizedBox(height: 30),
                          
                          // 姓名
                          Text(
                            _personalInfo!.name,
                            style: Theme.of(context).textTheme.displayLarge,
                            textAlign: TextAlign.center,
                          ),
                          
                          const SizedBox(height: 10),
                          
                          // 职业/标语
                          Text(
                            _personalInfo!.title,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // 个人简介
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                            ),
                            child: Text(
                              _personalInfo!.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          
                          const SizedBox(height: 50),
                          
                          // 技能标签
                          _buildSkillsSection(),
                          
                          const SizedBox(height: 50),
                          
                          // 联系方式
                          _buildContactSection(),
                          
                          const SizedBox(height: 60),
                          
                          // 底部版权信息
                          Text(
                            '© 2025 ${_personalInfo!.name}. Made with Flutter 💙',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: _personalInfo!.avatarPath.isNotEmpty
        ? CircleAvatar(
            radius: 58,
            backgroundImage: AssetImage(_personalInfo!.avatarPath),
          )
        : const CircleAvatar(
            radius: 58,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 60,
              color: Color(0xFF667eea),
            ),
          ),
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      children: [
        Text(
          '技能',
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: _personalInfo!.skills
              .map((skill) => _buildSkillChip(skill))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    final contact = _personalInfo!.contact;
    final List<Widget> contactButtons = [];

    if (contact.email.isNotEmpty) {
      contactButtons.add(_buildContactButton(
        icon: Icons.mail,
        label: 'Email',
        onTap: () => _launchUrl('mailto:${contact.email}'),
      ));
    }

    if (contact.github.isNotEmpty) {
      contactButtons.add(_buildContactButton(
        icon: Icons.code,
        label: 'GitHub',
        onTap: () => _launchUrl(contact.github),
      ));
    }

    if (contact.linkedin.isNotEmpty) {
      contactButtons.add(_buildContactButton(
        icon: Icons.work,
        label: 'LinkedIn',
        onTap: () => _launchUrl(contact.linkedin),
      ));
    }

    if (contact.website != null && contact.website!.isNotEmpty) {
      contactButtons.add(_buildContactButton(
        icon: Icons.language,
        label: 'Website',
        onTap: () => _launchUrl(contact.website!),
      ));
    }

    if (contact.phone != null && contact.phone!.isNotEmpty) {
      contactButtons.add(_buildContactButton(
        icon: Icons.phone,
        label: 'Phone',
        onTap: () => _launchUrl('tel:${contact.phone}'),
      ));
    }

    return Column(
      children: [
        Text(
          '联系我',
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: contactButtons,
        ),
      ],
    );
  }
  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      // 处理错误，或者显示一个错误消息
      debugPrint('无法打开链接: $url');
    }
  }
}

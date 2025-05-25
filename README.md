# personal_homepage

A new Flutter project.

## Getting Started

# 个人首页 - Flutter Web

一个使用Flutter构建的现代化个人首页，可部署到GitHub Pages。

## 🌟 特性

- 📱 响应式设计，支持各种屏幕尺寸
- 🎨 现代化渐变背景和动画效果
- 🔗 社交媒体链接集成
- ⚡ 基于Flutter Web的快速加载
- 🚀 自动化GitHub Pages部署

## 🛠️ 技术栈

- **Flutter 3.32.0** - 跨平台UI框架
- **Dart** - 编程语言
- **GitHub Pages** - 静态网站托管
- **GitHub Actions** - 自动化部署

## 🚀 快速开始

### 本地开发

1. 确保已安装Flutter SDK：
```bash
flutter --version
```

2. 克隆项目：
```bash
git clone https://github.com/yourusername/personal_homepage.git
cd personal_homepage
```

3. 安装依赖：
```bash
flutter pub get
```

4. 运行开发服务器：
```bash
flutter run -d chrome
```

### 构建生产版本

```bash
flutter build web --release
```

## 📦 部署到GitHub Pages

1. 将代码推送到GitHub仓库
2. 在仓库设置中启用GitHub Pages
3. 选择"GitHub Actions"作为源
4. 推送到main/master分支将自动触发部署

## ✨ 自定义配置

### 个人信息
编辑 `lib/main.dart` 文件中的以下内容：

- 姓名和职业描述
- 个人简介
- 技能标签
- 联系方式链接

### 样式主题
在 `PersonalHomepage` 类中修改：

- 颜色主题
- 字体样式
- 渐变背景

## 📁 项目结构

```
personal_homepage/
├── lib/
│   └── main.dart          # 主应用代码
├── web/
│   ├── index.html         # Web入口文件
│   └── icons/             # 应用图标
├── .github/
│   └── workflows/
│       └── deploy.yml     # GitHub Actions部署配置
├── pubspec.yaml           # 依赖配置
└── README.md
```

## 🔧 依赖包

- `flutter`: Flutter SDK
- `url_launcher`: 处理外部链接
- `cupertino_icons`: iOS风格图标

## 📝 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

## 🤝 贡献

欢迎提交Issue和Pull Request！

---

⭐ 如果这个项目对你有帮助，请给它一个Star！

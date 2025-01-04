# Overleaf 使用说明

## 项目设置

1. 在Overleaf中创建新项目
2. 上传以下文件到项目根目录：
   - `main.tex`（主文件）
   - `latexmkrc`（编译配置文件）
   - `マイ・ライブラリ.bib`（参考文献数据库）

## 编译设置

1. 在Overleaf的菜单中，点击左上角的"Menu"
2. 在"Compiler"选项中选择"LaTeX"
3. 确保选择"TeX Live version"为最新版本

## 字体设置

本项目使用了日本语支持，需要以下宏包：
- `jsarticle`（文档类）
- `otf`（OpenType字体支持）
- `inputenc`（UTF-8编码支持）

这些包在Overleaf的TeX Live发行版中已经预装，无需额外配置。

## 编译顺序

编译会自动按照以下顺序进行：
1. uplatex
2. biber
3. uplatex（多次，如有需要）
4. dvipdfmx

## 注意事项

- 文件名中包含日文字符（如`マイ・ライブラリ.bib`）在Overleaf中完全支持
- 如遇到编译错误，请检查日志输出

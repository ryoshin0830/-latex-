---
title: "日本語論文のためのLaTeXテンプレート：biblatexとbiberで参考文献を美しく管理する"
emoji: "📚"
type: "tech"
topics: ["latex", "論文", "研究", "参考文献", "vscode"]
published: true
---

# はじめに

論文執筆において、LaTeXは必須のツールとなっています。特に日本語論文を書く場合、参考文献の管理や体裁の統一が大きな課題となります。本記事では、以下の特徴を持つLaTeXテンプレートを紹介します：

- 日本語論文に最適化された設定
- biblatexとbiberによる高度な参考文献管理
- 日本語・英語文献の美しい出力形式
- VSCodeでの快適な執筆環境

## なぜbiblatexとbiberなのか？

従来のBibTeXには以下のような制限がありました：

1. Unicode対応が不完全
   - 日本語の文字化けが発生
   - 著者名の正しい表示が困難

2. 柔軟性の不足
   - 文献スタイルのカスタマイズが複雑
   - 言語混在時の処理が不十分

3. 文献情報の制限
   - フィールドの種類が限定的
   - 新しい文献タイプの追加が困難

biblatexとbiberの組み合わせは、これらの問題を解決し：

1. 完全なUnicode対応
   - 日本語が正しく処理可能
   - 多言語文献の適切な処理

2. 高度なカスタマイズ性
   - 文献スタイルの柔軟な定義
   - 言語別の書式設定が容易

3. 拡張性
   - カスタムフィールドの追加が容易
   - 新しい文献タイプの定義が可能

## 日本語論文特有の課題と解決策

### 1. 著者名の表示
- 問題：姓名の区切り、著者間の区切り
- 解決：条件分岐による言語別処理
```latex
\DeclareNameFormat{author}{%
  \iffieldequalstr{langid}{japanese}
    {\namepartfamily\space\namepartgiven}  % 日本語形式
    {\namepartfamily,\space\namepartgiven} % 英語形式
}
```

### 2. 句読点と括弧
- 問題：日本語と英語で異なる句読点体系
- 解決：言語に応じた自動切り替え
```latex
\renewcommand{\newunitpunct}{%
  \iffieldequalstr{langid}{japanese}{、}{,}%
}
```

### 3. 引用形式
- 問題：日本語論文特有の引用スタイル
- 解決：カスタム引用コマンドの実装

# 環境構築

## 1. TeXシステムのインストール

### macOS

#### MacTeXのインストール
```bash
# Homebrewを使用する場合
brew install --cask mactex

# または公式サイトからダウンロード
# https://tug.org/mactex/
```

#### 環境変数の設定
```bash
# .zshrcまたは.bashrcに追加
export PATH="/usr/local/texlive/2023/bin/universal-darwin:$PATH"
export MANPATH="/usr/local/texlive/2023/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2023/texmf-dist/doc/info:$INFOPATH"
```

### Windows

#### TeX Liveのインストール
1. [TeX Live](https://www.tug.org/texlive/)をダウンロード
2. インストーラを実行
3. フルインストールを推奨（約7GB）

#### 環境変数の確認
1. システム環境変数に以下が追加されていることを確認
   - `C:\texlive\2023\bin\win32`をPATHに追加
   - `TEXMFHOME`が設定されていることを確認

### Linux (Ubuntu/Debian)
```bash
# TeX Live完全版のインストール
sudo apt-get install texlive-full

# 日本語関連パッケージ
sudo apt-get install texlive-lang-japanese
```

## 2. VSCodeの詳細設定

### 推奨拡張機能
1. LaTeX Workshop
2. LaTeX Utilities
3. Code Spell Checker
4. PDF Viewer

### LaTeX Workshopの詳細設定
```json
{
    "latex-workshop.latex.tools": [
        {
            "name": "uplatex",
            "command": "uplatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-shell-escape",
                "%DOC%"
            ]
        },
        {
            "name": "biber",
            "command": "biber",
            "args": [
                "%DOCFILE%"
            ]
        },
        {
            "name": "dvipdfmx",
            "command": "dvipdfmx",
            "args": [
                "%DOCFILE%"
            ]
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "既定のビルド",
            "tools": [
                "uplatex",
                "biber",
                "uplatex",
                "uplatex",
                "dvipdfmx"
            ]
        }
    ],
    "latex-workshop.view.pdf.viewer": "tab",
    "latex-workshop.latex.autoBuild.run": "onSave",
    "latex-workshop.latex.autoClean.run": "onBuilt",
    "latex-workshop.message.error.show": true,
    "latex-workshop.message.warning.show": true,
    "latex-workshop.view.pdf.internal.synctex.enabled": true,
    "editor.wordWrap": "on",
    "files.autoSave": "afterDelay",
    "files.autoSaveDelay": 1000
}
```

### キーボードショートカット設定
```json
{
    "key": "ctrl+alt+b",
    "command": "latex-workshop.build",
    "when": "editorLangId == latex"
}
```

## 3. フォント設定

### 日本語フォントの設定
```latex
\usepackage[deluxe]{otf}  % 基本的な日本語フォント設定
\usepackage[T1]{fontenc}  % 欧文フォントエンコーディング

% 明朝体とゴシック体の設定
\renewcommand{\rmdefault}{ptm} % Times
\renewcommand{\sfdefault}{phv} % Helvetica
```

### カスタムフォント設定
```latex
% 游明朝・游ゴシックを使用する場合
\usepackage{luatexja-preset}
\setmainjfont{Yu Mincho}
\setsansjfont{Yu Gothic}
```

# 文書構造とテンプレート

## 1. 基本構造
```latex
% プリアンブル
\documentclass[a4paper,11pt,uplatex]{jsarticle}

% パッケージ
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{pxjahyper}

% 文書情報
\title{論文タイトル}
\author{著者名}
\date{\today}

% 本文開始
\begin{document}

\maketitle
\tableofcontents

\section{序論}
% ...

\end{document}
```

## 2. 章立ての例
```latex
\section{序論}
\subsection{研究背景}
\subsection{研究目的}

\section{関連研究}
\subsection{先行研究}
\subsection{本研究の位置づけ}

\section{提案手法}
\subsection{システム概要}
\subsection{アルゴリズム}

\section{実験}
\subsection{実験設定}
\subsection{結果と考察}

\section{結論}
```

# 参考文献の詳細管理

## 1. 文献タイプ別の書き方

### 学術論文 (@article)
```bibtex
@article{key,
  author       = {著者名},
  title        = {論文タイトル},
  journal      = {雑誌名},
  year/date    = {出版年},
  volume       = {巻},
  number       = {号},
  pages        = {ページ範囲},
  doi          = {DOI},
  language     = {言語},
  langid       = {japanese/english}
}
```

### 書籍 (@book)
```bibtex
@book{key,
  author       = {著者名},
  title        = {書籍タイトル},
  publisher    = {出版社},
  year/date    = {出版年},
  address      = {出版地},
  edition      = {版},
  series       = {シリーズ名},
  volume       = {巻},
  isbn         = {ISBN},
  language     = {言語},
  langid       = {japanese/english}
}
```

### 会議論文 (@inproceedings)
```bibtex
@inproceedings{key,
  author       = {著者名},
  title        = {論文タイトル},
  booktitle    = {会議名},
  year/date    = {開催年},
  pages        = {ページ範囲},
  organization = {主催組織},
  address      = {開催地},
  doi          = {DOI},
  language     = {言語},
  langid       = {japanese/english}
}
```

## 2. 文献情報の自動取得

### Google Scholarからの取得
1. Google Scholarで文献を検索
2. 引用ボタン→BibTeXを選択
3. 出力されたBibTeXコードを編集して利用

### CiNiiからの取得
1. CiNii Articlesで文献を検索
2. エクスポート→BibTeXを選択
3. 必要に応じて`langid`フィールドを追加

### DOIからの取得
```bash
# curl を使用してBibTeX形式で取得
curl -LH "Accept: application/x-bibtex" http://dx.doi.org/[DOI]
```

## 3. 引用スタイルのカスタマイズ

### 基本設定
```latex
\usepackage[backend=biber,
    style=authoryear-ibid,
    citestyle=authoryear-comp,
    maxcitenames=2,
    minnames=1,
    maxnames=999,
    uniquelist=false,
    sorting=none,
    defernumbers=true,
    labelnumber=true]{biblatex}
```

### 日本語用の引用スタイル
```latex
% 本文中の引用
\newcommand{\jcite}[1]{%
  \citeauthor{#1}（\citeyear{#1}）%
}

% 括弧書きの引用
\newcommand{\jpcite}[1]{%
  （\citeauthor{#1}，\citeyear{#1}）%
}

% 複数文献の引用
\newcommand{\jpcites}[2]{%
  （\citeauthor{#1}，\citeyear{#1}；\citeauthor{#2}，\citeyear{#2}）%
}
```

# 図表の挿入と管理

## 1. 図の挿入
```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.8\linewidth]{図のパス}
    \caption{図のキャプション}
    \label{fig:label}
\end{figure}
```

## 2. 表の作成
```latex
\begin{table}[htbp]
    \centering
    \caption{表のキャプション}
    \label{tab:label}
    \begin{tabular}{|c|c|c|}
        \hline
        列1 & 列2 & 列3 \\
        \hline
        データ1 & データ2 & データ3 \\
        \hline
    \end{tabular}
\end{table}
```

## 3. 相互参照
```latex
図\ref{fig:label}に示すように...
表\ref{tab:label}から分かるように...
```

# 数式の美しい書き方

## 1. 基本的な数式
```latex
% インライン数式
この式 $E = mc^2$ は有名です。

% ディスプレイ数式
\[
    E = mc^2
\]

% 番号付き数式
\begin{equation}
    E = mc^2
    \label{eq:einstein}
\end{equation}
```

## 2. 複雑な数式
```latex
\begin{align}
    \frac{\partial f}{\partial x} &= 2x + y \\
    \frac{\partial f}{\partial y} &= x + 2y
    \label{eq:partial}
\end{align}
```

# トラブルシューティング

## 1. 一般的なエラーと解決法

### LaTeX Error: File 'something' not found
- 原因：必要なパッケージが不足
- 解決：`tlmgr install パッケージ名`でインストール

### ! LaTeX Error: Unknown option
- 原因：パッケージオプションの指定ミス
- 解決：パッケージのドキュメントを確認して正しいオプションを使用

### Undefined control sequence
- 原因：未定義のコマンドを使用
- 解決：
  1. スペルミスの確認
  2. 必要なパッケージの読み込み確認
  3. コマンド名の確認

## 2. biber関連のエラー

### データベースファイルが見つからない
```bash
# .bibファイルの場所を確認
ls -l *.bib

# biberのバージョン確認
biber --version
```

### 文献が出力されない
1. `.aux`ファイルの確認
2. コンパイル手順の確認
3. 一時ファイルの削除と再コンパイル

## 3. 文字化けの解決

### 日本語文字化け
1. ファイルエンコーディングの確認
```bash
file -i ファイル名
```

2. VSCodeの設定確認
```json
{
    "files.encoding": "utf8"
}
```

3. LaTeXの設定確認
```latex
\usepackage[utf8]{inputenc}
```

# パフォーマンスとメンテナンス

## 1. 大規模文書の管理

### ファイル分割
```latex
% main.tex
\documentclass{jsarticle}
\input{preamble}  % プリアンブルを別ファイルに

\begin{document}
\input{chapters/introduction}
\input{chapters/methods}
\input{chapters/results}
\input{chapters/discussion}
\end{document}
```

### ビルドの最適化
```bash
# 部分的なビルド（章ごと）
latexmk -pvc chapters/introduction.tex

# 並列ビルド
latexmk -pdf -parallel
```

## 2. バージョン管理

### .gitignore の設定
```gitignore
## Core latex/pdflatex auxiliary files:
*.aux
*.lof
*.log
*.lot
*.fls
*.out
*.toc
*.fmt
*.fot
*.cb
*.cb2
.*.lb

## Generated if empty string is given at "Please type another file name for output:"
*.pdf

## Bibliography auxiliary files (bibtex/biblatex/biber):
*.bbl
*.bcf
*.blg
*-blx.aux
*-blx.bib
*.run.xml
```

### Git LFS の利用
```bash
# 大きな画像ファイルをLFSで管理
git lfs track "*.png"
git lfs track "*.jpg"
git lfs track "*.pdf"
```

## 3. 共同編集のベストプラクティス

### 作業の分担
1. 章ごとにファイルを分割
2. 各章を別のブランチで編集
3. プルリクエストでマージ

### コメントの活用
```latex
% TODO: ここに図を追加する
% FIXME: この部分の説明を詳しく
% NOTE: 参考文献の追加が必要
```

# まとめ

このテンプレートを使用することで、以下のメリットが得られます：

- 美しい日本語論文の作成
- 効率的な参考文献管理
- 一貫性のある引用スタイル
- VSCodeによる快適な執筆環境

特に、biblatexとbiberの組み合わせにより、日本語と英語の文献を適切に処理し、美しく整形された参考文献リストを自動生成できます。

# 参考リンク

- [LaTeX Workshop 公式ドキュメント](https://github.com/James-Yu/LaTeX-Workshop/wiki)
- [biblatex 公式ドキュメント](https://ctan.org/pkg/biblatex)
- [Biber 公式ドキュメント](https://ctan.org/pkg/biber)
- [TeXwiki](https://texwiki.texjp.org/)
- [日本語 LaTeX の新常識 2021](https://qiita.com/wtsnjp/items/76557b1598445a1fc9da)

# ライセンス

このテンプレートはMITライセンスで公開されています。自由に使用、改変、再配布が可能です。 
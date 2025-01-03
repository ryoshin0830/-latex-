# 日本語論文 LaTeX テンプレート

## 概要
このテンプレートは日本語の学術論文作成のためのLaTeXテンプレートです。biblatexとbiberを使用した参考文献管理システムを実装しています。

## 必要なソフトウェア
- upTeX（日本語LaTeXエンジン）
- dvipdfmx（PDF生成ツール）
- BibTeX（参考文献処理システム）
- Biber（参考文献管理用）

## VSCode での使用方法
`.vscode/settings.json` に必要な設定が含まれています：
- PDFプレビューはタブで表示
- ファイル保存時に自動ビルド
- ビルド後の一時ファイルを自動クリーン
- SyncTeX によるソースコードとPDFの双方向ジャンプ（ダブルクリックで移動）

## コンパイル方法
1. upLaTeXでコンパイル:
   ```
   uplatex main.tex
   ```
2. Biberで参考文献を処理:
   ```
   biber main
   ```
3. 再度upLaTeXでコンパイル（2回）:
   ```
   uplatex main.tex
   uplatex main.tex
   ```
4. PDFを生成:
   ```
   dvipdfmx main
   ```

## 一時ファイルの削除
以下のコマンドで一時ファイルを削除できます：
```
rm -f main.aux main.bbl main.bcf main.blg main.dvi main.log main.pdf main.run.xml main.synctex.gz
```

## 参考文献の形式
### 基本ルール
- タイトルは日本語の場合「」（論文）または『』（書籍）、英語の場合"" で囲みます
- 著者名は中黒（・）で区切ります
- 日本語文献は全角の句読点（、。）を使用します
- 各文献エントリには `langid = {japanese}` または `langid = {english}` を指定します

### 引用コマンド
- `\jcite{key}`: 本文中の引用（例：田中（2018）は〜）
- `\jpcite{key}`: 括弧書きの引用（例：〜である（田中，2018））
- `\jpcites{key1,key2}`: 複数文献の括弧書き引用（例：〜である（田中，2018；佐藤，2019））

## ファイル構成
- `main.tex`: メインの論文ファイル
- `マイ・ライブラリ.bib`: 参考文献データベース
- `.vscode/settings.json`: VSCode用の設定ファイル 

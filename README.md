# 日本語論文 LaTeX テンプレート

## 必要なソフトウェア
- upTeX
- dvipdfmx
- BibTeX
- Biber（参考文献管理用）

## コンパイル方法
1. upLaTeXでコンパイル:
   ```
   uplatex main.tex
   ```
2. Biberで参考文献を処理:
   ```
   biber main
   ```
3. 再度upLaTeXでコンパイル:
   ```
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
- タイトルは日本語の場合「」、英語の場合"" で囲みます
- 著者名は中黒（・）で区切ります
- 日本語文献は全角の句読点（、。）を使用します
- 各文献エントリには `langid = {japanese}` または `langid = {english}` を指定します

## ファイル構成
- `main.tex`: メインの論文ファイル
- `マイ・ライブラリ.bib`: 参考文献データベース 

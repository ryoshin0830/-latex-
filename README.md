# LaTeX Template for Japanese/English References

> [Zenn](https://zenn.dev/articles/d3e815a2af8a1e/edit)

日本語と英語の文献を同時に管理しやすいLaTeXテンプレートです。**upLaTeX + biblatex + biber** の組み合わせにより、以下のような機能を実現します。

- 日本語文献・英語文献を自動的に分割表示  
- 日本語論文に適した著者表記（例：山田 一郎）と英語文献の表記（例：Smith, John）をそれぞれ整形  
- BibTeXで起こりがちな日本語文字化けを軽減  
- VSCode＋LaTeX Workshop連携で保存時に自動ビルド  
- Zotero＋Better BibTeXによる自動エクスポートで文献管理を効率化  

## デモPDF

下記のように「日本語文献 → 英語文献」の順で分割され、それぞれフォーマットが整った参考文献リストが出力されます。

![PDFサンプル](https://storage.googleapis.com/zenn-user-upload/f22d99b51b36-20250103.png)

## クローン方法

```bash
git clone https://github.com/ryoshin0830/-latex-.git
```

> ディレクトリ名は自由につけられます（例：`my-latex-template` など）。

クローン直後のディレクトリ構成は以下のとおりです。

```
my-latex-template
├─ main.tex
├─ マイ・ライブラリ.bib
├─ .vscode/
│   └─ settings.json
└─ ...
```

## 使い方

1. **TeX環境のセットアップ**  
   - macOSの場合：Homebrew＋MacTeX推奨  
   - Windowsの場合：TeX Live / WSL など  
   - biberが導入済みか確認（`biber --version`）  

2. **VSCode + LaTeX Workshop 設定**  
   - `.vscode/settings.json` をご覧ください。  
   - デフォルトで `upLaTeX → biber → dvipdfmx` を保存時に自動実行します。  

3. **Zotero + Better BibTeX 連携（任意）**  
   - Zoteroで文献管理→Better BibTeXプラグインで `.bib` を自動エクスポート  
   - 文献更新のたびに `.bib` も自動更新されます  

4. **コンパイルフロー**  
   - VSCodeで `main.tex` を開き、保存すると自動ビルド  
   - 手動で行いたい場合は以下のようなコマンドを使います  
     ```bash
     uplatex main.tex
     biber main
     uplatex main.tex
     uplatex main.tex
     dvipdfmx main.dvi
     ```

## テンプレートのカスタマイズ

- `main.tex` には日本語/英語文献を仕分けるbiblatexの設定が含まれています。スタイルや表示形式の変更などは、`\DeclareFieldFormat` や `\DeclareNameFormat` を編集してください。  
- 参考文献の言語判定は `langid={japanese}` / `langid={english}` を使用。Zoteroなどで管理している場合は「Language」フィールドや「Extra」フィールドに `langid=japanese` と書くようにします。

## トラブルシューティング

1. **参考文献が表示されない**  
   - `\printbibliography` 前後の設定をチェック  
   - `.aux` や `.bbl` などの生成ファイルを削除して再度コンパイル  

2. **日本語の文字化け**  
   - `\usepackage[utf8]{inputenc}` を使用しているか  
   - VSCodeの `"files.encoding": "utf8"` が設定されているか  

3. **Zotero + Better BibTeX が連携しない**  
   - ZoteroのバージョンとBetter BibTeXのバージョンを確認  
   - 「自動エクスポート」設定がオンになっているか  

4. **著者区切りがおかしい**  
   - Bibファイル内で著者間を `and` でつないでいるか（`,` や `&` ではなく）  

## Overleafでの使用方法

### プロジェクトの設定

1. Overleafで新規プロジェクトを作成
2. 以下のファイルをプロジェクトのルートディレクトリにアップロード：
   - `main.tex`（メインファイル）
   - `latexmkrc`（コンパイル設定ファイル）
   - `マイ・ライブラリ.bib`（参考文献データベース）

### コンパイル設定

1. Overleafのメニューで左上の"Menu"をクリック
2. "Compiler"オプションで"LaTeX"を選択
3. "TeX Live version"は最新版を選択

### 必要なパッケージ

本プロジェクトは以下のパッケージを使用：
- `jsarticle`（文書クラス）
- `otf`（OpenType フォントサポート）
- `inputenc`（UTF-8エンコーディングサポート）

これらのパッケージはOverleafのTeX Live配布版に既にインストールされています。

### コンパイル順序

コンパイルは自動的に以下の順序で実行：
1. uplatex
2. biber
3. uplatex（必要に応じて複数回）
4. dvipdfmx

### 注意事項

- 日本語を含むファイル名（例：`マイ・ライブラリ.bib`）はOverleafで完全にサポートされています
- コンパイルエラーが発生した場合は、ログ出力を確認してください

## ライセンス

本テンプレートは [MITライセンス](LICENSE) で提供しています。  
ご自由にご利用・改変ください。フィードバックやプルリクエストも歓迎です。

## 参考リンク

- [Homebrew](https://brew.sh/)  
- [biblatex](https://ctan.org/pkg/biblatex) / [Biber](https://ctan.org/pkg/biber)  
- [TeXwiki](https://texwiki.texjp.org/)  
- [Zotero](https://www.zotero.org/)  
- [Better BibTeX for Zotero](https://retorque.re/zotero-better-bibtex/)  

---

もし本リポジトリが役立ったら、スターをつけていただけると嬉しいです！

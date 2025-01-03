---
title: "日本語論文のためのLaTeXテンプレート：biblatexとbiberで参考文献を美しく管理する"
emoji: "📚"
type: "tech"
topics: ["latex", "論文", "研究", "参考文献", "vscode"]
published: true
---

# 日本語論文のためのLaTeXテンプレート：biblatexとbiberで参考文献を美しく管理する

## はじめに

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

## biblatexの詳細設定

### 1. 基本設定
```latex
\usepackage[backend=biber,    % バックエンドとしてbiberを使用
    style=authoryear-ibid,    % 著者-年方式で、同じ文献の2回目以降の引用ではibidを使用
    citestyle=authoryear-comp,% 引用スタイルは著者-年方式で、複数引用を圧縮表示
    maxcitenames=2,           % 引用時の最大著者数を2名に制限
    minnames=1,               % 最小著者表示数を1名に設定
    maxnames=999,             % 参考文献リストでの最大著者表示数を999名に設定
    uniquelist=false,         % 著者リストの一意性を要求しない
    sorting=none,             % 文献の並び替えを行わない
    defernumbers=true,        % 文献番号の割り当てを遅延させる
    labelnumber=true]{biblatex}  % 文献ラベルに番号を使用
```

### 2. 日本語と英語の文献の分離
```latex
% 日本語文献フィルター
\defbibcheck{japanese}{%
  \iffieldequalstr{langid}{japanese}
    {}
    {\skipentry}%
}

% 非日本語文献フィルター
\defbibcheck{notjapanese}{%
  \iffieldequalstr{langid}{japanese}
    {\skipentry}
    {}%
}
```

### 3. 文献の並び順制御
```latex
\DeclareSourcemap{
  \maps[datatype=bibtex]{
    \map{
      \step[fieldsource=langid,match=japanese,final]
      \step[fieldset=presort,fieldvalue={a}]
    }
    \map{
      \step[fieldsource=langid,notmatch=japanese,final]
      \step[fieldset=presort,fieldvalue={b}]
    }
  }
}
```

### 4. 著者名の表示形式
```latex
% 基本の著者名形式
\DeclareNameFormat{author}{%
  \iffieldequalstr{langid}{japanese}
    {\namepartfamily\space\namepartgiven}  % 日本語は姓名の間にスペース
    {\namepartfamily,\space\namepartgiven}%  % 英語は姓,名の形式
  \ifnumequal{\value{listcount}}{\value{liststop}}
    {}
    {\iffieldequalstr{langid}{japanese}{・}{,\space}}%
}

% 引用時の著者名形式
\DeclareNameFormat{labelname}{%
  \ifnumgreater{\value{liststop}}{2}    % 著者が3人以上の場合
    {\ifnumequal{\value{listcount}}{1}
       {\namepartfamily\bibstring{andothers}}  % 第1著者名+"ほか"
       {}}
    {\ifnumequal{\value{listcount}}{1}   % 著者が2人以下の場合
       {\namepartfamily%
        \ifnumequal{\value{liststop}}{2}
          {\iffieldequalstr{langid}{japanese}{\finalnamedelim}{,\space}}
          {}}
       {\ifnumequal{\value{listcount}}{2}
          {\namepartfamily}
          {}}}%
}
```

### 5. タイトルの表示形式
```latex
% 書籍のタイトル
\DeclareFieldFormat[book,collection]{title}{%
  \iffieldequalstr{langid}{japanese}{『#1』}{#1}%
}

% 論文のタイトル
\DeclareFieldFormat[article,incollection]{title}{%
  \iffieldequalstr{langid}{japanese}{「#1」}{#1}%
}

% 雑誌のタイトル
\DeclareFieldFormat[periodical]{title}{%
  \iffieldequalstr{langid}{japanese}{『#1』}{\mkbibemph{#1}}%
}
```

## 引用コマンドの使い方

### 1. 基本的な引用コマンド
```latex
% 本文中の引用（著者名（年）は〜）
\jcite{key}

% 括弧書きの引用（〜である（著者名，年））
\jpcite{key}

% 複数文献の引用（〜である（著者名1，年；著者名2，年））
\jpcites{key1,key2}
```

### 2. 引用例
```latex
% 本文中での引用
\jcite{yamada2020}は大学教育における学習支援システムについて報告している。

% 括弧書きの引用
学習支援システムの開発が進められている\jpcite{suzuki2022}。

% 複数文献の引用
近年、様々な研究が行われている\jpcites{nakamura2023,kato2022}。
```

### 3. 出力例
- 本文中の引用：山田（2020）は大学教育における...
- 括弧書きの引用：...が進められている（鈴木ほか，2022）
- 複数文献の引用：...が行われている（中村ほか，2023；加藤・山本，2022）

## 参考文献データベースの書き方

### 1. 日本語の学術論文
```bibtex
@article{yamada2020,
  title = {大学教育における学習支援システムの開発と評価},
  author = {山田, 一郎},
  date = {2020},
  journaltitle = {教育工学研究},
  volume = {44},
  number = {2},
  pages = {123--134},
  langid = {japanese}
}
```

### 2. 英語の学術論文
```bibtex
@article{tanaka2021,
  title = {A Study on Learning Methods in Higher Education},
  author = {Tanaka, Taro},
  date = {2021},
  journaltitle = {Journal of Educational Research},
  volume = {15},
  number = {3},
  pages = {45--58},
  publisher = {International Education Society},
  langid = {english}
}
```

### 3. 複数著者の論文
```bibtex
@article{suzuki2022,
  title = {オンライン学習における学習者支援に関する研究},
  author = {鈴木, 花子 and 佐藤, 次郎 and Smith, John and Brown, Robert},
  date = {2022},
  journaltitle = {教育システム研究},
  volume = {25},
  pages = {88--102},
  publisher = {教育システム学会},
  langid = {japanese}
}
```

### 4. DOIとURLを含む論文
```bibtex
@article{sato2021,
  title = {高等教育におけるアクティブラーニングの実践と効果},
  author = {佐藤, 明子},
  date = {2021},
  journaltitle = {教育実践研究},
  volume = {12},
  pages = {45--60},
  doi = {10.12345/educ.2021.12345},
  url = {https://example.com/article},
  langid = {japanese}
}
```

## 参考文献リストの出力

### 1. 基本的な出力
```latex
\printbibheading[title=参考文献]
\printbibliography
```

### 2. 日本語と英語の文献を分けて出力
```latex
% 日本語文献
\newrefcontext[labelprefix=J]
\printbibliography[heading=none,check=japanese]

% 非日本語文献
\newrefcontext[labelprefix=F]
\printbibliography[heading=none,check=notjapanese,resetnumbers=false]
```

## トラブルシューティング

### 1. 文字化けが発生する場合
- ファイルのエンコーディングがUTF-8であることを確認
- `\usepackage[utf8]{inputenc}`が設定されているか確認
- VSCodeの設定で`"files.encoding": "utf8"`を確認

### 2. 参考文献が出力されない場合
1. `.aux`ファイルと`.bbl`ファイルを削除
2. 以下の順序で再コンパイル：
   ```bash
   uplatex main
   biber main
   uplatex main
   uplatex main
   dvipdfmx main
   ```

### 3. 著者名の区切りがおかしい場合
- `langid`フィールドが正しく設定されているか確認
- 著者名のフォーマット（姓，名の区切り）を確認

## まとめ

このテンプレートを使用することで：
- 日本語と英語の文献を適切に管理
- 引用スタイルの一貫性を保持
- 文献リストの自動生成と整形
が可能になります。

## 参考リンク

- [biblatex 公式ドキュメント](https://ctan.org/pkg/biblatex)
- [Biber 公式ドキュメント](https://ctan.org/pkg/biber)
- [TeXwiki](https://texwiki.texjp.org/)
- [日本語 LaTeX の新常識 2021](https://qiita.com/wtsnjp/items/76557b1598445a1fc9da)

## ライセンス

このテンプレートはMITライセンスで公開されています。自由に使用、改変、再配布が可能です。 
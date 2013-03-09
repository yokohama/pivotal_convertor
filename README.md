PivotalTrackerのプロジェクト運営を楽にするためのツール集
======================
月ごとの集計ポイント作業や、WBSやガントチャートへの出力などを追加していこうと思います。出来上がっている者にかんしては、随時（使い方）に記載をしていきます。
 
スクリプト
------
### mprbn.rb ###

- 目的
pivotalの特定の月に対して誰が何ポイント消化したかを集計する。

- 使い方
    ruby scripts/mprbn.rb [Pivotal username] [Pivotal password] [Pivotal project_id] [year] [month]

    (出力結果）
    name,derivered,accepted
    ITO,12,5
    もちづき,13,5
    ぴぼたろ,10,8
    もばお,28,10
    さとくん,8,13
    total,71,37
    
- パラメータの解説
+   `Pivotal username` :
    pivotaltrackerのユーザアカウント
 
+   `Pivotal password` :
    pivotaltrackerのパスワード
 
+   `Pivotal project_id` :
    対象のプロジェクトID
 
+   `year` :
    対象の年
    
+   `month` :
    対象の月
 
ライセンス
----------
Copyright &copy; 2013 RAEHIDE.
 
[RAWHIDE.]: http://raw-hide.co.jp

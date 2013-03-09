<h3>PivotalTrackerのプロジェクト集計を楽にするためのツール集</h3>

<h4><使い方></h4>

<article>
  <div class="title">月指定で、バイネームでデリバー＆アクセプトポイントをCSV出力</div>
  <div class="example">
    <code>
      ruby scripts/mprbn.rb [Pivotal username] [Pivotal password] [Pivotal project_id] [year] [month]
    </code>
  </div>
  <div class="disc">
    出力結果
    name,derivered,accepted<br />
    もちづき,13,5<br />
    ぴぼたろ,10,8<br />
    もばお,28,10<br />
    さとくん,8,13<br />
    total,59,33<br />
  </div>
</article>

PivotalTrackerのプロジェクト運営を楽にするためのツール集
======================
月ごとの集計ポイント作業や、WBSやガントチャートへの出力などを追加していこうと思います。出来上がっている者にかんしては、随時（使い方）に記載をしていきます。
 
スクリプト
------
### 目的 ###
pivotalの特定の月に対して誰が何ポイント消化したかを集計する。

### 名前 ###
mprbn.rb

### 使い方 ###
    ruby scripts/mprbn.rb [Pivotal username] [Pivotal password] [Pivotal project_id] [year] [month]

    (出力結果）
    name,derivered,accepted<br />
    ITO,12,5<br />
    もちづき,13,5<br />
    ぴぼたろ,10,8<br />
    もばお,28,10<br />
    さとくん,8,13<br />
    total,71,37<br />
    
パラメータの解説
----------------
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

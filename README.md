<h3>PivotalTrackerのプロジェクト集計を楽にするためのツール集</h3>

<h4><使い方></h4>

<p>月指定で、バイネームでデリバー＆アクセプトポイントをCSV出力</p>
<code>
  ruby scripts/mprbn.rb [Pivotal username] [Pivotal password] [Pivotal project_id] [year] [month]
</code>
<p>出力結果</p>
<code>
  name,derivered,accepted
  もちづき,13,5
  ぴぼたろ,10,8
  もばお,28,10
  さとくん,8,13
  total,59,33
</code>

<h3>PivotalTrackerのプロジェクト集計を楽にするためのツール集</h3>

<h4><使い方></h4>

<ul>月指定で、バイネームでデリバー＆アクセプトポイントをCSV出力</ul>
  <li>
    <code>
      ruby scripts/mprbn.rb [Pivotal username] [Pivotal password] [Pivotal project_id] [year] [month]
    </code>
  </li>
  <li>
    <p>出力結果</p>
    <div>
      <p>name,derivered,accepted</p>
      <p>もちづき,13,5</p>
      <p>ぴぼたろ,10,8</p>
      <p>もばお,28,10</p>
      <p>さとくん,8,13</p>
      <p>total,59,33</p>
    </div>
  </li>
</ul>

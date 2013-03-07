<h3>PivotalTrackerのプロジェクト集計を楽にするためのツール集</h3>

<h4><使い方></h4>

<ul>
  <li>月指定で、バイネームでデリバー＆アクセプトポイントをCSV出力</li>
  <li>
    <code>
      ruby scripts/mprbn.rb [Pivotal username] [Pivotal password] [Pivotal project_id] [year] [month]
    </code>
  </li>
  <li>
    <p>出力結果</p>
    <div>
      name,derivered,accepted<br />
      もちづき,13,5<br />
      ぴぼたろ,10,8<br />
      もばお,28,10<br />
      さとくん,8,13<br />
      total,59,33<br />
    </div>
  </li>
</ul>

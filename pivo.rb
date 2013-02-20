#!/Users/yokohama/.rbenv/shims/ruby
#coding: utf-8

require "csv"
require "erb"

module PivotalTracker

  class Ticket
    attr_accessor :comment, :task, :task_progres_rate, :done
    def initialize
      @comment = []
      @task = []
      @done = false
    end
  end
  
  class Comment
    attr_accessor :title
  end

  class Task
    attr_accessor :title
    attr_accessor :status
  end 

  class Print
    def self.escape(str)
      str.gsub!(/</, "&lt;")
      str.gsub!(/>/, "&gt;")
      str.gsub!(/\r\n|\r|\n/, "<br />")
      str
    end
  end

  class Html < Print
    def self.print(header, records)
      puts ERB.new(DATA.read).run(binding)
    end
  end

  class CSV < Print
    def self.print(header, records)
    end
  end
end

#出力の除外対象の列の設定
except_headers = []
argv = *ARGV
argv.each do |a|
  if a =~ /^except=/
    excepts = a.split(/=/)[1]
    except_headers = excepts.split(/,/)
  end
end
  
#ファイルの読み込み
reader = CSV.open(ARGV[0], "r") 
header = reader.take(1)[0].each {|attr| 
  attr.strip
  attr.gsub!(/\s+/, '_')
  attr.downcase!
}

records = []
reader.each do |r|
  ticket = PivotalTracker::Ticket.new

  task_statuses = []
  r.each_with_index do |attr, i|
    next if except_headers.include? header[i]
    if header[i] == 'comment'
      comment = PivotalTracker::Comment.new
      comment.title = attr
      ticket.comment << comment
    elsif header[i] == 'task'
      task = PivotalTracker::Task.new
      task.title = attr
      task.status = r[i+1]
      ticket.task << task
      task_statuses << task.status
    elsif header[i] == 'task_status'
    else
      ticket.class.class_eval { attr_accessor header[i] }
      ticket.send "#{header[i]}=", attr
    end
  end

  #タスク進捗率
  i = (task_statuses.select do |t|
    t == 'completed'
  end).count
  if task_statuses.count == 0
    ticket.task_progres_rate = '----'
  else
    ticket.task_progres_rate = "#{((i.to_f / task_statuses.count) * 100).round}%"
  end

  #タスクの完了
  ticket.done = true if ticket.current_state == 'accepted'

  records << ticket
end

#表示するヘッダーの調整
header.uniq!.delete('task_status')
header[-1,0] = 'task_progres_rate'
except_headers.each do |h|
  header.delete h
end

PivotalTracker::Html.print header, records


__END__
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html"; charset="UTF-8" />
    <style>
      table {
        border-top:1px solid #666666;
        border-left:1px solid #666666;
        border-collapse:collapse;
        border-spacing:0;
        background-color:#ffffff;
        empty-cells:show;
      }
      th{
        border-right:1px solid #666666;
        border-bottom:1px solid #666666;
        color:#330000;
        background-color:#87CEFA;
        background-image:url(../img/table-back.gif);
        background-position:left top;
        padding:0.3em 1em;
        text-align:center;
        font-size: 4px;
      }
      td{
        border-right:1px solid #666666;
        border-bottom:1px solid #666666;
        padding:0.3em 1em;
        font-size: 4px;
        vertical-align: top;
      }
      div.task-completed{
        background-color:#AAAAAA;
        margin-bottom:4px;
      }
      div.task{
        background-color:#FFF8DC;
        margin-bottom:4px;
      }
      div.comment{
        background-color:#F0F8FF;
        margin-bottom:4px;
      }
      tr.done{
        background-color:#AAAAAA;
      }
    </style>
  </head>
  <body>
    <table>
      <thead>
        <tr>
          <% header.each do |h| %>
            <th><%= h %></th>
          <% end %>
        </tr>
      </thead>
      <tbody>
        <% records.each_with_index do |r, i| %>
          <%= r.done ? '<tr class="done">' : '<tr>' %>
            <% header.each do |h| %>
              <td>
                <% if (h == "comment") %>
                  <% r.comment.each do |c| %>
                    <%= "<div class='comment'>#{PivotalTracker::Print.escape(c.title)}</div>" unless c.title.nil? %>
                  <% end %>
                <% elsif (h == 'task') %>
                  <% r.task.each do |c| %>
                    <% if c.status == 'completed' %>
                      <%= "<div class='task-completed'>#{PivotalTracker::Print.escape(c.title)}</div>" unless c.title.nil? %>
                    <% else %>
                      <%= "<div class='task'>#{PivotalTracker::Print.escape(c.title)}</div>" unless c.title.nil? %>
                    <% end %>
                  <% end %>
                <% else %>
                  <%= PivotalTracker::Print.escape(r.send("#{h}") || '') %>
                <% end %>
              </td>
            <% end %>
          </tr>
        <% end %>
      </tbody>
    </table>
  </body>
</html>

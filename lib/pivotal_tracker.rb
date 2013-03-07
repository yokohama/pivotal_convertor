require 'open-uri'
require 'nokogiri'

#TODO:yokohama クラスをファイル分割
module Railstar

  class PivotalTracker
    API_URL = "https://www.pivotaltracker.com".freeze
    STORY_ATTRIBUTES = [:id, :project_id, :story_type, :url, :estimate, :current_state, :description, :name, :requested_by, :owned_by, :created_at, :updated_at, :accepted_at, :labels, :end].freeze

    class Story
      attr_accessor *STORY_ATTRIBUTES

      def self.nokogiri2stories(result)
        stories = []
        result.each do |r|
          story = self.new
          STORY_ATTRIBUTES.each do |sa|
            story.send "#{sa}=", r.search(sa.to_s).text
          end
          stories << story
        end
        stories
      end
    end

    class Comment
    end

    class Report
      attr_reader :project_id, :guid, :stories

      def initialize(project_id, username, password)
        uri = "#{API_URL}/services/v3/tokens/active"
        doc = Nokogiri::XML(open(uri, {:http_basic_authentication => [username, password]})) 
        @guid = (doc.search("token guid").collect {|i| i.text}).first
        @project_id = project_id
        @story_url = "#{API_URL}/services/v3/projects/#{@project_id}/stories"
      end

      def find_stories(query="")
        query_uri = query.empty? ? @story_url : "#{@story_url}?filter=#{URI.escape(query)}"
        doc = Nokogiri::XML(open(query_uri, 'X-TrackerToken' => @guid))
        result = doc.search("stories story")
        @stories = Story.nokogiri2stories(result)
        @stories
      end

      def accepted_stories_in_month(year=nil, month=nil)
        result = []
        if year.nil? || month.nil?
          @stories.each {|s| result << s if s.accepted_at.empty? }
        else
          @stories.each do |s|
            next if s.accepted_at.empty?
            accepted_at = DateTime.parse(s.accepted_at)
            result << s if accepted_at.year == year && accepted_at.month == month
          end
        end
        result
      end
    end

    # 月を指定して担当者ごとの消化ポイントをcsvで出力する。
    #
    # 1) accepted_atから、指定された月＋空白の月を抽出
    # 2) その結果から、current_stateがacceptedのものを抽出＝指定された月にアクセプトしたもの。
    # 3) さらに1)の結果から、current_stateがdeliveredのものを抽出＝既にデリバー(作業完了)になっているが、まだポチっとしてもらえてないもの。
    # 4) 2)と3)の合計が、指定された月の成果という考え方。
    #
    #TODO:yokohama Reportにあるべきメソッドか？
    def self.monthly_point_report_by_name(username, password, project_id, year, month)
      pivo = Report.new(project_id, username, password)
      pivo.find_stories
      stories = pivo.accepted_stories_in_month + pivo.accepted_stories_in_month(year, month)
      result = {}
      stories.each do |s|
        owner = s.owned_by
        result[owner] = {delivered:0, accepted:0} unless result.key? owner
        if s.current_state == 'delivered'
          result[owner][:delivered] = result[owner][:delivered] + s.estimate.to_i
        elsif s.current_state == 'accepted'
          result[owner][:accepted] = result[owner][:accepted] + s.estimate.to_i
        end
      end
      csv = "name,delivered,accepted\n"
      result.each {|k, v| csv << "#{k.empty? ? 'unknown' : k},#{v[:delivered]},#{v[:accepted]}\n" }
      csv << "total,#{result.values.inject(0){|sum,v| sum+v[:delivered]}},#{result.values.inject(0){|sum,v| sum+v[:accepted]}}"
    end

  end
end

require File.expand_path(File.dirname(__FILE__) + '/../lib/pivotal_tracker')

puts Railstar::PivotalTracker.monthly_point_report_by_name(ARGV[0], ARGV[1], ARGV[2].to_i, ARGV[3].to_i, ARGV[4].to_i)

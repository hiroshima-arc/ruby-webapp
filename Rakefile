require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "yard"

RSpec::Core::RakeTask.new(:spec)
YARD::Rake::YardocTask.new

task :default => :spec

TXT_DIR = "#{Dir.pwd}/meals/"
OUTPUT_DIR = "#{Dir.pwd}/reports/"

FILE_EXT = '.txt'
MEALS = [
    {name: 'breakfast', label: '朝食'},
    {name: 'lunch'    , label: '昼食'},
    {name: 'dinner'   , label: '夕食'}
]

task :default => :daily_report

desc '一日の食事記録を作成する'
task :daily_report => [:check, :report] do
  puts '一日の食事記録を作成しました'
end

desc '食事記録ファイルの確認'
task :check do
  MEALS.each do |meal|
    file_name = meal[:name] + FILE_EXT
    full_path = TXT_DIR + file_name

    if File.exist?(full_path)
      puts "#{file_name} OK"
    else
      puts "#{file_name}がありません"
    end
  end
end

desc '食事レポート作成'
task :report do
  date_str = Time.now.strftime('%Y/%m/%d')
  output_str = "#{date_str}の食事記録\n\n"

  MEALS.each do |meal|
    file_name = meal[:name] + FILE_EXT
    full_path = TXT_DIR + file_name
    description <<DESC
#{meal[:label]}
#{File.read(full_path, :encoding => Encoding::UTF_8)}
DESC

    output_str += description
  end

  output_file = OUTPUT_DIR + "report_#{Time.now.strftime('%Y%m%d')}.txt"
  File.open(output_file, 'w') {|f|
    f.write output_file
  }

end
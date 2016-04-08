require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "yard"

RSpec::Core::RakeTask.new(:spec)
YARD::Rake::YardocTask.new

task :default => :spec

TXT_DIR     = "#{Dir.pwd}/works/"
OUTPUT_DIR  = "#{Dir.pwd}/reports/"
OUTPUT_FILE = OUTPUT_DIR + "report_#{Time.now.strftime('%Y%m%d')}.txt"

FILE_EXT = '.txt'
WORKS = [
    {name: 'desgin'   , label: '設計'},
    {name: 'code'     , label: 'コーディング'},
    {name: 'test'     , label: 'テスト'}
]
TXT_FILES = WORKS.map {|m| TXT_DIR + m[:name] + FILE_EXT}

desc '一日の作業記録を作成する'
task :daily_report => [:check, :report] do
  puts '一日の作業記録を作成しました'
end

desc '作業記録ファイルの確認'
task :check => [:create_output_directory,:create_files] do
end

task :create_output_directory => TXT_DIR do
end
directory TXT_DIR

task :create_output_directory => OUTPUT_DIR do
end
directory OUTPUT_DIR

task :create_files => TXT_FILES do
end
TXT_FILES.each do |file_name|
  file file_name do
    puts "#{file_name}がありません"
    puts "#{file_name}を作成します"
    sh "touch #{file_name}" # Windowsの場合は "type null > #{file_name}" に置き換えてください
  end
end

desc '作業レポート作成'
task :report => [:create_output_directory] do
  date_str = Time.now.strftime('%Y/%m/%d')
  output_str = "#{date_str}の作業記録\n\n"

  WORKS.each do |work|
    file_name = work[:name] + FILE_EXT
    full_path = TXT_DIR + file_name

    description = <<DESC
#{work[:label]}
#{File.read(full_path, :encoding => Encoding::UTF_8)}
DESC

    output_str += description
  end

  File.open(OUTPUT_FILE, 'w') {|f|
    f.write output_str
  }
end

require 'yaml'

LOG_DIR = "#{Dir.pwd}/logs/"
LOG_EXT = '.log'
LOGS = [
    {name:'daily'},
    {name:'sunday'},
    {name:'monday'},
    {name:'tuesday'},
    {name:'wednesday'},
    {name:'thursday'},
    {name:'friday'},
    {name:'saturday'}
]
DAILY_LOG_FILE = LOG_DIR + LOGS[0][:name] + LOG_EXT
LOG_FILES = LOGS.map { |m| LOG_DIR + m[:name] + LOG_EXT}

desc 'ログファイル生成'
task :create_log => [:create_log_directory,:create_log_file] do
  description = <<DESC
desgin,8h
coding,20h
DESC

  LOG_FILES.each do |log|
    File.open log , 'w' do |f|
      f.write description
    end
  end
end

task :create_log_directory => LOG_DIR do
end
directory LOG_DIR

task :create_log_file => LOG_FILES do
end
LOG_FILES.each do |log_name|
  file log_name do
    puts "#{log_name}がありません"
    puts "#{log_name}を作成します"
    sh "touch #{log_name}"
  end
end

desc '今までの作業の名前と作業時間ファイルを作成'
file 'work_history.yml' => DAILY_LOG_FILE do |t|
  sh "cat #{t.prerequisites.join(' ')} >> #{LOG_DIR}/#{t.name}" # Windowsの場合はcatをtypeに変更
end

rule '.yml' => '.log' do |t|
  data = {}
  File.open(t.source).each do |line|
    data.merge!(Hash[*line.chomp!.split(/,/)])
  end

  File.open(t.name, 'w') {|f|
    f.write data.to_yaml
  }
end

desc '一週間の作業の名前と作業時間履歴ファイルを作成'
file 'weekly_work_history.yml' => LOG_FILES do |t|
  sh "cat #{t.prerequisites.join(' ')} >> #{LOG_DIR}/#{t.name}"
end

require 'rake/clean'
CLEAN.include('works/*')
CLEAN.include('logs/*')
CLOBBER.include('reports/*')

BACKUP_DIR = 'backups'
desc 'レポートをバックアップする'
task :backup => BACKUP_DIR do
  sh 'cp reports/* backups/'
end
directory BACKUP_DIR
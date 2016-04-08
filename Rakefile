require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "yard"

RSpec::Core::RakeTask.new(:spec)
YARD::Rake::YardocTask.new

task :default => :spec

namespace :report do
  TXT_DIR = "#{Dir.pwd}/meals/"
  OUTPUT_DIR = "#{Dir.pwd}/reports/"
  OUTPUT_FILE = OUTPUT_DIR + "report_#{Time.now.strftime('%Y%m%d')}.txt"

  FILE_EXT = '.txt'
  MEALS = [
      {name: 'breakfast', label: '朝食'},
      {name: 'lunch'    , label: '昼食'},
      {name: 'dinner'   , label: '夕食'}
  ]
  TXT_FILES = MEALS.map {|m| TXT_DIR + m[:name] + FILE_EXT}

  task :default => :daily_report

  desc '一日の食事記録を作成する'
  task :daily_report => [:check, :report] do
    puts '一日の食事記録を作成しました'
  end

  desc '食事記録ファイルの確認'
  task :check => TXT_FILES do
  end

  TXT_FILES.each do |file_name|
    file file_name do
      puts "#{file_name}がありません"
      puts "#{file_name}を作成します"
      sh "touch #{file_name}" # Windowsの場合は "type null > #{file_name}" に置き換えてください
    end
  end

  desc '食事レポート作成'
  task :report do
    date_str = Time.now.strftime('%Y/%m/%d')
    output_str = "#{date_str}の食事記録\n\n"

    MEALS.each do |meal|
      file_name = meal[:name] + FILE_EXT
      full_path = TXT_DIR + file_name

      description = <<DESC
#{meal[:label]}
      #{File.read(full_path, :encoding => Encoding::UTF_8)}
DESC

      output_str += description
    end

    File.open(OUTPUT_FILE, 'w') {|f|
      f.write output_str
    }
  end
end

namespace :log do
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
  LOG_FILES = LOGS.map { |m| LOG_DIR + m[:name] + LOG_EXT}

  desc 'ログファイル生成'
  task :setup_log => [:create_log_directory,:create_log_file] do
    description = <<DESC
rice,100
misosoup,200
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

  desc '今までの食事の名前とカロリー履歴ファイルを作成'
  file 'menu_history.yml' => LOG_FILES do |t|
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

  desc '一週間の食事の名前とカロリー履歴ファイルを作成'
  file 'weekly_menu_history.yml' => LOG_FILES do |t|
    sh "cat #{t.prerequisites.join(' ')} >> #{LOG_DIR}/#{t.name}"
  end
end

namespace :housekeeping do
  require 'rake/clean'
  CLEAN.include('meals/*')
  CLEAN.include('logs/*')
  CLOBBER.include('reports/*')
  BACKUP_DIR = 'backups'

  directory BACKUP_DIR
  desc 'レポートをバックアップする'
  task :backup => BACKUP_DIR do
    sh 'cp reports/* backups/'
  end
end
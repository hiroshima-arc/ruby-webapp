# coding: utf-8

require 'sinatra/base'

require 'todo/db'
require 'todo/task'
require 'pry'

module Todo
  #
  # ==ToDoアプリケーションクラス
  #
  # Author:: hiroshima-arc
  # Version:: 0.0.1
  # License:: Ruby License
  #
  class Application < Sinatra::Base

    use Rack::MethodOverride

    set :erb, escape_html: true

    helpers do
      def error_class(task, name)
        task.errors.has_key?(name) ? 'has-error':''
      end

      def options_for_task_status(task)
        Task::STATUS.map { |key, value|
          selected = (value == task.status) ? ' selected' : ''
          %(<option value="#{value}"#{selected}>#{key}</option>)
        }.join
      end
    end

    configure do
      DB.prepare
    end

    configure :development do
      require 'sinatra/reloader'
      register Sinatra::Reloader
    end

    get '/' do
      redirect '/tasks'
    end

    get '/tasks' do
      @tasks = Task.order('created_at DESC')
      if @status = params[:status]
        case @status
          when 'not_yet'
            @tasks = @tasks.status_is_not_yet
          when 'done'
            @tasks = @tasks.status_is_done
          when 'pending'
            @tasks = @tasks.status_is_pending
          else
            @status = nil
        end
      end

      erb :index
    end

    get '/tasks/new' do
      @task = Task.new

      erb :new
    end

    post '/tasks' do
      begin
        Task.create!(name: params[:name], content: params[:content])

        redirect '/'
      rescue ActiveRecord::RecordInvalid => e
        @task = e.record

        erb :new
      end
    end

    get '/tasks/:id/edit' do
      begin
        @task = Task.find(params[:id])

        erb :edit
      rescue ActiveRecord::RecordNotFound
        error 404
      end
    end

    put '/tasks/:id' do
      begin
        task = Task.find(params[:id])
        task.update_attributes!(
                name:    params[:name],
                content: params[:content],
                status:  params[:status]
        )

        redirect '/'
      rescue ActiveRecord::RecordInvalid => e
        @task = e.record

        erb :edit
      rescue ActiveRecord::RecordNotFound
        error 4040
      end
    end

    delete '/tasks/:id' do
      begin
        task = Task.find(params[:id])
        task.destroy

        redirect '/'
      rescue ActiveRecord::RecordNotFound
        error 4040
      end
    end

    not_found do
      erb :not_found
    end
  end
end
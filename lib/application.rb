# coding: utf-8

require 'sinatra/base'
require 'haml'

require 'todo/db'
require 'todo/task'

module Todo
  class Application < Sinatra::Base

    set :haml, escape_html: true

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

      haml :index
    end

  end
end
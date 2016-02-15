require 'spec_helper'

describe Todo do
  it 'has a version number' do
    expect(Todo::VERSION).not_to be nil
  end

  describe 'Task' do
    before(:each) do
      Todo::DB.prepare
      @params = {name:'test',content:'contents'}
      Todo::Task.create!(name: @params[:name], content: @params[:content])
    end

    it 'やることが登録できる' do
      expect(Todo::Task.where(@params).count).to eq(1)
    end

    it 'やることが検索できる' do
      id = Todo::Task.where(@params)[0].id
      task = Todo::Task.find(id)
      expect(task.name).to eq('test')
    end

    it 'やることが更新できる' do
      id = Todo::Task.where(@params)[0].id
      task = Todo::Task.find(id)
      task.name = 'test2'
      task.save
      expect(task.name).to eq('test2')
    end

    it 'やることが削除できる' do
      id = Todo::Task.where(@params)[0].id
      task = Todo::Task.find(id)
      task.destroy
      expect(Todo::Task.where(id:id).count).to eq(0)
    end

    context 'やることが登録されている場合' do
      initial_name = '未完了'
      wip_name = 'ペンディング'
      done_name = '完了'

      it "初期値は#{initial_name}" do
        expect(Todo::Task.where(@params)[0].status_name).to eq(initial_name)
      end

      it "やりかけのタスクは#{wip_name}" do
        id = Todo::Task.where(@params)[0].id
        wip = Todo::Task.find(id)
        wip.status = Todo::Task::PENDING
        wip.save
        expect(Todo::Task.where(@params)[0].status_name).to eq(wip_name)
      end

      it "完了したタスクは#{done_name}" do
        id = Todo::Task.where(@params)[0].id
        wip = Todo::Task.find(id)
        wip.status = Todo::Task::DONE
        wip.save
        expect(Todo::Task.where(@params)[0].status_name).to eq(done_name)
      end

    end
  end
end

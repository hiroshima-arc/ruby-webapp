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

    after(:each) do
      Todo::Task.where(@params).delete_all
    end

    it 'やることが登録できる' do
      expect(Todo::Task.all.count).to eq(1)
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
      Todo::Task.where(name:'test2').delete_all
    end

    it 'やることが削除できる' do
      id = Todo::Task.where(@params)[0].id
      task = Todo::Task.find(id)
      task.destroy
      expect(Todo::Task.all.count).to eq(0)
    end

    context 'やることが登録されている場合' do
      it '初期値はNOT_YETである' do
        expect(Todo::Task.where(@params)[0].status_name).to eq('NOT_YET')
      end

      it 'やりかけのタスクはPENDINGである' do
        id = Todo::Task.where(@params)[0].id
        wip = Todo::Task.find(id)
        wip.status = Todo::Task::PENDING
        wip.save
        expect(Todo::Task.where(@params)[0].status_name).to eq('PENDING')
      end

      it '完了したタスクはDONEである' do
        id = Todo::Task.where(@params)[0].id
        wip = Todo::Task.find(id)
        wip.status = Todo::Task::DONE
        wip.save
        expect(Todo::Task.where(@params)[0].status_name).to eq('DONE')
      end

    end
  end
end

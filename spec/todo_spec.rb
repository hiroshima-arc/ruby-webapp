require 'spec_helper'

describe Todo do
  it 'has a version number' do
    expect(Todo::VERSION).not_to be nil
  end

  describe 'DB' do
    it 'やることが登録できる' do
      Todo::DB.prepare
      params = {name:'test',content:'contents'}
      Todo::Task.where(params).delete_all
      Todo::Task.create!(name: params[:name], content: params[:content])
      expect(Todo::Task.all.count).to eq(1)
    end

    it 'やることが検索できる' do
      Todo::DB.prepare
      params = {name:'test',content:'contents'}
      Todo::Task.where(params).delete_all
      Todo::Task.create!(name: params[:name], content: params[:content])
      id = Todo::Task.where(params)[0].id
      task = Todo::Task.find(id)
      expect(task.name).to eq('test')
    end

    it 'やることが更新できる' do
      Todo::DB.prepare
      params = {name:'test',content:'contents'}
      Todo::Task.where(params).delete_all
      Todo::Task.create!(name: params[:name], content: params[:content])
      id = Todo::Task.where(params)[0].id
      task = Todo::Task.find(id)
      task.name = 'test2'
      task.save
      expect(task.name).to eq('test2')
      Todo::Task.where(name:'test2').delete_all
    end

    it 'やることが削除できる' do
      Todo::DB.prepare
      params = {name:'test',content:'contents'}
      Todo::Task.where(params).delete_all
      Todo::Task.create!(name: params[:name], content: params[:content])
      Todo::Task.where(params).delete_all
      expect(Todo::Task.all.count).to eq(0)
    end
  end
end

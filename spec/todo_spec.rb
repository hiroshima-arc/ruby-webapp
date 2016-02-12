require 'spec_helper'

describe Todo do
  it 'has a version number' do
    expect(Todo::VERSION).not_to be nil
  end

  it 'やることが登録できる' do
    Todo::DB.prepare
    params = {name:'test',content:'contents'}
    Todo::Task.where(params).delete_all
    Todo::Task.create!(name: params[:name], content: params[:content])
    expect(Todo::Task.all.count).to eq(1)
  end
end

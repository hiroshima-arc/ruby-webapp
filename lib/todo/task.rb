# coding: utf-8

require 'active_record'

module Todo

  # taskテーブルを表現するモデルクラスです
  # @author hiroshima-arc
  class Task < ActiveRecord::Base
    scope :status_is, ->(status) { where(status: status) }

    scope :status_is_not_yet, -> { status_is(NOT_YET) }
    scope :status_is_done,    -> { status_is(DONE) }
    scope :status_is_pending, -> { status_is(PENDING) }

    NOT_YET = 0 # タスクが完了していない

    DONE    = 1 # タスクが完了した

    PENDING = 2 # 保留状態のタスク

    # ステータスの名称と数値の組み合わせの値
    STATUS = {
        '未完了' => NOT_YET,
        '完了'    => DONE,
        '保留中' => PENDING
    }.freeze

    validates :name,    presence:     true, length: {maximum: 140}
    validates :content, presence:     true
    validates :status,  numericality: true, inclusion: {in: STATUS.values}

    def status_name
      STATUS.key(self.status)
    end
  end

end
require 'rails_helper'

describe "Tasks" do

  it "Tasks can't be created without a description" do
    task = Task.new
    task.valid?
    expect(task.errors.present?).to eq(true)
    task.task = "Test"
    task.valid?
    expect(task.errors.present?).to eq(false)
  end

  it "Tasks can't be created with a due date in the past" do
    task = Task.new
    task.due_date = "1/1/1111"
    task.valid?
    expect(task.errors[:due_date].present?).to eq(true)
    task.due_date = "2020/1/1"
    task.valid?
    expect(task.errors[:due_date].present?).to eq(false)
  end

  it "Existing tasks can have a due date changed to the past" do
    task =Task.create!(task: "Test", due_date: "1/1/2020")
    task.valid?
    expect(task.errors.present?).to eq(false)
    task.due_date = "1/1/1111"
    task.valid?
    expect(task.errors.present?).to eq(false)
  end

end

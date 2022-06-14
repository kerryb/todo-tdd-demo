defmodule Todo.Factory do
  use ExMachina.Ecto, repo: Todo.Repo

  def item_factory do
    %Todo.TodoList.Item{
      text: Faker.Lorem.sentence(),
      priority: Enum.random(1..3),
      done?: Enum.random([true, false])
    }
  end
end

defmodule LevyApi.BookFeedBack.Vote do
  use Ecto.Schema
  import Ecto.Changeset
  alias LevyApi.BookFeedback.Book
  alias LevyApi.Accounts.User

  @required_fields [:book_id, :user_id]

  schema "votes" do
    # field :book_id, :id
    # field :user_id, :id
    belongs_to :user, User
    belongs_to :book, Book
    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [])
    |> validate_required(@required_fields)
  end
end

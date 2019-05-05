defmodule LevyApi.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:name, :isbn, :author, :book_club_id]

  schema "books" do
    field :author, :string
    field :isbn, :string
    field :name, :string
    field :book_club_id, :string
    belongs_to :book_clubs, BookClub
    has_many :votes, Vote
    has_many :scheduled_meet_ups, ScheduledMeetUp
    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs,  @required_fields)
    |> validate_required( @required_fields)
  end
end

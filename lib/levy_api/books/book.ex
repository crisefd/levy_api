defmodule LevyApi.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias LevyApi.BookClubs.BookClub
  alias LevyApi.BookFeedBack.{Vote, Comment}
  alias LevyApi.Scheduler.ScheduledMeetUp

  @required_fields [:name, :isbn, :author, :book_club_id]

  schema "books" do
    field :author, :string
    field :isbn, :string
    field :name, :string
    belongs_to :book_club, BookClub
    has_many :votes, Vote
    has_many :comments, Comment
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

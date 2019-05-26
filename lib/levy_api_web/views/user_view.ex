defmodule LevyApiWeb.UserView do
  use LevyApiWeb, :view
  alias LevyApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "show.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "show.json")}
  end

  def render("user.json", %{user: user, token: token}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      token: token}
  end
end

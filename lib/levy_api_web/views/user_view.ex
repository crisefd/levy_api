defmodule LevyApiWeb.UserView do
  use LevyApiWeb, :view
  alias LevyApi.Accounts.User

  def render("index.json", %{users: users}) do
   %{ rows: Enum.map(users, &user_to_map/1),
      total_count: length(users) }
  end

  def render("show.json", %{user: user}) do
    user |> user_to_map()
  end

  def render("user.json", %{user: user, token: token}) do
    user |> user_to_map |> Map.merge(%{token: token})
  end

  defp user_to_map( %User{} = user) do
    %{
      username: user.username,
      email: user.email,
      name: user.name,
      surname: user.surname,
      id: user.id
     }
  end

end

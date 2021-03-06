defmodule LevyApi.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias LevyApi.Repo

  alias LevyApi.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    try do
     users = Repo.all(User)
     {:ok, users}
    rescue
      _e in Ecto.QueryError -> {:error, :conflict}
      _ -> {:error, :internal_server_error}
    end
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_user(id) do
    try do
      case Repo.get(User, id) do
        nil -> {:error, :not_found}
        user -> {:ok, user}
      end
    rescue
      _e in ArgumentError -> {:error, :bad_request}
      _e in  Ecto.NoResultsError -> {:error, :not_found}
      _ -> {:error, :internal_server_error}
    end

  end


   @doc """
  Gets a single user by its email .

  ## Examples

      iex> get_user_by_email("user@example.com")
      %User{}

      iex> get_user_by_email("usuario@ejmplo.com")
      **  {:error, :not_found}

  """

  def get_user_by_email(email) do
    try do
      case Repo.get_by(User, email: email) do
        nil ->
          {:error, :not_found}
        user ->
          {:ok, user}
      end
    rescue
      _e in ArgumentError -> {:error, :bad_request}
      _ -> {:error, :internal_server_error}
    end

  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    try do
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()
    rescue
       _ -> {:error, :internal_server_error}
    end

  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    try do
      user
      |> User.changeset(attrs)
      |> Repo.update()
    rescue
      _e in Ecto.StaleEntryError -> {:error, :not_found}
      _e in Ecto.NoPrimaryKeyFieldError -> {:error, :bad_request}
      _ -> {:error, :internal_server_error}
    end

  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    try do
      Repo.delete(user)
    rescue
      _e in Ecto.StaleEntryError -> {:error, :conflict}
      _e in Ecto.NoResultsError -> {:error, :no_found}
      _ -> {:error, :internal_server_error}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

end

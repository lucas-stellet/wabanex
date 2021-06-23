defmodule Wabanex.Users.Create do
  @moduledoc """
  Users.Create allow creates a new user thanks to `Wabanex.User.changeset` and `Wabanex.Repo.insert` functions.
  With parameters passed, a `changeset` is created and pipe to `insert` create in database.
  """

  alias Wabanex.{Repo, User}

  @typedoc """
  User struct
  %User{name: "name", email: "name@mail.com", password: "123pass"}
  """
  @type params :: %{name: charlist(), password: charlist(), email: charlist()}

  @spec call(params()) :: {:ok, %Wabanex.User{}} | {:error, %Ecto.Changeset{}}

  @doc """
  Call calls `User.changeset` and `Repo.insert`, acting like a intermediate to create an user and insert him in database

  """

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end

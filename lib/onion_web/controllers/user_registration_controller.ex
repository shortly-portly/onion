defmodule OnionWeb.UserRegistrationController do
  use OnionWeb, :controller

  alias Onion.Accounts
  alias Onion.Accounts.User
  alias OnionWeb.UserAuth

  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def new_company(conn, _params) do
    changeset = Accounts.change_organisation_registration(%User{})
    render(conn, "new_company.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def create_company(conn, %{"user" => user_params}) do
    case Accounts.register_organisation(user_params) do
      {:ok, %{org_user: user}} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "Organisation created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, _entity, %Ecto.Changeset{} = changeset, _} ->
        render(conn, "new_company.html", changeset: changeset)
    end
  end
end

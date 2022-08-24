defmodule Onion.Repo do
  use Ecto.Repo,
    otp_app: :onion,
    adapter: Ecto.Adapters.Postgres
end

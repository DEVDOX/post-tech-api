defmodule PostTech.Repo do
  use Ecto.Repo,
    otp_app: :post_tech,
    adapter: Ecto.Adapters.Postgres
end

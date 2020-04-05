defmodule PostTech.Repo do
  use Ecto.Repo,
    otp_app: :post_tech,
    adapter: Ecto.Adapters.Postgres

  use Paginator,
    limit: 10,
    maximum_limit: 20,
    include_total_count: true,
    total_count_primary_key_field: :uuid
end

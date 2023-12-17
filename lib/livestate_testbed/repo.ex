defmodule LivestateTestbed.Repo do
  use Ecto.Repo,
    otp_app: :livestate_testbed,
    adapter: Ecto.Adapters.Postgres
end

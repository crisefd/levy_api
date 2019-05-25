defmodule LevyApiWeb.Version do
  import Plug.Conn

  @versions Application.get_env(:levy_api, :versions)

  def init(opts), do: opts

  def call(conn, opts) do
    version = validate_version!(opts[:version])
    assign(conn, :version, version)
  end

  defp validate_version!(provided_version) do
    if provided_version in @versions do
       provided_version
    else
      raise "(VersionNotFound) expected any of #{inspect(@versions)}, got #{provided_version}"
    end
  end

end

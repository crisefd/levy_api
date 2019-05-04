defmodule LevyApiWeb.DefaultController do 
  use LevyApiWeb, :controller

  def index(conn, _params) do
    text conn, "LevyApi!" 
  end
end

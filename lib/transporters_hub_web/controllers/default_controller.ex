defmodule TransportersHubWeb.DefaultController do
  use TransportersHubWeb, :controller

  def index(conn, _params) do
    text conn, "I'ts working! {\"status\": \"ok\"}"
  end
end

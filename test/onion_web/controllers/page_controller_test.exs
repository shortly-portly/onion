defmodule OnionWeb.PageControllerTest do
  use OnionWeb.ConnCase

  describe "An authenticated user" do
    setup :register_and_log_in_user

    test "GET / succeeds", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ "Welcome to Phoenix!"
    end
  end

  describe "An unauthenticated user" do
    test "GET / is redirected", %{conn: conn} do
      conn = get(conn, "/")
      assert redirected_to(conn) == Routes.user_session_path(conn, :new)
    end
  end
end

defmodule Toten do
  use Application

  def start(_type, _args) do
    Toten.Supervisor.start_link
  end
end

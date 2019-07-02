defmodule Toten.Server do
    use GenServer

    def start_link do
        Toten.Server.connect_central
        GenServer.start_link(__MODULE__, [], name: :toten)
    end

    def connect_central do
        Node.connect(:"central@127.0.0.1")
    end
    
    def new_command(command, arg) do
        IO.puts("Incoming message: #{inspect command} : #{inspect arg}")

        case command do
            :change_font_color ->
                Toten.Server.change_font_color(arg)
            :change_background_color ->
                Toten.Server.change_background_color(arg)
            :change_toten_name ->
                Toten.Server.change_toten_name(arg)
            :turn_off ->
                Toten.Server.turn_off
        end
    end

    def change_font_color(color) do
        path = Toten.Server.get_website_filepath("font-color.css")
        File.write(path, "#app { color: #{color}; }")
    end

    def change_background_color(color) do
        path = Toten.Server.get_website_filepath("background-color.css")
        File.write(path, "#app { background: #{color}; }")
    end

    def change_toten_name(name) do
        path = Toten.Server.get_website_filepath("toten-name.js")
        File.write(path, "var name = '#{name}';")
    end

    def turn_off do
        System.cmd("cmd.exe", ["/c", "SHUTDOWN", "-r", "-t", "0"])
    end

    def get_website_filepath(file) do
        {:ok, path} = File.cwd
        "#{path}/website/#{file}"
    end

    # 

    def init(messages) do
        {:ok, messages}
    end
end
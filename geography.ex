defmodule Geography do

  defmodule Country do
    defstruct name: "", language: "", cities: []
  end

  defmodule City do
    defstruct name: "", population: 0, latitude: 0.0, longitude: 0.0
  end

  def geo_list_test do
    make_geo_list("geography.csv")
  end

  def make_geo_list(file) do
    {:ok, pid} = File.open(file, [:read, :utf8])
    make_geo_list(pid, [])
  end

  defp make_geo_list(pid, countries) do
    case place = read_geo_file(pid) do
      %Country{}  -> append_country(pid, place, countries)
      %City{}     -> append_city(pid, place, countries)
      nil         -> Enum.reverse(countries)
    end
  end

  defp append_country(pid, country, countries) do
    make_geo_list(pid, [ country | countries ])
  end

  defp append_city(pid, city, [hd|tl]) do
    cities = [city | hd.cities]
    make_geo_list(pid, [ %Country{ hd | cities: cities } | tl ])
  end

  defp read_geo_file(pid) do
    line = IO.read(pid, :line)
    case line do
      :eof ->
        File.close(pid)
        nil
      _    ->
        case line |> String.strip() |> String.split(",") do
          # Unexpected cases should raise an error.
          [country, language] ->
            %Country{name: country, language: language}
          [city, population, longitude, latitude] ->
            %City{ name: city, population: String.to_integer(population),
                   longitude: String.to_float(longitude), latitude: String.to_float(latitude) }
        end
    end
  end
end

defmodule College do

  @doc "reads in a CSV of available courses and organizes them into a map by room number."
  @spec make_room_list(String.t) :: map
  def make_room_list(file) do
    {:ok, pid} = File.open(file, [:read, :utf8])
    make_room_list(pid, %{})
  end

  defp make_room_list(pid, map) do
    case line = IO.read(pid, :line) do
      :eof ->
        File.close(pid)
        map
      _    ->
        [_course_id, course_name, room_num] = String.split(String.strip(line),",")
        map = Map.put(map, room_num, [course_name | Map.get(map, room_num, [])])
        make_room_list(pid, map)
    end
  end

  def room_list_test do
    make_room_list("courses.csv")
  end

end

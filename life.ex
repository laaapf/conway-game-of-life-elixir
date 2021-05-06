defmodule Game do
  @dead "0"
  @alive "1"
  @zombie "2"
  @empty "E"

  def idx_or_false(i, j, max_i, max_j)
      when i >= max_i
      or j >= max_j
      or i < 0
      or j < 0 do
    false
  end

  def idx_or_false(i, j, _max_i, _max_j) do
    {i, j}
  end

  def neighbours(i, j, max_i, max_j) when is_number(i) and is_number(j) do

    [
      {i - 1, j - 1},
      {i - 1, j},
      {i - 1, j + 1},
      {i, j - 1},
      {i, j + 1},
      {i + 1, j - 1},
      {i + 1, j},
      {i + 1, j + 1}
    ]
    |> Enum.map(fn {i, j} -> idx_or_false(i, j, max_i, max_j) end)
    |> Enum.filter(fn coords -> coords != false end)
  end

  def count_status(neighbours_status, status) when is_list(neighbours_status) do
    l_status = neighbours_status |> Enum.filter(fn s -> s == status end)
    length(l_status)
  end

  def next_status(status, last_grid, i, j)
      when is_list(last_grid) and is_number(i) and is_number(j) do

    neighbours_status =
      Game.neighbours(i, j, length(last_grid), length(Enum.at(last_grid, 0)))
      |> Enum.map(fn {i, j} -> Enum.at(last_grid, i) |> Enum.at(j) end)

    alive = Game.count_status(neighbours_status, @alive)
    zombie = Game.count_status(neighbours_status, @zombie)

    case status do
      @empty -> @empty
      @dead ->
        cond do
          alive == 3 -> @alive
          true -> @dead
        end

      @alive ->
        cond do
          zombie > 0 -> @zombie
          alive < 2 -> @dead
          alive > 3 -> @dead
          true -> @alive
        end

      @zombie ->
        cond do
          alive > 0 -> @zombie
          true -> @dead
        end
    end
  end

  def print_grid(grid) when is_list(grid) do
    Enum.each(grid, fn(row) ->
      Enum.each(row,
        fn(j) ->
          case j do
            @empty -> IO.write "\x1b[37mE\x1b[0m"
            @dead -> IO.write "\x1b[31m0\x1b[0m"
            @alive -> IO.write "\x1b[36m1\x1b[0m"
            @zombie -> IO.write "\x1b[32m2\x1b[0m"
          end
        end)
      IO.write("\n")
    end)
  end

  def game(n, i, last_grid) when is_number(n) and is_list(last_grid) do

    print_grid(last_grid)
    IO.puts "---------------#{i}--------------------"
    if i == n do
      IO.inspect("Last Iteration #{i}")
      last_grid
    else
      next_grid =
        Enum.with_index(last_grid)
        |> Enum.map(fn {row, i} ->
          Enum.with_index(row)
          |> Enum.map(fn {status, j} ->
            next_status(status, last_grid, i, j)
          end)
        end)

      if next_grid == last_grid do
        IO.inspect("Stabilizes on iteration = #{i}")
        last_grid
      else
        game(n, i + 1, next_grid)
      end
    end
  end

  def main do
    filename = IO.gets("Filename you want to read the matrix from: ") |> String.trim()
    nIterations = IO.gets("Input the number of iterations: ") |> Integer.parse() |> elem(0)
    grid_list = File.read!(filename) |> String.split("\n")
    grid = Enum.map(grid_list, fn x -> String.graphemes(x) end)
    game(nIterations, 0, grid)
  end
end

fizz_buzz = fn 
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, n) -> n
end

IO.inspect fizz_buzz.(0, 0, 3)
IO.inspect fizz_buzz.(0, 1, 2)
IO.inspect fizz_buzz.(2, 0, 1)
IO.inspect fizz_buzz.(1, 2, 3)

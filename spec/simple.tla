---- MODULE simple ----
EXTENDS TLC, Integers

CONSTANTS MaxValue

(* --algorithm simple
variables x = 0;

process incrementer \in 1..3
variables y = 0
begin Incrementer:
  while x < MaxValue do
    y := MaxValue - x \div 2;
    x := x + y;
    Reset:
      y := 0;
  end while;
end process

end algorithm; *)


(* Invariants *)

ValidX == x <= MaxValue

====

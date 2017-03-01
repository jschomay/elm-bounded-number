# elm-bounded-number

A type representing bounded numbers.  Once a bound is set, the bounded value can never go out of this range.

    between 1 10
        |> set 7
        |> inc 5
        |> value
    -- (equals 10)

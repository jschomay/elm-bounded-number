# elm-bounded-number

A type representing bounded numbers.  Once a bound is set, the bounded value can never go out of this range.

    between 1 10
        |> set 7
        |> inc 5
        |> value
    -- (equals 10)

This is used in `elm-paginate`.

This is a very simple package with the express purpose of moving the logic of bounds-checking into a data structure to make your code more concise and clear.  See more about "Adding behavior with types instead of logic in Elm" in this video demonstrating a novel use of this package: https://www.youtube.com/watch?v=DxCca6_wdwI.


module Number.Bounded
    exposing
        ( Bounded
        , between
        , set
        , inc
        , dec
        , minBound
        , maxBound
        , value
        )

{-| A type representing bounded numbers.  Once a bound is set, the bounded value can never go out of this range.

(Note that although this is intended for numbers, it works for any comparable.)


    between 1 10
        |> set 7
        |> inc 5
        |> value
    -- (equals 10)


@docs Bounded

@docs between, set, inc, dec

@docs value, minBound, maxBound

-}


{-| -}
type Bounded comparable
    = Bounded { min : comparable, max : comparable, value : comparable }


{-| Initialize a bounded number by giving it a min and max for the bounds (inclusive).  The value will be initialized as the provided min.  The min will always be the lower number, regardless of which order you provide the arguments.
-}
between : comparable -> comparable -> Bounded comparable
between a b =
    if a < b then
        Bounded { min = a, max = b, value = a }
    else
        Bounded { min = b, max = a, value = b }


{-| Set the value manually.  If you try to set a value greater than the max bound, it will "clip" at the max.  Likewise, if you try to set a value less than the min bound, it will clip at the min.
-}
set : comparable -> Bounded comparable -> Bounded comparable
set value (Bounded { min, max }) =
    Bounded { min = min, max = max, value = Basics.max min <| Basics.min max value }


{-| Increments the value by the given amount, "clipping" at the max bound if it passes it.
-}
inc : comparable -> Bounded comparable -> Bounded comparable
inc by (Bounded { min, max, value }) =
    Bounded { min = min, max = max, value = Basics.min max <| value + by }


{-| Decrements the value by the given amount, "clipping" at the min bound if it passes it.
-}
dec : comparable -> Bounded comparable -> Bounded comparable
dec by (Bounded { min, max, value }) =
    Bounded { min = min, max = max, value = Basics.max min <| value - by }


{-| Get the value
-}
value : Bounded comparable -> comparable
value (Bounded { value }) =
    value


{-| Get the min bound
-}
minBound : Bounded comparable -> comparable
minBound (Bounded { min }) =
    min


{-| Get the max bound
-}
maxBound : Bounded comparable -> comparable
maxBound (Bounded { max }) =
    max

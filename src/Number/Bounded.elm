module Number.Bounded exposing
    ( Bounded
    , between, set, inc, dec
    , value, minBound, maxBound
    )

{-| A type representing bounded numbers. Once a bound is set, the bounded value can never go out of this range.

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
type Bounded number
    = Bounded { min : number, max : number, n : number }


{-| Initialize a bounded number by giving it a min and max for the bounds (inclusive). The value will be initialized as the provided min. The min will always be the lower number, regardless of which order you provide the arguments.
-}
between : number -> number -> Bounded number
between a b =
    if a < b then
        Bounded { min = a, max = b, n = a }

    else
        Bounded { min = b, max = a, n = b }


{-| Set the value manually. If you try to set a value greater than the max bound, it will "clip" at the max. Likewise, if you try to set a value less than the min bound, it will clip at the min.
-}
set : number -> Bounded number -> Bounded number
set n (Bounded { min, max }) =
    Bounded { min = min, max = max, n = Basics.max min <| Basics.min max n }


{-| Increments the value by the given amount, "clipping" at the max bound if it passes it.
-}
inc : number -> Bounded number -> Bounded number
inc by (Bounded { min, max, n }) =
    Bounded { min = min, max = max, n = Basics.min max <| n + by }


{-| Decrements the value by the given amount, "clipping" at the min bound if it passes it.
-}
dec : number -> Bounded number -> Bounded number
dec by (Bounded { min, max, n }) =
    Bounded { min = min, max = max, n = Basics.max min <| n - by }


{-| Get the value
-}
value : Bounded number -> number
value (Bounded { n }) =
    n


{-| Get the min bound
-}
minBound : Bounded number -> number
minBound (Bounded { min }) =
    min


{-| Get the max bound
-}
maxBound : Bounded number -> number
maxBound (Bounded { max }) =
    max

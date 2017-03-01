module Tests exposing (all)

import Number.Bounded exposing (..)
import ElmTest.Extra exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)


all : Test
all =
    describe "Number.Bounded"
        [ describe "between"
            [ fuzz2 int int "initializes the value to the set min" <|
                \a b ->
                    Expect.equal (value <| between a b) (Basics.min a b)
            , fuzz2 int int "ensures the min is always less than the max" <|
                \a b ->
                    Expect.equal (Number.Bounded.minBound <| between a b) (Basics.min a b)
            ]
        , describe "set"
            [ test "sets the value" <|
                \_ -> Expect.equal (value <| set 3 <| between 1 5) 3
            , fuzz int "the value is never greater than the max bound" <|
                \a ->
                    Expect.true "broke the upper bound!" <| (value <| set a <| between 1 5) <= 5
            , fuzz int "the value is never less than the min bound" <|
                \a ->
                    Expect.true "broke the lower bound!" <| (value <| set a <| between -10 5) >= -10
            ]
        , describe "inc"
            [ test "increments the value by the given amount" <|
                \_ -> Expect.equal (value <| inc 2 <| set 3 <| between 1 10) 5
            , fuzz int "the value will never increment past than the max bound" <|
                \by ->
                    Expect.true "broke the upper bound!" <| (value <| inc by <| between 1 10) <= 10
            ]
        , describe "dec"
            [ test "decrements the value by the given amount" <|
                \_ -> Expect.equal (value <| dec 2 <| set 5 <| between 1 10) 3
            , fuzz int "the value will never decrement past than the min bound" <|
                \by ->
                    Expect.true "broke the lower bound!" <| (value <| dec by <| between 1 10) >= 1
            ]
        ]

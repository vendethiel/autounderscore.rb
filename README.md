# AutoUnderscore

Allows you to write succinct lambdas with `it` (groovy-style) or numbered `_` helpers (where `_` is the same as `it` and
as `_0`).
The operator to call the final function is `[]` (like for closures).

Some examples:

```ruby
# A simple identity example
it[0]
#=> 0
it.to_s[:foo]
#=> "foo"
(_(0) + _(1))[1, 10]
# => 11
# A more convoluted example
((_0.split(" ") + _1.split(" ")).join(_2))["a b", "c d", ","]
#=> a,b,c,d
# _ is the "next argument" placeholder
(_ + _)[1, 2]
#=> 3
```

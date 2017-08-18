# Collections Basics

## Element Reference

- `String#slice` return new string

## Array Element Reference

- `Array#slice` return new array

## Hash Element Reference

- When initializing a hash, the keys must *unique*, values can be duplicated

## Element Reference Gotchas
### Out of Bounds Indices

- Referencing an out-of-bounds index in this way returns `nil`

- `nil` could be a valid return value since arrays can contain any other type of object, including `nil`

- `#fetch` Tries to return the element at position index, but throws an IndexError exception if the referenced indelx lies outside of the array bounds

- `#[]` or `#fetch`

### Negative Indeces

- Element in `string` and `Array` objects can be referenced using negative indices, starting from the last index in the collection `-1` and working backwards

### Invalid Hash Keys

- `Hash` also has a `#fetch` method which can be useful when trying to disambiguate valid hash key with a `nil` value from invalid hash keys.

## Conviersion

- `String#chars` return an array of invidual characters
- `Array#join` return a string with the elements of array joined together
- `Hash#to_a` returns an array
- `Array#to_h` `Ruby 2.1.0`

## Element Assignment
- element assignment notation of `string`

### Array Element Assignment

### Hash Element Assignment

## Summary


# Looping

## Controlling a loop

## Iteration

## Break Placement

## Next

## Iterating Over Collections

### String
- `String#size`

### Array

### Hash

## Summary

# Practice Looping

- Integer#betwween?(0,10)
- Array#push
- Array#shift
- Array#empty?
- Integer#odd? #even?


# Selection and Transformation

- a counter
- a way to retrieve the current value
- criteria

## Looping to Select and Transform

- When performing transformation, it's always important to pay attention to whether the original collection was mutated or if a new collection was returned.

## Extracting to Methods

- `String#include?`

## More Flexible Methods

## Summary

# Methods

- `each`

- `select` evaluates the *return value of the block*
  - only cares about its truthiness
  - `select` performs selection based on the truthiness of the block's return value
  - if the block's return value is always "truthy", then all of the elements will be selected
  - When an element is selected, it's placed in a new collection

- `map` uses the return value of the block to perform transformation instead of selection

- Enumerable

## Summary

# More Methods

- `Enumerable#any?`
  - the return value of the method
  - the return value of the block
  - if the block returns a "truthy" value for any element in the collection, then the method will return `true`

- `Enumerable#all?`
  - the method only return `true` if the block's return value in *every* iteration is truthy
  - `all?` can also be called on a hash

- `Enumerable#each_with_index`
  - take a block and execute the code within the blcok, the block's return value is ignored
  - takes a second argument which represents the index of each element
  - Hash.each_with_index do |pari, index|

- `Enumerable#each_with_object`
  - take a method argument
  - the method argument is a collection object that will returned by the method
  - the block take 2 arguments of its own
  - the first block argument represents the current element
  - the second block argument represents the collection object that was passed in as an argument to the method.
  - Once it's done iterating, the method returns the collection object that was passed in.

- `Enumerable#first`
  - doesn't take a blck,but it take an optional argument which represents the number of elements return
  - hash are typically thought of as unordered and values are retrieved by keys.
  - return value of calling `first` on a hash is a nested array.

- `Enumerable#include?`
  - doesn't take block, but it require one argument
  - it returns `true` if the argument exists in the collection and `false` if it doesn't
  - When called on a hash, `include?` only check the keys, not the values
  - `Hash#include?` is an alias for `Hash#key?` or `Hash#hash_key?`
  - `Hash#value?` or `Hash#has_value?`
  - `Hash#values``include?`

- `Enumerable#partition`
  - divides up element in the current collection into two collection, depending on the block's return value.
  - parallel assign variable to capture the divided inner array
  - Even if the collection is a hash, the return value of `partition` will always be an array

## Summary

- Whether the method takes a block
- How it handles the block's return value
- What the method itself returns


# Exercises Method and More Method

- `#select` {}

- `#count` {}
  - if a block is given, counts the number of elements for which the block returns a true value

- `#reject` {}
  - returns a new array containing items where the block's return value is "falsey". 
  - In other word, if the return value was `false` or `nil` the element would be selected.

- `#each_with_object({}) do | value, hash| ... end`

- `Hash#shift`
  - removes a key-value pair hsh and return it as the two-item array[key, value], or the hash's default value if the hash is empty.

- `array.pop.size`
  - `pop` destructively removes the last element from the calling array and return it.
  - `size` is bing called on the return value by `pop`

- The return value of the block is determined by the return value of the last expression within the block.
  - `Array#any?` method returns `true` if the block ever retruns a value other than `false` or `nil`, 
  - the block returns `true` on the first iteration
  - `any?` will return `true`
  - `any?` stops iteration after this point since there is no need to evaluate the remaining items in the array
  - `puts num` is only ever invoked for the first item in the array: `1`

- `Array#take` selects a specified number of elements from an array.
  - it isn't a destructive method

- the return value of `map` is an array, which is the collection type that `map` always returns
  - the first element, `'ant'`, the condition will evaluate to `false` and `value` won't be returned
  - When none of the conditions in an `if` statement is evaluated, then the `if` statement returns `nil` 

- We can determine the block's return value by looking at the return value of the last statement evaluated within the block
  - For the first element, the `if` condition evaluates to `false`, which means `num` is the block's return value for that iteration.
  - For the rest of the elements in the array, `num > 1` evaluates to `true`, which means `puts num` is the last statement evaluated, which in turn, means that block's return value is `nil` for those iterations.

# Exercises: Additional Practice

- Turn array to hash
  ```
  array.each_with_index do |name, index|
    array[name] = index
  end
  ```

- `ages.values.inject(:+)`

- ages.keep_if { |_, age| < 100 }
  - `Hash#select!` is "Equivalent to `Hash#keep_if`, but return `nil` if no changes were made"
  - Deletes every key-value pair from hsh for which block evaluates to false

- `ages.values.min`

- `array = %w(...)`
  - `array.index { |name| name[0, 2] == "Be" }`
  - returns the index of the first boject in ary such that object is == to obj

- `array.map! { |name| name[0,3] }

- `letter_frequency = statement.scan(letter).count
  - `String#scan`

- `titleize`
  - `words.split.map { |word| word.capitalize }.join(' ')`
  - `String#split -> anArray`
  - `Array#join -> str

# Summary

- som of the most commonly used iterate methods are `each`, `select`, and `map`. It's important to understand the difference between these methods
  - `each`
    - Return a new array with the result of running block once for every element in enum.
    - If no block is given, an enumerator is returned instead
  - `map`
    - Invokes the given block once for each element of self.
    - Create a new arry containing the values returned by the block.
    - If no block is given, an Enumerator is returned instead.
  - `select`
    - Returns a array containing all elements of ary for which the given block returns a true value
    - If no block is given, an Enumerator is returned instead

- Methods called on Ruby collection objects are often used with a block; the return value of the block is passed back to the method on each iteration. It is improtant to be aware of:
  - What the method with the block's return value
  - What the ultimate return value of the method is.
  - Any side-effects that the code in the block many have.

- Ruby provides a lot of other useful methods for workingwith collections. It's not necessary to memorize them all at this stage but you should:
  - Be aware that they exist and know where to look for them
  - Know how to read the documentation in order to understand the method's return value, how it uses the block's return value (if it takes a block), and whether the methodis destructive.

# Exercise: Sorting, Nested Collections and Working with Blocks

```
arr.sort do |a,b|
  b.to_i <=> a.to_i
end
```

```
books.sort_by do |book|
  book[:published]
end
```

- `Hash#key` method return the key of an occurrence of a given value.
  - If more than one key has the same value the method returns the key for the first occurrence of that value
  - If the requested value does not exist in the hash the `nil` is returned
  - `hsh2[:thrid].keys[0]` returns an array of all the keys in the hash, and the `[0]` is then referencing the object at index `0` of that returned array

- `hash.each_value do |value|`

- `hash.each_pair do |key,value|`

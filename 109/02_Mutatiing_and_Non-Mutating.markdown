# Mutating and Non-Mutating Methods

## Non-Mutating Methodss

- Some mutate their receiver, but few mutate any other arguments
- immutable objects

## Assignment is Non-Mutating

- `=` merely connects the variable to a new object.
- `=` a non-mutating method


## Mutating Methods

- `String#strip!`
- `String#concat`
- `#[]=`
- `#<<`

## Indexed Assignment is Mutating

- `#[]` modifies the original object

## Concatenation is Mutating

- `+=` `*=` is non-mutating
- `#<<` is mutating

## Setter are Mutating

# Refining the Mental Model

- Immutable objects still seem to passed by value, while mutable objects seemed to be passed by reference.

- assignment can break the binding between an argument name and the object it references.

# Conclusion

- A method that does not modify its arguments or receiver is non-mutating with respect to those objects

- a method that does modify its arguments or receiver is mutating with respect to the modified objects

- the assignment in Ruby like a non-mutating --- it doesn't modify any objects, but does alter the binding for target variable.

- indexed assignment and boject setter operations are mutating

- `#<<` is mutating
- `+=` is non-mutating


# Variables and References

- An object
  - data that has some sort of state
  - called a value
  - associated behavior

- Variable reference to object
- Variable as bing bound to object
  - binding variable to object

- Both variables are associated with the same object

# Reassignment

- variable is bound to a completely new object --- made to reference a new object
- The original object is merely disconnected frome the variable.

# Mutability

- mutable
  - Mutable objects can be changed
- immutable
  - Immutable objects cannot be changed

- garbage collection

# Mutable Objects

- `a` is a reference to an Array
- that Array contains three elements
- each of those elements is itself a reference to a String object

- variable reference the collection
- the collection contains references to the actual objects in the collection

# A Brief Introduction to Object Passing

- pass an object as an argument to a method
- Whether or not the method can modify an argument is less clear

- passing strategy
  - passed by value
    - make copies of method arguments, and pass those copies to the method, since they are merely copies, the original objects can't be modified
  - pass by reference
    - pass references to the method - a reference can be used to modify the original object, provided that object is mutable.

# Developing A Mental Model

- pass by vaule
- pass by reference

# Conclusion
- ruby is pass by value for immutable objects, pass by reference otherwise.


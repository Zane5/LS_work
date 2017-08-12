# What is Object Passing?

- call a method with some expression as an argument
- that expression is evaluated by ruby and reduced, ultimately, to an object
- The expression can be an boject literal, an variable name, or a complex expression, regardless, it is reduced to an object.
- Ruby then makes that object available inside the method
- This is called passing the object to the method, or, more simply, object passing

- method receivers

- return values are passed by those methods back to the caller

- blocks, procs, lambdas

- `+`, `*`, `!` are methods,  `=` acts like a method

# Evaluation Strategies

- strict evaluation strategies
  - very expression is evaluated and converted to an object to an object before it passed along to a method.
  - The two common strict evaluation strategies are pass by value and pass by reference

## Why is the Object Passing Strategy Improtant?

## Pass by Value

- a copy of an boject is created
- it is that copy that gets passed around
- it is impossible to change the original object

## Pass by Reference

- a reference to an object is passed around
- This establishes an alias between the argument and the original object
- both the argument and object refer to the same localtion in memory
- if you modify the argument's state, you also modify the original object

# It's References All The Way Down

- ruby's variables don't contain objects; they are merely references to object

- pass by reference isn't limited to mutating methods.
- A non-mutating method can use pass by reference as well
- so pass by reference can be used with immutable objects
- There may be a reference passed, but the reference isn't a guarantee that the object can be modified

# Pass By Reference Value

- ruby variables and constants aren't objects, but are references to object
- Assignment merely changes which object is bound to a particular variable

- pass by reference value, pass by reference of the vaule, pass by vaule of the reference
- ruby passes around copies of the references
- ruby is pass by value nor pass by reference, but insead employs a thrid strategy that blends the two strategies.

# Final Mental Model

- *pass by reference value* at least not unitl you full understand it
- *pass by reference* is accurate so long as you account for assignment and immutability
- Ruby acts like *pass by value* for immutable objects, *pass by reference* for mutable objects is a reasonable answer when learning about ruby, so long as you keep in mind that ruby only appears to act like this.

# Wrap-up


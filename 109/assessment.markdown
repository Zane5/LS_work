
- Method scopes are entirely self-contained. Methods can't access variables in another scope but can access objects passed in as parameters

- `a` local variable inside the method is only scoped at the method level and literally dies when method ends. It is not the same variables as the outer scoped `a` even thy use the same name.

- `Hash#select` return a new hash, press every key-value to the block, only if the block return true, add this key-value to the new hash. If no block is given, `Hash#select` return every key-value as an enumerator

- the inner scope of block can access variable initialized in an outer scope, but not vice vera



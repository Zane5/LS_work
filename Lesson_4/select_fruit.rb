def select_fruit(produce_list)
  produce_keys = produce_keys.keys
  counter = 0
  selected_fruits = {}

  loop do
    break if conter == produce_keys.size

    current_key = produce_keys[counter]
    current_value = produce_list[current_key]

    if current_value == 'Fruit'
      selected_fruits[current_key] = current_value
    end

    counter += 1
  end

  selected_fruits
end

def double_numbers(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    doubled_numbers << current_number * 2

    counter += 1
  end

  doubled_numbers
end

def double_numbers!(numbers)
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    numbers[counter] = current_number * 2

    counter += 1
  end

  numbers
end

def double_odd_numbers(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *= 2 if current_number.odd?
    doubled_numbers << current_number

    counter += 1
  end

  doubled_numbers
end

p 'double_odd_numbers'
my_numbers = [1, 4, 3, 7, 2, 6]
p double_numbers!(my_numbers) == [2, 8, 6, 14, 4, 12]
p my_numbers == [2, 8, 6, 14, 4, 12]

def double_odd_indices(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *= 2 if counter.odd?
    doubled_numbers << current_number

    counter += 1
  end

  doubled_numbers
end

p 'double_odd_indices'
my_numbers = [1, 4, 3, 7, 2, 6]
p double_odd_indices(my_numbers) == [1, 8, 3, 14, 2, 12]

#########################3

def general_select(produce_list, selection_criteria)
  produce_keys = produce_list.keys
  counter = 0
  selected_fruits = {}

  loop do
    break if counter == produce_keys.size

    current_key = produce_keys[counter]
    current_value = produce_list[current_key]

    if current_value == selection_criteria
      selected_fruits[current_key] = current_value
    end

    counter += 1
  end

  selected_fruits
end

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}
p 'general_select'
p general_select(produce, 'Fruit') == {"apple"=>"Fruit", "pear"=>"Fruit"}
p general_select(produce, 'Vegetable') == {"carrot"=>"Vegetable", "broccoli"=>"Vegetable"}
p general_select(produce, 'Meat') == {}

def multiply(numbers, multiplier)
  multiplied_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    multiplied_numbers << numbers[counter] * multiplier
    counter += 1
  end

  multiplied_numbers
end

p '------------------------'
p 'multiply'
my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3) == [3, 12, 9, 21, 6, 18]

def select_letter(sentence, character)
  selected_chars = ''
  counter = 0

  loop do
    break if counter == sentence.size
    current_char = sentence[counter]

    if current_char == character
      selected_chars << current_char
    end

    counter += 1
  end

  selected_chars
end

p '--------------'
p 'select_letter'
question = 'How many times does a particular character appear in this sentence?'
p select_letter(question, 'a') == "aaaaaaaa"
p select_letter(question, 't') == "ttttt"
p select_letter(question, 'z') == ""


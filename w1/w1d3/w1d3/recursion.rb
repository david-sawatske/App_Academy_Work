require 'byebug'

# ranges
def iterative_range(start_num, end_num)
  (start_num..end_num).to_a
end

def recursive_range(start_num, end_num)
  return [end_num] if start_num == end_num

  recur_range(start_num, end_num - 1) << end_num
end

# iterative and recursive sums
def iterative_sum(arr)
  arr.reduce(:+)
end

def recursive_sum(arr)
  return arr[-1] if arr.count == 1

  arr[-1] += recursive_sum(arr[0..-2])
end

# exponentation
def exponentation1(base, power)
  return 1 if power == 0

  base * exponentation1(base, power - 1)
end

def exponentation2(base, power)
  return 1 if power == 0
  return base if power == 1

  if power.even?
    exponentation2(base, power / 2)**2
  else
    base * (exponentation2(base, (power - 1) / 2)**2)
  end
end

# deep dup
def deep_dup(arr)
  duplicate = []

  arr.each do |el|
    if el.is_a?(Array)
      deep_dup(el)
    else
      duplicate << el
    end
  end

end

deep_dup([1, [2], [3, [4]]])

#p deep_dup([1, [2], [3, [4]]])

def fib_recursive(n)
  if n == 1
    [0]
  elsif n == 2
    [0, 1]
  else
    ret_fibs = fib_recursive(n - 1)
    ret_fibs << ret_fibs[-1] + ret_fibs[-2]
  end
end

fib_recursive(5)


def subsets(array)
  return [[]] if array.empty?

  subs = subsets(array.take(array.count - 1))

  subs.concat(subs.map { |sub| sub + [array.last] })
end

#p subsets([1, 2]) # => [[], [1], [2], [1, 2]]

def permutations(array)
  return [array.first] if array.count == 1

  prev = permutations(array[1..-1])
  new_arrays = []

  prev.each do |arr|
    if arr.is_a?(Array) #[2, 3]
      (0..arr.count).each do |idx|
        temp_arr = arr.dup
        new_array = temp_arr.insert(idx, array[0])
        new_arrays << new_array
      end
    else
      temp_arr1 = prev.dup
      temp_arr1 << array[0]
      temp_arr2 = prev.dup
      temp_arr2.unshift(array[0])
      return [temp_arr1, temp_arr2]
    end
  end

  new_arrays
end

#p permutations([1, 2, 3, 4])

def bsearch(array, target)
  sorted_array = array.sort
  middle = sorted_array.length / 2

  return middle if target == sorted_array[middle]

  case sorted_array[middle] <=> target
  when -1
    bsearch(sorted_array[middle..-1], target)
  when 0
    return middle + sorted_array.length
  when 1
    bsearch(sorted_array[0..middle], target)
  end
end

p bsearch([1, 2, 3], 1)

def quick_sort(arr, target)
  return arr if arr.length <= 1

  pivot_el = arr[arr.length / 2]  # this is the # in the middle

  left_side = arr[0..middle].select { |el| el < arr.first }   # one of these needs = for
  right_side = arr[middle..-1].select { |el| el >= arr.first } # duplicates of base case

  quick_sort(left_side) + piviot_arr + quick_sort(right_side)
end

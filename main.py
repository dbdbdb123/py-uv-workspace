
class MyClass:
    a = 10


my_object = MyClass()

def print_hi(name):
    print(f'Hi, {name}')


if __name__ == '__main__':


    nums = [1, 2, 3, 4, 5]
    print(nums[2:-1])




    myFriend = ['John', 'Mike', 'Tom', 'Jane']
    print(myFriend)
    myFriend.insert(1, 'John')
    print(myFriend)

    tuple1 = (9,)
    print(tuple1)
    tuple2 = 10,
    print(tuple2)

    count = ['a', 'b', 'c', 'd', 'e','a']
    print(count.count('a'))

    set1 = {1, 2, 3, 4, 5}
    set2 = {4, 5, 6, 7, 7}
    print(set1)
    print(set2)

    first = ["egg", "salad", "bread", "soup", "canafe"]
    second = ["fish","lamb","pork","beef","chicken"]
    third = ["apple", "banana", "orange", "grape", "manago"]

    order = [first, second, third]

    print(second[1::3])
    print(second[3])

    john = [order[0][:-2], second[1::3], third[0]]
    del john[2]
    john.extend(order[2][0:1])
    print(john)


    nums = {'1': 'one', '2': 'two', '3': 'three', '4': 'four', '5': 'five'}
    nums['1'] = 'ones'
    print(nums)

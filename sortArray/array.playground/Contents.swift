import UIKit
var array: [Int] = [2,12,4,8,3,5,21,9,11,432,42,15]
var evenArray: [Int] = []
var unEvenArray: [Int] = []

for i in 0...array.count - 1{
    if array[i] % 2 == 0 {
        evenArray.append(array[i])
    } else {
        unEvenArray.append(array[i])
    }
}

evenArray.sort()
unEvenArray.sort()
unEvenArray.reverse()

array = evenArray + unEvenArray
print("result = \(array)")

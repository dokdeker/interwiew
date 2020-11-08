import UIKit

var num:Int = 134431

var calcNum = num
var reverseNum:Int = 0

while calcNum > 0 {
    let lastNum = calcNum % 10
    calcNum /= 10
    reverseNum = reverseNum * 10 + lastNum
}

if reverseNum == num {
    print("число является палиндромом")
} else {
    print("число не является палиндромом")
}

//
//  main.swift
//  ee
//
//  Created by Евгений on 08.11.2020.
//

import Foundation

print("Введите фразу, указав в квадратных скобках слово, которое нужно будет заменить.")
var str:String = readLine()!
var secStr:String = ""
if str.contains("[") && str.contains("]") {
    print("вы ввели: \(str)")
    print("введите на что нужно заменить слово в квадратных скобках:")
    secStr = readLine()!
    print("Слово измененно!")
    changeWord()
    print(str)
} else {
    print("фраза не содержит квадратных скобок")
}

func changeWord() {
    var startIndexWord = 0
    var calcStartIndex = str.index(str.startIndex, offsetBy: startIndexWord)
    while str[calcStartIndex] != "[" {
        startIndexWord += 1
        calcStartIndex = str.index(str.startIndex, offsetBy: startIndexWord)
    }
    var endIndexWord = 0
    var calcEndIndex = str.index(str.startIndex, offsetBy: endIndexWord)
    while str[calcEndIndex] != "]" {
        endIndexWord += 1
        calcEndIndex = str.index(str.startIndex, offsetBy: endIndexWord)
    }
    let startWord = str.index(str.startIndex, offsetBy: startIndexWord + 1)
    let endWord = str.index(str.startIndex, offsetBy: endIndexWord)
    let word = startWord..<endWord

    let removeWorld = str[word]
    if let range = str.range(of: removeWorld ) {
        str.removeSubrange(range)
    }
    str.insert(contentsOf: secStr, at: str.index(str.startIndex, offsetBy: startIndexWord + 1))
}



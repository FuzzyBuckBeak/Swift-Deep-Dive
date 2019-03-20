import UIKit

var str = "Internal implementation of closures"

extension Array {
    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
        var runningValue = initialResult
        return map { next in
            runningValue = nextPartialResult(runningValue, next)
            return runningValue
        }
    }
    
    func filter(_ isIncluded: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        for element in self where isIncluded(element) {
            result.append(element)
        }
        return result
    }
    
    func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> Result {
        var runningValue = initialResult
        for element in self {
            runningValue = nextPartialResult(runningValue, element)
        }
        return runningValue
    }

    func flatMap<T>(_ transform: (Element) -> [T]) -> [T] {
        var result: [T] = []
        for element in self {
            result.append(contentsOf: transform(element))
        }
        return result
    }
}

var fib = [1, 2, 3, 4, 5]
print(fib.accumulate(0, +))

print (fib.reduce(0) { (sum, number) -> Int in
    return sum + number
})

var array = [["♠︎", "♥︎", "♣︎", "♦︎"], ["J","Q","K","A"]]
print(array.flatMap { (string) -> [String] in
    return string
})

print(array.flatMap {$0})

let suits = ["♠︎", "♥︎", "♣︎", "♦︎"]
let ranks = ["J","Q","K","A"]
let result = suits.flatMap { suit in
    ranks.map { rank in
    (suit, rank)
    }
}

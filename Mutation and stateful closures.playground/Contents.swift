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
}

var fib = [1, 2, 3, 4, 5]
print(fib.accumulate(0, +))

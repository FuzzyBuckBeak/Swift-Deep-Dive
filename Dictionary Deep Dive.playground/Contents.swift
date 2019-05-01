import UIKit

var str = "Hello, playground"

var userSetting = ["Name": "FuzzyBuckbeak"]
var defaults = ["Name": "owner"]

userSetting.merge(defaults) { (first, second) -> String in
    return second
}


//Get frequecny of elements in the given sequence
extension Sequence where Element: Hashable {
    var frequencies: [Element: Int] {
        let frequencyPairs = self.map { ($0, 1)}
        return Dictionary(frequencyPairs, uniquingKeysWith: +)
    }
}

//Get unique elements in array maintaining the stability
extension Sequence where Element: Hashable {
    func unique() -> [Element] {
        var array: [Element] = []
        return filter { element in
            if array.contains(element) { return false }
            else { array.append(element); return true }
        }
    }
}

let some  = [2, 3, 4, 3, 3, 3, 3, 2, 1, 4].unique()
print(some)




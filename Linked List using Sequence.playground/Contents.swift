import UIKit

var str = "Implementing sequence"

enum LinkedList<T> {
    case tail
    //recursive enum
    indirect case node(val: T, next: LinkedList)
    
    init(array: [T]) {
        self = array.reversed().reduce(LinkedList<T>.tail, { node, value in
            return LinkedList.node(val: value, next: node)
        })
    }
    
    public final class ListIterator<T> {
        private var current: LinkedList<T>
        
        init(current: LinkedList<T>) {
            self.current = current
        }
    }
}

extension LinkedList.ListIterator: IteratorProtocol {
    public typealias Element = T
    public func next() -> T? {
        switch current {
        case .tail: return nil
        case .node(let value, let node):
            defer { current = node }
            return value
        }
    }
}

extension LinkedList: Sequence {
    typealias Iterator = ListIterator<T>
    func makeIterator() -> LinkedList<T>.ListIterator<T> {
        return ListIterator(current: self)
    }
}

let list = LinkedList(array: [1, 2, 3, 4, 5])
print(list.forEach { print($0) } )
print(list.map { $0 * 3 })
print(list.filter { $0 != 1 })



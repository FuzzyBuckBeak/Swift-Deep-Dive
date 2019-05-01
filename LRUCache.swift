//
//  LRUCache.swift
//  CodingChallenge
//
//  Created by Apo on 4/22/19.
//  Copyright © 2019 FuzzyBuckbeak. All rights reserved.
//

import Foundation

class ListNode<Key, Value> {
    
    var value: Value
    var key: Key
    var next: ListNode?
    var previous: ListNode?
    
    init(value: Value, key: Key, next: ListNode? = nil, previous: ListNode? = nil) {
        self.value = value
        self.key = key
        self.next = next
        self.previous = previous
    }
}

class QueuedLinkedList<Key, Value> {
    var head: ListNode<Key, Value>?
    var tail: ListNode<Key, Value>?
    var count: Int = 0
    
    init() { }
    
    func add(_ key: Key, _ value: Value) -> ListNode<Key, Value>? {
        let node = ListNode(value: value, key: key)
        count += 1
        guard let temphead = head, let _ = tail else {
            head = node; tail = head; return node
        }
        
        temphead.previous = node
        node.next = head
        head = node
        return node
    }
    
    func removeLast() -> ListNode<Key, Value>? {
        guard let temptail = tail else { return nil }
        let previous = temptail.previous
        previous?.next = nil
        defer {
            count -= 1
            tail = previous
        }
        return tail
    }
    
    func moveNodeTowardsHead(node: ListNode<Key, Value>) {
        guard head !== node else { return }
        if tail === node { tail = node.previous }
        node.previous?.next = node.next
        node.next?.previous = node.previous
        
        node.next = head
        node.previous = nil
        
        head?.previous = node
        head = node
    }
}

class LRUCache <Key: Hashable, Value> {
    var data: [Key: ListNode<Key, Value>] = [:]
    let list: QueuedLinkedList<Key, Value> = QueuedLinkedList()
    var maximumSize: Int
    init(maximumSize: Int) {
        guard maximumSize > 0 else { fatalError() }
        self.maximumSize = maximumSize
    }
    
    func add(key: Key, value: Value) {
        print("Adding - \(value)")
        if let node = data[key] {
            list.moveNodeTowardsHead(node: node)
        } else {
            guard let node = list.add(key, value) else { fatalError() }
            data[key] =  node
        }
        
        if list.count > maximumSize {
            guard let node = list.removeLast() else { return }
            data[node.key] = nil
            print("removing - \(node.value)")
        }
    }
    
    func get(key: Key) -> Value? {
        guard let node = data[key] else { return nil }
        list.moveNodeTowardsHead(node: node)
        print("---------------------------------------------")
        print("Moved to head - \(node.value)")
        return node.value
    }
    
    func isValid(key: Key) -> Bool {
        return data[key] != nil
    }
}

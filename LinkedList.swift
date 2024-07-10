public class Node<dataType> {
    public var value: dataType
    public var next: Node?
    public var previous: Node?
    
    public init(_ value: dataType) {
        self.value = value
    }
}

class LinkedList<dataType> {
    private var head: Node<dataType>?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node<dataType>? {
        return head
    }
    
    public var last: Node<dataType>? {
        guard var node = head else {
            return nil
        }
        while let next = node.next {
            node = next
        }
        return node
    }
    
    public func append(value: dataType) {
        let newNode = Node(value)
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    public var count: Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    public func printList() -> String {
        var s = "["
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil {
                s += ", "
            }
        }
        return s + "]"
    }
    
    public func node(atIndex index: Int) -> Node<dataType>? {
        if index == 0 {
            return head
        } else {
            var node = head?.next
            for _ in 1..<index {
                node = node?.next
                if node == nil {
                    break
                }
            }
            return node
        }
    }
    
    public func insert(value: dataType, at index: Int) {
        let newNode = Node(value)
        if index == 0 {
            newNode.next = head
            head?.previous = newNode
            head = newNode
        } else {
            guard let previousNode = self.node(atIndex: index - 1) else { return }
            let nextNode = previousNode.next
            newNode.previous = previousNode
            newNode.next = nextNode
            previousNode.next = newNode
            nextNode?.previous = newNode
        }
    }
    
    public func remove(node: Node<dataType>) -> dataType {
        let previousNode = node.previous
        let nextNode = node.next
        
        if let previousNode = previousNode {
            previousNode.next = nextNode
        } else {
            head = nextNode
        }
        nextNode?.previous = previousNode
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    public func remove(at index: Int) -> dataType? {
        guard let nodeToRemove = node(atIndex: index) else { return nil }
        return remove(node: nodeToRemove)
    }
}


var list : LinkedList<Int> = LinkedList()

list.append(value: Int(9))
list.append(value: 89)
let list1 = list.printList()

print(list1)
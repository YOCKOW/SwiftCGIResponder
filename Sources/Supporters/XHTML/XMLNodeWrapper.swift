/* *************************************************************************************************
 XMLNodeWrapper.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

internal struct _XMLNodeWrapper<Node> where Node:XMLNode {
  private var _node:Node
  internal init(_ node:Node) { self._node = node }
}

extension _XMLNodeWrapper {
  private func get<Value>(_ keypath:KeyPath<Node, Value>) -> Value {
    return self._node[keyPath:keypath]
  }
  
  private mutating func set<Value>(_ value:Value, for keyPath:WritableKeyPath<Node, Value>) {
    self._node = self._node.copy() as! Node
    self._node[keyPath:keyPath] = value
  }
  
  internal subscript<Value>(_ keyPath:KeyPath<Node, Value>) -> Value {
    get { return self.get(keyPath) }
  }
  
  internal subscript<Value>(_ keyPath:WritableKeyPath<Node, Value>) -> Value {
    get { return self.get(keyPath) }
    set { self.set(newValue, for:keyPath) }
  }
}

extension _XMLNodeWrapper {
  internal func call<Arguments, Result>(getter method:(Node) -> (Arguments) -> Result,
                                        arguments:Arguments) -> Result
  {
    return method(self._node)(arguments)
  }
  
  internal mutating func call<Arguments, Result>(setter method:(Node) -> (Arguments) -> Result,
                                                 arguments:Arguments) -> Result
  {
    self._node = self._node.copy() as! Node
    return method(self._node)(arguments)
  }
}

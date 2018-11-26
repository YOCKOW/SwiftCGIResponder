/* *************************************************************************************************
 HeaderField+DelegateSelector.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
extension HeaderField {
  /// Metatype-erasure for `HeaderFieldDelegate`
  private class _TypeBox {
    fileprivate func headerField(with value:HeaderFieldValue) -> HeaderField {
      fatalError("Must be overridden.")
    }
    
    fileprivate class _Normal<Delegate>: _TypeBox where Delegate:HeaderFieldDelegate {
      private let _type: Delegate.Type
      fileprivate init(_ type:Delegate.Type) {
        self._type = type
      }
      
      fileprivate override func headerField(with value:HeaderFieldValue) -> HeaderField {
        guard let source = Delegate.ValueSource(httpHeaderFieldValue:value) else {
          fatalError("\(Delegate.ValueSource.self) cannot be initialized with \"\(value)\".")
        }
        return HeaderField(delegate:Delegate(source))
      }
    }
    
    fileprivate class _Appendable<Delegate>: _Normal<Delegate>
      where Delegate:AppendableHeaderFieldDelegate
    {
      fileprivate override func headerField(with value:HeaderFieldValue) -> HeaderField {
        guard let source = Delegate.ValueSource(httpHeaderFieldValue:value) else {
          fatalError("\(Delegate.ValueSource.self) cannot be initialized with \"\(value)\".")
        }
        return HeaderField(delegate:Delegate(source))
      }
    }
  }
  
  public final class DelegateSelector {
    private init() {}
    public static let `default` = DelegateSelector()
    
    private var _list:[HeaderFieldName:_TypeBox] = [
      // Here are default delegates implemented in this module.
      .cacheControl: _TypeBox._Appendable(CacheControlHeaderFieldDelegate.self),
      .contentDisposition: _TypeBox._Normal(ContentDispositionHeaderFieldDelegate.self),
      .contentLength: _TypeBox._Normal(ContentLengthHeaderFieldDelegate.self),
      .eTag: _TypeBox._Normal(ETagHeaderFieldDelegate.self),
      .ifMatch: _TypeBox._Appendable(IfMatchHeaderFieldDelegate.self),
      .ifNoneMatch: _TypeBox._Appendable(IfNoneMatchHeaderFieldDelegate.self),
      .lastModified: _TypeBox._Normal(LastModifiedHeaderFieldDelegate.self),
      .location: _TypeBox._Normal(LocationHeaderFieldDelegate.self),
    ]
    
    private func _register(_ box:_TypeBox, for name:HeaderFieldName) -> Bool {
      if let _ = _list[name] {
        return false
      }
      _list[name] = box
      return true
    }
    
    /// Register the type for the delegate that generates the header field named `name`.
    @discardableResult
    public func register<Delegate>(_ typeObject:Delegate.Type, for name:HeaderFieldName) -> Bool
      where Delegate: HeaderFieldDelegate
    {
      return self._register(_TypeBox._Normal(typeObject), for:name)
    }
    
    /// Register the type for the delegate that generates the header field named `name`.
    @discardableResult
    public func register<Delegate>(_ typeObject:Delegate.Type, for name:HeaderFieldName) -> Bool
      where Delegate: AppendableHeaderFieldDelegate
    {
      return self._register(_TypeBox._Appendable(typeObject), for:name)
    }
    
    fileprivate func _headerField(name:HeaderFieldName, value:HeaderFieldValue) -> HeaderField? {
      guard let box = self._list[name] else { return nil }
      return box.headerField(with:value)
    }
  }
  
  /// Initializes with `name` and `value`.
  /// Appropriate delegate will be selected if the type for the name is registered in
  /// `DelegateSelector.default`.
  public init(name:HeaderFieldName, value:HeaderFieldValue) {
    if let field = DelegateSelector.default._headerField(name:name, value:value) {
      self = field
    } else {
      self.init(_AnyHeaderFieldDelegate(name:name, value:value))
    }
  }
}



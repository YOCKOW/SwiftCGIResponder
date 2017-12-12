/***************************************************************************************************
 Client+Browser.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/// Extend `Client` to detect what kind of browser the user uses.
extension Client {
  open class Browser {
    /// Initialize with string of "HTTP_USER_AGENT"
    /// This initializer must be concretely implemented in subclasses.
    /// Returns `nil` unless "HTTP_USER_AGENT" doesn't match the browser represented by the class.
    /// ## note
    /// You should not trust the result, because
    /// "HTTP_USER_AGENT" can be freely set by the user.
    public required init?(with userAgentString:String) { }
    
    /// Initialize with an instance of `Client`.
    /// - returns: `nil` if `client.userAgent` or `init(with:client.userAgent!)` is `nil`.
    public convenience required init?(with client:Client) {
      guard let userAgent = client.userAgent else { return nil }
      self.init(with:userAgent)
    }
  }
}

extension Client.Browser {
  public class Unknown: Client.Browser {
    public required init?(with userAgentString: String) {
      fatalError("init(with:) has not been implemented")
    }
    
    fileprivate init() { super.init(with:"")! }
  }
  
  /// Represents Google Chrome.
  open class Chrome: Client.Browser {
    public required init?(with userAgentString: String) {
      guard (userAgentString.contains("Chrome") || userAgentString.contains("CriOS")) &&
            !userAgentString.contains("Edge") &&
            !userAgentString.contains("OPR/") else { return nil }
      super.init(with:userAgentString)
    }
  }
  
  /// Represents Microsoft Edge
  open class Edge: Client.Browser {
    public required init?(with userAgentString: String) {
      guard userAgentString.contains("Edge") else { return nil }
      super.init(with:userAgentString)
    }
  }
  
  /// Represents Firefox
  open class Firefox: Client.Browser {
    public required init?(with userAgentString: String) {
      guard userAgentString.contains("Firefox") else { return nil }
      super.init(with:userAgentString)
    }
  }
  
  /// Represents Internet Explorer
  open class InternetExplorer: Client.Browser {
    public required init?(with userAgentString: String) {
      guard userAgentString.contains("MSIE") ||
            userAgentString.contains("Trident") else { return nil }
      super.init(with:userAgentString)
    }
  }
  
  /// Represents Opera
  open class Opera: Client.Browser {
    public required init?(with userAgentString: String) {
      guard userAgentString.contains("Opera") ||
            userAgentString.contains("OPR/") else { return nil }
      super.init(with:userAgentString)
    }
  }
  
  /// Represents Safari
  open class Safari: Client.Browser {
    public required init?(with userAgentString: String) {
      guard userAgentString.contains("Safari") &&
            !userAgentString.contains("Chrome") &&
            !userAgentString.contains("Edge") else { return nil }
      super.init(with:userAgentString)
    }
  }
}

extension Client.Browser {
  /// Represents Safari 11.x
  open class Safari11: Client.Browser.Safari {
    public required init?(with userAgentString: String) {
      super.init(with:userAgentString)
      guard userAgentString.contains("Version/11.") else { return nil }
    }
  }
}

extension Client {
  /**
    - parameter possibleBrowsers: spcify the list of possible browsers
    - returns: an instance of `Client.Browser`. It is the first instance that can be created using
               `init(with:self)` of each class in `possibleBrowsers`.
              An instance of `Client.Browser.Unknown` will be returned if no instance cannot be
              created with the list.
   
   ## Usage
   
   ```
   let browser = Client.client.browser()
   if browser is Client.Browser.Firefox {
     print("Client uses Firefox.")
   } else if browser is Client.Browser.Safari {
     print("Client uses Safari.")
   }
   ```
   
    */
  public func browser(with possibleBrowsers:[Client.Browser.Type] = [
    Client.Browser.Chrome.self,
    Client.Browser.Edge.self,
    Client.Browser.Firefox.self,
    Client.Browser.InternetExplorer.self,
    Client.Browser.Opera.self,
    Client.Browser.Safari11.self,
    Client.Browser.Safari.self,
  ]) -> Client.Browser {
    guard let _ = self.userAgent else { return Client.Browser.Unknown() }
    for browserClass in possibleBrowsers {
      if let browser = browserClass.init(with:self) { return browser }
    }
    return Client.Browser.Unknown()
  }
}







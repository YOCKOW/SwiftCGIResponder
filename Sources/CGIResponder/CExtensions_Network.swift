/***************************************************************************************************
 CExtensions_Network.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # Network/C
 Extends some structures related to network in C.
 Actual implementations are in each file.
 
 ## structures in C
 +-----------+----------------+------------------+----------------+------------------------+-------------+----------------------------+
 |           |sockaddr        |sockaddr_in       |in_addr         |sockaddr_in6            |in6_addr     |size on general OS          |
 +-----------+----------------+------------------+----------------+------------------------+-------------+----------------------------+
 |__uint8_t  |sa_len          |sin_len           |                |sin6_len                |             |(1 byte; not exist on Linux)|
 |sa_family_t|sa_family       |sin_family        |                |sin6_family             |             |(1 byte)                    |
 |           |char sa_data[14]|in_port_t sin_port|                |sin6_port               |             |(2 bytes)                   |
 |           |                |in_addr sin_addr  |in_addr_t s_addr|__uint32_t sin6_flowinfo|             |(4 bytes)                   |
 |           |                |                  |                |in6_addr sin6_addr      |union s6_addr|(16 bytes)                  |
 |           |                |                  |                |__uint32_t sin6_scope_id|             |(4 bytes)                   |
 +-----------+----------------+------------------+----------------+------------------------+-------------+----------------------------+
 
 Other structures (i.g. `struct sockaddr_un`) are also available on some OS.
 
 ```
 // Darwin
 struct in6_addr {
   union {
     __uint8_t   __u6_addr8[16];
     __uint16_t  __u6_addr16[8];
     __uint32_t  __u6_addr32[4];
   } __u6_addr;
 };
 #define s6_addr __u6_addr.__u6_addr8
 
 // Linux
 struct in6_addr {
   union {
     uint8_t  __u6_addr8[16];
     uint16_t __u6_addr16[8];
     uint32_t __u6_addr32[4];
   } __in6_u;
 }
 #define s6_addr __in6_u.__u6_addr8
 
 // NOTICE
 //// Cannot access `.s6_addr` from Swift on neither macOS and Linux
 ```
 
 There's also a structure named `addrinfo`:
 
 ```
 struct addrinfo {
   int              ai_flags;
   int              ai_family;
   int              ai_socktype;
   int              ai_protocol;
   socklen_t        ai_addrlen;
   struct sockaddr *ai_addr;
   char            *ai_canonname;
   struct addrinfo *ai_next;
 };
 ```
 */

import CoreFoundation
import Foundation

/// Swifty Naming
public typealias CSocketAddressSize  = __uint8_t
public typealias CSocketPort         = in_port_t
public typealias CIPv6FlowIdentifier = __uint32_t
public typealias CIPv6ScopeID        = __uint32_t
public typealias CSocketLength       = socklen_t

public typealias CAddressInfo       = addrinfo
public typealias CSocketAddress     = sockaddr
public typealias CIPv4SocketAddress = sockaddr_in
public typealias CIPv4Address       = in_addr
public typealias CIPv6SocketAddress = sockaddr_in6
public typealias CIPv6Address       = in6_addr
public typealias CUNIXSocketAddress = sockaddr_un

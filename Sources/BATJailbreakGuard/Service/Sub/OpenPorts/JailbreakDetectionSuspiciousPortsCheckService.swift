//
//  JailbreakDetectionOpenPortsCheckService.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//

// MARK: - Implementation

import Foundation

/// Service that detects jailbreaks by checking for suspicious open ports commonly used by jailbreak tools.
///
/// ## Detection Method
/// - Attempts brief TCP connections to known malicious ports on localhost (127.0.0.1) without sending or receiving data.
/// - Immediately closes connections after establishing availability.
///
/// ## Security Notes
/// - Only checks localhost to avoid network traffic
/// - Minimal system impact (connections are immediately closed)
/// - Focuses on ports used by Frida, SSH backdoors, and other jailbreak tools
public final class JailbreakDetectionSuspiciousPortsCheckService: JailbreakDetectionSuspiciousPortsCheckServiceProtocol {
    
    /// Default suspicious ports that are only present on jailbroken devices.
    private var _defaultSuspiciousPorts: [Int] = [
        27042, // Frida server
        22     // SSH daemon
    ]
    
    /// User-added ports
    private var _userAddedPorts: [Int] = []
    
    public init() {}
    
    /// Checks all configured ports for suspicious activity
    ///
    /// - Returns: `true` if any monitored port is open, indicating a possible jailbreak.
    public func isJailbreakDetected() -> Bool {
        let allPorts = self._defaultSuspiciousPorts + self._userAddedPorts
        return checkPorts(allPorts)
    }
    
    /// Adds custom ports to monitor
    ///
    /// - Parameter ports: Array of port numbers to monitor
    public func addSuspiciousPorts(_ ports: [Int]) {
        self._userAddedPorts.append(contentsOf: ports)
    }
    
    /// Clears default suspicious ports
    public func clearSuspiciousPorts() {
        self._defaultSuspiciousPorts.removeAll()
    }
}





private extension JailbreakDetectionSuspiciousPortsCheckService {
        
    private func checkPorts(_ ports: [Int]) -> Bool {
        
        for port in ports {
            
            if isPortOpen(port: Int32(port)) {
                return true
            }
        }
        
        return false
    }
       
    private func isPortOpen(port: Int32) -> Bool {
        
        let sock = socket(AF_INET, SOCK_STREAM, 0)
        
        guard sock >= 0 else { return false }
        
        defer { close(sock) }
        
        var addr = sockaddr_in()
        addr.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        addr.sin_family = sa_family_t(AF_INET)
        addr.sin_port = in_port_t(port).bigEndian
        addr.sin_addr.s_addr = inet_addr("127.0.0.1")
        
        let result = withUnsafePointer(to: &addr) { ptr -> Int32 in
            ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                connect(sock, $0, socklen_t(MemoryLayout<sockaddr_in>.size))
            }
        }
        
        return result == 0
    }
}

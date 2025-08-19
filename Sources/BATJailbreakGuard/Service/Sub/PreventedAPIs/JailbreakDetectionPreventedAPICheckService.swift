//
//  JailbreakDetectionPreventedAPICheckService.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//


// MARK: - Implementation

import Foundation

/// Service that detects jailbreaks by checking for restricted system APIs.
///
/// ## Detection Method
/// - Uses symbol lookup (`dlsym`) to detect potentially dangerous APIs without calling them:
///     - Shell execution: `system`
///     - Process spawning: `posix_spawn`
///     - Dynamic code injection: `dlopen`, `dlsym`
///
/// - Safe for App Store: does not execute any restricted APIs.
/// - Works best combined with other checks (file paths, environment variables, symlinks).
public final class JailbreakDetectionPreventedAPICheckService: JailbreakDetectionPreventedAPICheckServiceProtocol {

    public init() {}
    
    /// Performs API availability checks to detect jailbreak.
    ///
    /// - Returns: `true` if any restricted API is unexpectedly available, indicating a likely jailbreak.
    public func isJailbreakDetected() -> Bool {
        return isSystemPossible() ||
               isPosixSpawnPossible() ||
               isDyldInjectable()
    }
    
    /// Checks if shell execution API (`system`) is available.
    ///
    /// - Returns: `true` if `system` symbol exists in process memory.
    public func isSystemPossible() -> Bool {
        return _symbolCheck("system")
    }
    
    /// Checks if process spawning API (`posix_spawn`) is available.
    ///
    /// - Returns: `true` if `posix_spawn` symbol exists in process memory.
    public func isPosixSpawnPossible() -> Bool {
        return _symbolCheck("posix_spawn")
    }
    
    /// Checks for dynamic code injection capabilities (`dlopen`, `dlsym`).
    ///
    /// - Returns: `true` if either dynamic library loading or symbol resolution is possible.
    public func isDyldInjectable() -> Bool {
        return _symbolCheck("dlopen") || _symbolCheck("dlsym")
    }
}

private extension JailbreakDetectionPreventedAPICheckService {
    
    /// Core symbol lookup function
    ///
    /// - Parameter name: Symbol name to check.
    /// - Returns: `true` if the symbol exists in the current process (possible jailbreak)
    private func _symbolCheck(_ name: String) -> Bool {
        return dlsym(.init(bitPattern: -2), name) != nil
    }
}

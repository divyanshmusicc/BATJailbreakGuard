//
//  JailbreakDetectionService.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//


/// Main service class that performs jailbreak detection by delegating
/// the check to an injected service conforming to `JailbreakDetectionServiceProtocol`.
///
/// This class acts as a facade to abstract different jailbreak detection implementations.
///
/// Usage:
/// ```swift
/// let service = JailbreakDetectionService(service: YourConcreteDetectionService())
/// let detected = service.isJailbreakDetected()
/// ```
public final class JailbreakDetectionService {
    
    /// The injected jailbreak detection service that performs the actual detection logic.
    private let _service: JailbreakDetectionServiceProtocol
    
    /// Initializes the main jailbreak detection service with a concrete service conforming to `JailbreakDetectionServiceProtocol`.
    ///
    /// - Parameter service: A concrete instance of a jailbreak detection service.
    init(service: JailbreakDetectionServiceProtocol) {
        self._service = service
    }
    
    /// Checks whether the device is jailbroken by calling the injected service.
    ///
    /// - Returns: `true` if jailbreak is detected; otherwise, `false`.
    public func isJailbreakDetected() -> Bool {
        return self._service.isJailbreakDetected()
    }
    
}

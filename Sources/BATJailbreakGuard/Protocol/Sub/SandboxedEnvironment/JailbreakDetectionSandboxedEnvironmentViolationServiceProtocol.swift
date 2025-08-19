//
//  JailbreakDetectionSandboxedEnvironmentViolationServiceProtocol.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//



/// Protocol for detecting jailbreak via sandbox violation by attempting to write outside the app sandbox.
///
/// Services conforming to this protocol detect jailbreak by checking whether the application
/// can write files outside its sandbox. Successful writes outside the sandbox indicate
/// a compromised device.
public protocol JailbreakDetectionSandboxedEnvironmentViolationServiceProtocol: JailbreakDetectionServiceProtocol {
    
    /// Sets the file path to use for the sandbox violation write test.
    ///
    /// - Parameter path: A file path outside the sandbox to test write permission.
    func changeTestPath(_ path: String) -> Void
}

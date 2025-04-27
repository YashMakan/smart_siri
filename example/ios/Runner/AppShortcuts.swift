//
//  AppShortcuts.swift
//  Runner
//
//  Created by Yash Makan on 24/04/25.
//

import AppIntents

@available(iOS 16, *)
struct AppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        return [
            AppShortcut(
                intent: ChatIntent(),
                phrases: [
                    "Hey \(.applicationName)",
                    "Hi \(.applicationName)",
                    "Hey \(.applicationName) can you help me",
                ]
            ),
        ]
    }
}

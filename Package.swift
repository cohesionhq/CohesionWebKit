// swift-tools-version: 6.2
// SPDX-License-Identifier: MIT

import PackageDescription

let package = Package(
    name: "CohesionWebKit",
    platforms: [.macOS("27.0"), .iOS("27.0")],
    products: [
        .library(name: "CohesionWebKit", targets: ["CohesionWebKit"]),
    ],
    targets: [
        .target(
            name: "CohesionWebKit",
            swiftSettings: [
                // As the apps build: main actor by default, approachable concurrency.
                .defaultIsolation(MainActor.self),
                .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
                .enableUpcomingFeature("InferIsolatedConformances"),
            ]
        ),
    ]
)

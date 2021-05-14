// swift-tools-version:5.3

import PackageDescription

let package = Package(name: "KatexUtils",
                      platforms: [
                        .iOS(.v13)
                      ],
                      products: [
                        .library(name: "KatexUtils",
                                 targets: ["KatexUtils"])
                      ],
                      targets: [
                        .target(name: "KatexUtils",
                                path: "KatexUtils",
                                resources: [.copy("Assets")])
                      ])

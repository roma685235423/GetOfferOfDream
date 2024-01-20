import ProjectDescription

let target = Target(
    name: "getOfferOfDream",
    platform: .iOS,
    product: .app,
    bundleId: "roman.boiko.getOfferOfDream",
    deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
    infoPlist: "getOfferOfDream/Info.plist",
    sources: ["getOfferOfDream/Sources/**"],
    resources: [
        "getOfferOfDream/Resources/**"
    ],
    dependencies: [
        .project(target: "GetOfferCore", path: "GetOfferCore"),
        .project(target: "GetOfferDI", path: "GetOfferDI"),
        .project(target: "GetOfferNetwork", path: "GetOfferNetwork"),
        .project(target: "GetOfferUI", path: "GetOfferUI")
    ]
)

let project = Project(
    name: "getOfferOfDream",
    targets: [target]
)

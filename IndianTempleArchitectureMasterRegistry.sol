// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract IndianTempleArchitectureMasterRegistry {

    struct TempleStyle {
        string region;
        string schoolOrDynasty;
        string styleName;
        string materials;
        string planAndElevation;
        string iconography;
        string uniqueness;
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct StyleInput {
        string region;
        string schoolOrDynasty;
        string styleName;
        string materials;
        string planAndElevation;
        string iconography;
        string uniqueness;
    }

    TempleStyle[] public styles;

    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event StyleRecorded(
        uint256 indexed id,
        string styleName,
        string schoolOrDynasty,
        address indexed creator
    );

    event StyleVoted(
        uint256 indexed id,
        bool like,
        uint256 likes,
        uint256 dislikes
    );

    constructor() {
        styles.push(
            TempleStyle({
                region: "India",
                schoolOrDynasty: "ExampleSchool",
                styleName: "Example Style (replace with real entries)",
                materials: "example materials",
                planAndElevation: "example plan and elevation",
                iconography: "example iconography",
                uniqueness: "example uniqueness",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordStyle(StyleInput calldata s) external {
        styles.push(
            TempleStyle({
                region: s.region,
                schoolOrDynasty: s.schoolOrDynasty,
                styleName: s.styleName,
                materials: s.materials,
                planAndElevation: s.planAndElevation,
                iconography: s.iconography,
                uniqueness: s.uniqueness,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit StyleRecorded(
            styles.length - 1,
            s.styleName,
            s.schoolOrDynasty,
            msg.sender
        );
    }

    function voteStyle(uint256 id, bool like) external {
        require(id < styles.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;

        TempleStyle storage t = styles[id];

        if (like) {
            t.likes += 1;
        } else {
            t.dislikes += 1;
        }

        emit StyleVoted(id, like, t.likes, t.dislikes);
    }

    function totalStyles() external view returns (uint256) {
        return styles.length;
    }
}

const core = require('@actions/core');
const fs = require('fs');

// Function to check if the input string is a valid SemVer
function isValidSemver(version) {
    return /^[0-9]+\.[0-9]+\.[0-9]+$/.test(version);
}

async function run() {
    try {
        const input = core.getInput('version');
        const incrementBy = core.getInput('increment_by');
        let currentSemver = "1.0.0"; // Default version

        if (fs.existsSync(input)) {
            // If the input is a file path
            const fileContent = fs.readFileSync(input, 'utf8');

            if (isValidSemver(fileContent)) {
                console.log(`The content of the file is a valid Semantic Version: ${fileContent}`);
                currentSemver = fileContent;
            } else {
                throw new Error("File content is not a valid Semantic Version.");
            }
        } else if (isValidSemver(input)) {
            // If the input is a valid SemVer string
            console.log(`The provided string is a valid Semantic Version: ${input}`);
            currentSemver = input;
        } else {
            // If the input is neither a valid file nor a valid SemVer string
            throw new Error("Input is not a valid Semantic Version.");
        }

        // Setting the output
        core.setOutput("current_version", currentSemver);
        core.setOutput("new_version", currentSemver);
    } catch (error) {
        core.setFailed(error.message);
    }
}
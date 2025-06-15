// ...existing code...
import fs from 'fs';
import readline from 'readline';
import fetch from 'node-fetch';
// ...existing code...

async function getLeetCodeInfo(title) {
    const prompt = `Given the LeetCode problem title or partial title: '${title}', return the correct problem number and full title in the format: '00001 Two Sum'. Only output the formatted string.`;
    const url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=' + GEMINI_API_KEY;
    const body = {
        contents: [{ parts: [{ text: prompt }] }]
    };
    const res = await fetch(url, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body)
    });
    const data = await res.json();
    if (
        data &&
        data.candidates &&
        data.candidates[0] &&
        data.candidates[0].content &&
        data.candidates[0].content.parts &&
        data.candidates[0].content.parts[0] &&
        data.candidates[0].content.parts[0].text
    ) {
        return data.candidates[0].content.parts[0].text.trim();
    }
    return null;
}

function getDirs() {
    return fs.readdirSync('.').filter(
        d =>
            fs.statSync(d).isDirectory() &&
            d !== 'node_modules' &&
            d !== '.dist'
    );
}

function extractTitle(folder) {
    return folder.replace(/^\d+\s*/, '').replace(/_/g, ' ').trim();
}

function askYesNo(question) {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });
    return new Promise(resolve => {
        rl.question(question, answer => {
            rl.close();
            resolve(answer.trim().toLowerCase() === 'y');
        });
    });
}

(async () => {
    const dirs = getDirs();
    const renamePairs = [];
    for (const folder of dirs) {
        const title = extractTitle(folder);
        try {
            const correctName = await getLeetCodeInfo(title);
            if (!correctName || correctName === folder) continue;
            renamePairs.push({ from: folder, to: correctName });
        } catch (e) {
            console.log(`Error processing ${folder}: ${e}`);
        }
    }

    if (renamePairs.length === 0) {
        console.log('No folders to rename.');
        return;
    }

    console.log('\nPlanned renames:');
    renamePairs.forEach(pair => {
        console.log(`"${pair.from}" -> "${pair.to}"`);
    });

    const proceed = await askYesNo('\nProceed with renaming? (y/n): ');
    if (!proceed) {
        console.log('Aborted.');
        return;
    }

    for (const pair of renamePairs) {
        try {
            fs.renameSync(pair.from, pair.to);
            console.log(`Renamed: "${pair.from}" -> "${pair.to}"`);
        } catch (e) {
            console.log(`Failed to rename "${pair.from}": ${e}`);
        }
    }
})();
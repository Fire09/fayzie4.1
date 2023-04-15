//////////////////////////////////////////
//           Discord Whitelist          //
//////////////////////////////////////////

/// Config Area ///

var guild = "947662586164420619";
var botToken = "OTk3MTU5ODA5OTY5MjkxMzQ1.GwcfBT.4XoQNLVF4jjYKbFE2ZElcX9AyDvzthEpP-a6Hw";

var whitelistRoles = [ // Roles by ID that are whitelisted.
    "956679918593396756"
]

var blacklistRoles = [ // Roles by Id that are blacklisted.
    ""
]

var notWhitelistedMessage = "Not In Discord | Join Discord Now To Play | https://discord.gg/Faye"
var noGuildMessage = "Discord Not Detected. Make sure your discord is on and you are in the Faye discord | discord.gg/Faye."
var blacklistMessage = "You're blacklisted from this server."
var debugMode = true

/// Code ///
const axios = require('axios').default;
axios.defaults.baseURL = 'https://discord.com/api/v8';
axios.defaults.headers = {
    'Content-Type': 'application/json',
    Authorization: `Bot ${botToken}`
};
function getUserDiscord(source) {
    if(typeof source === 'string') return source;
    if(!GetPlayerName(source)) return false;
    for(let index = 0; index <= GetNumPlayerIdentifiers(source); index ++) {
        if (GetPlayerIdentifier(source, index).indexOf('discord:') !== -1) return GetPlayerIdentifier(source, index).replace('discord:', '');
    }
    return false;
}
on('playerConnecting', (name, setKickReason, deferrals) => {
    let src = global.source;
    deferrals.defer();
    var userId = getUserDiscord(src);

    setTimeout(() => {
        deferrals.update(`Hello ${name}. Your Discord ID is being checked with our whitelist.`)
        setTimeout(async function() {
            if(userId) {
                axios(`/guilds/${guild}/members/${userId}`).then((resDis) => {
                    if(!resDis.data) {
                        if(debugMode) console.log(`'${name}' with ID '${userId}' cannot be found in the assigned guild and was not granted access.`);
                        return deferrals.done(noGuildMessage);
                    }
                    const hasRole = typeof whitelistRoles === 'string' ? resDis.data.roles.includes(whitelistRoles) : resDis.data.roles.some((cRole, i) => resDis.data.roles.includes(whitelistRoles[i]));
                    const hasBlackRole = typeof blacklistRoles === 'string' ? resDis.data.roles.includes(blacklistRoles) : resDis.data.roles.some((cRole, i) => resDis.data.roles.includes(blacklistRoles[i]));
                    if(hasBlackRole) {
                        if(debugMode) console.log(`'${name}' with ID '${userId}' is blacklisted to join this server.`);
                        return deferrals.done(blacklistMessage);
                    }
                    if(hasRole) {
                        if(debugMode) console.log(`'${name}' with ID '${userId}' was granted access and passed the whitelist.`);
                        return deferrals.done();
                    } else {
                        if(debugMode) console.log(`'${name}' with ID '${userId}' is not whitelisted to join this server.`);
                        return deferrals.done(notWhitelistedMessage);
                    }
                }).catch((err) => {
                    if(debugMode) console.log(`^1There was an issue with the Discord API request. Is the guild ID & bot token correct?^7`);
                });
            } else {
                if(debugMode) console.log(`'${name}' was not granted access as a Discord identifier could not be found.`);
                return deferrals.done(`Discord was not detected. Please make sure Discord is running and installed. See the below link for a debugging process - https://docs.faxes.zone/c/fivem/debugging-discord`);
            }
        }, 0)
    }, 0)
})
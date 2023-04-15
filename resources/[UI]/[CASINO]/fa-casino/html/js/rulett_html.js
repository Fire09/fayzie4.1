const roulettePanel = new Vue({
    el: "#roulettePanel",
    data: {
        opened: false,

        currentChips: 0,
        betAmount: 0,
        gameInfo: {
            header: null,
            text: null
        }
    },
    methods: {
        formatMoney: function (n, c, d, t) {
            var c = isNaN((c = Math.abs(c))) ? 2 : c,
                d = d == undefined ? "." : d,
                t = t == undefined ? "," : t,
                s = n < 0 ? "-" : "",
                i = String(parseInt((n = Math.abs(Number(n) || 0).toFixed(c)))),
                j = (j = i.length) > 3 ? j % 3 : 0;
            return (
                s +
                (j ? i.substr(0, j) + t : "") +
                i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) +
                (c ?
                    d +
                    Math.abs(n - i)
                        .toFixed(c)
                        .slice(2) :
                    "")
            );
        }
    }
});

const self = roulettePanel;

window.addEventListener('message', (event) => {
    if (event.data.action == 'show') {
        console.log("showing nui");
        self.opened = event.data.state;
    }
    else if (event.data.action == 'setCurrentChips') {
        console.log("setting chips");
        self.currentChips = event.data.amount;
    }
    else if(event.data.action == 'setBetAmount') {
        console.log("seeting bet amount");
        self.betAmount = event.data.amount;
    }
    else if(event.data.action == 'setGameInfo') {
        console.log("set game info");
        self.gameInfo.header = event.data.header;
        self.gameInfo.text = event.data.text;
    }
});
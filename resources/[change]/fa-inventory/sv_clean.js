const stolenGoods = [];
let stolenGoodsString;

function generateStolenGoods() {
    for (const key in itemList) {
        let item = itemList[key];
        if (item.isStolen) {
            stolenGoods.push(key);
        } else if (key == 'oxy') {
            stolenGoods.push(key);
        }
    }
    stolenGoodsString = stolenGoods.map(s => `'${s}'`).join(',');
}

generateStolenGoods();

setInterval(() => {
    exports["oxmysql"].execute(`DELETE FROM inventory WHERE name = 'Stolen-Goods-1' and item_id NOT IN (${stolenGoodsString})`);
}, 10 * 60 * 1000);

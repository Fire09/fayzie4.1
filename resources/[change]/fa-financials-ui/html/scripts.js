// Credit to Kanersps @ llrp-mode and Eraknelo @FiveM
function addGaps(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + '<span style="margin-left: 3px; margin-right: 3px;"/>' + '$2');
    }
    return x1 + x2;
}



$(document).ready(function() {
    window.addEventListener('message', function(event) {
      var item = event.data;
      var balanceElement = $('.balance');
      var cashElement = $('.cash');
      var transactionElement = $('.transaction');
      var cashTransactionElement = $('.cashtransaction');
  
      switch (item.action) {
        case 'updateBalance':
          balanceElement.hide();
          if (item.show !== false) {
            balanceElement.show();
          }
          balanceElement.html(`<p id="balance"><img id="icon" src="bank-icon.png" alt=""/>${addGaps(item.balance)}</p>`);
          if (item.show !== false) {
            setTimeout(function() {
              balanceElement.fadeOut(600);
            }, 4000);
          }
          break;
        case 'viewBalance':
        case 'viewCash':
          balanceElement.show();
          cashElement.show();
          setTimeout(function() {
            balanceElement.fadeOut(600);
            cashElement.fadeOut(600);
          }, 8000);
          break;
        case 'updateCash':
          $(".cashrightnow").html(`Cash: $${item.cash}`);
          cashElement.hide();
          if (item.show !== false) {
            cashElement.show();
          }
          cashElement.html(`<p id="cash"><span class="green"> $ </span>${addGaps(item.cash)}</p>`);
          if (item.show !== false) {
            setTimeout(function() {
              cashElement.fadeOut(600);
            }, 4000);
          }
          break;
        case 'addBalance':
          transactionElement.show();
          var element = $(`<p id="add-balance"><span class="pre">+</span><span class="green"> $ </span>${addGaps(item.amount)}</p>`);
          transactionElement.append(element);
          setTimeout(function() {
            $(element).fadeOut(600, function() { $(this).remove(); });
          }, 2000);
          break;
        case 'removeBalance':
          transactionElement.show();
          var element = $(`<p id="add-balance"><span class="pre">-</span><span class="red"> $ </span>${addGaps(item.amount)}</p>`);
          transactionElement.append(element);
          setTimeout(function() {
            $(element).fadeOut(600, function() { $(this).remove(); });
          }, 2000);
          break;
        case 'addCash':
          cashTransactionElement.show();
          var element = $(`<p id="add-balance"><span class="pre">+</span><span class="green"> $ </span>${addGaps(item.amount)}</p>`);
          cashTransactionElement.append(element);
          setTimeout(function() {
            $(element).fadeOut(600, function() { $(this).remove(); });
          }, 2000);
          break;
        case 'removeCash':
        cashTransactionElement.show();
        var element = $(`<p id="add-balance"><span class="pre">-</span><span class="red"> $ </span>${addGaps(item.amount)}</p>`);
        cashTransactionElement.append(element);
        setTimeout(function() {
          $(element).fadeOut(600, function() { $(this).remove(); });
        }, 2000);
        break;
      case 'showNotification':
        $.notify(item.text, {
          style: 'cashNotify',
          className: item.class,
          position: 'top center'
        });
        break;
    }
  });
});
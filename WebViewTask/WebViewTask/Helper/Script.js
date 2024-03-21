
function changeRandomColor() {
    var element = document.querySelector('.main-title');
    var elementSummary = document.querySelector('.summary');
    var elementTitle = document.querySelector('.item-name');
    
/*    var randomColor = '#' + Math.floor(Math.random()*16777215).toString(16);*/

    element.style.color = '#' + Math.floor(Math.random()*16777215).toString(16);
    elementSummary.style.color = '#' + Math.floor(Math.random()*16777215).toString(16);
    elementTitle.style.color = '#' + Math.floor(Math.random()*16777215).toString(16);
}

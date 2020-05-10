$(function () {
    var visitedList = $('[name = visited]').val()
                      .replace('[', '')
                      .replace(']', '')
                      .replace(/ /g, '')
                      .split(',');
    $.each(visitedList, function (index, value) {
        $('#game-table' + value).addClass('visited');
    })


    $('.match-table').click(function () {
        window.location = $(this).data("link");
    })
})


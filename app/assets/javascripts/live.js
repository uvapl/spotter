var complete = function() {
    // find the col and row for this appointment
    var col = this.parentElement.parentElement
    var row = col.parentElement

    // find the id
    var appointment = col.dataset.appointment

    // send request to mark the appointment complete
    var xhttp = new XMLHttpRequest();
    xhttp.open('POST', '/appointments/' + appointment + '/complete');
    xhttp.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content)
    xhttp.send();

    // remove the appointment from the screen
    if (row.children.length < 4) {
        row.addEventListener('transitionend', () => row.remove());
        row.style.opacity = '0'
    } else {
        col.addEventListener('transitionend', () => col.remove());
        col.style.opacity = '0'
    }
};

window.onload = function() {
    var buttons = document.getElementsByClassName("card-x");

    for (var i = 0; i < buttons.length; i++) {
        buttons[i].addEventListener('click', complete, false);
    }

    window.setInterval('window.location.reload()', 600000); 	
}
$('#btn-add').click(createEvent);


function createEvent()
{
    // initialize dictionary 
    var eventInfo = {};
    var appointments = [];
    //goes through form data and inserts data into dictionary
    $.each($('#newEvent').serializeArray(), function() {
        if(this.name.startsWith("appointment"))
        {
            appointments.push(this.value);
            return;
        }
        eventInfo[this.name] = this.value;

    });
    eventInfo["appointment"] = appointments;
    //adds new event to database and creates li element
    $.ajax({
        type: "GET",
        url: "./serviceHandler.php",
        cache: false,
        data: {method: "createEvent", param: eventInfo},
        dataType: "json",
        success: function (response) {
            var $li = document.createElement("li");
            $li.addEventListener("click", function() { getEventDetails(response['id'], response) })
            $li.innerHTML += response["eventName"];
            $('ul').append($li); 
        },
        error: function(e) {
            console.log(e);
        } 
    });
}
function vote()
{
    $.ajax({
        type: "GET",
        url: "../serviceHandler.php",
        cache: false,
        data: {method: "addVote", param: formValues},
        dataType: "json",
        success: function () {

        },
        error: function(e) {
            console.log(e);
        }
        
    });
}
function getEvents()
{
    //gets events from backend as json and creates for each object an li element
    $.ajax({
        type: "GET",
        url: "./serviceHandler.php",
        cache: false,
        data: {method: "getEvents", param: 0},
        dataType: "json",
        success: function (data) {
            console.log(data);
            $.each(data, function(i, item) {
                var $li = document.createElement("li");
                $li.addEventListener("click", function() { getEventDetails(data[i]['id']) })
                $li.innerHTML += data[i]["eventName"];
                $('ul').append($li);
            });
        }
    });
}
function getEventDetails(eventId)
{
    console.log(eventId);
    //checks if div with event details is hidden
    if($('#eventDetails').css('display') == 'none'){
        //gets event details with matching eventId
        $.ajax({
            type: "GET",
            url: "./serviceHandler.php",
            cache: false,
            data: {method: "getEventDetails", param: eventId},
            dataType: "json",
            success: function (data) {
                console.log(data);
                //creates tr element with columns for each appointment
                $.each(data["appointments"], function(i, item) {
                    var tr = document.createElement("tr");
                    $.each([ data["eventName"], data["creator"], data["dueDate"], data["place"]], function() {
                        var td = document.createElement("td");
                        td.innerHTML = this;
                        tr.append(td);
                    });
                    var td = document.createElement("td");
                    td.innerHTML = item["date"];
                    tr.append(td);
                    var cb = document.createElement("input");
                    cb.type = "checkbox";
                    tr.append(cb);
                    $('#selectedEvent').append(tr);
                });
            }
        });
        //makes div visible
        $('#eventDetails').show();
    }
    //details already shown -> hide and clear table body
    else{
        $('#eventDetails').hide();
        $('#selectedEvent').html("");
    }
}
//checks if addTable div is visible
function showAppointmentDiv()
{
    //hidden -> show
    if($('#addTable').css('display') == 'none'){
        $('#addTable').slideDown(500);
    }
    //visible -> hide
    else{
        $('#addTable').slideUp(500);
    }
}

var appointments = 0;
//adds label and input for multiple appointments
function addAppointment()
{
    appointments++;
    var label = document.createElement("label");
    var input = document.createElement("input");
    input.type = "datetime-local";
    input.name = "appointment" + appointments;
    label.append(document.createTextNode("Option " + appointments));
    label.append(input);

    $(label).insertBefore("#btn-add-appointment");
    $("<br>").insertBefore("#btn-add-appointment");
}

$("#btn-add-appointment").click(()=>{addAppointment()});

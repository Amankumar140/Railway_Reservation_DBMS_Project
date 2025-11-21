const API = "http://localhost:5000/api";

/***********************/
/*  TRAIN AVAILABILITY */
/***********************/
function loadTrains() {
    fetch(API + "/trains")
        .then(res => res.json())
        .then(data => {
            document.getElementById("trainOutput").textContent =
                JSON.stringify(data, null, 2);
        })
        .catch(err => alert("Error loading trains"));
}

/*****************/
/* SEARCH TRAIN  */
/*****************/
function searchTrain() {
    let source = document.getElementById("searchSource").value.trim();
    let destination = document.getElementById("searchDestination").value.trim();

    fetch(API + "/trains")
        .then(res => res.json())
        .then(data => {
            let filtered = data.filter(
                t => t.source.toLowerCase() === source.toLowerCase() &&
                     t.destination.toLowerCase() === destination.toLowerCase()
            );

            document.getElementById("searchOutput").textContent =
                JSON.stringify(filtered, null, 2);
        });
}

/*****************/
/* BOOK TICKET   */
/*****************/
function bookTicket() {
    const data = {
        passenger_id: document.getElementById("pid").value,
        schedule_id: document.getElementById("sid").value,
        seat_no: document.getElementById("seat").value,
        coach: document.getElementById("coach").value,
        class_type: document.getElementById("cls").value,
        amount: document.getElementById("amt").value,
    };

    fetch(API + "/book", {
        method: "POST",
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify(data)
    })
        .then(res => res.json())
        .then(result => {
            alert("🎉 Ticket Booked Successfully!");
        })
        .catch(() => alert("Error: Booking Failed"));
}

/*****************/
/* CANCEL TICKET */
/*****************/
function cancelTicket() {
    let id = document.getElementById("cancelId").value;

    fetch(API + "/cancel/" + id, { method: "PUT" })
        .then(res => res.json())
        .then(() => alert("❌ Ticket Cancelled"))
        .catch(() => alert("Error cancelling ticket"));
}

/***********************/
/* BOOKING SUMMARY     */
/***********************/
function loadSummary() {
    fetch(API + "/summary")
        .then(res => res.json())
        .then(data => {
            document.getElementById("summaryOutput").textContent =
                JSON.stringify(data, null, 2);
        });
}

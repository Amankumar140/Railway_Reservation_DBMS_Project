const express = require("express");
const cors = require("cors");
const path = require("path");
const db = require("./db");

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, "../public")));

// --------------------- ROUTES ---------------------

// Get Train Availability View
app.get("/api/trains", (req, res) => {
    db.query("SELECT * FROM TrainAvailability", (err, results) => {
        if (err) return res.status(500).json({ error: err });
        res.json(results);
    });
});

// Booking Summary View
app.get("/api/summary", (req, res) => {
    db.query("SELECT * FROM BookingSummary", (err, results) => {
        if (err) return res.status(500).json({ error: err });
        res.json(results);
    });
});

// Book Ticket (Stored Procedure)
app.post("/api/book", (req, res) => {
    const { passenger_id, schedule_id, seat_no, coach, class_type, amount } = req.body;

    db.query(
        "CALL BookTicket(?, ?, ?, ?, ?, ?)",
        [passenger_id, schedule_id, seat_no, coach, class_type, amount],
        (err, result) => {
            if (err) return res.status(500).json({ error: err });
            res.json({ message: "Ticket Booked Successfully", result });
        }
    );
});

// --------------------------------------------------
// CANCEL TICKET
app.put("/api/cancel/:id", (req, res) => {
    const id = req.params.id;

    db.query(
        "UPDATE Booking SET booking_status='CANCELLED' WHERE booking_id=?",
        [id],
        (err) => {
            if (err) return res.json({ error: err });
            res.json({ message: "Ticket Cancelled" });
        }
    );
});


const PORT = 5000;
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});

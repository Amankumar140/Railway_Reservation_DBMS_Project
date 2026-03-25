# 🚆 Railway Reservation System — DBMS Mini Project

A complete **Railway Reservation System** built using Node.js, Express.js, and Vanilla JavaScript/HTML/CSS on the frontend. It operates on a robust **MySQL** database (hosted on Aiven Cloud) that leverages advanced DBMS concepts like views, stored procedures, and triggers.

---

## 📌 Key Features

*   **Train Availability:** View complete schedules, available seats, and journey details using a SQL `View`.
*   **Search Trains:** Filter trains efficiently by specifying the source and destination stations.
*   **Book Ticket:** Utilizes a highly optimized Stored Procedure `BookTicket()` to seamlessly manage bookings across multiple relational tables (`Booking`, `BookingDetails`, `Payment`), ensuring data integrity.
*   **Cancel Ticket:** Uses smart SQL Triggers to update booking status to `CANCELLED` and automatically restore available seat counts.
*   **Booking Summary:** Comprehensive summary generated securely and quickly via SQL `View`.

---

## 🛠️ Technology Stack

*   **Database:** MySQL (Aiven Cloud Database)
*   **Backend:** Node.js, Express.js
*   **Frontend:** HTML5, CSS3, Vanilla JavaScript

---

## 🗄️ Database Structure

The project incorporates **6 relational tables**:
1.  `Train` (Basic train details)
2.  `Schedule` (Timings and dates)
3.  `SeatAvailability` (Class-wise seat tracking)
4.  `Passenger` (User records)
5.  `Booking` & `BookingDetails` (Ticketing and transactions)
6.  `Payment` (Payment ledger)

It heavily relies on database Views (`TrainAvailability`, `BookingSummary`), Stored Procedures (`BookTicket`), and Triggers for complex constraint handling.

---

## 🚀 Setup & Installation Instructions

**1. Clone the repository:**
```bash
git clone <your-repo-url>
cd Railway_Reservation_DBMS_Project
```

**2. Setup the Database:**
*   Create a MySQL Database.
*   Execute the `Aiven Railway.session.sql` file in your preferred SQL client to create the schema, tables, views, triggers, and stored procedures.

**3. Configure Backend Credentials:**
*   Navigate to the `backend` folder.
*   Copy `eample.db.js` to `db.js`.
*   Update `db.js` with your active MySQL cloud or local credentials.

**4. Install Dependencies & Run Backend:**
```bash
cd backend
npm install
node server.js
```
The server will start running on `http://localhost:5000`.

**5. Run the Application:**
*   Open the `public/index.html` file in your web browser.
*   If using VS Code, use the *Live Server* extension to avoid local CORS restrictions.

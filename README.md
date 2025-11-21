# 🚆 Railway Reservation System — DBMS Mini Project

This repository contains a complete **Railway Reservation System** developed using:

- **MySQL (Aiven Cloud Database)**
- **Node.js + Express.js (Backend API)**
- **HTML, CSS, JavaScript (Frontend UI)**

It demonstrates DBMS concepts such as table creation, relationships, SQL joins, views, triggers, stored procedures, and API-based interaction with a cloud-hosted database.

---

## 📌 Features

### 🔹 Train Availability  
Displays trains, schedules, dates, and available seats using SQL View.

### 🔹 Search Train  
Search trains by **source** and **destination**.

### 🔹 Book Ticket  
Uses a stored procedure `BookTicket()` to automatically insert:

- Booking  
- BookingDetails  
- Payment  

### 🔹 Cancel Ticket  
Updates booking status to **CANCELLED** and restores seats using triggers.

### 🔹 Booking Summary  
Shows complete booking information using SQL View.

---

## 🗄️ Database Structure

This project contains **6 relational tables**:


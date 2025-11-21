const mysql = require("mysql2");
const fs = require("fs");

const db = mysql.createPool({
  host: "your string",
  user: "admin",
  password: "your password",
  database: "your database",
  port: 11977,
  ssl: {
      ca: fs.readFileSync(" path to your pem file ")
  },
});

module.exports = db;

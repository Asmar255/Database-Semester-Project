# Food Waste Management System 🍽️📉

An advanced, highly optimized relational database backend engineered for the commercial hospitality sector to track inventory lifecycles, audit high-volume food loss patterns, and streamline surplus food donation logistics to local NGOs.

Developed as a comprehensive **4th-Semester Advanced Database Systems Project** at the University of Central Punjab.

---

## 🚀 Key Features

* **3NF Normalized Database Structure:** An optimized 8-table relational schema engineered to completely eliminate data redundancies and ensure total data integrity.
* **Symmetric Union Joins:** Advanced query architecture utilizing symmetric `LEFT JOIN` and `RIGHT JOIN` structures consolidated through `UNION` blocks to simulate full outer joins for seamless cross-entity data reporting.
* **Restrictive Aggregation Filters:** Integrated administrative reporting leveraging complex `GROUP BY` and `HAVING` clauses to automatically isolate and flag facilities exceeding critical organic waste limits.
* **Encapsulated User-Defined Functions (UDFs):** Parametric, type-safe SQL functions designed to accept singular integer inputs to calculate inline metrics like live transaction counts and cumulative waste.
* **Pre-Compiled Stored Procedures:** Modular, secure transactional routines created to safely manage data lookup, processing, and status toggles while insulating the underlying schema from manual input anomalies.

---

## 🛠️ Tech Stack & Environment

* **Database Engine:** MySQL Server (Managed via **XAMPP Control Panel** service stack)
* **Client Interface / IDE:** MySQL Workbench & Visual Studio 2022
* **Database Driver Port:** `3306` (Localhost network card mapping)

---

## 📊 Relational Schema Architecture

The core data layout consists of 8 strictly correlated entities structured to maintain absolute referential integrity:

1. `Restaurant` — Root facility configuration files.
2. `Staff` — Tracks operational and data logging accountability.
3. `WasteCategory` — Isolates major processing categories (e.g., Bakery, Dairy, Vegetables).
4. `FoodItem` — Granular product inventory registry.
5. `WasteLog` — High-frequency transactional log tracking food loss weights and timelines.
6. `RecipientOrg` — Verified logistical directory for charity/NGO partners.
7. `Donation` — Manages supply-chain handovers from origin logging to successful drop-off status.
8. `WasteReductionGoal` — Sets corporate milestones with active performance target metrics.

---

## ⚙️ Installation & Deployment

To run this backend repository locally on your machine, follow these steps:

### 1. Fire up the Server Engine
1. Download and open the **XAMPP Control Panel**.
2. Click **Start** next to the **MySQL** module (this instantiates the `mysqld.exe` process in your system memory on Port `3306`).

### 2. Establish Client Connection
1. Open **MySQL Workbench**.
2. Create a new connection targeting hostname `127.0.0.1` or `localhost`.

### 3. Build the Database Layout
1. Clone this repository to your local system.
2. Open and run the DDL creation script file inside Workbench to compile the schemas, constraints, functions, and procedures

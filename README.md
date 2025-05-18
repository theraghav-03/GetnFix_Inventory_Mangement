# Auto-Parts Warehouse Inventory Management System

This project is a relational database system designed to streamline inventory management for an auto-parts warehouse. It supports stock tracking, pricing integrity, automated data workflows, and cross-platform data migration. Built using SQL Server and MongoDB, the system provides a scalable and efficient solution for managing complex relationships between vehicle parts, manufacturers, and compatibility data.

## 📌 Project Overview

The system was developed to help a real-world auto-parts business in Winnipeg manage their warehouse inventory. It allows users to:

- Track parts by manufacturer, category, and vehicle compatibility (make, model, year)
- Locate items in the warehouse (aisle and shelf-level detail)
- Maintain data accuracy with validation triggers
- Analyze inventory and generate reports using SQL views and queries

## ⚙️ Key Features

- **Relational Database Design**: Fully normalized schema with clear ER modeling
- **Advanced SQL**: Views, joins, subqueries, stored procedures, user-defined functions, and transactions
- **Triggers**: Automated stock logging and pricing error prevention
- **Performance Optimization**: Indexing and query tuning
- **Automation**: Scheduled backups, CSV imports, and text report generation via SQL Server Agent and batch scripts
- **Data Migration**: Transferred relational data to MongoDB collections for NoSQL integration

## 🧱 Entity-Relationship Overview

The system includes the following key entities and relationships:

- `Parts_Detail`: Stores core part information (ID, name, price, quantity, etc.)
- `Categories`: Categorizes parts (e.g., brakes, spoiler)
- `Parts_Location`: Maps part to specific warehouse aisle and shelf
- `Company`, `Vehicle`: Many-to-many relationships resolved via `Company_Part` and `Parts_Fitment` bridge tables

## 🛠️ Technologies Used

- **SQL Server (T-SQL)**
- **MongoDB**
- **SQL Server Agent**
- **Batch Scripts**
- **ER Modeling Tools (e.g., dbdiagram.io or draw.io)**

## 📈 Use Cases

- Quickly locate auto-parts in a warehouse by vehicle type
- Generate reports on part stock levels, vendors, and compatibility
- Maintain inventory accuracy through automated validations
- Provide a foundation for future integrations (e.g., web-based inventory dashboard)

## 🚀 Getting Started

To test or deploy this system:

1. Clone this repo
2. Import the SQL schema into SQL Server
3. Configure SQL Server Agent for automated tasks
4. Load sample data using CSV import scripts
5. Run migration scripts for MongoDB

## 📂 Folder Structure

├── schema/
│ ├── create_tables.sql
│ ├── insert_sample_data.sql
│ └── triggers_procedures.sql
├── automation/
│ ├── backup_script.bat
│ ├── data_import.bat
│ └── sql_agent_jobs.md
├── migration/
│ └── mongo_migration_script.js
├── docs/
│ └── ER_diagram.png
└── README.md

## 📧 Contact

Developed by Raghav Sharma - (rsharma16@academic.rrc.ca)  
For any questions, feel free to reach out.

---

*Note: This project was built for academic and real-world practice purposes and does not contain any confidential or proprietary data.*


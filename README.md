## ELT Project with Docker, PostgreSQL, and dbt and CRON 

Welcome to the ELT project repository! This project showcases a custom Extract, Load, Transform (ELT) process using Docker, PostgreSQL, and dbt. Below, you'll find details on the repository structure, how it works, and instructions to get started.

### Repository Structure

- **docker-compose.yaml**: This file orchestrates Docker containers for the project. It defines services for the source PostgreSQL database, destination PostgreSQL database, ELT script, and dbt.
  
- **elt_script**: Contains the ELT script and Dockerfile for the ELT service.
  - **Dockerfile**: Sets up a Python environment and installs the PostgreSQL client. It also copies the ELT script into the container.
  - **elt_script.py**: Performs the ELT process, waiting for the source PostgreSQL database to become available, dumping its data to a SQL file, and loading it into the destination PostgreSQL database.
  
- **source_db_init**: Includes the SQL script for initializing the source database with sample data.
  - **init.sql**: Initializes tables for users, films, film categories, actors, and film actors, and inserts sample data.
  
- **custom_postgres**: Contains configurations for the custom PostgreSQL database.

### How It Works

#### Docker Compose
- Using the `docker-compose.yaml` file, Docker containers are spun up for:
  1. Source PostgreSQL database with sample data.
  2. Destination PostgreSQL database.
  3. Python environment to run the ELT script.
  4. dbt for running data transformations.

#### ELT Process
- The `elt_script.py` waits for the source PostgreSQL database to become available.
- Once available, the script uses `pg_dump` to dump the source database to a SQL file.
- It then uses `psql` to load this SQL file into the destination PostgreSQL database.

#### Data Transformation with dbt
- dbt (data build tool) is used for performing data transformations.
- It runs SQL queries against the destination PostgreSQL database to transform the data as per defined models and configurations.

#### CRON Job Implementation
In this branch, a CRON job has been implemented to automate the ELT process. The CRON job is scheduled to run the ELT script at specified intervals, ensuring that the data in the destination PostgreSQL database is regularly updated with the latest data from the source database.

To configure the CRON job:

Currently, the CRON job is setup to run every day at 3am.
You can adjust the time as needed within the Dockerfile found in the elt_script folder.

### Getting Started

1. Ensure you have Docker and Docker Compose installed on your machine.
2. Clone this repository to your local machine.
3. Navigate to the project directory.
4. Run the following command to start the Docker containers:
   ```bash
   docker-compose up
   ```
5. To stop the containers and remove volumes, run:
   ```bash
   docker-compose down -v
   ```

### Connecting to PostgreSQL Database

To connect to the destination PostgreSQL database:

```bash
docker exec -it elt-project-destination_postgres-1 psql -U postgres
```

After connecting to the database, you can use the following commands:
```sql
\c destination_db   -- Connects to the destination database named destination_db
\dt                 -- Lists all tables in the current database
```

### Conclusion

You've successfully set up the ELT project using Docker, PostgreSQL, and dbt.
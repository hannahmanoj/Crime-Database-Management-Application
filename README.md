# 📂 Crime-Database-Management-Application



## Overview

The Crime Database Management Application is a comprehensive system designed to manage and maintain data related to criminal activities, suspects, witnesses, and crime events. This repository contains SQL scripts to create and manage database structures, triggers, and sequences that enforce data integrity and consistency.

The application is suitable for law enforcement agencies or any organization that needs a reliable system to track and analyze crime-related data.

## Repository Contents

### SQL Files

1. Crime.sql

Contains the main schema for managing crime-related data such as events, suspects, witnesses, and associated objects.

2. UKcities.sql

Provides a dataset of cities in the United Kingdom, serving as a reference table for storing location-related data in the database.

3. CrimeApplication.sql

Includes queries and statements for initializing and populating the crime application database.

4. Sequence.sql

Defines sequences used to generate unique IDs for various entities like suspects, witnesses, and crime events.

### Triggers

The repository contains several triggers to maintain data integrity, automate ID generation, and prevent invalid entries. These include:

- TRG_GENERATE_CRIME_EVENT.sql

Automatically generates unique IDs for crime events when new entries are added.

- TRG_GENERATE_CRIME_EVENT_SUSPECT_ID.sql

Ensures unique IDs are created for the relationship between crime events and suspects.

- TRG_GENERATE_OBJECT_ID.sql

Automatically assigns unique IDs to objects associated with a crime event.

- TRG_GENERATE_SUSPECT_ID.sql

Generates unique IDs for suspects added to the database.

- TRG_GENERATE_WITNESS_ID.sql

Ensures each witness in the database is assigned a unique ID.

- trg_prevent_future_crime_event_suspect_dates.sql

Prevents entering suspect-related crime dates that occur in the future.

- trg_prevent_future_event_dates.sql

Ensures that crime events cannot have future-dated occurrences.

- trg_prevent_future_suspect_DOB.sql

Validates that suspect date of birth entries are not set in the future.

- trg_prevent_future_suspect_arrest_dates.sql

Restricts the input of future arrest dates for suspects.

- trg_prevent_future_witness_dob.sql

Verifies that witness date of birth entries are realistic and not future-dated.

- trg_prevent_future_witness_statement_date.sql

Prohibits witness statement dates from being entered as future dates.

## Documentation

README.md

This file provides an overview of the repository and its contents.

## Features

+ Automated ID Management: Use of sequences and triggers ensures unique and consistent ID generation for all entities.

+ Data Validation: Triggers prevent the entry of logically invalid data, such as future dates for events or impossible dates of birth.

+ Comprehensive Schema: Designed to handle multiple aspects of crime management, including events, suspects, witnesses, and objects.

+ Geographical Support: Includes a dataset of UK cities to enhance location tracking and analysis.

## Setup Instructions

* Clone the Repository

git clone https://github.com/yourusername/Crime-Database-Management-Application.git
cd Crime-Database-Management-Application

* Load the SQL Files

Use your preferred database management system (e.g., Oracle, MySQL, PostgreSQL) to execute the SQL files in the following order:

- Crime.sql

- UKcities.sql

- Sequence.sql
  
- crimeapplication.sql

- Remaining trigger files as needed.

## Test the Application

Execute sample queries and validate the functionality of triggers and sequences.

## Usage

- Adding a Crime Event: Insert data into the CrimeEvent table to log new incidents.

- Adding Suspects and Witnesses: Use related tables to associate suspects and witnesses with crime events.

- Preventing Invalid Data: Built-in triggers automatically enforce rules for valid data entry.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes. Ensure that your code adheres to the repository’s standards and includes proper documentation.


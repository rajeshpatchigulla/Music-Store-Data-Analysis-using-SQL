# Music Store Data Analysis using SQL

This project focuses on analyzing a Music Store relational database to extract meaningful insights about customer behavior, music preferences, and revenue trends using SQL.
The dataset simulates the operations of a digital music store, containing transactional data related to customers, invoices, tracks, artists, albums, and music genres. By applying SQL queries and analytical techniques, this project demonstrates how raw data can be transformed into actionable business insights.
The analysis involves exploring relationships between different tables, identifying patterns in customer purchases, and answering key business questions that could support decision-making in a music retail business.

 ## Project Objectives
The main objectives of this project are:
- Analyze customer purchasing behavior
- Identify the most popular music genres
- Determine top-performing artists and tracks
- Explore revenue distribution across cities and countries
- Identify high-value customers
- Demonstrate practical SQL skills for data analysis

## Database Schema
The Music Store database consists of multiple relational tables connected through primary and foreign keys.
| Table       | Description                             |
| ----------- | --------------------------------------- |
| Customers   | Stores customer information             |
| Employees   | Contains employee details               |
| Invoices    | Records customer purchases              |
| InvoiceLine | Stores individual items within invoices |
| Artists     | Contains artist information             |
| Albums      | Album details linked to artists         |
| Tracks      | Individual songs available for purchase |
| Genres      | Categories of music                     |
| MediaType   | Format of tracks                        |

These tables allow for comprehensive analysis by connecting sales transactions with music metadata.

## Tools & Technologies
- SQL
- Relational Database Management
- Data Analysis
- Query Optimization
- Data Exploration

## Business Analysis
The analysis answers several business-focused questions such as:
- Who is the senior-most employee based on job title?
- Which countries generate the highest number of invoices?
- What are the top three highest invoice totals?
- Which city generates the highest revenue?
- Who is the highest spending customer?
- Which customers listen to Rock music?
- Which artists have produced the most Rock tracks?
- Which tracks are longer than the average track length?
- How much does each customer spend on different artists?
- What is the most popular music genre in each country?
- Who is the top customer in each country?
These questions simulate real-world analytics tasks performed by data analysts.

## Key Insights
### Music Preferences
- Rock music is the most popular genre among customers.
- A small number of artists dominate the total number of tracks purchased.
### Geographic Revenue Distribution
- A significant portion of revenue comes from a few countries.
- Certain cities generate considerably higher sales compared to others.
### Customer Spending Patterns
- A small group of high-value customers contributes a large share of total revenue.
- Customer purchases often concentrate around popular artists and genres.
### Artist Performance
- A limited number of artists produce the majority of tracks in the Rock genre.
- Popular artists significantly influence overall sales.
### Sales Trends
- Transactional data reveals strong relationships between music genre popularity and revenue generation.
- Understanding customer preferences can help optimize product offerings and marketing strategies.

Through this project, I developed practical experience in:

- Writing complex SQL queries
- Working with relational databases
- Performing data exploration and analysis
- Extracting business insights from raw transactional data
- Structuring analytical projects for professional portfolios

## Future Improvements
- Possible enhancements for this project include:
- Creating interactive dashboards using Power BI or Tableau
- Performing Exploratory Data Analysis using Python
- Building predictive models for customer purchase behavior
- Developing automated reporting pipelines

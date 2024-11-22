# Portfolio Manager
The Portfolio Manager is a simple application designed to help users manage their stock investments. It allows users to track their holdings in different stocks, view their profits or losses for each stock, and calculate the overall profit or loss for the entire portfolio.

Core Features:

Track Stock Holdings:
The portfolio stores information about each stock in the user's investment portfolio. For each stock, the system tracks:
Stock Name: The name of the stock (e.g., "AAPL", "GOOG").
Quantity: How many shares of the stock the user owns.
Purchase Price: The price at which the stock was purchased (the user's cost basis).
Current Price: The current market price of the stock.
Calculate Profit or Loss for Each Stock:
For each stock in the portfolio, the system calculates the profit or loss:
Profit occurs when the current price is greater than the purchase price.
Loss occurs when the current price is less than the purchase price.

This is calculated as:
Profit or Loss = ( Current Price − Purchase Price) × Quantity
Profit or Loss=(Current Price−Purchase Price)×Quantity
Total Portfolio Profit and Loss:
The portfolio manager can calculate and display the total profit or loss for the entire portfolio by summing up the profit or loss for each individual stock.
User-Friendly Output:
The portfolio manager displays:
A list of each stock with its name, quantity, purchase price, current price, and the profit/loss for that stock.
A total profit/loss for the entire portfolio.

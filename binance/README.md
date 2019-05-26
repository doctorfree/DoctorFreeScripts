Scripts/binance
===============

Scripts to access the Binance API providing command line support for placing buy/sell trade orders, retrieving ticker or average prices for trading pairs, and retrieving open orders for a trading pair.

Setup
-----

    - Create an API Key on binance.com
    - Copy the newly created key and secret
    - Create the file $HOME/.binance with entries in the form:
        KEY="your-newly-created-key"
        SEC="your-newly-generated-secret"

Contents
--------

[**BinanceOrder**](binance/BinanceOrder) - Place buy and sell orders on Binance

[**GetAvgPrice**](binance/GetAvgPrice) - Retrieve the average price for a specified trading pair

[**GetTickerPrice**](binance/GetTickerPrice) - Retrieve the ticker price for a specified trading pair

[**GetTime**](binance/GetTime) - Get the Binance server time

[**TestConn**](binance/TestConn) - Test the Binance API connection


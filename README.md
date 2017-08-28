# Welcome to Exchange

## What does it do?
It gives the end user a rough idea on how a certain currency pair has performed in the near past and eventually helps the user understand when to buy or sell the currency.

## What all is available in this prototype?
1. Create an account with your email.
2. Login and create an exchange combination.
3. View the exchange combination with past data.
4. Edit or delete the exchange combination.

## Where is it?
https://exchangecombinations.herokuapp.com/

## On local
The system makes use of the following environment variables,      
EXCHANGE_DATABASE_USERNAME            
EXCHANGE_DATABASE_PASSWORD          
GMAIL_DOMAIN           
GMAIL_PASSWORD            
GMAIL_USERNAME         
Make sure you fill in the .env file or setup these variables using other means.     
*Note: These variables will be needed for appropriate tasks such as rake db tasks etc.*

```EXCHANGE_DATABASE_USERNAME='your username' EXCHANGE_DATABASE_PASSWORD='your password' rake db:migrate```

Run the server by executing the folowing command,
```foreman start```
## To run specs       

```EXCHANGE_DATABASE_USERNAME='your username' EXCHANGE_DATABASE_PASSWORD='your password' rspec```      

-- isolate (or group) the transactions of each cardholder


-- Count the transactions that are less than $2.00 per cardholder
CREATE VIEW transactions_less_$2 as
SELECT "name", count(*)
FROM "card_holder" as a
JOIN "credit_card" as b on a.id = b.cardholder_id
JOIN "transaction" as c on b.card = c.card
WHERE amount < 2.00
GROUP BY "name"


-- Is there any evidence to suggest that a credit card has been hacked? Explain your rationale

-- What are the top 100 highest transactions made between 7:00 am and 9:00 am?
CREATE VIEW highest_transactions_from_7to9 as
SELECT *
FROM "transaction"
WHERE extract (hour from "date") >= 7 and extract (hour from "date") <= 9
GROUP BY amount desc
limit 100

-- Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?

CREATE VIEW transactions_not_between_7to9 as
SELECT * 
FROM "transaction"
WHERE extract (hour from "date") =< 7 and extract (hour from "date") => 9
GROUP BY amount desc
limit 100


SELECT *  transactions_less_$2
SELECT *  highest_transactions_from_7to9
SELECT *  transactions_not_between_7to9

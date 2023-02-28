% --- [knowledge base] --- %
schedule(canakkale, erzincan, 6).
schedule(erzincan, canakkale, 6).
schedule(erzincan, antalya, 3).
schedule(antalya, erzincan, 3).
schedule(antalya, izmir, 2).
schedule(izmir, antalya, 2).
schedule(antalya, diyarbakir, 4).
schedule(diyarbakir, antalya, 4).
schedule(izmir, istanbul, 2).
schedule(istanbul, izmir, 2).
schedule(izmir, ankara, 6).
schedule(ankara, izmir, 6).
schedule(diyarbakir, ankara, 8).
schedule(ankara, diyarbakir, 8).
schedule(istanbul, ankara, 1).
schedule(ankara, istanbul, 1).
schedule(istanbul, eskisehir, 1).
schedule(eskisehir, istanbul, 1).
schedule(eskisehir, rize, 3).
schedule(rize, eskisehir, 3).
schedule(istanbul, rize, 4).
schedule(rize, istanbul, 4).
schedule(ankara, rize, 5).
schedule(rize, ankara, 5).
schedule(ankara, van, 4).
schedule(van, ankara, 4).
schedule(van, gaziantep, 3).
schedule(gaziantep, van, 3).

% --- [rules] --- %
connection(DEPART, ARRIVE, X) :- 
    calCost(DEPART, ARRIVE, X , []).

calCost(DEPART, ARRIVE, X , _) :- 
    schedule(DEPART, ARRIVE, X).

calCost(DEPART, ARRIVE, X , LIST) :- 
    \+ member(DEPART, LIST), 
    schedule(DEPART, TEMP_CITY, TEMP_COST1), 
    calCost(TEMP_CITY, ARRIVE, TEMP_COST2, [DEPART | LIST]), 
    DEPART \= ARRIVE, 
    X is TEMP_COST1 + TEMP_COST2.
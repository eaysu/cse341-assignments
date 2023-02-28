% --- [knowledge base] --- %
% room(roomID, capacity, equipment).
room(z23, 10, [handicapped, projector]).
room(z10, 8, [handicapped, smartboard]).

% occupancy(roomID, hour, courseID).
occupancy(z23, 8,  progLanguages).
occupancy(z23, 9,  progLanguages).
occupancy(z23, 10, progLanguages).
occupancy(z23, 11, progLanguages).
occupancy(z23, 12, empty).
occupancy(z23, 13, empty).
occupancy(z23, 14, compOrganization).
occupancy(z23, 15, compOrganization).
occupancy(z23, 16, compOrganization).
occupancy(z10, 8,  algDesign).
occupancy(z10, 9,  algDesign).
occupancy(z10, 10, algDesign).
occupancy(z10, 11, empty).
occupancy(z10, 12, empty).
occupancy(z10, 13, softEngineering).
occupancy(z10, 14, softEngineering).
occupancy(z10, 15, empty).
occupancy(z10, 16, empty).

% course(courseID, instructor, capacity, hour, roomID).
course(progLanguages, yakupgenc, 10, 4, z23).
course(compOrganization, alparslanbayrakci, 8, 3, z23).
course(algDesign, didemgozupek, 6, 3, z10).
course(softEngineering, habilkalkan, 8, 2, z10).

% student(studentID, courses, handicapped).
student(duygu,  [progLanguages, algDesign], no).
student(emir,   [compOrganization, softEngineering], no).
student(aylin,  [progLanguages, compOrganization], no).
student(burak,  [compOrganization, algDesign], yes).
student(esra,   [progLanguages, algDesign], no).
student(selin,  [compOrganization, softEngineering], no).
student(cem,    [progLanguages, compOrganization], no).
student(beren,  [compOrganization, algDesign], yes).
student(deniz,  [progLanguages, algDesign], no).
student(berkay, [compOrganization, softEngineering], no).
student(elif,   [progLanguages, compOrganization], yes).
student(yusuf,  [compOrganization, algDesign], no).

% instructor(instructorID, courseID, equipment).
instructor(yakupgenc, progLanguages, projector).
instructor(alparslanbayrakci, compOrganization, projector).
instructor(didemgozupek, algDesign, smartboard).
instructor(habilkalkan, softEngineering, smartboard).

% --- [rules] --- %
% checks if in list
member(X, [Y | T]) :- 
    X = Y; isMember(X, T).

% add element to list
add(X, [], [X]).
add(X, [Y | T], [X, Y | T]) :-
    X @< Y,
    !.
add(X, [Y | T1], [Y | T2]) :-
    add(X, T1, T2).

% --- [query 1] --- %
class(X, Y):-
    occupancy(A, _, X),
    occupancy(B, _, Y),
    A == B.

time(X, Y) :- 
    occupancy(_, A, X),
    occupancy(_, B, Y),
    A == B.

conflict(X, Y) :-
    not((not(class(X, Y)), not(time(X, Y)))).

% --- [query 2] --- %
assign1(ROOM, COURSE) :-
    instructor(_, COURSE, X),
    room(ROOM, A, Y),
    member(X, Y),
    course(COURSE, _, B, _, _),
    A >= B.

% --- [query 3] --- %
assign2(ROOM, X) :-
    join2_f1(ROOM, X);
    join2_f2(ROOM, X).

assign2_f1(ROOM, X) :-
    room(ROOM, _, Y),
    course(X, _, _, _, ROOM),
    instructor(_, X, B),
    member(B, Y).

assign2_f2(ROOM, X) :-
    room(ROOM, _, Y),
    course(X, _, _, _, ROOM),
    instructor(_, X, B),
    member(B, [empty]).

% --- [query 4] --- %
enroll(STUDENT, COURSE) :-
    student(STUDENT, X, _),
    member(COURSE, X).

% --- [query 5] --- %
enroll2(STUDENT, X) :-
    student(STUDENT, X, _).




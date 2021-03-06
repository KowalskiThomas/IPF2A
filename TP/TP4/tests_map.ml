
module StringMap = AVLMap.AVLMap(String)

let test =
  let test = StringMap.add "1" 1 StringMap.empty in
  let test = StringMap.add "2" 2 test in
  let test = StringMap.add "3" 3 test in
  let resultat1 = StringMap.find test "1" in
  let resultat2 = StringMap.find test "2" in
  let resultat3 = StringMap.find test "3" in

  if resultat1 = 1 && resultat2 = 2 && resultat3 = 3 then
    Printf.printf "OK: 1, 2, 3\n"
  else
    Printf.printf "NOK: 1, 2, 3\n"

let test =
  let test = StringMap.add "2" 1 StringMap.empty in
  let test = StringMap.add "1" 2 test in
  let test = StringMap.add "3" 3 test in
  let resultat1 = StringMap.find test "2" in
  let resultat2 = StringMap.find test "1" in
  let resultat3 = StringMap.find test "3" in

  if resultat1 = 1 && resultat2 = 2 && resultat3 = 3 then
    Printf.printf "OK: 2, 1, 3\n"
  else
    Printf.printf "NOK: 2, 1, 3 %d %d %d\n" resultat1 resultat2 resultat3

let test =
  let rec insert x =
    if x = 0 then StringMap.empty
    else StringMap.add (string_of_int x) x (insert (x - 1)) in

  let test = insert 999 in
  let resultat20 = StringMap.find test "20" in

  if resultat20 = 20 then
    Printf.printf "OK: 1 - 999\n"
  else
    Printf.printf "NOK: 1 - 999 => %d \n" resultat20

let test =
  let test = StringMap.add "1" 1 StringMap.empty in
  let test = StringMap.add "2" 2 test in
  let test = StringMap.add "3" 3 test in
  let test = StringMap.remove "2" test in
  try
    StringMap.find test "2";
    Printf.printf "NOK: Pair not removed";
  with StringMap.NotInSet -> Printf.printf "OK: Pair removed\n"

let test =
  let test = StringMap.add "1" 1 StringMap.empty in
  let test = StringMap.add "2" 2 test in
  let test = StringMap.add "3" 3 test in
  let test = StringMap.remove "2" test in
  let test = StringMap.remove "1" test in
  let test = StringMap.remove "3" test in
  let result = StringMap.is_empty test in
  if result
  then Printf.printf "OK: Empty Map\n"
  else Printf.printf "NOK: Map is not empty\n"

let test =
  let empty = StringMap.empty in
  let result = StringMap.is_empty empty in
  if result
  then Printf.printf "OK: StringMap.empty is empty\n"
  else Printf.printf "NOK: StringMap.empty is not empty\n"

let test =
  let f k v acc = 2 * v + acc in
  let test = StringMap.add "1" 1 StringMap.empty in
  let test = StringMap.add "2" 2 test in
  let test = StringMap.add "3" 3 test in
  let result = StringMap.fold f test 0 in
  if result = 12
  then Printf.printf "OK: StringMap.fold\n"
  else Printf.printf "NOK: StringMap.fold = %d\n" result



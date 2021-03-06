module MLLPath = IMLLPath.MLLPath
module Carte = ICarte.Carte
module Optimizer = IOptimizer.Optimizer

let _ = Random.self_init()

let _ = Printf.printf "Détermination d'une tournée\n"

let monde = [
    ("Paris", 0., 0.);
    ("Londres", -3., 4.);
    ("Berlin", 8., 2.);
    ("Luxembourg", 6., 3.);
    ("Strasbourg", 5., 1.);
    ("Evry", 1., -2.);
    ("Toulouse", -2., -6.);
    ("NewYork", -22., 4.);
    ("Pekin", 26., -2.);
    ("Belgrade", 16., 4.);
    ("Lima", -22., -6.);
    ("Montreal", -18., 8.);
    ("Dublin", -4., 6.);
    ("CapeTown", 10., -14.);
    ("Reunion", 4., -16.);
]

let rec monde_aleatoire n =
  if n = 0
  then []
  else ("City", (Random.float 1600.), (Random.float 900.))::(monde_aleatoire (n - 1))

let s = Sys.time()
let monde = monde_aleatoire 20
let e = Sys.time()
let _ = Printf.printf "------------------------------------ TRUCS DU DEBUT ------------------------------------\n"
let _ = Printf.printf "Génération monde: %f\n" (e -. s)

let s = Sys.time()
let monde = Carte.make_carte_from_cities_and_roads monde
let e = Sys.time()
let _ = Printf.printf "Construction carte: %f\n" (e -. s)

let rec test_n_fois f n = 
    if n = 0 then () else
        let _ = f n monde in
        test_n_fois f (n-1)

let execute_test name initial_path_builder solution_builder = 
  let _ = Printf.printf "\n------------------------------------ %s ------------------------------------\n" name in
  let s = Sys.time() in
  let _ = Optimizer.find_solution initial_path_builder solution_builder monde in
  let e = Sys.time() in
  Printf.printf "Temps total: %f\n" (e -. s)

let _ = execute_test "Point + Nearest " Optimizer.random_point_initial_path Optimizer.build_solution_nearest
let _ = execute_test "Point + Farthest" Optimizer.random_point_initial_path Optimizer.build_solution_farthest
let _ = execute_test "Point + Random  " Optimizer.random_point_initial_path Optimizer.build_solution_random
let _ = execute_test " Hull + Nearest " Optimizer.hull_initial_path Optimizer.build_solution_nearest
let _ = execute_test " Hull + Farthest" Optimizer.hull_initial_path Optimizer.build_solution_farthest
let _ = execute_test " Hull + Random  " Optimizer.hull_initial_path Optimizer.build_solution_random

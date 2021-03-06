(*
    A map that represents a path
    Each element is a pair (last, next)
    So it is a kind of linked-list though the access to the elements is in a way better complexity
*)

module MLLPath : sig
    (* Le module Carte utilisé pour calculer les distances *)
    module Carte = ICarte.Carte
    (* Un ensemble de villes d'une carte (<=> noeuds sur un graphe) *)
    (* module NodeSet : Set.S *)
    (* Une ville. Dans un chemin, elle est représentée par un entier qui est son "indice" dans la carte *)
    module Node : sig
        type t = int
        val compare : int -> int -> int
    end
    module NodeSet = Carte.NodeSet
    type node = int
    type node_set = Carte.NodeSet.t

    module PathEntry : Map.OrderedType with type t = Node.t * int
    (* Le type des éléments des chemins *)
    type path_entry = PathEntry.t

    (* Le type des données contenues dans la Map. En pratique, c'est un couple (précédent, suivant) d'indices *)
    type value
    (* Le type des chemins *)
    type path
    (* Le type des ensembles d'éléments des chemins *)
    type path_entry_set

    (* Exception levée si on essaie d'obtenir des informations ou d'insérer après une ville absente du chemin *)
    exception NotInPath
    (* Exception levée lors de l'appel d'une fonction demandant un chemin non vide sur un chemin vide *)
    exception EmptyPath
    (* Exception levée lorsque l'enveloppe convexe n'est pas connexe *)
    exception NonConnexe

    (* Renvoie un chemin vide *)
    val empty : path

    (* Vérifie si un chemin est vide *)
    val is_empty : path -> bool

    (* Renvoie le nombre d'éléments dans le chemin 
      @requires Rien
      @ensures 
      @raises Rien
    *)
    val cardinal : path -> int

    (* Retourne un chemin entre deux points 
      @requires Rien
      @ensures Le chemin qui était A -> ... -> x1 ... xn --> B -> ... est A --> xn ... x1 --> B --> ...
      @raises Rien    
    *)
    val reverted : path -> path_entry -> path_entry -> path

    (*
      @requires Les deux path_entry sont dans le chemin 
      @ensures Les deux path_entry sont échangés sur le chemin
      @raises NotInPath si un des deux path_entry est absent du chemin
    *)
    val swap : path_entry -> path_entry -> path -> path

    (* 
      @requires
      @ensures Trouve la ville suivante dans un chemin
      @raises NotInPath si l'élément passé n'est pas dans le chemin
    *)
    val get_next : path_entry -> path -> path_entry

    (* 
      @requires
      @ensures Trouve la ville précédente dans un chemin
      @raises NotInPath si l'élément passé n'est pas dans le chemin
    *)
    val get_last : path_entry -> path -> path_entry

    (* 
      @requires Rien
      @ensures Affiche un chemin (comme suite d'indices) 
      @raises Rien  
    *)
    val print : path -> unit

    (* Affiche un chemin (comme suite de noms de villes) *)
    val print_with_names : path -> Carte.carte -> unit

    (* Affiche un chemin (comme distance puis suite de noms de villes) *)
    val print_distance_names : path -> Carte.carte -> unit

    (* Vérifie si une ville appartient au chemin *)
    val mem_city : node -> path -> bool

    (* Vérifie si un path_entry appartient au chemin *)
    val mem : path_entry -> path -> bool

    (* 
      @requires L'élément est dans le chemin
      @ensures Supprime l'élément du chemin
      @raises NotInPath si l'indice n'y est pas. 
    *)
    val remove : path_entry -> path -> path

    (* Construit un chemin de base avec un seul indice.
    Le chemin est alors de la forme indice -> (indice, indice) *)
    val make : node -> path_entry * path

    (*
      @requires Rien
      @ensures Créé un chemin à partir d'une liste de villes (indices)
      @raises Rien
    *)
    val from_list : node list -> Carte.carte -> path

    (* Détermine la longueur totale d'un chemin *)
    val length : path -> Carte.carte -> float

    (* Renvoie une liste contenant tous les éléments d'un chemin *)
    val entries_list : path -> path_entry list

    (* Renvoie la liste des villes d'un chemin dans l'ordre *)
    val cities_list : path -> node list

    (* Renvoie un ensemble contenant toutes les villes présentes dans un chemin *)
    val cities_set : path -> node_set

    (* 
      @requires Le chemin est non vide
      @ensures Renvoie le premier indice du chemin (dans N) 
      @raises EmptyPath si le chemin est vide
    *)
    val get_first : path -> path_entry

    (* 
      @requires Le chemin est non vide
      @ensures Renvoie un élément aléatoire du chemin
      @raises EmptyPath si le chemin est vide
    *)
    val get_random : path -> path_entry

    (* 
      @requires Le chemin contient l'élément passé en paramètre
      @ensures Ajoute un indice à un chemin 
               Utilisation: insert [noeud] après [after] dans [chemin] 
      @raises NotInPath si l'élément donné comme référence n'est pas dans le chemin.
    *)
    val insert : node -> path_entry -> path -> path_entry * path

    (* Ajoute un indice dans un chemin afin d'optimiser la longueur totale *)
    val insert_in_path : node -> path_entry -> path -> Carte.carte -> path_entry * path

    (* Insère un indice dans un chemin en minimsant sa longueur *)
    val insert_minimize_length : node -> path -> Carte.carte -> path_entry * path

    (* Insère un indice aléatoire de la Carte en minimisant la longueur du chemin *)
    val insert_random_minimize : path -> Carte.carte -> node list -> Carte.node_set -> path_entry * path

    (* --------------- A FINS DE TESTS --------------- *)
    (* Trouve la ville suivant une autre ville par son nom *)
    val get_next_by_name : string -> path -> Carte.carte -> path_entry
    (* Trouve la ville précédant une autre ville par son nom *)
    val get_last_by_name : string -> path -> Carte.carte -> path_entry
end
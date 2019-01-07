module Parser = struct
  let rec parse_villes cin nb_villes =
    if nb_villes = 0
    then []
    else
      let v = Scanf.bscanf cin "%s %f %f " (fun na x y -> na, x, y) in
      v::parse_villes cin (nb_villes - 1)

  let parse_input cin =
    let nb_villes = Scanf.bscanf cin "%d " (fun x -> x) in
    List.rev (parse_villes cin nb_villes)

  exception FileNotFound of string
  exception SyntaxError of string*string  

  type config = {
    mode : string;
    insertion : string;
    optimization: string;
  }

  let parse_input_file file_name =
    try
      let cin = Scanf.Scanning.from_file file_name in
      try
        let l = parse_input cin in
        let _ = Scanf.Scanning.close_in cin in  (* parce qu'on est pas des porcs *)
        l
      with e -> Scanf.Scanning.close_in cin; raise e
    with
    | Sys_error _ -> (* fichier non trouvé *)
      raise (FileNotFound file_name)
    | Scanf.Scan_failure msg ->
      raise (SyntaxError(file_name,msg))

  let parse_config_file file_name = 
    try
      let cin = Scanf.Scanning.from_file file_name in 
      try 
        let mode = Scanf.bscanf cin "%s" (fun x -> x) in 
        let insertion = Scanf.bscanf cin "\n%s" (fun x -> x) in 
        let optimisation = Scanf.bscanf cin "\n%s" (fun x -> x) in 
        { mode = mode; insertion = insertion; optimization = optimisation }
      with e -> Scanf.Scanning.close_in cin; raise e
    with
    | Sys_error _ -> (* fichier non trouvé *)
      raise (FileNotFound file_name)
    | Scanf.Scan_failure msg ->
      raise (SyntaxError(file_name,msg))
  end
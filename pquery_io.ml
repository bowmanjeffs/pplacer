(* pplacer v0.3. Copyright (C) 2009  Frederick A Matsen.
 * This file is part of pplacer. pplacer is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. pplacer is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with pplacer. If not, see <http://www.gnu.org/licenses/>.
 *)

open Fam_batteries
open MapsSets

 
(* ***** WRITING ***** *)

let write ch pq = 
  Printf.fprintf ch ">%s\n" (Pquery.name pq);
  Printf.fprintf ch "%s\n" (Pquery.seq pq);
  List.iter 
    (fun p -> 
      Printf.fprintf ch "%s\n" (Placement.placement_to_str p)) 
    (Pquery.place_list pq)

    (*
let write_unplaced ch unplaced_list = 
  if unplaced_list <> [] then
    Printf.fprintf ch "# unplaced sequences\n";
  List.iter (write ch) unplaced_list

let write_placed_map ch placed_map = 
  IntMap.iter
    (fun loc npcl ->
      Printf.fprintf ch "# location %d\n" loc;
      List.iter (write ch) npcl)
    placed_map

let write_by_best_loc criterion ch pq_list =
  let (unplaced_l, placed_map) = 
    Pquery.make_map_by_best_loc criterion pq_list in
  write_unplaced ch unplaced_l;
  write_placed_map ch placed_map
  *)


(* ***** READING ***** *)

let parse_pquery = function
  | name::seq::places ->
      Pquery.make_ml_sorted
      ~name:(Alignment.read_fasta_name name)
      ~seq
      (List.map Placement.placement_of_str places)
  | _ -> 
      invalid_arg "problem with place file. missing sequence data?"
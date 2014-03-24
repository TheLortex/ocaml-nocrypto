(* MODP Diffie-Hellman *)

(* DH parameters: a modulus and a group generator. *)
type group = { p: Z.t ; gg : Z.t ; q : Z.t option }

(* A private secret. *)
type secret = { x : Z.t }

(* Construct `group`. *)
val group : p:Cstruct.t -> gg:Cstruct.t -> ?q:Cstruct.t -> unit -> group

(* Given group and a string serving as secret, generate `secret` and the public
 * part. *)
val of_secret : group -> s:Cstruct.t -> secret * Cstruct.t

(* Given group, a secret and the other party's public message, recover the
 * shared secret. *)
val shared : group -> secret -> Cstruct.t -> Cstruct.t

(* Generate parameters.
 * (Searches for a safe prime. Minutes-slow for 1-3K bits.)  *)
val gen_group : ?g:Rng.g -> int -> group

(* Generate a secret and the corresponding public message. *)
val gen_secret : ?g:Rng.g -> group -> secret * Cstruct.t

(* Some standard parameter sets. *)
module Group : sig

  (* RFC2409 *)
  val oakley_1   : group
  val oakley_2   : group

  (* RFC3526 *)
  val oakley_5   : group
  val oakley_14  : group
  val oakley_15  : group
  val oakley_16  : group
  val oakley_17  : group
  val oakley_18  : group

  val rfc_5114_1 : group
  val rfc_5114_2 : group
  val rfc_5114_3 : group

end
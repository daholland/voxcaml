(*
   Minimal Tgl3 example. This code is in the public domain.
   Draws a fantastic tri-colored triangle.

   Compile with:
   ocamlfind ocamlc -linkpkg -package tsdl,tgls.tgl3 -o trigl3.byte trigl3.ml
   ocamlfind ocamlopt -linkpkg -package tsdl,tgls.tgl3 -o trigl3.native \
                      trigl3.ml
*)

open Tsdl
open Voxgl
open Result

let str = Printf.sprintf

let ( >>= ) x f = match x with Ok v -> f v | Error _ as e -> e

(* Helper functions. *)



(* Shaders *)
let vertex_shader v = Printf.sprintf "
  #version %s core
  in vec3 vertex;
  in vec3 color;
  out vec4 v_color;
  void main()
  {
    v_color = vec4(color, 1.0);
    gl_Position = vec4(vertex, 1.0);
  }" v

let fragment_shader v = Printf.sprintf "
  #version %s core
  in vec4 v_color;
  out vec4 color;
  void main() { color = v_color; }" v

let vertices =
  let vs = bigarray_create Bigarray.float32 (3 * 3) in
  set_3d vs 0 (-0.8) (-0.8) 0.0;
  set_3d vs 1 0.8    (-0.8) 0.0;
  set_3d vs 2 0.0    0.8    0.0;
  vs

let colors =
  let cs = bigarray_create Bigarray.float32 (3 * 3) in
  set_3d cs 0 1.0 0.0 0.0;
  set_3d cs 1 0.0 0.5 0.0;
  set_3d cs 2 0.0 0.0 1.0;
  cs

let indices =
  let is = bigarray_create Bigarray.int8_unsigned 3 in
  set_3d is 0 0 1 2;
  is


(* Window and OpenGL context *)

let create_window ~gl:(maj, min) =
  let w_atts = Sdl.Window.(opengl + resizable) in
  let w_title = Printf.sprintf "OpenGL %d.%d (core profile)" maj min in
  let set a v = Sdl.gl_set_attribute a v in
  set Sdl.Gl.context_profile_mask Sdl.Gl.context_profile_core >>= fun () ->
  set Sdl.Gl.context_major_version maj                        >>= fun () ->
  set Sdl.Gl.context_minor_version min                        >>= fun () ->
  set Sdl.Gl.doublebuffer 1                                   >>= fun () ->
  Sdl.create_window ~w:640 ~h:480 w_title w_atts              >>= fun win ->
  Sdl.gl_create_context win                                   >>= fun ctx ->
  Sdl.gl_make_current win ctx                                 >>= fun () ->
  Sdl.log "%a" Voxgl.pp_opengl_info ();
  Ok (win, ctx)

let destroy_window win ctx =
  Sdl.gl_delete_context ctx;
  Sdl.destroy_window win;
 Ok ()

(* Event loop *)

let event_loop win draw =
  let e = Sdl.Event.create () in
  let key_scancode e = Sdl.Scancode.enum Sdl.Event.(get e keyboard_scancode) in
  let event e = Sdl.Event.(enum (get e typ)) in
  let window_event e = Sdl.Event.(window_event_enum (get e window_event_id)) in
  let rec loop () =
    ignore (Sdl.wait_event_timeout (Some e) 1);
    match event e with
    | `Quit -> Ok ()
    | `Key_down when key_scancode e = `Escape -> Ok ()
    | `Window_event ->
        begin match window_event e with
        | `Exposed | `Resized ->
            let w, h = Sdl.get_window_size win in
            Voxgl.reshape win w h;
            draw win;
            draw win; (* bug on osx ? *)
            loop ()
        | _ -> loop ()
        end
    | _ -> loop ()
  in
  (draw win; loop ())
  

(* Main *)

let tri ~gl:(maj, min as gl) =
  let glsl_version = (glsl_version gl) in
  Sdl.init Sdl.Init.video                                  >>= fun () ->
  create_window ~gl                                        >>= fun (win, ctx) ->
  Voxgl.create_geometry indices vertices colors ()               >>= fun (gid, bids) ->
  Voxgl.create_program (vertex_shader glsl_version) (fragment_shader glsl_version)                         >>= fun pid ->
  event_loop win (draw pid gid)                            >>= fun () ->
  Voxgl.delete_program pid                                       >>= fun () ->
  Voxgl.delete_geometry gid bids                                 >>= fun () ->
  destroy_window win ctx                                   >>= fun () ->
  Sdl.quit ();
  Ok ()

let main () =
  let exec = Filename.basename Sys.executable_name in
  let usage = str "Usage: %s [OPTION]\n Tests Tgl3.\nOptions:" exec in
  let minor = ref 2 in
  let options =
    [ "-minor", Arg.Set_int minor,
      " <x> use Use an OpenGL 3.x context (defaults to 3.2)"; ]
  in
  let anon _ = raise (Arg.Bad "no arguments are supported") in
  Arg.parse (Arg.align options) anon usage;
  match tri ~gl:(3, !minor) with
  | Ok () -> exit 0
  | Error `Msg msg -> Sdl.log "%s@." msg; exit 1

let () = main ()

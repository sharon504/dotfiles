{ config, pkgs, inputs, system, ... }:
{
  systemd.user.services.xwayland-satellite.wantedBy = [ "graphical-session.target" ];
  services.displayManager.defaultSession = "niri";
  services = {
    libinput = { enable = true; };
    openssh = { enable = true; };
    pipewire = { enable = true; };
    udev.packages = [
      pkgs.android-udev-rules
    ];
    hypridle = { enable = true; };
    kanata = {
      enable = true;
      keyboards = {
        InternalKeyboard = {
          config = ''
            ;; Basic home row mods example using QWERTY
            ;; For a more complex but perhaps usable configuration,
            ;; see home-row-mod-advanced.kbd

            (defsrc
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rmet rctl
            )
            (defvar
              ;; Note: consider using different time values for your different fingers.
              ;; For example, your pinkies might be slower to release keys and index
              ;; fingers faster.
              tap-time 200
              hold-time 200
            )
            (defalias
              a (tap-hold $tap-time $hold-time a lmet)
              s (tap-hold $tap-time $hold-time s lalt)
              d (tap-hold $tap-time $hold-time d lsft)
              f (tap-hold $tap-time $hold-time f lctl)
              j (tap-hold $tap-time $hold-time j rctl)
              k (tap-hold $tap-time $hold-time k rsft)
              l (tap-hold $tap-time $hold-time l ralt)
              ; (tap-hold $tap-time $hold-time ; rmet)
              caps (tap-hold $tap-time $hold-time esc (layer-while-held arrows))
            )
            (deflayer base
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              @caps @a   @s    @d    @f    g  h   @j    @k    @l    @;  '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rmet rctl
            )

            (deflayer arrows  
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              esc  @a   @s    @d    @f    g    left    down    up    right ;  '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rmet rctl
            )

          '';
        };
      };
    };
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = ''${pkgs.greetd.tuigreet}/bin/tuigreet \
                    --remember \
                    --remember-session \
                    --asterisks \
                    --time \
                    --sessions ${pkgs.niri}/share/wayland-sessions'';
          user = "alpha";
        };
      };
    };
  };

}

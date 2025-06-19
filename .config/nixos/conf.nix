{ config, pkgs, lib, ... }:

let
  sources = import ./nix/sources.nix;
  lanzaboote = import sources.lanzaboote;
  inherit (import ./variables.nix) primaryDisplay;
  inherit (import ./variables.nix) displayName;

in
{
  imports = [ lanzaboote.nixosModules.lanzaboote ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    loader = {
      timeout = 120;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = lib.mkForce false;
        configurationLimit = 1;
      };
    };
    supportedFilesystems = [
      "btrfs"
      "ntfs"
      "ext4"
    ];
  };

  networking = {
    hostName = displayName;
    networkmanager.enable = true;
  };

  time.timeZone = "America/Chicago";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = "true";
        };
      };
    };
    graphics = {
      enable = true;
    };
  };

  # Configure keymap in X11
  services = {
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    blueman.enable = true;
    thermald.enable = true;
    printing.enable = true;

    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = true;
        PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };

    };

    displayManager = {
      defaultSession = "sway";
      sessionPackages = [ pkgs.swayfx ];
    };

    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      # displayManager.lightdm = {
      #   enable = true;
      #   greeters.gtk.enable = true;
      # };
      displayManager = {
        gdm = {
          enable = true;
          debug = true;
          # wayland = true;
        };
      };
    };

    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        middleEmulation = true;
        tapping = true;
        disableWhileTyping = true;
      };
    };

    fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix;
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    logind = {
      lidSwitch = "poweroff";
      lidSwitchExternalPower = "sleep";
      lidSwitchDocked = "sleep";
    };

    # tlp = {
    # 	enable = true;
    # 	settings = {
    # 		CPU_SCALING_GOVERNOR_ON_AC = "performance";
    # 		CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    #
    # 		CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    # 		CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    #
    # 		CPU_MIN_PERF_ON_AC = 0;
    # 		CPU_MAX_PERF_ON_AC = 100;
    # 		CPU_MIN_PERF_ON_BAT = 0;
    # 		CPU_MAX_PERF_ON_BAT = 100;
    #
    # 		# Optional helps save long term battery health
    # 		START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
    # 		STOP_CHARGE_THRESH_BAT0 = 80;  # 80 and above it stops charging
    # 	};
    # };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;

    pam.services.swaylock = {
      text = ''
        auth sufficient pam_unix.so try_first_pass likeauth nullok
        auth sufficient pam_fprintd.so
        auth include login
      '';
    };
  };


  systemd = {
    sleep.extraConfig = ''
      			AllowSuspend=yes
      			AllowHibernation=yes
      			AllowHybridSleep=yes
      			AllowSuspendThenHibernate=yes
      		'';
    services = {
      fprintd = {
        wantedBy = [ "multi-user.target" ];
        serviceConfig.Type = "simple";
      };
      "getty@tty1".enable = true;
      "autovt@tty1".enable = true;
    };
    user.services.mpris-proxy = {
      description = "Mpris proxy";
      after = [ "network.target" "sound.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };
  };

  powerManagement.enable = true;

  programs = {
    sway = {
      enable = true;
      package = pkgs.swayfx;
      wrapperFeatures.gtk = true;
    };
    fish.enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
    wlr = {
      enable = true;
      settings = {
        screencast = {
          chooser_type = "none";
          output_name = primaryDisplay;
        };
      };
    };
  };


  users = {
    defaultUserShell = pkgs.fish;
    users.chanadu = {
      isNormalUser = true;
      description = "Chanadu";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [ ];
      shell = pkgs.fish;
    };
    groups.input = {
      name = "input";
      members = [ "chanadu" ];
    };
  };


  environment = {
    variables = {
      GTK_THEME = "Adwaita:dark";
      EDITOR = "nvim";
      TERM = "alacritty";
      BROWSER = "firefox";
      XCURSOR_SIZE = "64";
      NO_AT_BRIDGE = "1";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "sway";
      XDG_CURRENT_DESKTOP = "sway";
      NO_AT_BRIDGE = "1";
    };

    systemPackages = with pkgs; [
      swayfx-unwrapped
      vim
      wget
      neovim
      firefox
      alacritty
      fish
      waybar
      rofi
      pipewire
      wireplumber
      mako
      git
      xfce.thunar
      p7zip
      zoxide
      kubectl
      gcc
      rocmPackages.llvm.clang-unwrapped
      zig
      go
      zulu
      fzf
      gnumake
      obsidian
      nodejs_24
      cmake
      playerctl
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      polkit
      grim
      wl-clipboard
      neofetch
      autotiling
      spotify
      discord
      ripgrep
      stow
      lazygit
      vscode
      fd
      gh
      sway-contrib.grimshot
      slurp
      libnotify
      killall
      via
      adw-gtk3
      python313
      ninja
      gtk3
      xorg.xev
      google-chrome
      usbutils
      udiskie
      udisks
      btop
      sbctl
      niv
      sway-new-workspace
      kdePackages.dolphin
      kdePackages.qtsvg
      kdePackages.kio-fuse
      kdePackages.kio-extras
      kdePackages.okular
      gparted
      xorg.xhost
      timeshift
      ydotool
      networkmanager
      networkmanagerapplet
      wev
      rofi-power-menu
      xorg.xrandr
      arandr
      ntfs3g
      cdrkit
      bluez
      mission-planner
      xwayland
      lua
      luajitPackages.luarocks
      ruff
      pyright
      libpam-wrapper
      rustup
      lshw
      lshw-gui
      libfprint-2-tod1-goodix
      pavucontrol
      libreoffice
      lxappearance
      adwaita-icon-theme
      fprintd
      swaylock-effects
      # swaylock-fancy
    ];

  };

  fonts.packages = with pkgs; [
    nerd-fonts.monaspace
  ];

  system.stateVersion = "25.05";
}



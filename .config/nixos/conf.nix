

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
    sources = import ./nix/sources.nix;
    lanzaboote = import sources.lanzaboote;
	inherit (import ./variables.nix) primaryDisplay;

in
{
	imports = [ lanzaboote.nixosModules.lanzaboote ];

	# nix.settings.auto-optimize-store = true;
	nix.gc = {
		automatic = true;
		dates = "daily";
	};

	nix.settings.experimental-features = ["nix-command" "flakes"];

	# Bootloader.
	boot.loader.systemd-boot = {
		# enable = lib.mkForce false;
		enable = true;
		configurationLimit = 1;
	}
	# 	
	#
	# 	 windows = {
	# 		"windows" =
	# 			let
	# 				# To determine the name of the windows boot drive, boot into edk2 first, then run
	# 				# `map -c` to get drive aliases, and try out running `FS1:`, then `ls EFI` to check
	# 				# which alias corresponds to which EFI partition.
	# 				boot-drive = "FS0";
	# 			in
	# 			{
	# 				title = "Windows";
	# 				efiDeviceHandle = boot-drive;
	# 				sortKey = "y_windows";
	# 			};
	# 	  };
	# 	# windows = {
	# 	# 	"windows" =
	# 	# 	  let
	# 	# 		# To determine the name of the windows boot drive, boot into edk2 first, then run
	# 	# 		# `map -c` to get drive aliases, and try out running `FS1:`, then `ls EFI` to check
	# 	# 		# which alias corresponds to which EFI partition.
	# 	# 		boot-drive = "FS1";
	# 	# 	  in
	# 	# 	  {
	# 	# 		title = "Windows";
	# 	# 		efiDeviceHandle = boot-drive;
	# 	# 		sortKey = "y_windows";
	# 	# 	  };
	# 	#   };
	# 	
	# };

	# boot.loader.systemd-boot.enable = true;
	# boot.loader.systemd-boot.configurationLimit = 1;

	# boot.loader.efi.efiSysMountPoint = "/efi";
	# boot.loader.systemd-boot.xbootldrMountPoint = "/boot";
		# boot.lanzaboote = {
	# 	enable = true;
	# 	pkiBundle = "/var/lib/sbctl";
	# };
	# boot.loader.systemd-boot.enable = false;
	#
	# boot.loader.grub = {
	# 	enable = true;
	# 	device = "nodev";
	# 	useOSProber = true;
	# 	efiSupport = true;
	# 	# extraConfig = "set theme=/nix/store/1zaqasa6x02vw09wwpbqzn4br0slizwj-minimal-grub-theme-0.3.0/theme.txt";
	# 	splashImage = null;
	# 	# configurationLimit = 3;
	# };
	# #
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "chanadu-desktop"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "America/Chicago";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
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

	hardware.graphics = {
		enable = true;
	};

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	services.xserver = {
		enable = true;
		# displayManager = {
		# 	gdm = {
		# 	enable = true;
		# 	wayland = true;
		# 	autoLogin.delay = -1;
		# 	banner = "AhjsdgjhsdfkhsdfklhA";
		# 	};
		# };
	};
	# services.displayManager.defaultSession = "asdasd";
	services.libinput.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users = {
		defaultUserShell = pkgs.fish;
		users.chanadu = {
			isNormalUser = true;
			description = "Chanadu";
			extraGroups = [ "networkmanager" "wheel" ];
			packages = with pkgs; [];
			shell = pkgs.fish;
		};
		groups.input = {
			name = "input";
			members = ["chanadu"];
		};
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		# bspwm
		# sxhkd
		# hyprland
		swayfx-unwrapped
		vim
		wget
		neovim
		firefox
		# refind
		# efibootmgr
		# sbsigntool
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
		# kitty
		playerctl
		xdg-desktop-portal
		xdg-desktop-portal-wlr
		polkit
		# gtk4
		# gtk3
		# gtk2
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
		# python313Packages.pycairo
		# xorg.libXt
		# haskellPackages.gi-cairo
		# python313Packages.pygobject3
		gtk3
		xorg.xev
		google-chrome
		libinput
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
	];

	fonts.packages = with pkgs; [
		nerd-fonts.monaspace
	];

	# gtk = {
	# 	enable = true;
	# 	font.name = "MonaspiceNe Nerd Font Mono";
	#
	# 	iconTheme = {
	# 		name = "Papirus-Dark";
	# 		package = pkgs.papirus-icon-theme;
	# 	};
	#
	# 	gtk3.extraConfig = {
	# 		Settings = ''
	# 			gtk-application-prefer-dark-theme=1
	# 		'';
	# 	};
	#
	# 	gtk4.extraConfig = {
	# 		Settings = ''
	# 			gtk-application-prefer-dark-theme=1
	# 		'';
	# 	};
	# };

	# services.xserver.windowManager.bspwm.configFile = "/home/chanadu/.config/bspwm/bspwmrc.sh";
	# services.xserver.windowManager.bspwm.sxhkd.configFile = "/home/chanadu/.config/sxhkd/sxkhdrc.sh";


	security.rtkit.enable = true;

	security.polkit.enable = true;

	services.gnome.gnome-keyring.enable = true;

	services.gvfs.enable = true;
	services.udisks2.enable = true;
	  
	# services.greetd = {
	# 	enable = true;
	# 	settings = rec {
	# 		initial_session = {
	# 		command = "{config.programs.swayfx.package}/bin/sway -- conf";
	# 		user = "greeter";
	# 		};
	# 		default_session = initial_session;
	# 	};
	# };

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# programs.hyprland.enable = true;

	programs.sway = {
		enable = true;
		package = pkgs.swayfx;
		wrapperFeatures.gtk = true;
	};

	programs.fish.enable = true;

	programs.waybar.enable = true;
	programs.xwayland.enable = true;

	programs.regreet.enable = true;


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

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	services.openssh.enable = true;

	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};


	environment = {
		variables = {
			GTK_THEME = "Adwaita:dark";
			EDITOR = "nvim";
			TERM = "alacritty";
		};
		sessionVariables = {
			NIXOS_OZONE_WL = "1";
			XDG_SESSION_TYPE="wayland";
			XDG_SESSION_DESKTOP="sway";
			XDG_CURRENT_DESKTOP="sway";
		};
	};

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.05"; # Did you read the comment?
}

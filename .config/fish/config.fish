if status is-interactive
# Commands to run in interactive sessions can go here
end

alias p 'paru && sudo fixBootLoader'
alias pis 'paru -Ss --searchby name'
alias ps 'paruz'
alias pi 'paru -S'
alias pr 'paru -R'
alias prs 'paru -Rs'

alias rscp 'rsync -aP'
alias rsmv 'rsync -aP --remove-source-files'

alias rm 'rmtrash'
alias rmdir 'rmdirtrash'

alias man 'tldr'
alias fix 'fuck'

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
    if test "$argv" = !!
        echo sudo $history[1]
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

fish_add_path ~/go/bin
fish_add_path ~/Folders/CustomPrograms
fish_add_path ~/Folders/CustomPrograms/pros-cli-linux
fish_add_path ~/Folders/CustomPrograms/CEDev/bin
fish_add_path ~/.local/bin
fish_add_path ~/update.sh

set -x BROWSER '/usr/bin/firefox'
set -x EDITOR '/usr/bin/nvim'
set -x SHELL '/usr/bin/fish'
set -x TERMINAL '/usr/bin/alacritty'
set -x CAPACITOR_ANDROID_STUDIO_PATH '/opt/android-studio/bin/studio.sh'
set -x XDG_CURRENT_DESKTOP sway
set -x XDG_SESSION_DESKTOP sway
set -x XDG_SESSION_TYPE wayland
# set -x XDG_RUNTIME_DIR '/run/user/$UID'
# set -x DBUS_SESSION_BUS_ADDRESS 'unix:path=${XDG_RUNTIME_DIR}/bus'


set -xU __done_min_cmd_duration 5000


# pnpm
set -gx PNPM_HOME "/home/chanadu/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# while nvim .code === 0
#   echo "restarting" 
# end
set -u pure_show_job true
set -u pure_enable_k8s true
set -u pure_enable_nixdevshell true
set -u pure_separate_prompt_on_error true
set -u pure_symbol_ssh_prefix "ssh:"
set -u pure_show_system_time true
set -u pure_show_subsecond_command_duration true
set -u pure_threshold_command_duration .25
set -u pure_show_prefix_root_prompt true
set -u pure_color_info blue
set -u pure_color_primary cyan

atuin init fish | source
#silver init | source
#starship init fish | source
zoxide init --cmd cd fish | source

thefuck --alias | source

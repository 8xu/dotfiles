autoload -Uz colors && colors

# %B - bold
# %b - reset bold

# %F{color} - color
# %f - reset color

# %n - username of the current user
# %m - hostname up to the first '.'

# %(!.%1~.%~) - if the current directory is $HOME, display ~, otherwise display the full path
# %(!.#.$) - if the current user is root, display #, otherwise display $

PROMPT='%B%F{red}%n%f%b@%B%F{blue}%m%b %f%B(%b%(!.%1~.%~)%B)%b %B%F{yellow}$%f%b '
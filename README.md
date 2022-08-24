# Air Quality Plugin for Tmux

Shows air quality status in the status line, data provided by iqair.com.

## Installation

### Requirements

* curl
* AirVisual [account](https://www.airvisual.com/auth/login) and [API key](https://www.iqair.com/dashboard/api)

### With Tmux Plugin Manager

Add the plugin in `.tmux.conf`:
```
set -g @plugin 'andreymarkinppc/tmux-airquality'
```
Press `prefix + I` to fetch the plugin and source it. Done.

### Manual
Clone the repo somewhere. Add `run-shell` in the end of `.tmux.conf`:

```
run-shell PATH_TO_REPO/tmux-airquality.tmux
```
NOTE: this line should be placed after `set-option -g status-right ...`.

Press `prefix + :` and type `source-file ~/.tmux.conf`. Done.

## Usage
Add `#{airq}` somewhere in the right status line:
```
set-option -g status-right "#{airq}"
```

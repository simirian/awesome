# simirian's AwesomeWM

Window managers are complicated. This git repo contains all of the code that
AwesomeWM will load on startup. This repo *does not* contain many additional
scripts and configs that are required for this awesome config to work properly.
Ideally, this should be installed with https://github.com/simirian/dotfiles.

This config handles global keybinds, tags/workspaces, and most of the UI. Some ui
features are handled by picom, but those are minimal.

## Dynamic Tag Groups

WIP

Tags are sorted into one of five groups: general, internet, development, art,
and multimedia. Each group has at least one tag. Groups will dynamically add and
remove tags on demand.

This is implemented by maintaining one more tag than have active clients in each
group. When a tag loses all of its clients then it will become volatile. If a
volatile tag is hidden, then it will be removed and all the tags after it in the
group will be shifted downwards.

## Toggleable Docks

WIP

This config comes with three togglable docks.

The main dock is the bar at the top of the screen, it is called "the bar". The
bar is shown on startup, and contains the taglist, tasklist for the current tag,
systray, date/time, and window layout.

The left dock is called the panel, and includes several system controls. The
main features are the user profile and shutdown menu. Also inclues sliders to
set microphone and output volume, as well as screen brightness. There are also
informational sections to show the weather, cpu, ram, and disk usage.

The right dock is a view into the notification history, which should be stored
in `~/.local/state/awesome-yicks/notifications`. By default the last 100
notifications will be saved, and they will not be deleted until they leave the
end of the queue.

## Keybinds

Keybind notation has two parts. A keybind may begin with a subset of the four
capital letters `MCAS`. These indicate the modifier keys pressed, meta, control,
alt, and shift. After these, there can be either a single key, a set of keys, or
a key chord. Single keys are an ascii character or word, all lowercase, that
should transparently represent what key needs to be pressed. Note that `M` is
meta, and `m` is the letter key. All letter keys and keys named with words are
lowercase.

Sets of keys are denoted with `[]`, and generally work like regular expressions.
This means that `[1-5]` is the same as `[12345]`. This notation is used when any
key from the set can be input and directly impacts the affect of invoking the
keybind. Sometimes a set of keys might include a key group, which should clearly
describe a type of key. eg. `[ARROW]` means any arrow key.

Key chords are marked `()`, and require all the keys within the parentheses to
be pressed while the modifiers are held in order to take effect. eg. the chord
`M(q q)` requires that you press and hold the meta key, then while it's held
press the `q` key twice. Keys in the chord are separated by spaces.

Where possible, keybinds are defined to be possible to complete with only the
laft hand. When this is not possible, it should be possible to use the mouse to
complete those actions. This is so that a right-handed user driving with the
mouse loses little to no functionality, and does not have to let go of the mouse
to use the keyboard.

### Target Action Keybinds

WIP

Target action keybinds have two components which combine to a large number of
possible results. The modifier keys pressed define the action, which is what
will happen based on the target and current focus. The target decides where the
current focus will go.

Using the numbers 1-5 will target the tag group with that number. Using `j`
will target the last active tag in the next tag group. `k` will target the last
active tag in the previous tag group. `h` and `l` will target the previous and
next tags in this group. If you are on the last non-empty tag of a group, then
`l` will create a new tag, but if you are on the first tag `h` will send you to
the last.

To target the client in a particular direction on the current tag, use the keys
`[uiop]`. These should be directly above the vim keys, and will target the
client in the direction of the key. They will not wrap around the screen edges
or work across screen borders.

To target screens, use the keys `[` and `]`.

The meta key alone is the shift action. This can let you switch between tags,
clients, and monitors.

- `Ml` will go to the next tag in the current group
- `Mu` will focus the client below
- `Mk` will go to the last used tag in the previous tag group

The meta and shift keys combined are the move action. They will move the
currently focused item to the target.

- `MSl` will move the current client to the next tag in the current group
- `MSu` will swap the current client with the one below it
- `MSk` will move the current client to the last used tag in the group below

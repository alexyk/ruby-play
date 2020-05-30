# About Tasks

## Task One

Read data from `data.json` and print a hierarchical structure

### Initial Plan

1. Read JSON
2. Create a Hash with `id` as key

### Plan Improvements

* More time should've been put on the problem
* The core of this task is _parsing the data into the appropriate structure_

### Plan Refactored

1. Read JSON
2. Create a Hash with `id` as key
3. Stop and Think
  * What is exactly the problem about:  
    * getting linear structure into a tree/stairs-like _hierarchy_
    * when to do what (parsing, level defining, printing etc.)
    * where to put what (an Item class, top_nodes vs traversing to top/printing 'backwards'  etc.)
  * What is the appropriate structure that would best represent the problem here?
  * How is it involved in the parsing and how can the structure make it easy/prepare the next step <small>(as was deciding to make a map with a key `id` in the initial plan - gave access to all nodes by `id` all the time)</small>?
  * How to print - again mind the role of the structure as a previous step / preparation for this one
  * Finally - evaluate and decide on a solution <small>(each step & the hole picture/steps inter-dependency/process flow)</small>
4. Implement the solution
  * parsing into structures
  * figuring out printing depth
  * putting printing in the appropriate place

### Good Things -> Even Better

#### First Retrospection  

_Ideas_

* Using a shortcut and running the spec was quick - reiterate the start up / debug / test process to be absolutely quick
* The extra `bin/run` also looks like a good way for quick development - if combined with a quick text editor (see next)
* Deciding to re-parse into a map with key `id`
* Deciding to use `top_items` - seemed obvious/intuitive when I was implementing it but what about using a similar `obviousness`/`intuition` when thinkering about and choosing the structure -> **Think and try how to implement this when doing other tasks**
* All this _tasks stuff_ bring to my mind the old idea - would it make sense to finally make it into a *hackatron* this time? Ruby is a lot of *fun* + *quick and handy*...

#### Second Retrospection

_Approach Tried_

* Used `bin/run` in `Terminal` by creating a Service (Automator `Quick Action`) to:  (1) switch to Terminal, (2) press `enter` in Terminal, (3) refocus IDE  

## TODO

**Tools**

* Using *text editors* (vim, emacs) for such tasks - could be better, find out what works best for me
* How to test - think, prepare, exercise more variants for quick task (aka *hackatrons*)
* More tasks to try - also invent some

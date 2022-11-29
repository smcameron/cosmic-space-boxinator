cosmic-space-boxinator
======================

Little space skybox generator written in Processing.  Not very sophisticated.

It will output 6 files:

* image0.png
* image1.png
* image2.png
* image3.png
* image4.png
* image5.png

which are laid out as follows:

```

                +------+
                |  4   |
                |      |
  +------+------+------+------+
  |  0   |  1   |  2   |  3   |
  |      |      |      |      |
  +------+------+------+------+
                |  5   |
                |      |
                +------+

```

To run this thing, after cloning the project wherever you like in the usual manner,
(I will assume that you cloned the project into $MYGITREPO)
do the following to create a symbolic link from your Processing sketchbook into
the git repo. Obviously, these instructions are for Linux/Unix.

On Linux/Unix:

```
	cd $HOME/sketchbook
	mkdir cosmicspaceboxinator
	cd cosmicspaceboxinator
	ln -s $MYGITREPO/cosmicspaceboxinator/cosmicspaceboxinator.pde
```

On Windows:

```
	Someone send me a patch to fill in the instructions for Windows.
```

Now you can run it from within the Processing environment as usual
without being forced to locate your git repo inside the ~/sketchbook
directory.

There are some knobs at the top of the cosmicspaceboxinator.pde that you
can use to control various aspects of the generated skybox:

```
int xdim = 2048;
int ydim = 2048;
int nstars = 40000;

/* Nebula color controls, each value is between 0 and 255 */
int neb_min_red = 150;
int neb_min_green = 50;
int neb_min_blue = 150;
int neb_max_red = 255;
int neb_max_green = 70;
int neb_max_blue = 255;
int neb_max_opacity = 200;
int nebula_size = int(xdim * 1.0);
```


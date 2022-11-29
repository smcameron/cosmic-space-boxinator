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

To run this thing, after cloning the project wherever you like in the usual manner.
I will assume that you cloned the project into $MYGITREPO
do the following:

```
	cd $HOME/sketchbook
	mkdir cosmicspaceboxinator
	cd cosmicspaceboxinator
	ln -s $GITREPO/cosmicspaceboxinator/cosmicspaceboxinator.pde
```

Now you can run it from within the Processing environment as usual
without being forced to locate your git repo inside the ~/sketchbook
directory.


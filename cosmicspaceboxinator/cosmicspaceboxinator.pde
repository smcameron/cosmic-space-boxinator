
PImage[] img = new PImage[6];
int xdim = 256;
int ydim = 256;

void draw_all_images()
{
	image(img[0], 0, ydim);
	image(img[1], xdim, ydim);
	image(img[2], xdim * 2, ydim);
	image(img[3], xdim * 3, ydim);
	image(img[4], xdim * 2, 0);
	image(img[5], xdim * 2, ydim * 2);
}

void setup()
{


	size(xdim * 4,  ydim * 3);


	for (int i = 0;  i < 6; i++) {
		img[i] = createImage(xdim, ydim, ARGB);
	}

	img[0].loadPixels();

	for (int i = 0; i < 6; i++) {
		for (int j = 0; j < img[i].pixels.length; j++) {
			img[i].pixels[j] = color(0, 0, 0, 255);
		}
		img[0].updatePixels();
	}

	draw_all_images();
}


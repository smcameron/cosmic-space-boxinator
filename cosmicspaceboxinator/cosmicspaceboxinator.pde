
PImage[] img = new PImage[6];
int xdim = 256;
int ydim = 256;

float alphablendcolor(float underchannel, float underalpha, float overchannel, float overalpha)
{
	return overchannel * overalpha + underchannel * underalpha * (1.0 - overalpha);
}

color combine_color(float or, float og, float ob, float oa, float r, float g, float b, float a)
{
	float nr, ng, nb, na;

	or = or / 255.0;
	og = og / 255.0;
	ob = ob / 255.0;
	oa = oa / 255.0;

	r = r / 255.0;
	g = g / 255.0;
	b = b / 255.0;
	a = a / 255.0;

	na = a + oa * (1 - a);
	nr = alphablendcolor(or, oa, r, a) / na;
	nb = alphablendcolor(ob, oa, b, a) / na;
	ng = alphablendcolor(og, oa, g, a) / na;
		
	return color(nr * 255.0, ng * 255.0, nb * 255.0, na * 255.0);
}

void simple_plotpoint(int imgnum, int x, int y, float r, float g, float b, float a)
{
	color oldcolor, newcolor;
	float or, og, ob, oa;

	oldcolor = img[imgnum].get(x, y);
	or = red(oldcolor);
	og = green(oldcolor);
	ob = blue(oldcolor);
	oa = alpha(oldcolor);
	newcolor = combine_color(or, og, ob, oa, r, g, b, a);

	img[imgnum].set(x, y, newcolor);
}

void plotpoint(int imgnum, int x, int y, int r, int g, int b, int a)
{
	int newimg;

	if (x >= 0 && x < xdim) {
		if (y >= 0 && y < ydim) {
			simple_plotpoint(imgnum, x, y, r, g, b, a);
		} else {
			if (y >= ydim) {
				switch (imgnum) {
				case 0:
					plotpoint(5, xdim - x, ydim - (y - ydim) - 1, r, g, b, a);
					break;
				case 1: plotpoint(5, y - ydim, xdim - x, r, g, b, a);
					break;
				case 2: plotpoint(5, x, y - ydim, r, g, b, a); 
					break;
				case 3: plotpoint(5, xdim - (y - ydim) - 1, x, r, g, b, a);
					break;
				case 4: plotpoint(2, x, y - ydim, r, g, b, a);
					break;
				case 5: plotpoint(0, xdim - x, ydim - (y - ydim) - 1, r, g, b, a);
					break;
				}
			} else { /* y < 0 */
				switch (imgnum) {
				case 0:
					plotpoint(4, xdim - x, -y, r, g, b, a);
					break;
				case 1:
					plotpoint(4, -y, x, r, g, b, a);
					break;
				case 2:
					plotpoint(4, x, ydim + y, r, g, b, a);
					break;
				case 3:
					plotpoint(4, xdim + y, xdim - x, r, g, b, a);
					break;
				case 4:
					plotpoint(0, xdim - x, -y, r, g, b, a);
					break;
				case 5:
					plotpoint(2, x, ydim + y, r, g, b, a);
					break;
				}
			}
		}
	} else {
		if (x < 0) {
			switch (imgnum) {
			case 0:
				plotpoint(3, xdim + x, y, r, g, b, a);
				break;
			case 1:
				plotpoint(0, xdim + x, y, r, g, b, a);
				break;
			case 2:
				plotpoint(1, xdim + x, y, r, g, b, a);
				break;
			case 3:
				plotpoint(2, xdim + x, y, r, g, b, a);
				break;
			case 4:
				plotpoint(1, y, -x, r, g, b, a);
				break;
			case 5:
				plotpoint(1, ydim - y, ydim + x, r, g, b, a);
				break;
			}
		} else { /* x >= xdim */
			switch (imgnum) {
			case 0:
				plotpoint(1, x - xdim, y, r, g, b, a);
				break;
			case 1:
				plotpoint(2, x - xdim, y, r, g, b, a);
				break;
			case 2:
				plotpoint(3, x - xdim, y, r, g, b, a);
				break;
			case 3:
				plotpoint(0, x - xdim, y, r, g, b, a);
				break;
			case 4:
				plotpoint(3, ydim - y, x - xdim, r, g, b, a);
				break;
			case 5:
				plotpoint(3, y, ydim - (x - xdim) - 1, r, g, b, a);
				break;
			}
		}
	}
}

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


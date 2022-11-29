/*
	Copyright (C) 2013 Stephen M. Cameron
	Author: Stephen M. Cameron

	This file is part of Cosmic Space Boxinator.

	Cosmic Space Boxinator is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Cosmic Space Boxinator is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Cosmic Space Boxinator; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/

PImage[] img = new PImage[6];

/* NOTE xdim and ydim need to match the parameters to size() in setup().
 * Apparently processing is so fucking stupid that you cannot use variables
 * as parameters to size(), only constants.  There *cannot* be a good reason
 * for that other than stupidity.
 */
int xdim = 2048;
int ydim = 2048;
int nstars = 10000;

/* Nebula color controls, each value is between 0 and 255, but probably 0 - 100
 * and the proportions control the overall color of the nebula.  The lower the
 * numbers, the more variation is allowed, as the calculation is something like:
 * (neb_min_red + noise_value * (255 - neb_min_red))
 */
int neb_min_red = 20;
int neb_min_green = 120;
int neb_min_blue = 50;

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

void draw_a_star(int img, int x, int y, int size, int r, int g, int b)
{
	float a;

	for (int i = -size; i <= size; i++) {
		a = 255.0 - ((255.0 / float(size)) * abs(float(i)));
		plotpoint(img, x + i, y, r, g, b, int(a));
		plotpoint(img, x, y + i, r, g, b, int(a));
	}

	for (int i = -size / 2; i <= size / 2; i++) {
		a = 255.0 - ((255.0 / (float(size) / 2.0)) * abs(float(i)));
		plotpoint(img, x + i, y + i, r, g, b, int(a));
		plotpoint(img, x - i, y + i, r, g, b, int(a));
	}
}

void draw_random_star_at(int img, int x, int y, float maxsize)
{
	int size, r, g, b;

	size = int(random(1.0) * random(1.0) * random(1.0) * random(1.0) * maxsize) + 1;
	r = 255 - int(random(60));
	g = 255 - int(random(60));
	b = 255 - int(random(60));

	if (size == 1) {
		float f = random(1.0);
		r = int(r * f);
		g = int(r * f);
		b = int(r * f);
	}

	draw_a_star(img, x, y, size, r, g, b);
}

void draw_random_star()
{
	int x, y, img;

	x = int(random(xdim));
	y = int(random(ydim));
	img = int(random(6 * 100)) % 6;
	draw_random_star_at(img, x, y, 25.0);
}

void draw_random_stars()
{
	for (int i = 0; i < nstars; i++) {
		draw_random_star();
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

void save_all_images()
{
	image(img[0], 0, 0);
	save("image0.png");
	image(img[1], 0, 0);
	save("image1.png");
	image(img[2], 0, 0);
	save("image2.png");
	image(img[3], 0, 0);
	save("image3.png");
	image(img[4], 0, 0);
	save("image4.png");
	image(img[5], 0, 0);
	save("image5.png");
}

void add_nebula()
{
	int x, y;
	int ox = xdim / 2;
	int oy = ydim / 2;
	float a, dist;
	int nsize = int(xdim * 1.0);
	float noisex, noisey, nz;
	float nrx, nry, ngx, ngy, nbx, nby, nzc, nzr, nzb, nzg;
	float neb_noise_scale = float(xdim) / 10.0;
	float color_noise_scale = float(xdim) / 7.0;

	noisex = random(500) + xdim;
	noisey = random(500) + ydim;
	nrx = random(500) + xdim; 
	nry = random(500) + ydim; 
	ngx = random(500) + xdim; 
	ngy = random(500) + ydim; 
	nbx = random(500) + xdim; 
	nby = random(500) + ydim; 

	for (x = -xdim * 3; x < xdim * 3; x++) {
		for (y = -ydim * 2; y < ydim * 2; y++) {
			dist = sqrt(x * x + y * y);
			if (dist < nsize / 2) {
				a = 0.7;
			} else {
				a = (0.7 - (dist - nsize / 2) / (nsize / 2));
				if (a < 0.0)
					a = 0.0;
			}
			if (a > 0.01) {
				nz = noise((float(x) + noisex) / neb_noise_scale,
						(float(y) + noisey) / neb_noise_scale);
				nz = nz * nz;
				a = a * nz;
			
				nzr = noise((float(x) + nrx) / color_noise_scale,
						(float(y) + nry) / color_noise_scale);
				nzg = noise((float(x) + ngx) / color_noise_scale,
						(float(y) + ngy) / color_noise_scale);
				nzb = noise((float(x) + nbx) / color_noise_scale,
						(float(y) + nby) / color_noise_scale);
				plotpoint(2, ox + x, oy + y,
						int(neb_min_red + nzr * (255 - neb_min_red)),
						int(neb_min_green + nzg * (255 - neb_min_green)),
						int(neb_min_blue + nzb * (255 - neb_min_blue)),
						int(a * 255));
			}
		}
	}
}

void setup()
{
	/* Note: if you change the parameters to size, you must change xdim and ydim
	 * at the top of this file to match.
	 */
	size(2048, 2048);

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

	draw_random_stars();
	add_nebula();
	save_all_images();
}


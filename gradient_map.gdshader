shader_type canvas_item;

uniform sampler2D gradient : hint_default_black;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 input_colour = texture(TEXTURE, UV);
	float grayscale_value = dot(input_colour.rgb, vec3(0.299, 0.587, 0.114));
	vec3 sampled_colour = texture(gradient, vec2(grayscale_value, 0.0)).rgb;
	
	COLOR.rgb = sampled_colour;
	COLOR.a = input_colour.a;
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}

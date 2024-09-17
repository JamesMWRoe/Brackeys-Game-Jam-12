shader_type canvas_item;

uniform vec4 blink_color: source_color;
uniform float blink_intensity = 0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() 
{
	vec4 original_color = texture(TEXTURE, UV);
	vec4 new_sprite_color = mix(original_color, blink_color, blink_intensity * original_color.a);
	
	COLOR = new_sprite_color;
}

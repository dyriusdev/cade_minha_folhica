shader_type canvas_item;

uniform bool active;
uniform vec3 flash_color : source_color = vec3(1);

void fragment() {
	vec4 temp = texture(TEXTURE, UV);
	if (active) {
		COLOR = vec4(flash_color, temp.a);
	}
}
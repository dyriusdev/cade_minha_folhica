shader_type canvas_item;

const vec2 center =  vec2(0.5,0.5);

uniform float intensity : hint_range(0.0, 20) = 9.14159265359;
uniform float radius : hint_range(0.0, 1) = 0.5;

varying float angle;
varying float time;

void fragment() {
	vec2 uv = UV;

	if (length(center - uv) > radius) {
		COLOR = texture(TEXTURE, UV);
	} else {
		time  = abs( cos(TIME * 1.0) );
		angle = intensity * (length(center - uv) - sqrt(0.5)) * time;
		uv -= vec2(0.5, 0.5);
		uv = vec2(
			uv.x * cos(angle) - uv.y * sin(angle),
			uv.x * sin(angle) + uv.y * cos(angle)
		);
		uv += vec2(0.5, 0.5);
		COLOR = texture(TEXTURE, uv);
	}
}
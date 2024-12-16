class_name Logger extends Object

enum Types {Debug, Event, Warning, Error}

const TEMPLATE : String = "[%s](%s) : %s"

static func logger(type : Types, message : String) -> void:
	var dt : Dictionary = Time.get_datetime_dict_from_system()
	var time : String = "%s/%s/%s-%s:%s:%s" % [dt.day, dt.month, dt.year, dt.hour, dt.minute, dt.second]
	print(TEMPLATE % [time, Types.keys()[type], message])
	pass

static func debug(message : String):
	logger(Types.Debug, message)
	pass

static func event(message : String):
	logger(Types.Event, message)
	pass

static func warning(message : String):
	logger(Types.Warning, message)
	pass

static func error(message : String):
	logger(Types.Error, message)
	pass

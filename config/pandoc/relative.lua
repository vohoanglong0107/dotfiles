local function starts_with(str, start)
	return str:sub(1, #start) == start
end

local function get_parent(file)
	return file:match("^(.*/)[^/]+$")
end

local function fix_path(path)
	-- this mean pandoc should be invoke on 1 file only
	return get_parent(PANDOC_STATE.input_files[1]) .. path
end

function Link(element)
	if starts_with(element.target, "./") or starts_with(element.target, "../") then
		element.target = fix_path(element.target)
	end
	return element
end

function Image(element)
	if starts_with(element.src, "./") or starts_with(element.src, "../") then
		element.src = fix_path(element.src)
	end
	return element
end

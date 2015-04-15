type SoundBuffer
	ptr::Ptr{Void}
end

function SoundBuffer(filename::String)
	return SoundBuffer(ccall(dlsym(libcsfml_audio, :sfSoundBuffer_createFromFile), Ptr{Void}, (Ptr{Cchar},), pointer(filename)))
end

function copy(buffer::SoundBuffer)
	return SoundBuffer(ccall(dlsym(libcsfml_audio, :sfSoundBuffer_copy), Ptr{Void}, (Ptr{Void},), buffer.ptr))
end

function destroy(buffer::SoundBuffer)
	ccall(dlsym(libcsfml_audio, :sfSoundBuffer_destroy), Void, (Ptr{Void},), buffer.ptr)
	buffer = nothing
end

function save_to_file(buffer::SoundBuffer, filename::String)
	ccall(dlsym(libcsfml_audio, :sfSoundBuffer_saveToFile), Void, (Ptr{Void}, Ptr{Cchar},), buffer.ptr, pointer(filename))
end

function get_duration(buffer::SoundBuffer)
	return ccall(dlsym(libcsfml_audio, :sfSoundBUffer_getDuration), Time, (Ptr{Void},), buffer.ptr)
end

export SoundBuffer
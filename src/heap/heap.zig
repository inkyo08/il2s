const mi = @cImport(@cInclude("mimalloc.h"));

pub fn malloc(size: usize) *anyopaque {
    return mi.mi_malloc(size) orelse @panic("mi_malloc failed");
}

pub fn calloc(count: usize, size: usize) *anyopaque {
    return mi.mi_calloc(count, size) orelse @panic("mi_calloc failed");
}

pub fn realloc(p: *anyopaque, newsize: usize) *anyopaque {
    return mi.mi_realloc(p, newsize) orelse @panic("mi_realloc failed");
}

pub fn free(p: *anyopaque) void {
    mi.mi_free(p);
}

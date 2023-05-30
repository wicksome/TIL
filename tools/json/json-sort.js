/*!
 * is-plain-object <https://github.com/jonschlinkert/is-plain-object>
 *
 * Copyright (c) 2014-2017, Jon Schlinkert.
 * Released under the MIT License.
 */

function isObject(o) {
    return Object.prototype.toString.call(o) === '[object Object]';
}

function isPlainObject(o) {
    var ctor,prot;

    if (isObject(o) === false) return false;

    // If has modified constructor
    ctor = o.constructor;
    if (ctor === undefined) return true;

    // If has modified prototype
    prot = ctor.prototype;
    if (isObject(prot) === false) return false;

    // If constructor does not have an Object-specific method
    if (prot.hasOwnProperty('isPrototypeOf') === false) {
        return false;
    }

    // Most likely a plain Object
    return true;
};

// https://github.com/IndigoUnited/js-deep-sort-object
function defaultSortFn(a, b) {
    return a.localeCompare(b);
}

function sort(src, comparator) {
    var out;

    if (Array.isArray(src)) {
        return src.map(function (item) {
            return sort(item, comparator);
        });
    }

    if (isPlainObject(src)) {
        out = {};

        Object.keys(src).sort(comparator || defaultSortFn).forEach(function (key) {
            out[key] = sort(src[key], comparator);
        });

        return out;
    }

    return src;
}

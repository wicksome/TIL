
const toBoolean = (value, returnIfNull = false) => {
    return (value === null) ? returnIfNull : /^true$/i.test(value)
}

const toNumber = (value) => {
    if (!value || !/^\d+$/.test(value)) return null
    return parseInt(value)
}

const isIsoDate = (str) => {
    try {
        // https://stackoverflow.com/a/37563868/3793078
        const ISO_8601 = /^\d{4}(-\d\d(-\d\d(T\d\d:\d\d(:\d\d)?(\.\d+)?(([+-]\d\d:\d\d)|Z)?)?)?)?$/i

        if (ISO_8601.test(str)) {
            new Date(Date.parse(str));
            return true
        } else {
            return false
        }
    } catch (e) {
        return false
    }
}

const debounce = (callback, limit = 100) => {
    let timeout
    return function (...args) {
        clearTimeout(timeout)
        timeout = setTimeout(() => {
            callback.apply(this, args)
        }, limit)
    }
}

const escape = function (text) {
    const tagsToReplace = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;'
    };
    return text.replace(/[&<>]/g, function (tag) {
        return tagsToReplace[tag] || tag;
    });
};

const truncate = (input, length, endMessage) => {
    console.log(endMessage)
    if (input.length > length) {
        if (!!endMessage) {
            return `${input.substring(0, length)}... ${endMessage}`
        } else {
            return `${input.substring(0, length)}...`
        }
    } else {
        return input
    }
};

function formatTimeAgo(date) {
    const formatter = new Intl.RelativeTimeFormat('ko-kr', {
        numeric: 'auto'
    })

    const DIVISIONS = [
        {amount: 60, name: 'seconds'},
        {amount: 60, name: 'minutes'},
        {amount: 24, name: 'hours'},
        {amount: 7, name: 'days'},
        {amount: 4.34524, name: 'weeks'},
        {amount: 12, name: 'months'},
        {amount: Number.POSITIVE_INFINITY, name: 'years'}
    ]

    let duration = (date - new Date()) / 1000

    for (let i = 0; i < DIVISIONS.length; i++) {
        const division = DIVISIONS[i]
        if (Math.abs(duration) < division.amount) {
            return formatter.format(Math.round(duration), division.name)
        }
        duration /= division.amount
    }
}

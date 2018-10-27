class Ships
    constructor: (@coordinates) ->

    isAShip: (coor) ->
        return coor in @coordinates

class Cell
    #value = X pour dans l'eau,
    #T pour touché et O quand pas tirée
    constructor: (@coordinates, @value) ->

    getValue: ->
        return @value

    getCoordinates: ->
        return @coordinates


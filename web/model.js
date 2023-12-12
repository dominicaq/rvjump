const directions = ["north", "east", "south", "west"]
class Tile {
    constructor(type = "normal", north = null, east = null, south = null, west = null) {
        this.type = type
        this.north = north
        this.east = east
        this.south = south
        this.west = west
    }
};

class GameState {
    constructor() {
        this.map = null
        this.last = null
        this.location = null
    }

    add_tile(location, type="normal") {
        location = location.toLowerCase()
        if (!directions.includes(location))
            return -1

        var tile = new Tile(type=type)
        this.last.$location = tile
        this.last = tile
        return 0
    }

    start() {
        this.location = this.map
    }

    move(direction) {
        if (!directions.includes(direction))
            return -1

        if (!this.location.$direction)
            return -1

        this.location = this.location.$direction
        return 0
    }

    // format:
    // direction,type
    // added to last node
    parse_csv(filepath) {
        var input = ""
        fetch(filepath).then(res => input = res.text())
        var split = input.split(/[\r\n]+/)
        for (line of split)
            var dir,type = line.split(",")
            this.add_tile(dir, type)
    }

};


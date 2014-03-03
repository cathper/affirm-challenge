require 'bigdecimal'
require 'matrix'

class Numeric
    def ring
        n = BigDecimal.new(self.to_s)

        ((Math.sqrt(12*n-3) - 3) / 6).ceil
    end

    def coordinates
        r = self.ring

        max_in_ring_r = 3*r*(r+1) + 1

        d = max_in_ring_r - self

        case d
        when (0*r)..(1*r) then b = d-0*r; Vector[r-b, b]
        when (1*r)..(2*r) then b = d-1*r; Vector[-b, r]
        when (2*r)..(3*r) then b = d-2*r; Vector[-r, r-b]
        when (3*r)..(4*r) then b = d-3*r; Vector[b-r, -b]
        when (4*r)..(5*r) then b = d-4*r; Vector[b, -r]
        when (5*r)..(6*r) then b = d-5*r; Vector[r, b-r]
        end
    end

    def sign
        self < 0 ? -1 : 1
    end

    def dist(other)
        dx, dy = *(other.coordinates - self.coordinates)

        (dx.sign == dy.sign) ? (dx.abs + dy.abs) : [dx.abs, dy.abs].max
    end
end

puts 1.dist(10000000000)

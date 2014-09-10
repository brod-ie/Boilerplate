describe 'Server', ->

    it 'can tell 5 is 5', ->
        expect(5).toBe 5

    it 'thinks 4 is more than 5', ->
        expect(4).toBeGreaterThan 5
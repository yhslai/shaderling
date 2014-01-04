#= require ../Block

class Combinator extends Block
  constructor: () ->
    @inPorts = [
      { type: 'hub', hubtypes: [
        'collection@vect3#vertex', 'collection@vect3#color', 'collection@face'
      ]}
    ]
    @outPorts = [
      { type: 'member@mesh' }
    ]
    @id = 'c'

    super 

window.Combinator = Combinator




#= require ../Block

class Combinator extends Block
  constructor: () ->
    @inPortTypes = [
      { type: 'hub', hubtypes: [
        'collection@vect3#vertex', 'collection@vect3#color', 'collection@face'
      ]}
    ]
    @outPortTypes = [
      { type: 'member@mesh' }
    ]
    @id = 'c'

    super 

window.Combinator = Combinator




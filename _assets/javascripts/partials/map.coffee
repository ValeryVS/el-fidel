if $('#contacts-map').length
  offices = [
    {
      latlng: "59.866608,30.472049"
      zoom: 16
    }
    {
      latlng: "55.723978,37.702058,55.723978"
      zoom: 16
    }
  ]

  officesData = offices.map((o) ->
    o.latlng = o.latlng.split(",")
    o
  )

  ymaps.ready ->
    contactMap = new ymaps.Map("contacts-map",
      center: officesData[0].latlng
      zoom: officesData[0].zoom
    )
    for i in [0...officesData.length]
      office = officesData[_i]
      officePlacemark = new ymaps.Placemark(office.latlng, {}, {
          iconLayout: 'default#image',
          iconImageHref: 'assets/images/mark.png',
          iconImageSize: [80, 80],
          iconImageOffset: [-40, -40]
      })
      # officePlacemark = new ymaps.GeoObject(geometry:
      #   type: "Point"
      #   coordinates: office.latlng
      # )
      contactMap.geoObjects.add officePlacemark
    $('[role="offices-link"][data-order="0"]').addClass "active"
    $('[role="offices-link"]').bind "click", (e) ->
      $('[role="offices-link"]').removeClass "active"
      $(@).addClass "active"
      officeOrder = $(@).data("order")
      contactMap.setCenter officesData[officeOrder].latlng
      contactMap.setZoom officesData[officeOrder].zoom

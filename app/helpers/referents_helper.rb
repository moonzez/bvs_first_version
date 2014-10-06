module ReferentsHelper
  def build_activ_link(referent, activ)
    image = (activ == 'activ') ? 'activate.png' : 'temporary.png'
    title = (activ == 'activ') ? 'Aktivieren' : 'Temporär deaktivieren'
    link_to(
      image_tag(image, size: '20'),
      change_activ_referent_path(referent, activ: activ), title: title, remote: true, method: :put
    )
  end
end

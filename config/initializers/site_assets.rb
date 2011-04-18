class SiteAssets
  cattr_accessor :prefix

  MAP = {
    :header_bg => '/header/header-bg.jpg',
    :published => '/icons/published.png',
    :loading => '/icons/loading.gif',
    :thebasics_create => '/icons/create.png',
    :thebasics_add => '/icons/add.png',
    :thebasics_enjoy => '/icons/enjoy.png'
  }

  def self.[](name)
    '%s%s' % [self.prefix, MAP[name] || '/default/feed/unknown.png']
  end

end

SiteAssets.prefix = Rails.application.config.site_assets_prefix
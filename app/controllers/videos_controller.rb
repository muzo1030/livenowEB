class VideosController < ApplicationController
  include VideosHelper

  def index
    get_data("live" || "ライブ")#検索条件設定
    @movies_page = Kaminari.paginate_array(@movies).page(params[:page]).per(8)
  end

  def search
    if params[:search].blank?
       get_data("live" || "ライブ")
    else
      get_data("live" + params[:search] || "ライブ" + params[:search])#2つの検索条件でキーワード検索
    end
    @movies_page = Kaminari.paginate_array(@movies).page(params[:page]).per(8)
    render :index
  end




  def get_data(keyword)
    opts = Trollop::options do
      opt :q, 'Search term', :type => String, :default => keyword
      opt :max_results, 'Max results', :type => :int, :default => 50#APIのMAX件数取得
      opt :order, 'order', :type => String, :default => 'date'#新着順で取得
      opt :regionCode, 'region', :type => String, :default => 'JP'#第一言語を日本語で取得
      opt :type, 'type', :type => String, :default => 'video'
      opt :video_category_id, 'video category id', :type => String, :default => '10'#音楽カテゴリで取得
      opt :video_definition, 'video definition', :type => String, :default => 'high'#HD動画のみ取得
    end
    client, youtube = get_service
    begin

      search_response = client.execute!(
        :api_method => youtube.search.list,
        :parameters => {
          :part => 'snippet',
          :q => opts[:q],
          :maxResults => opts[:max_results],
          :order => opts[:order],
          :regionCode => opts[:regionCode],
          :type => opts[:type],
          :videoCategoryId => opts[:video_category_id],
          :videoDefinition => opts[:video_definition]
        }
        )

    @movies = search_response.data.items#Jsonの中身が多かったので必要な情報のみ受けれるようにしています。

    rescue Google::APIClient::TransmissionError => e
      puts e.result.body
    end

	end

end

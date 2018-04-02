class VideosController < ApplicationController

  def index
    get_data("live" || "ライブ") #検索条件設定
    @movies_page = Kaminari.paginate_array(@movies).page(params[:page]).per(8)
    @my_lists = current_user.my_lists
  end

  def search
    if params[:search].blank?
       get_data("live" || "ライブ")
    else
      get_data("live" + params[:search] || "ライブ" + params[:search])#2つの検索条件でキーワード検索
    end
    @movies_page = Kaminari.paginate_array(@movies).page(params[:page]).per(8)
    @my_lists = current_user.my_lists
    render :index
  end




  def get_data(keyword)
    require 'google/apis/youtube_v3'
    # require 'trollop'
    # opts = Trollop::options do
    #   opt :q, 'Search term', :default => keyword
    #   opt :max_results, 'Max results', :default => 8 #APIのMAX件数取得
    #   opt :order, 'order', :default => 'date' #新着順で取得
    #   opt :regionCode, 'region', :default => 'JP' #第一言語を日本語で取得
    #   opt :type, 'type', :default => 'video'
    #   opt :video_category_id, 'video category id', :default => '10' #音楽カテゴリで取得
    #   # opt :video_definition, 'video definition', :default => 'high' #HD動画のみ取得
    # end

    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = 'AIzaSyAUat8tsl5tjcPzcsvxs8l3hTW0_203zy0'

    # search_response = youtube.list_searches("id",
    #   q: opts[:q],
    #   max_results: opts[:max_results],
    #   order: opts[:order],
    #   region_code: opts[:regionCode],
    #   type: opts[:type],
    #   video_category_id: opts[:video_category_id]
    #   )

    search_response = youtube.list_searches("id",
      q: keyword,
      max_results: 8,
      order: "date",
      region_code: "JP",
      type: "video",
      video_category_id: "10"
      )

    @movies = search_response.items #Jsonの中身が多かったので必要な情報のみ受けれるようにしています。
    # @movies = []
  end

end

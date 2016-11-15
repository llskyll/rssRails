class UserBlogInfosController < ApplicationController
  before_action :set_user_blog_info, only: [:show, :edit, :update, :destroy]
   require 'feedjira'

    $alist = []

    def perse(url)
      feed = Feedjira::Feed.fetch_and_parse(url)
      feed.entries.each do |item|
        $alist.push(item)
      end
    end

  # GET /user_blog_infos
  # GET /user_blog_infos.json
  def index
    # カレントページはGETパラメーターとして受け取ってくる想定
    @page = params['page'].to_i
     # リスト初期化
    $alist = []
    @userBlogInfos = UserBlogInfo.all
    
    url = []
    @userBlogInfos.each do |userBlogInfo|
        if userBlogInfo.feedUrl.present?
           url.push(userBlogInfo.feedUrl)
        else
          puts "no"
        end
    end
    
    url.each do |item|
      perse(item)
    end

    #時系列順にソート　-にすることで降順にする。
    @sorted = $alist.sort{|aa, bb|
        -(aa.published.to_i <=> bb.published.to_i)
      }
    #ページサイズ
    #ページネーション設定
    @rss_list = Kaminari.paginate_array(@sorted).page(params[:page]).per(10)
  end

  #ra GET /user_blog_infos/1
  # GET /user_blog_infos/1.json
  def show
  end

  # GET /user_blog_infos/new
  def new
    @user_blog_info = UserBlogInfo.new
  end

  # GET /user_blog_infos/1/edit
  def edit
  end

  # POST /user_blog_infos
  # POST /user_blog_infos.json
  def create
    @user_blog_info = UserBlogInfo.new(user_blog_info_params)

    respond_to do |format|
      if @user_blog_info.save
        format.html { redirect_to @user_blog_info, notice: 'User blog info was successfully created.' }
        format.json { render :show, status: :created, location: @user_blog_info }
      else
        format.html { render :new }
        format.json { render json: @user_blog_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_blog_infos/1
  # PATCH/PUT /user_blog_infos/1.json
  def update
    respond_to do |format|
      if @user_blog_info.update(user_blog_info_params)
        format.html { redirect_to @user_blog_info, notice: 'User blog info was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_blog_info }
      else
        format.html { render :edit }
        format.json { render json: @user_blog_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_blog_infos/1
  # DELETE /user_blog_infos/1.json
  def destroy
    @user_blog_info.destroy
    respond_to do |format|
      format.html { redirect_to user_blog_infos_url, notice: 'User blog info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_blog_info
      @user_blog_info = UserBlogInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_blog_info_params
      params.require(:user_blog_info).permit(:userId, :userName, :blogUrl, :feedUrl)
    end
end

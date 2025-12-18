require "fileutils"

class SearchController < ApplicationController
  def index
  end

  def results
    @repo_url = params[:query]


    #validate URL format
    if valid_git_url?(@repo_url)

      begin
        #defines temporary directory for cloning
        repo_name = File.basename(@repo_url, ".git")
        temp_dir = Rails.root.join("tmp", repo_name).to_s

        #remove existing directory to avoid git clone failure
        if Dir.exist?(temp_dir)
          FileUtils.rm_rf(temp_dir)
        end

        #clone the repository
        #--depth 1 to avoid cloning full history and faster
        success_clone = system("git clone --depth 1 \"#{@repo_url}\" \"#{temp_dir}\"")

        #successs clone
        if success_clone
          @message = "Repository cloned successfully."
          @tree_data = build_tree(temp_dir)
          @repo_name = repo_name
        else
          @message = "Failed to clone the repository."
          @tree_data = []
        end
      
      #exception handling
      rescue => e
        @message = "An error occurred: #{e.message}"
        @files = []
      end 
    else
      @message = "Invalid GitHub repository URL. Must be HTTPS and end with .git"
      @files = []
    end

  end

  def file
    repo_dir = Rails.root.join("tmp", params[:repo]).to_s
    file_path = File.expand_path(File.join(repo_dir, params[:path]))

    unless file_path.start_with?(repo_dir)
      render plain: "Invalid file path", status: :forbidden
      return
    end

    if File.file?(file_path)
      render plain: File.read(file_path)
    else
      render plain: "File not found", status: :not_found
    end
  end

  private
  def valid_git_url?(url)
    url =~ /\Ahttps:\/\/github\.com\/[\w.-]+\/[\w.-]+\.git\z/
  end

  def build_tree(path, root = path)
    Dir.children(path).map do |entry|
      full_path = File.join(path, entry)
      relative_path = full_path.sub("#{root}/", "")

      if File.directory?(full_path)
        {
          text: entry,
          children: build_tree(full_path, root)
        }
      else
        {
          text: entry,
          icon: "jstree-file",
          data: { path: relative_path }
        }
      end
    end
  end
end

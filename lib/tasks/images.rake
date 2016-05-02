namespace :images do
    desc "TODO"
    task :recreate => :environment do
        for image in Image.all
            puts image.file.recreate_versions!
        end
    end
end
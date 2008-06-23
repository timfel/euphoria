require "rbconfig"
require "rake/clean"

sitelibdir = ENV["RUBYLIBDIR"] || Config::CONFIG["sitelibdir"]
destdir = "#{ENV["DESTDIR"]}"
prefix = ENV["PREFIX"] || "/usr/"

themes = ["iio", "winter"].map do |t|
	"data/themes/#{t}/#{t}.edj"
end

CLOBBER.include(themes)

task :default => :themes
task :themes => themes

rule ".edj" => [".edc"] do |t|
	Dir.chdir(File.dirname(t.source)) do
		sh "edje_cc -id img -id images " +
		   "-fd ../../fonts -fd fonts #{File.basename(t.source)}"
	end
end

task :install => :themes do |t|
	ddir = destdir + prefix + "/bin"
	FileUtils::Verbose.install("bin/euphoria", ddir, :mode => 0755)

	ddir = destdir + sitelibdir + "/euphoria"
	FileUtils::Verbose.mkdir_p(ddir) unless File.directory?(ddir)
	FileUtils::Verbose.install(Dir["lib/*.rb"], ddir, :mode => 0644)

	ddir = destdir + prefix + "/share/euphoria/themes"
	FileUtils::Verbose.mkdir_p(ddir) unless File.directory?(ddir)
	FileUtils::Verbose.install(themes, ddir, :mode => 0644)
end

defmodule NeteaseMusicApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :netease_music_api,
      version: "1.0.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      dialyzer: [plt_add_deps: :transitive],
      # Docs
      name: "NeteaseMusicAPI",
      source_url: "https://github.com/fimars/netease_music_api",
      docs: [main: "README", # The main page in the docs
              extras: ["README.md"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {NeteaseMusicApi.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:httpoison, "~> 0.13"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.16", only: [:dev], runtime: false}
    ]
  end

  defp description do
    "NeteaseMusic API's Elixir version base Plug."
  end

  defp package do
    [
      # These are the default files included in the package
      files: ["lib", "mix.exs", "README*", "README*", "LICENSE*"],
      maintainers: ["fimars"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/fimars/netease_music_api"}
    ]
  end
end

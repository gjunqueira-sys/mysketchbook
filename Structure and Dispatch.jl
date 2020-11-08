### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 439e1de0-0033-11eb-30fd-fba8bf05f801
using Images

# ╔═╡ 027b3790-002d-11eb-2808-6b697f8f496d
myonehatvector = [0, 1, 0, 0, 0, 0] #hot vectors are all zeroes and have one "hot" 1 number, with one hot element on number 2 position

# ╔═╡ b73324d0-002e-11eb-152a-554c7bb16b1d
struct OneHot <:AbstractVector{Int}
	n::Int
	k::Int
end

# ╔═╡ 3afb1b10-002f-11eb-2cef-3f83b763da9c
x = 1 +2

# ╔═╡ 1affbd0e-0030-11eb-003a-2f52a00e1636
expr = :(1 + 2)

# ╔═╡ 79b77af0-0030-11eb-1455-079c74d2f504
md"Julia leaves the expression alone"

# ╔═╡ 88540510-0030-11eb-3a7a-03dc1301c181
typeof(expr)

# ╔═╡ 918f4d10-0030-11eb-0775-91ad9c16de7c
md"As an exmaple, we can create the following expression"

# ╔═╡ 9b89030e-0030-11eb-25bd-e5d3159bda51
exprt3= :(y+1)

# ╔═╡ b43d2b70-0030-11eb-1dae-0d676f8a0c33
md"Since expressions are Julia objects, we can examine them using Julia's usual mechanisms. For example, the *dump* function allows us to inspect the fields inside an object"


# ╔═╡ 88278160-0031-11eb-0bd0-c1b267f23d2e


# ╔═╡ 185bf7d0-0031-11eb-0877-5b34510f7e9e
dump(exprt3)

# ╔═╡ 2a411d40-0031-11eb-1213-8742066a6460
exprt3.head

# ╔═╡ 96d04080-0031-11eb-25d3-c584cf40bfea
exprt3.args

# ╔═╡ 9651c1b0-0031-11eb-1bb7-1df5ce08361e
md"because they are standard julia objects, I can modify them with code"

# ╔═╡ ee96a660-0031-11eb-16a7-a77caadbab2c
exprt3.args[2]

# ╔═╡ efd39330-0031-11eb-01f6-f1abff4c20b3
exprt3.args[2]=:x

# ╔═╡ ef38d9d0-0031-11eb-3b65-837c0482262e
exprt3

# ╔═╡ 018b4000-0032-11eb-3a3e-5747250f86cf
outer(v,w)=[x * y for x in v, y in w]

# ╔═╡ 00ac2aa0-0032-11eb-2184-113a5b40dbea
outer(1:10, 1:10)

# ╔═╡ 47f47520-0032-11eb-3199-e5fe1abf344c
md"some flags are a simple example of this"

# ╔═╡ 47d1aae0-0032-11eb-28b4-3b6745562d09
flag = outer([1, 0.1, 2], ones(6))

# ╔═╡ 47b45ee2-0032-11eb-00e0-cd5769c25c19
show_image(flag)

# ╔═╡ 479676a0-0032-11eb-1f6d-c54246c8acbf


# ╔═╡ 46cb5e70-0032-11eb-2c00-0f44a67e91a5


# ╔═╡ 46aa68f0-0032-11eb-116e-4fddc6b6af07


# ╔═╡ Cell order:
# ╠═027b3790-002d-11eb-2808-6b697f8f496d
# ╠═b73324d0-002e-11eb-152a-554c7bb16b1d
# ╠═3afb1b10-002f-11eb-2cef-3f83b763da9c
# ╠═1affbd0e-0030-11eb-003a-2f52a00e1636
# ╟─79b77af0-0030-11eb-1455-079c74d2f504
# ╠═88540510-0030-11eb-3a7a-03dc1301c181
# ╟─918f4d10-0030-11eb-0775-91ad9c16de7c
# ╠═9b89030e-0030-11eb-25bd-e5d3159bda51
# ╟─b43d2b70-0030-11eb-1dae-0d676f8a0c33
# ╠═88278160-0031-11eb-0bd0-c1b267f23d2e
# ╠═185bf7d0-0031-11eb-0877-5b34510f7e9e
# ╠═2a411d40-0031-11eb-1213-8742066a6460
# ╠═96d04080-0031-11eb-25d3-c584cf40bfea
# ╟─9651c1b0-0031-11eb-1bb7-1df5ce08361e
# ╠═ee96a660-0031-11eb-16a7-a77caadbab2c
# ╠═efd39330-0031-11eb-01f6-f1abff4c20b3
# ╠═ef38d9d0-0031-11eb-3b65-837c0482262e
# ╠═018b4000-0032-11eb-3a3e-5747250f86cf
# ╠═00ac2aa0-0032-11eb-2184-113a5b40dbea
# ╟─47f47520-0032-11eb-3199-e5fe1abf344c
# ╠═47d1aae0-0032-11eb-28b4-3b6745562d09
# ╠═439e1de0-0033-11eb-30fd-fba8bf05f801
# ╠═47b45ee2-0032-11eb-00e0-cd5769c25c19
# ╠═479676a0-0032-11eb-1f6d-c54246c8acbf
# ╠═46cb5e70-0032-11eb-2c00-0f44a67e91a5
# ╠═46aa68f0-0032-11eb-116e-4fddc6b6af07

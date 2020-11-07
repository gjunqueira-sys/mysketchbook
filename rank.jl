### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 6ded684e-010d-11eb-1022-e391f5dc3d44
using Images, ColorSchemes

# ╔═╡ ef44d3c0-010d-11eb-0992-51d723a7aba7
using LinearAlgebra

# ╔═╡ 508eea5e-0110-11eb-3570-0b9e05d8b3c5
using Plots

# ╔═╡ b6b172d0-010c-11eb-119f-835053eec796
begin
	show_image(M) = get.(Ref(ColorSchemes.rainbow), M ./ maximum(M))
	show_image(x::AbstractVector) = show_image(x')
end

# ╔═╡ d61f4160-010c-11eb-2527-e11389647166
md"""
# Finding structure in data
"""

# ╔═╡ f4a5e440-010c-11eb-1f99-33fc40240bdb
md"In this notebook we will look at one way to analyse, understand and simplify data. We will look at the ideas and intuition behind principal component analysis, a technique to find the most important directions and dimensions in a data set. This is very closely related to the SVD (singular-value decomposition) "

# ╔═╡ 04299a0e-010d-11eb-1afe-872f9c60e3b6
md"## Flags"

# ╔═╡ 0b876f80-010d-11eb-0284-1ffd71f80a26
md"Let's start off by recalling the idea of a **multiplication table**, also called an **outer product**:"

# ╔═╡ 0ed959a0-010d-11eb-3f81-cd49986ef3a1
outer(v, w) = [x * y for x in v, y in w]

# ╔═╡ 0fdaeb20-010d-11eb-02cb-2f7f9f7008a2
outer(1:10, 1:10)

# ╔═╡ 0fa7cd30-010d-11eb-00bc-2bc07615203b
md"Some flags are a simple example of this:"

# ╔═╡ 0eb88b32-010d-11eb-3aea-bba89b35385c
flag=outer([1, 0.1, 2], ones(6))

# ╔═╡ 110699e0-010d-11eb-28e7-49220d2c4bcf
show_image(flag)

# ╔═╡ a3ef6570-010d-11eb-1fcb-63685af87837


# ╔═╡ 10e9ea20-010d-11eb-1758-538de07bf290
flag2 = outer([1, 0.1, 2], [1, 1, 1, 3, 3, 3])

# ╔═╡ 948e79e0-010d-11eb-0b0d-1337e3f3fab0
show_image(flag2)

# ╔═╡ 9566b170-010d-11eb-2d2c-232d4c1ca3a1
md"
# Rank of a Matrix
"

# ╔═╡ 9ddf93d0-010d-11eb-17ad-598fa213d271
md"How does the **Rank** of a Matrix related to its multiplication table?"

# ╔═╡ 9cb0d7d0-010d-11eb-11c5-1d7755500d4f
md"We know that the Rank 1 Matrix only has one Linear Independant Column. All other columns are linearnly depedant.

Therefore, a Matrix that can be written exactly as a **single multiplication Table** is called a **Rank 1** Matrix."

# ╔═╡ 9d50e860-010d-11eb-2a2d-bb694ac0e396
md"Flag is the product of only one multiplication table"

# ╔═╡ ef8908b0-010d-11eb-3478-d3c8da6f726c
flag

# ╔═╡ eee68720-010d-11eb-2a43-27f36b21b9a7
rank(flag)

# ╔═╡ ee1861b0-010d-11eb-1b94-d15df53784dc
md"Flag2 is also the product of only one multiplication table"

# ╔═╡ dfd59ae0-010e-11eb-3491-4fc7091208b3
rank(flag2)

# ╔═╡ 4f6490a0-010f-11eb-3774-577ba0c04be9
md"Let's see what a general rank-1 matrix looks like:"

# ╔═╡ 5030e150-010f-11eb-2f5d-972aa9a07e4f
image = outer([1; 0.4; rand(50)], rand(500));

# ╔═╡ 50c977d0-010f-11eb-22c7-076fbf159b74
rank(image)

# ╔═╡ 51ad4820-010f-11eb-33c4-a9426ac0142f
show_image(image)

# ╔═╡ 52384a10-010f-11eb-1c19-bf12518ca730
md"Given this matrix, how can we discover that it is close to a structured, rank-1 matrix? We would like to be able to find this out and say that the matrix is close to a simple one."

# ╔═╡ 4e98bfb0-0110-11eb-0a4e-fb11bafa789c
md"## Images as data"

# ╔═╡ 5137fba0-0110-11eb-0547-fd2062507dca
md"Images are just one example of the many different types of data we come across in the world.

Let's treat the image as a **data matrix**, where each column of the image / matrix is a **vector** representing one observation of data. (In data science it is often the rows that correspond to observations.)

Let's try to visualize those vectors, taking just the first two rows of the image as the $x$ and $y$ coordinates of our data points:"

# ╔═╡ 511a1360-0110-11eb-1506-9daa4dad30dc
show_image(image[1:2, 1:20])

# ╔═╡ 50ff5f6e-0110-11eb-01c4-499ff6c8ad8a
image[1:2, 1:20]

# ╔═╡ 50e5bcf0-0110-11eb-1670-131f453a7f74
begin 
	xx = image[:, 1]
	yy = image[:, 2]
end

# ╔═╡ 50cb3012-0110-11eb-1e5f-bd84658e3cd8
md"## Plotting data"

# ╔═╡ 50af6ab0-0110-11eb-1691-cb88b2312940
md"We would like to **visualise** this data. There are various plotting packages that we could use. We will use `Plots.jl`:"

# ╔═╡ 507065e0-0110-11eb-13b2-21014983476a
scatter(xx, yy, alpha=0.5, framestyle=:origin, label="original image", leg=:topleft,
		xlabel="x values", ylabel="y values")

# ╔═╡ 5035f4f0-0110-11eb-25a5-2d90a1826a90
md"We see that the exact rank-1 matrix has columns that **lie along a line**, since they are just multiples of one another.

The approximate rank-1 matrix has columns that **lie *close to* a line**!"

# ╔═╡ 4fee64a0-0110-11eb-287a-d5b42bfe835d


# ╔═╡ 4f315630-0110-11eb-2e84-93d9348afdaf


# ╔═╡ Cell order:
# ╠═b6b172d0-010c-11eb-119f-835053eec796
# ╠═6ded684e-010d-11eb-1022-e391f5dc3d44
# ╟─d61f4160-010c-11eb-2527-e11389647166
# ╟─f4a5e440-010c-11eb-1f99-33fc40240bdb
# ╠═04299a0e-010d-11eb-1afe-872f9c60e3b6
# ╟─0b876f80-010d-11eb-0284-1ffd71f80a26
# ╠═0ed959a0-010d-11eb-3f81-cd49986ef3a1
# ╠═0fdaeb20-010d-11eb-02cb-2f7f9f7008a2
# ╠═0fa7cd30-010d-11eb-00bc-2bc07615203b
# ╠═0eb88b32-010d-11eb-3aea-bba89b35385c
# ╠═110699e0-010d-11eb-28e7-49220d2c4bcf
# ╠═a3ef6570-010d-11eb-1fcb-63685af87837
# ╠═10e9ea20-010d-11eb-1758-538de07bf290
# ╠═948e79e0-010d-11eb-0b0d-1337e3f3fab0
# ╟─9566b170-010d-11eb-2d2c-232d4c1ca3a1
# ╟─9ddf93d0-010d-11eb-17ad-598fa213d271
# ╟─9cb0d7d0-010d-11eb-11c5-1d7755500d4f
# ╠═9d50e860-010d-11eb-2a2d-bb694ac0e396
# ╠═ef8908b0-010d-11eb-3478-d3c8da6f726c
# ╠═ef44d3c0-010d-11eb-0992-51d723a7aba7
# ╠═eee68720-010d-11eb-2a43-27f36b21b9a7
# ╠═ee1861b0-010d-11eb-1b94-d15df53784dc
# ╠═dfd59ae0-010e-11eb-3491-4fc7091208b3
# ╠═4f6490a0-010f-11eb-3774-577ba0c04be9
# ╠═5030e150-010f-11eb-2f5d-972aa9a07e4f
# ╠═50c977d0-010f-11eb-22c7-076fbf159b74
# ╠═51ad4820-010f-11eb-33c4-a9426ac0142f
# ╠═52384a10-010f-11eb-1c19-bf12518ca730
# ╟─4e98bfb0-0110-11eb-0a4e-fb11bafa789c
# ╟─5137fba0-0110-11eb-0547-fd2062507dca
# ╠═511a1360-0110-11eb-1506-9daa4dad30dc
# ╠═50ff5f6e-0110-11eb-01c4-499ff6c8ad8a
# ╠═50e5bcf0-0110-11eb-1670-131f453a7f74
# ╠═50cb3012-0110-11eb-1e5f-bd84658e3cd8
# ╠═50af6ab0-0110-11eb-1691-cb88b2312940
# ╠═508eea5e-0110-11eb-3570-0b9e05d8b3c5
# ╠═507065e0-0110-11eb-13b2-21014983476a
# ╟─5035f4f0-0110-11eb-25a5-2d90a1826a90
# ╠═4fee64a0-0110-11eb-287a-d5b42bfe835d
# ╠═4f315630-0110-11eb-2e84-93d9348afdaf

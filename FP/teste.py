def valor(q, j, count):
	if q <= 0 or j <= 0 or count <= 0:
		raise ValueError("Valor(es) icountválido(s)")
	return q * (1 + j) ** count

def duplicou(q, j):
	count = 0
	while valor(q, j, count) <= 2 * q:
		count += 1
	return count

print(valor)
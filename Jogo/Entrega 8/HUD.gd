extends CanvasLayer

var total_itens: int = 0

func adicionar_item() -> void:
	total_itens += 1
	$Contador.text = "Itens: " + str(total_itens)

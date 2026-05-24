extends Control

@onready var inputID = $inputID
@onready var btnBuscar = $btnBuscar
@onready var lblErro = $lblErro
@onready var lblID = $lblID
@onready var lblNome = $lblNome
@onready var lblPai = $lblPai
@onready var lblMae = $lblMae
@onready var listaJutsus = $ScrollContainer/listaJutsus
@onready var httpRequest = $HTTPRequest


func _on_btn_buscar_pressed() -> void:
	var idPersonagem = inputID.text.strip_edges()
	
	if idPersonagem == "":
		return
	
	btnBuscar.disabled = true
	lblErro.text = "Buscando as informações do(a) personagem..."
	
	var url = "http://api-dattebayo.vercel.app/characters/" + idPersonagem
	httpRequest.request(url)
	
	pass # Replace with function body.


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	pass # Replace with function body.

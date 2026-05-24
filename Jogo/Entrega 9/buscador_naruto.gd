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
	removerDadosAntigos()
	
	var url = "https://dattebayo-api.onrender.com/characters/" + idPersonagem
	httpRequest.request(url)
	pass # Replace with function body.


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	btnBuscar.disabled = false
	
	if response_code == 404:
		lblErro.text = "Erro: personagem não escontrado!"
		return
	elif response_code != 200:
		lblErro.text = "Erro na requisição. Código: " + str(response_code)
		return
	
	lblErro.text = ""
	
	var json = JSON.new()
	var erro = json.parse(body.get_string_from_utf8())
	
	if erro == OK:
		var dados = json.data
		preencherInformacoes(dados)
	else:
		lblErro.text = "Erro ao ler os dados recebidos da API"
	pass # Replace with function body.

func preencherInformacoes(dados: Dictionary):
	lblID.text = "ID do personagem: " + str(dados.get("id",""))
	lblNome.text = "Nome: " + dados.get("name","Desconhecido")
	
	var family = dados.get("family", {})
	lblPai.text = "Pai: " + family.get("father", "Desconhecido")
	lblMae.text = "Mãe: " + family.get("mother", "Desconhecido")
	
	var jutsus = dados.get("jutsu", [])
	if jutsus.size() > 0:
		for item in jutsus:
			var lblJutsu = Label.new()
			lblJutsu.text = "* " + str(item)
			listaJutsus.add_child(lblJutsu)
	
func removerDadosAntigos():
	lblID.text = "ID do personagem: "
	lblNome.text = "Nome: "
	lblPai.text = "Pai: "
	lblMae.text = "Mãe: "
	
	for jutsu in listaJutsus.get_children():
		jutsu.queue_free()

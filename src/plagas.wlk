
class Elemento{
	method esBueno()
	method recibirAtaque(plaga)
}

class Hogar inherits Elemento{
	var nivelMugre 
	var confort
	override method esBueno() = nivelMugre <= (confort / 2)
	override method recibirAtaque(plaga){ nivelMugre = 0.max( nivelMugre - plaga.nivelDanio()) }
}

class Huerta inherits Elemento{
	var capacidadProd
	override method esBueno() = capacidadProd > nivel
	override method recibirAtaque(plaga){ 
		capacidadProd = 0.max(capacidadProd - plaga.nivelDanio() * 0.1 -
		if(plaga.transmiteEnfermedad())10 else 0)
	}
}

object nivel{
	var property nivelProd = 3
}

class Mascota inherits Elemento{
	var nivelSalud
	override method esBueno() = nivelSalud > 250
	override method recibirAtaque(plaga){ if(plaga.transmiteEnfermedad()) nivelSalud = 0.max( nivelSalud - plaga.nivelDanio()) }
}

class Barrios{
	const elementos = []
	method agregarElemento(elemento) {
		elementos.add(elemento)
	}
	method eliminarElemento(elemento) {
		elementos.remove(elemento)
	}
	method esCopado() = self.elementosBuenos() > self.elementosNoBuenos()
	method elementosBuenos() = elementos.count({e => e.esBueno()}) 
	method elementosNoBuenos() = elementos.count({e => ! e.esBueno()}) 
}

class Plagas{
	var property poblacion
	method nivelDanio()
	method transmiteEnfermedad() = poblacion >= 10
	method atacarElemento(){ poblacion = poblacion * 0.1 } 
}

class Cucarachas inherits Plagas{
	var pesoPromedio
	override method nivelDanio() = poblacion / 2
	override method transmiteEnfermedad() = super() and pesoPromedio >= 10
	override method atacarElemento(){ super() pesoPromedio += 2 }
}

class Pulgas inherits Plagas{
	override method nivelDanio() = poblacion * 2
}

class Garrapatas inherits Pulgas{
	override method atacarElemento(){ super() super() }
}

class Mosquitos inherits Plagas{
	override method nivelDanio() = poblacion 
	override method transmiteEnfermedad() = super() and poblacion % 3 == 0
}

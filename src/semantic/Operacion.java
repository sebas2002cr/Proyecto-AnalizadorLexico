package semantic;

import java.util.ArrayList;

public class Operacion extends Expresion {
	ArrayList<Expresion> elementos = new ArrayList<Expresion>();
	Expresion valor;
	Operacion izquierda;
	Operando operando;
	Operacion derecha;

	Operacion() {}

	Operacion(ArrayList<Expresion> elementos) {
		this.priorizarParentesis(elementos);
		System.out.println(this.print(0));
	}

	Operacion(Expresion valor) {
		this.valor = valor;
	}

	public static Operando operando(String simbolo) {
		return new Operando(simbolo);
	}

	private void priorizarParentesis(ArrayList<Expresion> elementos) {
		ArrayList<ArrayList<Expresion>> subOperaciones = new ArrayList<ArrayList<Expresion>>();
		subOperaciones.add(this.nuevaSubExpresion());
		for (Expresion elemento : elementos) {
			// Añadir el elemento actual a la última operación de cada sub-operación
			for (ArrayList<Expresion> subOperacion : subOperaciones) {
				Expresion ultima = this.ultimaExpresion(subOperacion);
				if(ultima.getClass() == Operacion.class){
					((Operacion)ultima).elementos.add(elemento);
				}
			}

			// Tratamiento para operandos
			if(elemento.getClass() == Operando.class) {
				Operando operando = (Operando)elemento;
				// Si es un paréntesis abierto se añade una nueva sub-operación
				if(operando.tipo == Operandos.PARENTESIS_ABIERTO) {
					ultimaOperacion(subOperaciones).elementos.add(elemento);
					subOperaciones.add(this.nuevaSubExpresion());
				}

				// Si es un paréntesis cerrado, prioriza por signo
				// Quitamos la última sub-operación
				// Copiamos el resultado de la priorización por signo en el último elemento de la última sub-operación
				else if(operando.tipo == Operandos.PARENTESIS_CERRADO) {
					Operacion operacion = this.priorizarSignos(this.ultimaSubExpresion(subOperaciones));
					subOperaciones.remove(subOperaciones.size() - 1);
					this.ultimaOperacion(subOperaciones).copiar(operacion);
				}

				// Caso para operandos, añadimos el operando y una nueva operación a la última sub-operación
				else {
					var ultima = this.ultimaSubExpresion(subOperaciones);
					ultima.add(operando);
					ultima.add(new Operacion());
				}
			}

			// Tratamiento para no operandos(operadores)
			else {
				var ultima = this.ultimaOperacion(subOperaciones);
				ultima.elementos.add(elemento);
				ultima.valor = elemento;
			}
		}
		var operacion = this.priorizarSignos(subOperaciones.get(0));
		this.copiar(operacion);
	}

	private Operacion priorizarSignos(ArrayList<Expresion> subOperacion) {
		// Si hay sólo un elemento se devuelve como valor
		if(subOperacion.size() == 1) {
			var operacion = (Operacion)subOperacion.get(0);
			return operacion;
		}

		// Buscamos el índice menos prioritario
		int menosPrioritario = subOperacion.size() - 2;
		for (int i = subOperacion.size() - 1; i >= 0; i--) {
			var elemento = subOperacion.get(i);
			if(elemento.getClass() == Operando.class) {
				var operandoActual = (Operando)elemento;
				var operandoMenosPrioritario = (Operando)subOperacion.get(menosPrioritario);
				if(operandoActual.prioridad() < operandoMenosPrioritario.prioridad()) {
					menosPrioritario = i;
				}
			}
		}

		// Creamos la nueva operación a devolver
		var operacion = new Operacion();
		operacion.izquierda = this.priorizarSignos(subSubExpresion(subOperacion, 0, menosPrioritario));
		operacion.operando = (Operando)subOperacion.get(menosPrioritario);
		operacion.derecha = this.priorizarSignos(subSubExpresion(subOperacion, menosPrioritario + 1, subOperacion.size()));
		return operacion;
	}

	private void copiar(Operacion origen) {
		this.valor = origen.valor;
		this.izquierda = origen.izquierda;
		this.operando = origen.operando;
		this.derecha = origen.derecha;
	}

	private String print(int nivel) {
		if(this.operando != null) {
			return
				((this.izquierda != null) ? "(" + this.izquierda.print(nivel + 1) + ")" : "") +
				this.operando.toString() +
				((this.derecha != null) ? "(" + this.derecha.print(nivel + 1) + ")" : "");
		}
		if(this.valor != null) {
			return this.valor.toString();
		}
		return "";
	}

	private ArrayList<Expresion> ultimaSubExpresion(ArrayList<ArrayList<Expresion>> subExpresiones) {
		return subExpresiones.get(subExpresiones.size() - 1);
	}

	private Expresion ultimaExpresion(ArrayList<Expresion> expresiones) {
		return expresiones.get(expresiones.size() - 1);
	}

	private Operacion ultimaOperacion(ArrayList<ArrayList<Expresion>> subOperaciones) {
		return (Operacion)ultimaExpresion(ultimaSubExpresion(subOperaciones));
	}

	private ArrayList<Expresion> nuevaSubExpresion() {
		ArrayList<Expresion> subOperacion = new ArrayList<Expresion>();
		subOperacion.add(new Operacion());
		return subOperacion;
	}

	private ArrayList<Expresion> subSubExpresion(ArrayList<Expresion> subExpresion, int start, int end) {
		var subList = new ArrayList<Expresion>();
		for(int i=start; i<end; i++){
			subList.add(subExpresion.get(i));
		}
		return subList;
	}
}

enum Operandos {
	OR,
	AND,

	DISTINTO,
	IGUAL,
	MENOR,
	MAYOR,
	MENOR_IGUAL,
	MAYOR_IGUAL,

	SUMA,
	RESTA,

	MULTIPLICACION,
	DIVISION,
	MODULO,
	POTENCIA,

	INCREMENTO,
	DECREMENTO,
	NEGATIVO,
	NOT,

	PARENTESIS_ABIERTO,
	PARENTESIS_CERRADO
}

class Operando extends Expresion {
	Operandos tipo;

	Operando(String simbolo) {
		this.tipo = Operandos.valueOf(simbolo);
	}

	@Override
	public String toString() {
		return tipo.toString();
	}

	int prioridad() {
		return this.tipo.ordinal();
	}
}

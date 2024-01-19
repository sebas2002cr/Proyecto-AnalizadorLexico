package semantic;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class AnalisisSemantico {
	private ArrayList<String> errores = new ArrayList<String>();
	private ArbolSintactico arbol;
	private ArrayList<Variable> variables = new ArrayList<Variable>();
	private int ciclosAbiertos = 0;

	public AnalisisSemantico(ArbolSintactico arbol) {
		this.arbol = arbol;
		this.funcionesUnicas(arbol.funciones);
		for (Funcion funcion : arbol.funciones) {
			this.parametrosUnicos(funcion);
			this.validarBloqueCodigo(funcion.bloqueCodigo, funcion);
			variables.clear();
		}
		System.out.println("\n---------- Análisis semántico iniciado ----------\n");
		for (String error : errores) {
			System.out.println(error);
		}
		System.out.println("\n---------- Análisis semántico realizado ----------");
	}

	private void funcionesUnicas(ArrayList<Funcion> funciones) {
		HashMap<String, Integer> nombres = new HashMap<String, Integer>();
		for (Funcion funcion : funciones) {
			if (nombres.containsKey(funcion.nombre)) {
				nombres.put(funcion.nombre, nombres.get(funcion.nombre) + 1);
			} else {
				nombres.put(funcion.nombre, 1);
			}
		}
		for (Map.Entry<String, Integer> entry : nombres.entrySet()) {
			if(entry.getValue() > 1) {
				this.errores.add("Se repite el nombre de la función: " + entry.getKey());
			}
        }
	}

	private void parametrosUnicos(Funcion funcion) {
		HashMap<String, Integer> nombres = new HashMap<String, Integer>();
		for (Variable parametro : funcion.parametros) {
			variables.add(parametro);
			if (nombres.containsKey(parametro.nombre)) {
				nombres.put(parametro.nombre, nombres.get(parametro.nombre) + 1);
			} else {
				nombres.put(parametro.nombre, 1);
			}
		}
		for (Map.Entry<String, Integer> entry : nombres.entrySet()) {
			if(entry.getValue() > 1) {
				this.errores.add("En la función: " + funcion.nombre + " se repite el parámetro: " + entry.getKey());
			}
        }
	}

	private void validarBloqueCodigo(BloqueCodigo bloqueCodigo, Funcion funcion) {
		int variablesIniciales = this.variables.size();
		for (LineaCodigo lineaCodigo : bloqueCodigo.lineasCodigo) {
			// validamos las expresiones como línea de código
			if(lineaCodigo.getClass() == LineaExpresion.class) {
				LineaExpresion lineaExpresion = (LineaExpresion)lineaCodigo;
				validarExpresion(lineaExpresion.expresion);
			}

			// Validamos que las declaraciones de variables no existan
			if(lineaCodigo.getClass() == DeclaracionesVariables.class) {
				DeclaracionesVariables declaracionesVariables = (DeclaracionesVariables)lineaCodigo;
				for (Variable declaracion : declaracionesVariables.declaraciones) {
					this.validarDeclaracion(declaracion);
				}
			}

			// Validamos que las declaraciones de variables no existan
			if(lineaCodigo.getClass() == AsignacionVariable.class) {
				this.validarAsignacion((AsignacionVariable)lineaCodigo);
			}

			// Validamos que las declaraciones de variables no existan
			if(lineaCodigo.getClass() == DeclaracionAsignacionVariable.class) {
				DeclaracionAsignacionVariable declAsig = (DeclaracionAsignacionVariable)lineaCodigo;
				this.validarDeclaracion(declAsig.declaracion);
				this.validarAsignacion(new AsignacionVariable(declAsig.declaracion.nombre, declAsig.asignacion));
			}

			// Validamos que el tipo a retornar sea igual que el de la función
			if(lineaCodigo.getClass() == Return.class) {
				Return returnLine = (Return)lineaCodigo;
				Tipo tipoReturn = this.validarExpresion(returnLine.valor);
				if(tipoReturn == null || tipoReturn.nombre != funcion.tipo.nombre) {
					errores.add("El tipo del return no coincide con el tipo de la función: " + funcion.nombre);
				}
			}

			// Valida si el break está dentro de un ciclo
			if(lineaCodigo.getClass() == Break.class) {
				if(this.ciclosAbiertos < 1) {
					errores.add("El break no se ubica dentro de un ciclo");
				}
			}

			if(lineaCodigo.getClass() == For.class) {
				this.ciclosAbiertos++;
				For forLine = (For)lineaCodigo;

				int variablesCreadas = 0;
				// Variable en el for
				if(forLine.asigVariable != null) {
					this.validarAsignacion(forLine.asigVariable);
				} else {
					DeclaracionAsignacionVariable declAsig = forLine.decAsiVariable;
					this.validarDeclaracion(declAsig.declaracion);
					this.validarAsignacion(new AsignacionVariable(declAsig.declaracion.nombre, declAsig.asignacion));
				}

				// Finalización del for
				this.validarCondicion(forLine.finalizacion, "for");

				// Continuación del for
				this.validarExpresion(forLine.continuacion);

				// Se valida el bloque de código del for
				this.validarBloqueCodigo(forLine.bloqueCodigo, funcion);
				this.popVariables(variablesCreadas);
				this.ciclosAbiertos--;
			}

			// Validamos un do until
			if(lineaCodigo.getClass() == DoUntil.class) {
				DoUntil doUntil = (DoUntil)lineaCodigo;
				this.validarBloqueCodigo(doUntil.bloqueCodigo, funcion);
				this.validarCondicion(doUntil.condicion, "do until");
			}

			// Validamos un if
			if(lineaCodigo.getClass() == If.class) {
				If ifLine = (If)lineaCodigo;
				this.validarCondicion(ifLine.condicion, "if");
				this.validarBloqueCodigo(ifLine.bloqueCodigo, funcion);
				Condicional condicion = ifLine.sino;
				while(condicion != null) {
					if(condicion.getClass() == Elif.class) {
						Elif elif = (Elif)condicion;
						this.validarCondicion(elif.condicion, "elif");
						this.validarBloqueCodigo(elif.bloqueCodigo, funcion);
					}
					if(condicion.getClass() == Else.class) {
						Else elseC = (Else)condicion;
						this.validarBloqueCodigo(elseC.bloqueCodigo, funcion);
					}
					condicion = condicion.sino;
				}
			}
		}
		this.popVariables(variablesIniciales);
	}

	private Tipo validarExpresion(Expresion expresion) {
		if(expresion.getClass() == Literal.class) {
			Literal literal = (Literal)expresion;
			return literal.tipo;
		}

		if(expresion.getClass() == Read.class) {
			return ((Read)expresion).tipo;
		}

		// validamos si el identificador existe en las variables
		if(expresion.getClass() == Identificador.class) {
			Identificador id = (Identificador)expresion;
			Variable variable = existeVariable(id.identificador);
			if(variable == null){
				errores.add("No se encontró la variable: " + id.identificador);
			} else {
				return variable.tipo;
			}
		}

		// validamos la llamada a una función
		if(expresion.getClass() == LlamadaFuncion.class) {
			LlamadaFuncion llamadaFuncion = (LlamadaFuncion)expresion;
			// Se valida si existe la función
			Funcion funcion = existeFuncion(llamadaFuncion.nombre);
			if(funcion == null) {
				errores.add("La función: " + llamadaFuncion.nombre + " no existe");
			} else {
				// validamos la cantidad de parámetros
				if(llamadaFuncion.argumentos.size() == funcion.parametros.size()) {
					boolean mismosTipos = true;
					// validamos el tipo de los argumentos
					for(int i=0; i < llamadaFuncion.argumentos.size(); i++) {
						Tipo tipoArgumento = this.validarExpresion(llamadaFuncion.argumentos.get(i));
						if(tipoArgumento == null || tipoArgumento.nombre != funcion.parametros.get(i).tipo.nombre) {
							errores.add("Tipo de argumento número " + (i + 1) + " de la llamada a la función " + llamadaFuncion.nombre + " es de tipo incorrecto");
							mismosTipos = false;
						}
					}
					if(mismosTipos) return funcion.tipo;
				} else {
					errores.add("Se pasó una cantidad incorrecta de argumentos a la función: " + funcion.nombre);
				}
			}
		}
		return null;
	}

	private Variable existeVariable(String nombreVariable) {
		for (Variable variable : this.variables) {
			if(variable.nombre.equals(nombreVariable)) return variable;
		}
		return null;
	}

	private Funcion existeFuncion(String nombreFuncion) {
		for (Funcion funcion : this.arbol.funciones) {
			if(funcion.nombre.equals(nombreFuncion)) return funcion;
		}
		return null;
	}

	// Valida que la variable no exista, si existe la devuelve
	private boolean validarDeclaracion(Variable nuevaVariable) {
		if(this.existeVariable(nuevaVariable.nombre) != null) {
			errores.add("Ya existe la variable: " + nuevaVariable.nombre);
			return false;
		}
		this.variables.add(nuevaVariable);
		return true;
	}

	private boolean validarAsignacion(AsignacionVariable asignacion) {
		Variable variable = this.existeVariable(asignacion.nombreVariable);
		if(variable == null) {
			errores.add("La variable: " + asignacion.nombreVariable + " no existe para asignar");
			return false;
		}
		Tipo tipoAsignacion = validarExpresion(asignacion.asignacion);
		if(tipoAsignacion == null || variable.tipo.nombre != tipoAsignacion.nombre) {
			errores.add("Se intenta asignar un tipo diferente al de la variable: " + asignacion.nombreVariable);
			return false;
		}
		return true;
	}

	private void popVariables(int cantidad) {
		while (variables.size() > cantidad) {
			variables.remove(variables.size() - 1);
		}
	}

	private void validarCondicion(Expresion expresion, String estructura) {
		Tipo tipoFinalizacion = this.validarExpresion(expresion);
		if(tipoFinalizacion == null || tipoFinalizacion.nombre != Tipos.BOOLEAN) {
			errores.add("La condición del " + estructura + " no es de tipo booleano");
		}
	}
}


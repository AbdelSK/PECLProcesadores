package analizadorLex;

public class Variable {
	
	private String tipo;
	private String valor;
	private int linea;
	private int columna;
	
	public Variable(String tipo, String valor, int linea, int columna) {
		super();
		this.tipo = tipo;
		this.valor = valor;
		this.linea = linea;
		this.columna = columna;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getValor() {
		return valor;
	}

	public void setValor(String valor) {
		this.valor = valor;
	}

	public int getLinea() {
		return linea;
	}

	public int getColumna() {
		return columna;
	}
	
}

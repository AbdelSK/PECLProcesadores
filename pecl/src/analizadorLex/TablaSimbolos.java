package analizadorLex;

import java.util.ArrayList;

public class TablaSimbolos {
	
	private ArrayList<Simbolo> listaSimpolos;
	private ArrayList<String> listaErroresLexicos;
	
	public TablaSimbolos() {
		this.listaSimpolos = new ArrayList<Simbolo>();
		this.listaErroresLexicos = new ArrayList<String>();
	}

	public ArrayList<String> getListaErroresLexicos() {
		return listaErroresLexicos;
	}

	public ArrayList<Simbolo> getListaSimpolos() {
		return listaSimpolos;
	}

	public String imprimirListaSimbolos() {
		return "Analisis Lexico completado: \n" + "--------------------------- \n\n" + listaSimpolos + "\n";
	}
	
	public void imprimirListaErroresLexicos() {
		System.err.println("Errores Lexicos: \n---------------- ");
		for(String t: this.listaErroresLexicos){
			System.err.println("\t-->"+t);
		}
		System.err.println("\n");
	}
}

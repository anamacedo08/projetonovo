class ManageAttendantUseCase {
  Future<void> criarAtendente(Map<String, dynamic> dados) async {
    // verificarPermissaoAdmin()
    // novoAtendente = EntidadeAtendente(dados: dados, papel: 'ATENDENTE', ativo: verdadeiro)
    // UserRepository.salvar(novoAtendente)
    print('Criando atendente: ${dados['email']}');
  }

  Future<void> inativarAtendente(int id) async {
    // verificarPermissaoAdmin()
    // UserRepository.atualizacaoLogica(id, ativo: falso)
    print('Inativando atendente: $id');
  }
}

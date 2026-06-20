class RegisterClientUseCase {
  // Simulação de dependência UserRepository
  // final UserRepository _userRepository;

  // RegisterClientUseCase(this._userRepository);

  Future<bool> executar(Map<String, dynamic> dadosCliente) async {
    // se dadosCliente.email ja existe:
    //   retornar ErroConflito

    // hash = encriptar(dadosCliente.senha)
    // novoCliente = EntidadeCliente(dados: dadosCliente, senha: hash, papel: 'CLIENTE')

    // UserRepository.salvar(novoCliente)
    print('Registrando cliente: ${dadosCliente['email']}');
    return true;
  }
}

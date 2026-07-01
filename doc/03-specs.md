Aqui está a especificação técnica detalhada do sistema ArtesaLab, estruturada conforme o formato e os padrões arquiteturais exigidos.

## 1. Comportamento Visual e Design System
- **Paleta de Cores**: Predominância de tons terrosos (Brown) e neutros para refletir a natureza artesanal.
- **Tipografia**: Uso de fontes legíveis com tamanhos adequados para acessibilidade (mínimo 12pt para corpo, 16pt para títulos).
- **Componentes**: 
  - `AppDrawer`: Menu lateral dinâmico por perfil.
  - `ProductCard`: Cartão de exibição de produtos com suporte a imagens via URL.
  - `LoadingIndicator`: Feedback visual durante processamento assíncrono.
  - `EmptyState`: Mensagens claras quando não houver dados (ex: "Nenhum pedido encontrado").

## 2. Requisitos de Interface e Experiência (UI/UX)
- **Responsividade**: Layout adaptável para dispositivos móveis e desktop.
- **Acessibilidade**: 
  - Contrastes adequados.
  - Rótulos descritivos em formulários.
  - Feedback visual de erros via SnackBar ou textos de ajuda.
- **Navegação**: 
  - Interceptação de rotas para usuários não autenticados.
  - Fluxos claros entre telas de gestão e visualização.

## 3. Funcionalidades Específicas
### 3.1. Visão do Atendente
- **Gestão de Pedidos**: 
  - Visualização de lista de pedidos.
  - **Detalhes do Pedido**: Ao clicar em um pedido, deve abrir uma visualização detalhada com todas as informações (Descrição, Endereço, Contato).
  - **Transição de Status**: Fluxo de "Aguardando Início" -> "Em Fabricação" -> "Enviado" (com rastreio).

### 3.2. Visão do Administrador
- **Relatórios**: Dashboard com métricas agregadas:
  - Quantidade total de pedidos cadastrados.
  - Quantidade total em análise ("AGUARDANDO_INICIO").
  - Quantidade total em fabricação.
  - Quantidade total enviados.

### 3.3. Visão do Cliente
- **Meus Pedidos**: Lista histórica de pedidos realizados pelo cliente logado, exibindo o status atualizado em tempo real.

## 4. Arquitetura Técnica
- **Frontend**: Flutter com `Provider` para gestão de estado.
- **Backend**: SQLite via `sqflite` (Singleton pattern).
- **Notificações**: Firebase Messaging (Simulado/Robusto).
- **Segurança**: Bloqueio de rotas por perfil de usuário.

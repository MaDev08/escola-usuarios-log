# Gerenciamento de Usuários e Auditoria de Senhas

Este projeto implementa um sistema de gerenciamento de usuários com um mecanismo de auditoria para alterações de senhas no banco de dados SQL Server. Ele registra as modificações realizadas, armazenando informações como a senha anterior, nova senha, data da alteração e o IP do responsável pela mudança.

## 🚀 Funcionalidades
- **Cadastro de usuários** com informações básicas.
- **Registro de alterações de senha** em uma tabela de log.
- **Trigger automática** para capturar e armazenar mudanças de credenciais de forma segura.
- **Uso de `GETDATE()`** para manter registros precisos de datas e horas.
- **Referência cruzada** entre usuários e histórico de alterações via chave estrangeira.

## 🔧 Como utilizar
1. Crie o banco de dados `Escola`.
2. Execute os comandos SQL para criação das tabelas `usuario` e `log_de_usuario`.
3. Insira usuários de exemplo para testar a funcionalidade.
4. Modifique senhas e veja os registros sendo adicionados automaticamente na tabela de log.

## 🔒 Melhorias recomendadas
- Utilizar **hashing** para armazenar senhas de forma segura.
- Capturar o **IP do usuário via aplicação** para maior precisão na auditoria.
- Expandir a auditoria para outras ações críticas dos usuários.

---

Este projeto pode ser útil para sistemas que necessitam de rastreabilidade em alterações sensíveis de credenciais. Contribuições e melhorias são bem-vindas! 😊

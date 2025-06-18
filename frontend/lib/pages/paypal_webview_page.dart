import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Página que exibe o checkout do PayPal dentro da app.
///
/// [approvalUrl] é a URL que o PayPal fornece para o cliente aprovar o pagamento.
/// [onPaymentComplete] é chamado quando o PayPal redirecionar para a sua return_url.
class PaypalWebviewPage extends StatefulWidget {
  final String approvalUrl;
  final VoidCallback onPaymentComplete;

  const PaypalWebviewPage({
    super.key,
    required this.approvalUrl,
    required this.onPaymentComplete,
  });

  @override
  State<PaypalWebviewPage> createState() => _PaypalWebviewPageState();
}

class _PaypalWebviewPageState extends State<PaypalWebviewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // No Android a inicialização não precisa de configuração extra.
    // No iOS, o plugin já cuida.
    // Em desktop não usamos WebView aqui.
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            final url = request.url;

            // Quando o usuário for redirecionado para sua return_url:
            if (url.contains('/payment-success')) {
              // Aqui você já sabe que o PayPal capturou o pagamento no backend
              widget.onPaymentComplete();
              return NavigationDecision.prevent; // fecha a WebView
            }

            // Se cancelar:
            if (url.contains('/payment-cancel')) {
              Navigator.of(context).pop(); // volta sem completar
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.approvalUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento PayPal'),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

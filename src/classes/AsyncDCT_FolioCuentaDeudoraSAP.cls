//Generated by wsdl2apex

public class AsyncDCT_FolioCuentaDeudoraSAP {
    public class RegistraCuentaDeudoraResponse_elementFuture extends System.WebServiceCalloutFuture {
        public String getValue() {
            DCT_FolioCuentaDeudoraSAP.RegistraCuentaDeudoraResponse_element response = (DCT_FolioCuentaDeudoraSAP.RegistraCuentaDeudoraResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.RegistraCuentaDeudoraResult;
        }
    }
    public class AsyncFolioCuentaDeudoraSoap {
        public String endpoint_x = 'https://www.region9.telcel.com/smartdistribuidores/PORTALES/FolioNISI/FolioCuentaDeudora.asmx';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://tempuri.org/', 'DCT_FolioCuentaDeudoraSAP'};
        public AsyncDCT_FolioCuentaDeudoraSAP.RegistraCuentaDeudoraResponse_elementFuture beginRegistraCuentaDeudora(System.Continuation continuation,String pUsuario,String pContrasenia,String pXmlConsulta) {
            DCT_FolioCuentaDeudoraSAP.RegistraCuentaDeudora_element request_x = new DCT_FolioCuentaDeudoraSAP.RegistraCuentaDeudora_element();
            request_x.pUsuario = pUsuario;
            request_x.pContrasenia = pContrasenia;
            request_x.pXmlConsulta = pXmlConsulta;
            return (AsyncDCT_FolioCuentaDeudoraSAP.RegistraCuentaDeudoraResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncDCT_FolioCuentaDeudoraSAP.RegistraCuentaDeudoraResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'http://tempuri.org/RegistraCuentaDeudora',
              'http://tempuri.org/',
              'RegistraCuentaDeudora',
              'http://tempuri.org/',
              'RegistraCuentaDeudoraResponse',
              'DCT_FolioCuentaDeudoraSAP.RegistraCuentaDeudoraResponse_element'}
            );
        }
    }
}
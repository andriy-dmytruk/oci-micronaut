package mushop.orders.client;

import io.micronaut.http.MediaType;
import io.micronaut.http.annotation.Body;
import io.micronaut.http.annotation.Post;
import io.micronaut.http.client.annotation.Client;
import io.reactivex.Flowable;
import mushop.orders.values.PaymentRequest;
import mushop.orders.values.PaymentResponse;

@Client(id="payment")
public interface PaymentClient {

    @Post(uri = "/paymentAuth", processes = MediaType.APPLICATION_JSON)
    Flowable<PaymentResponse> createPayment(@Body PaymentRequest paymentRequest);
}

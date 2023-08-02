exports.handler = async (event) => {

    console.log('event', event);
    let body = JSON.parse(event.body);
    console.log('body', body);
    const product = body.num1 * body.num2;
    const response = {
        statusCode: 200,
        body: "The product of " + body.num1 + " and " + body.num2 + " is " + product,
    };
    return response;
};
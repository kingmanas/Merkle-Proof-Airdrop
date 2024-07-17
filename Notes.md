### Signature Standards:
Let's imagine EIP-191 and EIP-712 are like different ways of sending secret messages.

#### EIP-191
--> i sign the transaction and give that key to my friend to sign that transaction on behalf of me.

Think of EIP-191 as a simple secret code. Imagine you have a toy that can make secret messages. When you want to send a message to your friend, you use the toy to make sure no one else can understand it. Your friend also has the same toy, so they can understand your message. This is a very basic and easy way to send secret messages.

#### EIP-712

Now, EIP-712 is like a super fancy secret code toy. It not only hides your message but also makes sure it's super clear and easy for your friend to understand, without any mix-ups. It's like having a special book that explains all the secret codes perfectly, so your friend knows exactly what you mean. This way, even if the message is very important and has a lot of details, your friend will always get it right.

So, EIP-191 is a simple secret message toy, and EIP-712 is a fancy one that makes sure the message is super clear and correct.

### ECDSA 

Elliptical Curve Digital Signature Algorithm (ECDSA)

Used for:
1. Create key pairs
2. Create signatures
3. verify signatures


r: x point on elliptical curve
s: proof signer knows the private key
v: if in positive or negative part of the curve

#### Private key : random genrated from 0 to n-1


#### Public Key : privKey * G(genrated point)


## Transaction Types :

0x0 legacy (Type0)

0x01 Type1

0x02 Type2

0x03 Type3 (Blob tx)
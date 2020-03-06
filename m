Return-Path: <SRS0=V1ps=4X=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8465C3F2CD
	for <rcu@archiver.kernel.org>; Fri,  6 Mar 2020 05:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F28A20728
	for <rcu@archiver.kernel.org>; Fri,  6 Mar 2020 05:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="ceDItYFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgCFFHo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 6 Mar 2020 00:07:44 -0500
Received: from m15-6.126.com ([220.181.15.6]:19916 "EHLO m15-6.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgCFFHo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 6 Mar 2020 00:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=XfIPh
        7x1oEHUZRf575YujUvh2bmTi0eo55RZ9OzvY18=; b=ceDItYFOsRS/UZ/CwRWan
        UfqfW9u+yjFoylptIDCtdhHP1b6TMzjd9NpqvIpa9+6Tams5+l2wJ2y7gfMp+TgT
        Vr3snPOAzoXIGPcbIr8TpcUYQcvLdAd7u0S+YyfSkOaNwLpFc7NDwjKuqVymUevV
        XMFuVMWNpBKp3Vl6iiv8qE=
Received: from zhangzl2013$126.com ( [147.11.252.42] ) by
 ajax-webmail-wmsvr6 (Coremail) ; Fri, 6 Mar 2020 13:06:13 +0800 (CST)
X-Originating-IP: [147.11.252.42]
Date:   Fri, 6 Mar 2020 13:06:13 +0800 (CST)
From:   "Zhaolong Zhang" <zhangzl2013@126.com>
To:     paulmck@kernel.org
Cc:     "Zhaolong Zhang" <zhangzl2013@126.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        "Lai Jiangshan" <jiangshanlai@gmail.com>,
        "Joel Fernandes" <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix the (t=0 jiffies) false positive
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 126com
In-Reply-To: <20200305230515.GN2935@paulmck-ThinkPad-P72>
References: <1583394357-11767-1-git-send-email-zhangzl2013@126.com>
 <20200305230515.GN2935@paulmck-ThinkPad-P72>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3e2ee4b9.3169.170ae3c9ed0.Coremail.zhangzl2013@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: BsqowAD3Br9G2mFeFFR0AA--.44548W
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/1tbikgfez1pD-8BC0QABsw
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

SGkgUGF1bCwKClNvcnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZS4gCkkgY3JlYXRlZCBteSBwYXRj
aCBiYXNlZCBvbiBtYWlubGluZScgY29tbWl0IDc3NmU0OWU4ZGRiNTE2OWU2NDc3ZmQzM2EzOTZl
OWM3YjJlYjc0MDAKClRoYW5rIHlvdSBmb3IgdGhlIHByb2Zlc3Npb25hbCBkZXNjcmlwdGlvbiBh
bmQgaGFuZCBhcHBseWluZy4KSSB3aWxsIHNlbmQgZnV0dXJlIHJjdSByZWxhdGVkIHBhdGNoZXMg
YmFzZWQgb24geW91ciAiZGV2IiBicmFuY2ggb2YgbGludXgtcmN1IHRyZWUuCgpSZWdhcmRzLApa
aGFvbG9uZwoKCkF0IDIwMjAtMDMtMDYgMDc6MDU6MTUsICJQYXVsIEUuIE1jS2VubmV5IiA8cGF1
bG1ja0BrZXJuZWwub3JnPiB3cm90ZToKPk9uIFRodSwgTWFyIDA1LCAyMDIwIGF0IDAzOjQ1OjU3
UE0gKzA4MDAsIFpoYW9sb25nIFpoYW5nIHdyb3RlOgo+PiBDYWxjdWxhdGUgJ3QnIHdpdGggdGhl
IHByZXZpb3VzbHkgcmVjb3JkZWQgJ2dwcycgaW5zdGVhZCBvZiAnZ3Bfc3RhcnQnLgo+PiAKPj4g
U2lnbmVkLW9mZi1ieTogWmhhb2xvbmcgWmhhbmcgPHpoYW5nemwyMDEzQDEyNi5jb20+Cj4KPkdv
b2QgY2F0Y2gsIHRoYW5rIHlvdSEKPgo+SSBoYWQgdG8gYXBwbHkgdGhpcyBieSBoYW5kLiAgTXkg
Z3Vlc3MgaXMgdGhhdCB5b3UgZGV2ZWxvcGVkIGFnYWluc3QKPm1haW5saW5lIHJhdGhlciB0aGFu
IHRoZSAiZGV2IiBicmFuY2ggb2YgdGhlIC1yY3UgdHJlZToKPgo+Z2l0Oi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3BhdWxtY2svbGludXgtcmN1LmdpdAo+Cj5PciBw
ZXJoYXBzIHlvdXIgZW1haWwgY2xpZW50IGNvcnJ1cHRlZCB0aGUgcGF0Y2g/Cj4KPlJlZ2FyZGxl
c3MsIHBsZWFzZSBjaGVjayB0aGUgdmVyc2lvbiBiZWxvdyBhbmQgbGV0IG1lIGtub3cgaWYgSSBt
ZXNzZWQKPmFueXRoaW5nIHVwLgo+Cj4JCQkJCQkJVGhhbngsIFBhdWwKPgo+LS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4KPmNvbW1pdCA3ZGQ1ODFiYmJjYzAwMjQ2ZmVjMzVlZGE2MGFkZDRiMzIyMDBiMGEwCj5B
dXRob3I6IFpoYW9sb25nIFpoYW5nIDx6aGFuZ3psMjAxM0AxMjYuY29tPgo+RGF0ZTogICBUaHUg
TWFyIDUgMTQ6NTY6MTEgMjAyMCAtMDgwMAo+Cj4gICAgcmN1OiBGaXggdGhlICh0PTAgamlmZmll
cykgZmFsc2UgcG9zaXRpdmUKPiAgICAKPiAgICBJdCBpcyBwb3NzaWJsZSB0aGF0IGFuIG92ZXIt
bG9uZyBncmFjZSBwZXJpb2Qgd2lsbCBlbmQgd2hpbGUgdGhlIFJDVQo+ICAgIENQVSBzdGFsbCB3
YXJuaW5nIG1lc3NhZ2UgaXMgcHJpbnRpbmcuICBJbiB0aGlzIGNhc2UsIHRoZSBlc3RpbWF0ZSBv
Zgo+ICAgIHRoZSBvZmZlbmRpbmcgZ3JhY2UgcGVyaW9kJ3MgZHVyYXRpb24gY2FuIGJlIGVycm9u
ZW91cyBkdWUgdG8gcmVmZXRjaGluZwo+ICAgIG9mIHJjdV9zdGF0ZS5ncF9zdGFydCwgd2hpY2gg
d2lsbCBub3cgYmUgdGhlIHRpbWUgb2YgdGhlIG5ld2x5IHN0YXJ0ZWQKPiAgICBncmFjZSBwZXJp
b2QuICBDb21wdXRhdGlvbiBvZiB0aGlzIGR1cmF0aW9uIGNsZWFybHkgbmVlZHMgdG8gdXNlIHRo
ZQo+ICAgIHN0YXJ0IHRpbWUgZm9yIHRoZSBvbGQgb3Zlci1sb25nIGdyYWNlIHBlcmlvZCwgbm90
IHRoZSBmcmVzaCBuZXcgb25lLgo+ICAgIFRoaXMgY29tbWl0IGF2b2lkcyBzdWNoIGVycm9ycyBi
eSBjYXVzaW5nIGJvdGggcHJpbnRfb3RoZXJfY3B1X3N0YWxsKCkgYW5kCj4gICAgcHJpbnRfY3B1
X3N0YWxsKCkgdG8gcmV1c2UgdGhlIHZhbHVlIHByZXZpb3VzbHkgZmV0Y2hlZCBieSB0aGVpciBj
YWxsZXIuCj4gICAgCj4gICAgU2lnbmVkLW9mZi1ieTogWmhhb2xvbmcgWmhhbmcgPHpoYW5nemwy
MDEzQDEyNi5jb20+Cj4gICAgU2lnbmVkLW9mZi1ieTogUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1j
a0BrZXJuZWwub3JnPgo+Cj5kaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90cmVlX3N0YWxsLmggYi9r
ZXJuZWwvcmN1L3RyZWVfc3RhbGwuaAo+aW5kZXggYjE3Y2Q5Yi4uNTAyYjRkZCAxMDA2NDQKPi0t
LSBhL2tlcm5lbC9yY3UvdHJlZV9zdGFsbC5oCj4rKysgYi9rZXJuZWwvcmN1L3RyZWVfc3RhbGwu
aAo+QEAgLTM3MSw3ICszNzEsNyBAQCBzdGF0aWMgdm9pZCByY3VfY2hlY2tfZ3Bfa3RocmVhZF9z
dGFydmF0aW9uKHZvaWQpCj4gCX0KPiB9Cj4gCj4tc3RhdGljIHZvaWQgcHJpbnRfb3RoZXJfY3B1
X3N0YWxsKHVuc2lnbmVkIGxvbmcgZ3Bfc2VxKQo+K3N0YXRpYyB2b2lkIHByaW50X290aGVyX2Nw
dV9zdGFsbCh1bnNpZ25lZCBsb25nIGdwX3NlcSwgdW5zaWduZWQgbG9uZyBncHMpCj4gewo+IAlp
bnQgY3B1Owo+IAl1bnNpZ25lZCBsb25nIGZsYWdzOwo+QEAgLTQwOCw3ICs0MDgsNyBAQCBzdGF0
aWMgdm9pZCBwcmludF9vdGhlcl9jcHVfc3RhbGwodW5zaWduZWQgbG9uZyBncF9zZXEpCj4gCWZv
cl9lYWNoX3Bvc3NpYmxlX2NwdShjcHUpCj4gCQl0b3RxbGVuICs9IHJjdV9nZXRfbl9jYnNfY3B1
KGNwdSk7Cj4gCXByX2NvbnQoIlx0KGRldGVjdGVkIGJ5ICVkLCB0PSVsZCBqaWZmaWVzLCBnPSVs
ZCwgcT0lbHUpXG4iLAo+LQkgICAgICAgc21wX3Byb2Nlc3Nvcl9pZCgpLCAobG9uZykoamlmZmll
cyAtIHJjdV9zdGF0ZS5ncF9zdGFydCksCj4rCSAgICAgICBzbXBfcHJvY2Vzc29yX2lkKCksIChs
b25nKShqaWZmaWVzIC0gZ3BzKSwKPiAJICAgICAgIChsb25nKXJjdV9zZXFfY3VycmVudCgmcmN1
X3N0YXRlLmdwX3NlcSksIHRvdHFsZW4pOwo+IAlpZiAobmRldGVjdGVkKSB7Cj4gCQlyY3VfZHVt
cF9jcHVfc3RhY2tzKCk7Cj5AQCAtNDQyLDcgKzQ0Miw3IEBAIHN0YXRpYyB2b2lkIHByaW50X290
aGVyX2NwdV9zdGFsbCh1bnNpZ25lZCBsb25nIGdwX3NlcSkKPiAJcmN1X2ZvcmNlX3F1aWVzY2Vu
dF9zdGF0ZSgpOyAgLyogS2ljayB0aGVtIGFsbC4gKi8KPiB9Cj4gCj4tc3RhdGljIHZvaWQgcHJp
bnRfY3B1X3N0YWxsKHZvaWQpCj4rc3RhdGljIHZvaWQgcHJpbnRfY3B1X3N0YWxsKHVuc2lnbmVk
IGxvbmcgZ3BzKQo+IHsKPiAJaW50IGNwdTsKPiAJdW5zaWduZWQgbG9uZyBmbGFnczsKPkBAIC00
NjcsNyArNDY3LDcgQEAgc3RhdGljIHZvaWQgcHJpbnRfY3B1X3N0YWxsKHZvaWQpCj4gCWZvcl9l
YWNoX3Bvc3NpYmxlX2NwdShjcHUpCj4gCQl0b3RxbGVuICs9IHJjdV9nZXRfbl9jYnNfY3B1KGNw
dSk7Cj4gCXByX2NvbnQoIlx0KHQ9JWx1IGppZmZpZXMgZz0lbGQgcT0lbHUpXG4iLAo+LQkJamlm
ZmllcyAtIHJjdV9zdGF0ZS5ncF9zdGFydCwKPisJCWppZmZpZXMgLSBncHMsCj4gCQkobG9uZyly
Y3Vfc2VxX2N1cnJlbnQoJnJjdV9zdGF0ZS5ncF9zZXEpLCB0b3RxbGVuKTsKPiAKPiAJcmN1X2No
ZWNrX2dwX2t0aHJlYWRfc3RhcnZhdGlvbigpOwo+QEAgLTU0Niw3ICs1NDYsNyBAQCBzdGF0aWMg
dm9pZCBjaGVja19jcHVfc3RhbGwoc3RydWN0IHJjdV9kYXRhICpyZHApCj4gCSAgICBjbXB4Y2hn
KCZyY3Vfc3RhdGUuamlmZmllc19zdGFsbCwganMsIGpuKSA9PSBqcykgewo+IAo+IAkJLyogV2Ug
aGF2ZW4ndCBjaGVja2VkIGluLCBzbyBnbyBkdW1wIHN0YWNrLiAqLwo+LQkJcHJpbnRfY3B1X3N0
YWxsKCk7Cj4rCQlwcmludF9jcHVfc3RhbGwoZ3BzKTsKPiAJCWlmIChyY3VfY3B1X3N0YWxsX2Z0
cmFjZV9kdW1wKQo+IAkJCXJjdV9mdHJhY2VfZHVtcChEVU1QX0FMTCk7Cj4gCj5AQCAtNTU1LDcg
KzU1NSw3IEBAIHN0YXRpYyB2b2lkIGNoZWNrX2NwdV9zdGFsbChzdHJ1Y3QgcmN1X2RhdGEgKnJk
cCkKPiAJCSAgIGNtcHhjaGcoJnJjdV9zdGF0ZS5qaWZmaWVzX3N0YWxsLCBqcywgam4pID09IGpz
KSB7Cj4gCj4gCQkvKiBUaGV5IGhhZCBhIGZldyB0aW1lIHVuaXRzIHRvIGR1bXAgc3RhY2ssIHNv
IGNvbXBsYWluLiAqLwo+LQkJcHJpbnRfb3RoZXJfY3B1X3N0YWxsKGdzMik7Cj4rCQlwcmludF9v
dGhlcl9jcHVfc3RhbGwoZ3MyLCBncHMpOwo+IAkJaWYgKHJjdV9jcHVfc3RhbGxfZnRyYWNlX2R1
bXApCj4gCQkJcmN1X2Z0cmFjZV9kdW1wKERVTVBfQUxMKTsKPiAJfQo=

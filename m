Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA311D4150
	for <rcu@vger.kernel.org>; Mon,  7 Oct 2024 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307202; cv=none; b=VCJ231emdOqRYugm47wXRzSegP5U0u7jbo4eiFkxXJWxdnXzm/sdPiCg7Trqa4srL4wE9QprotXAz+Ixg5I5W+ctyjcxDasqbOWl991Dwlhf7Ip0pqfA0HbXwDxi+Cef6F2ibou/+my73pqb45hKMlTsnFKEnzIqQA2xCO3LSwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307202; c=relaxed/simple;
	bh=3YwKFRUNFJmgLjP1rnmgXaT5FfHp2H1LLenfe751Fpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Wga3oHpGkmtdsTMCw1uZtxHkBheJsnknan7OsCZ/M+8C0pkhg78NqEp/PHmnBeipMF+ZzqC7u9asAB2QjT5ZCztj9/pRU9aOJsSV8n8v0BQl2SZth3oiojTuP/xNcVorLrwCx6Oh+J5dp+kQTVzw3XQ1NzJ3BG8P7V7u/B3jj3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-113-scvUWw6vOdGrDUiS0t4NIw-1; Mon, 07 Oct 2024 14:19:55 +0100
X-MC-Unique: scvUWw6vOdGrDUiS0t4NIw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 7 Oct
 2024 14:18:58 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 7 Oct 2024 14:18:58 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jonas Oberhauser' <jonas.oberhauser@huaweicloud.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, 'Alan Stern' <stern@rowland.harvard.edu>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon
	<will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng
	<boqun.feng@gmail.com>, John Stultz <jstultz@google.com>, Neeraj Upadhyay
	<Neeraj.Upadhyay@amd.com>, Frederic Weisbecker <frederic@kernel.org>, "Joel
 Fernandes" <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, "Mark
 Rutland" <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, "maged.michael@gmail.com"
	<maged.michael@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, Gary Guo
	<gary@garyguo.net>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "lkmm@lists.linux.dev"
	<lkmm@lists.linux.dev>
Subject: RE: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
Thread-Topic: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
Thread-Index: AQHbE2njI9qt6nx11kSrjhsE5O+AlrJyIkGggABQqYCAAKZugIAAWd+AgAAhswCAB6ONHIAAFVQA
Date: Mon, 7 Oct 2024 13:18:58 +0000
Message-ID: <43788527053542e78001820857445e4d@AcuMS.aculab.com>
References: <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <9539c551-5c91-42db-8ac1-cff1d6d7c293@huaweicloud.com>
 <2cdda043-1ad9-40cf-a157-0c16a0ffb046@rowland.harvard.edu>
 <5d7d8a59-57f5-4125-95bb-fda9c193b9cf@huaweicloud.com>
 <82e97ad5-17ad-418d-8791-22297acc7af4@rowland.harvard.edu>
 <ea02ce2ce8a348efa8d461f84f976478@AcuMS.aculab.com>
 <2b1caba3-48fa-43b9-bd44-cf60b9a141d7@rowland.harvard.edu>
 <22638e2fe1274eb0834fa3e43b44184e@AcuMS.aculab.com>
 <d192cf63-a274-4721-968e-a2c098db523b@rowland.harvard.edu>
 <e39c6e5975f345c4b1a97145e207dee4@AcuMS.aculab.com>
 <68dc00b3-1ca1-42bc-8f1e-78ace10e4d64@rowland.harvard.edu>
 <bd93a57c-662f-470e-8ba4-509f27eada6d@efficios.com>
 <6ae2461a-e509-4c4d-8959-ae17eb214419@huaweicloud.com>
In-Reply-To: <6ae2461a-e509-4c4d-8959-ae17eb214419@huaweicloud.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogSm9uYXMgT2JlcmhhdXNlcg0KPiBTZW50OiAwNyBPY3RvYmVyIDIwMjQgMTI6NTUNCj4g
DQo+IEFtIDEwLzMvMjAyNCB1bSAzOjIzIFBNIHNjaHJpZWIgTWF0aGlldSBEZXNub3llcnM6DQo+
ID4gV2hhdCBfZG9lc18gd29yayBob3dldmVyIGFyZSB0aGUgZm9sbG93aW5nIHR3byBhcHByb2Fj
aGVzOg0KPiA+DQo+ID4gMSkgUGVyZm9ybSB0aGUgZXF1YWxpdHkgY2hlY2sgb24gdGhlIG9yaWdp
bmFsIHZhcmlhYmxlcywgY3JlYXRpbmcNCj4gPiBuZXcgdmVyc2lvbnMgKHdpdGggT1BUSU1JWkVS
X0hJREVfVkFSKSBvZiBib3RoIHZhcmlhYmxlcyBmb3IgdGhlDQo+ID4gcmVzdCBvZiB0aGVpciB1
c2UsIHRoZXJlZm9yZSBtYWtpbmcgc3VyZSB0aGUgcG9pbnRlciBkZXJlZmVyZW5jZQ0KPiA+IGFy
ZSBub3QgZGVyaXZlZCBmcm9tIHZlcnNpb25zIG9mIHRoZSB2YXJpYWJsZXMgd2hpY2ggd2VyZSBj
b21wYXJlZA0KPiA+IHdpdGggYW5vdGhlciBwb2ludGVyLiAoYXMgc3VnZ2VzdGVkIGJ5IEJvcXVu
KQ0KPiANCj4gVGhpcyBzaG91bGQgbm90IGJlIGd1YXJhbnRlZWQgdG8gd29yaywgYmVjYXVzZSBy
aWdodCBhZnRlciB0aGUNCj4gY29tcGFyaXNvbiB0aGUgY29tcGlsZXIgY2FuIGRvIGI9YSwgdGhl
biBpdCBkb2Vzbid0IG1hdHRlciBob3cgbXVjaCB5b3UNCj4gaGlkZSBhZnRlcndhcmRzLg0KPiAN
Cj4gSG93ZXZlciBpdCBtaWdodCB3b3JrIGlmIHlvdSBlc2NhcGUgdGhlIGFkZHJlc3NlcyBvZiBh
IGFuZCBiIGZpcnN0LCBpbg0KPiB3aGljaCBjYXNlIHRoZSBjb21waWxlciB3aWxsIG5vdCBkbyBi
PWEgYW55bW9yZSwgYnV0IGl0IG1pZ2h0IGZvcmNlIHRoZQ0KPiBjb21waWxlciB0byBwdXQgYSBh
bmQgYiBvbiB0aGUgc3RhY2ssIHdoaWNoIGhhcyBzb21lIHBlcmZvcm1hbmNlIGltcGFjdC4NCg0K
Tm9wZSwgYXMgcG9pbnRlZCBvdXQgbGFzdCB3ZWVrLCB0aGUgY29tcGlsZXIgY2FuIG1vdmUgdGhl
ICdhID09IGInDQpjaGVjayB0byBiZWZvcmUgdGhlIE9QVElNSVNFUl9ISURfVkFSKCkgYW5kIHRo
ZW4gdXNlIHRoZSBzYW1lIHJlZ2lzdGVyDQpmb3IgYm90aCBvZiB0aGVtLg0KDQo+ID4gMikgUGVy
Zm9ybSB0aGUgZXF1YWxpdHkgY2hlY2sgb24gdGhlIHZlcnNpb25zIHJlc3VsdGluZyBvZiBoaWRp
bmcNCj4gPiBib3RoIHZhcmlhYmxlcywgbWFraW5nIHN1cmUgdGhvc2UgdmVyc2lvbnMgb2YgdGhl
IHZhcmlhYmxlcyBhcmUNCj4gPiBub3QgZGVyZWZlcmVuY2VkIGFmdGVyd2FyZHMuIChhcyBzdWdn
ZXN0ZWQgYnkgTGludXMpDQoNClRoYXQgKGFuZCBvdGhlciB0aGluZ3MpIGNvdWxkIHVzZWZ1bGx5
IHVzZToNCiNkZWZpbmUgT1BUSU1JU0VSX0hJREVfVkFMVUUoeCkgXA0KCSh7IF9fYXV0b190eXBl
IF94ID0geDsgT1BUSU1JU0VSX0hJREVfVkFSKF94KTsgX3g7IH0pDQpZb3UnbGwgYWxtb3N0IGNl
cnRhaW5seSBlbmQgdXAgd2l0aCBhIHJlZ2lzdGVyLXJlZ2lzdGVyIG1vdmUNCmV2ZW4gaWYgJ3gn
IGlzbid0IHVzZWQgYWZ0ZXJ3YXJkcy4NCg0KVGhlIGNhbGxpbmcgY291bGQganVzdCBiZWNvbWU6
DQoJaWYgKGEgPT0gT1BUSU1JU0VSX0hJREVfVkFMVUUoYikgLi4uDQpzaW5jZSBpdCBpcyBsaWtl
bHkgdGhhdCB5b3Ugb25seSBjYXJlIGFib3V0IG9uZSBvZiB0aGUgcG9pbnRlcnMuDQooQWN0dWFs
bHkgaXNuJ3QgaGlkaW5nIG9uZSBvZiB0aGVtIGFsd2F5cyBlbm91Z2g/KQ0KDQoJRGF2aWQNCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K


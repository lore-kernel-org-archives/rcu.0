Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75801A7240
	for <rcu@vger.kernel.org>; Thu,  3 Oct 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975283; cv=none; b=cUfXZ8tOFl4NDqiuleggv5c5tE2juGBDrKO4TXcfBAU+uCGMdoRWgOsA5os0u34aNysTme0lvv7SJzDOeQxO7SsEaMj4bgwE//pKnhObySqZLtlW3Ecg7MMRjgQ8qLTmov4U3tp1csJRWG/VDvny0lRcXyxXDcwcJgexH5HCXnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975283; c=relaxed/simple;
	bh=0Ij5XWAwsZPbw+bPDgqpD8vZ9GGw/q1i15KLrImp22Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=su4iTBzxkg0XpBCNO5uC7CgeCMYTnMrYqfhATDdMvwTtekYpirdtjEqoHz0ifqigtcveljjvRbOE/9NeWSacNLKexTFCfyNHmOZgxpDGEUF6/aHYETpcqc5MRyIAlyTmeJtn0oAzRX2dRdYE65NHar3Ym66jzlSL7ONedZ7iHIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-213-dw_JzulIP0eg1EL9EfNb8Q-1; Thu, 03 Oct 2024 18:07:53 +0100
X-MC-Unique: dw_JzulIP0eg1EL9EfNb8Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 3 Oct
 2024 18:07:03 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 3 Oct 2024 18:07:03 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mathieu Desnoyers' <mathieu.desnoyers@efficios.com>, 'Alan Stern'
	<stern@rowland.harvard.edu>
CC: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior
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
Thread-Index: AQHbE2njI9qt6nx11kSrjhsE5O+AlrJyIkGggABQqYCAAKZugIAAWd+AgAAhswCAAXOBa4AAO0Sg
Date: Thu, 3 Oct 2024 17:07:03 +0000
Message-ID: <498f11de5a024f0ca0b70aba4e28b17b@AcuMS.aculab.com>
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
In-Reply-To: <bd93a57c-662f-470e-8ba4-509f27eada6d@efficios.com>
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

Li4uDQo+IFdoYXQgX2RvZXNfIHdvcmsgaG93ZXZlciBhcmUgdGhlIGZvbGxvd2luZyB0d28gYXBw
cm9hY2hlczoNCj4gDQo+IDEpIFBlcmZvcm0gdGhlIGVxdWFsaXR5IGNoZWNrIG9uIHRoZSBvcmln
aW5hbCB2YXJpYWJsZXMsIGNyZWF0aW5nDQo+IG5ldyB2ZXJzaW9ucyAod2l0aCBPUFRJTUlaRVJf
SElERV9WQVIpIG9mIGJvdGggdmFyaWFibGVzIGZvciB0aGUNCj4gcmVzdCBvZiB0aGVpciB1c2Us
IHRoZXJlZm9yZSBtYWtpbmcgc3VyZSB0aGUgcG9pbnRlciBkZXJlZmVyZW5jZQ0KPiBhcmUgbm90
IGRlcml2ZWQgZnJvbSB2ZXJzaW9ucyBvZiB0aGUgdmFyaWFibGVzIHdoaWNoIHdlcmUgY29tcGFy
ZWQNCj4gd2l0aCBhbm90aGVyIHBvaW50ZXIuIChhcyBzdWdnZXN0ZWQgYnkgQm9xdW4pDQoNCklm
IHRoYXQgaXMNCglhMSA9IGE7IE9QVElNSVNFUl9ISURFX1ZBUihhMSk7DQoJYjEgPSBiOyBPUFRJ
TUlTRVJfSElERV9CQVIoYjEpOw0KCWlmIChhICE9IGJ9DQoJCXJldHVybjsNCgkvLyBjb2RlIHVz
aW5nIGExIGFuZCBiMQ0KdGhlbiBjYW4ndCB0aGUgY29tcGlsZXIgZmlyc3QgZmxpcCBpdCB0bzoN
CglpZiAoYSAhPSBiKQ0KCQlyZXR1cm47DQoJYTEgPSBhOyBPUFRJTUlTRVJfSElERV9WQVIoYTEp
Ow0KCWIxID0gYjsgT1BUSU1JU0VSX0hJREVfVkFSKGIxKTsNCmFuZCB0aGVuIHJlcGxhY2UgdGhl
IGxhc3QgbGluZSB3aXRoOg0KCWIxID0gYTsgT1BUSU1JU0VSX0hJREVfVkFSKGIxKTsNCndoaWNo
IGlzbid0IGludGVuZGVkIGF0IGFsbC4NCgkJDQoJDQpPVE9IIGlmIHlvdSBkbzoNCglhMSA9IGE7
IE9QVElNSVNFUl9ISURFX1ZBUihhMSk7DQoJYjEgPSBiOyBPUFRJTUlTRVJfSElERV9WQVIoYjEp
Ow0KCWlmIChhMSAhPSBiMSkNCgkJcmV0dXJuOw0KCS8vIGNvZGUgdXNpbmcgYSBhbmQgYg0KKHdo
aWNoIEkgdGhpbmsgaXMpDQoNCj4gMikgUGVyZm9ybSB0aGUgZXF1YWxpdHkgY2hlY2sgb24gdGhl
IHZlcnNpb25zIHJlc3VsdGluZyBvZiBoaWRpbmcNCj4gYm90aCB2YXJpYWJsZXMsIG1ha2luZyBz
dXJlIHRob3NlIHZlcnNpb25zIG9mIHRoZSB2YXJpYWJsZXMgYXJlDQo+IG5vdCBkZXJlZmVyZW5j
ZWQgYWZ0ZXJ3YXJkcy4gKGFzIHN1Z2dlc3RlZCBieSBMaW51cykNCg0KdGhlbiB0aGUgY29tcGls
ZXIgY2FuJ3QgcG9zc2libHkgcmV2ZXJzZSB0aGUgYXNtIGJsb2Nrcy4NCg0KCURhdmlkDQoNCi0N
ClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBN
aWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxl
cykNCg==


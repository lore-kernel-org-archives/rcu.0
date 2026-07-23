Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AC48AE36;
	Thu, 23 Jul 2026 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808268; cv=none; b=nGVIA20bl2OYrEpsNKmMdoXRz9zm1Y0Wleb4Js0eo7dbtQzJMl9kfRn9Z3fVB5HbHLusokBMagY/3GI71034l40HInVNF2hO/YLugXEX0oSK3dgR+KnZiRFHAlQr93IWgiLdnwPiEqFJG7nJz6fHHB6K333yONc9SOfBAbO4Fik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808268; c=relaxed/simple;
	bh=m3/0YSZYQzDgQyuA6SQ6Ur7WoM1y3Eq+jlVzjnL0T7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oxA0JmJ95JvT6izUCmgNeji+/WkwWBvNUXNuNgmI+bPryRg3dFv3fhT+6jqOfU+vvof+PLqVhZWGKMZ0i/NzNmFbPG2Hvvq1xuujhClnoC9CMDVw1kTeK5IwyMjY+KnDdBtLNJ3S6+s/bR/NvnwCeDOLQNB1ij4Sk4jnTOBWdI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=StdM88VO; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="StdM88VO"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h5V2h6GJWzKpmh;
	Thu, 23 Jul 2026 13:56:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784807788; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3/0YSZYQzDgQyuA6SQ6Ur7WoM1y3Eq+jlVzjnL0T7c=;
	b=StdM88VOL0qKMar551fpvZ4V8Ra4MhAyAJnN/U1PArk+62n3lTwyHwRSOL8Ir/L561oVss
	Qq7WBQHYut/4lTneTkg0IPPgW7Or5hKUZDZWgQqM45fHdSlQ6e1vXrrmTJ0sArXgtlEjDu
	RJRzTjpt4uflj+tAzuDTIRp2/QqDCyo7eMVo04X7grMdfr1AKQuXY/YNtTy64RL/rprZ6K
	AznFIIgCWu7PIzVtau7TxEVbpUgIMq6whmYSHbgzKMuo6bjWkm9ZSj20mGD7o2MMgI4qN+
	cCFPqAZp+KO28Mhxk73e9/Skz0+3qs2yXbzUrMrNwhkQXQGaa6CyZDrSXWf/Kg==
Message-ID: <73981717a8a609013eaca197a41a741c52bff44d.camel@mailbox.org>
Subject: Re: [PATCH v6 2/6] rust: error: Add ECANCELED error code
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Timur Tabi <ttabi@nvidia.com>, "qiang.zhang@linux.dev"	
 <qiang.zhang@linux.dev>, "josh@joshtriplett.org" <josh@joshtriplett.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>,
 "delcastillodelarosadaniel@gmail.com"	
 <delcastillodelarosadaniel@gmail.com>, "a.hindborg@kernel.org"	
 <a.hindborg@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Eliot
 Courtney <ecourtney@nvidia.com>, "adzicmirko97@gmail.com"
 <adzicmirko97@gmail.com>,  "alistair.francis@wdc.com"	
 <alistair.francis@wdc.com>, "ojeda@kernel.org" <ojeda@kernel.org>, 
 "sumit.semwal@linaro.org"	 <sumit.semwal@linaro.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>, 
 "yury.norov@gmail.com"	 <yury.norov@gmail.com>, "tmgross@umich.edu"
 <tmgross@umich.edu>,  "frederic@kernel.org"	 <frederic@kernel.org>,
 "aliceryhl@google.com" <aliceryhl@google.com>, 
 "daniel.almeida@collabora.com"	 <daniel.almeida@collabora.com>,
 "boqun@kernel.org" <boqun@kernel.org>,  "lossin@kernel.org"	
 <lossin@kernel.org>, "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
  "neeraj.upadhyay@kernel.org"	 <neeraj.upadhyay@kernel.org>,
 "paulmck@kernel.org" <paulmck@kernel.org>,  "phasta@kernel.org"	
 <phasta@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
 "dakr@kernel.org"	 <dakr@kernel.org>, "tamird@kernel.org"
 <tamird@kernel.org>,  "gregkh@linuxfoundation.org"	
 <gregkh@linuxfoundation.org>, "lyude@redhat.com" <lyude@redhat.com>, 
 "lina+kernel@asahilina.net"	 <lina+kernel@asahilina.net>, "ljs@kernel.org"
 <ljs@kernel.org>,  "mathieu.desnoyers@efficios.com"	
 <mathieu.desnoyers@efficios.com>, "work@onurozkan.dev"
 <work@onurozkan.dev>,  "urezki@gmail.com"	 <urezki@gmail.com>,
 "gary@garyguo.net" <gary@garyguo.net>,  "jiangshanlai@gmail.com"	
 <jiangshanlai@gmail.com>, "fujita.tomonori@gmail.com"	
 <fujita.tomonori@gmail.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-media@vger.kernel.org"	 <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org"	 <linaro-mm-sig@lists.linaro.org>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org"	 <rust-for-linux@vger.kernel.org>
Date: Thu, 23 Jul 2026 13:56:15 +0200
In-Reply-To: <fdcff2949180fa40d0605866fcb306781ddae4cf.camel@nvidia.com>
References: <20260722144931.1070312-2-phasta@kernel.org>
		 <20260722144931.1070312-4-phasta@kernel.org>
	 <fdcff2949180fa40d0605866fcb306781ddae4cf.camel@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 1wph3j35gedcc8zuwpiwyyaxym5kdm86
X-MBO-RS-ID: a53eb3e66d41100d98c

On Wed, 2026-07-22 at 18:38 +0000, Timur Tabi wrote:
> On Wed, 2026-07-22 at 16:49 +0200, Philipp Stanner wrote:
> > The Rust dma_fence abstractions need the ECANCELED error code.
> >=20
> > Add ECANCELED error code.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>=20
> No need for this, all remaining codes are being added via
>=20
> https://lore.kernel.org/rust-for-linux/20260629183022.2709524-1-ttabi@nvi=
dia.com/
>=20
> Please pick up that patch instead.

Ok, pulled it in my local branch for now, thx for the heads-up.

I see that your patch is from June. If it lands in drm-rust-next
soonish I'd simply rebase.


Regards
P.

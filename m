Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F534DCE4;
	Mon, 10 Aug 2026 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348104; cv=none; b=sgCb8Q8jNEof0yziW+heHd/xKEG0iDvSCevcQhpOS6DfcNxZRkzLeWY4ZumzjL7Al+kNaXRhTjRxh8jn4A1Dc7yjC/rWLJAsiB0tvfPLO6bJLnLCospuHgbBbFheIBrg7e9Z4p6PNMbv0+kcL4WNuMs7RidChjffFuMvUJwB8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348104; c=relaxed/simple;
	bh=wcfouqGkbtN6qbgtaKfsihWkqZ0FKvP4t7FAWyvgg3k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bb0Fa4tizdR8Oe7ufvcZm2dXSJakq87MqiuqXngns4Ze/9ikfl6H+MWhhL+EI+o4nxQUGzhhSbjjaNS4/L4A+63HKTlPiXaeGHekcW92PnXQqf+f4q05XHXeq/UWPhONvSyjMoaB6JL8EpeQws+vb7ARp97rqtrDCJKAE57rc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ViiVWbZH; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ViiVWbZH"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hJRgv2Mm8zMlDr;
	Mon, 10 Aug 2026 09:48:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786348091; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcfouqGkbtN6qbgtaKfsihWkqZ0FKvP4t7FAWyvgg3k=;
	b=ViiVWbZH8vUUunF8Vd0PWAu3HSRksIQ9wiOB+zo9xu3rhYOC84nlsH7di9G3hhbeYZxSP2
	WCl+f9V615ix5sjUwX+AnN6Y0A4Xe5jpj+DBVdbYXLn1OmrOWiudIyoTWSWY7tg9exUXap
	gVEPbTy+Yi4IB4GH1SKZQY4CgNeaM7vlh9om3T31EaSxe7Jz/i0XQb94Refz1BOCmbAGpe
	OZd7lUsn/Nikk9iUfybN8obV24vjLwq8OzWUuJ3BnRUXsreuqhyKXmzYFaWidBOtk4ewfj
	M2cG09kFLzRAg/3TFj4o2L/EE3ayEaFFUa9W6S85R5DyH8T50R5iXFox69UVsQ==
Message-ID: <91325da652d7840509015c043c8cb7b4450a00f3.camel@mailbox.org>
Subject: Re: [PATCH v9 0/5] rust / dma_buf: Add abstractions for dma_fence
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Philipp Stanner
	 <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
	 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Sumit Semwal	
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Lyude Paul <lyude@redhat.com>, "Paul E.
 McKenney"	 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett	 <josh@joshtriplett.org>, Uladzislau
 Rezki <urezki@gmail.com>, Steven Rostedt	 <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,  Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Greg
 Kroah-Hartman	 <gregkh@linuxfoundation.org>, Asahi Lina
 <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>, Lorenzo Stoakes
 <ljs@kernel.org>, FUJITA Tomonori	 <fujita.tomonori@gmail.com>, Eliot
 Courtney <ecourtney@nvidia.com>, Mirko Adzic	 <adzicmirko97@gmail.com>,
 Timur Tabi <ttabi@nvidia.com>, Daniel del Castillo	
 <delcastillodelarosadaniel@gmail.com>, Boris Brezillon	
 <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	rcu@vger.kernel.org
Date: Mon, 10 Aug 2026 09:47:55 +0200
In-Reply-To: <CANiq72nZ25wkxVHpz9GTA_m5E_vyBmRKdDSUNMsJAZ=6zk=zhw@mail.gmail.com>
References: <20260805145949.938505-2-phasta@kernel.org>
	 <CANiq72nZ25wkxVHpz9GTA_m5E_vyBmRKdDSUNMsJAZ=6zk=zhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: e1q7rg1nfpbi93b8n3c9nfpegttm8ggb
X-MBO-RS-ID: 32b232e1d19317e22c3

On Mon, 2026-08-10 at 08:00 +0200, Miguel Ojeda wrote:
> On Wed, Aug 5, 2026 at 5:01=E2=80=AFPM Philipp Stanner <phasta@kernel.org=
> wrote:
> >=20
> > =C2=A0 rust: types: implement ForeignOwnable for ARef<T>
> > =C2=A0 rust: sync: Add abstraction for rcu_barrier()
> > =C2=A0 rust: error: add remaining error codes
>=20
> Applied (these three) to `rust-next` -- thanks everyone!
>=20
> Please note that your Signed-off-by is required when sending a patch
> from someone else:
>=20
> =C2=A0 https://docs.kernel.org/process/submitting-patches.html#sign-your-=
work-the-developer-s-certificate-of-origin
>=20
> I added it here on apply for you -- please let me know if that is not
> what you intended!

No, fine by me, thank you for fixing it

P.

>=20
> =C2=A0=C2=A0=C2=A0 [ Formatted comments. Added the submitter's Signed-off=
-by tag. - Miguel ]
>=20
> =C2=A0=C2=A0=C2=A0 [ Relaxed `'static` bound and added `#[inline]` as dis=
cussed. Added
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the submitter's Signed-off-by tag. - Migue=
l ]
>=20
> =C2=A0=C2=A0=C2=A0 [ Formatted documentation. Sorted tags. - Miguel ]
>=20
> Thanks!
>=20
> Cheers,
> Miguel

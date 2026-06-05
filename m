Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628C37B023
	for <rcu@vger.kernel.org>; Fri,  5 Jun 2026 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674724; cv=none; b=Fz7bJoMANXj5uupM0poEaF5w9z7bODtPkONdmUOl1NGZ1qnwER50pv4qx1REerqc4q3/1ghYDFVDVW7RX2czJWX/zZSIPsas4ty7AMp4bauD7ObuTyEU9lPj3++MToiQ12MZadKesUk1PBk7aVAKaz84ZTxIcKJUkKmbyovGMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674724; c=relaxed/simple;
	bh=WrF22v7dZaB4Mq26zO/CB+whNeAifS2ZudP3T3DO/Ms=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ir2LPzeFylgAkC9PM56lU/4Vi+CubnR06/m8g4VtpJSjDhG8ST62Co3dn8uCDl2e5GOcqT8jVmKi1pf/IJSe3YXemxv7pRTN4ByvMmDCQjNRt2JrP2tcK9ZrV+XRjZmQOegVEGN3Q+W/aYnQobCD2zoKniJ6MWB2Za1kRr857qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVswh1fY; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVswh1fY"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-59ccf81e74bso688382e0c.3
        for <rcu@vger.kernel.org>; Fri, 05 Jun 2026 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780674720; x=1781279520; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nGKygQkHUwQC80rJNI9ybnw4Obautm/GK0xUhE4dko=;
        b=WVswh1fYeeyUbsNxnThZ7ToV56z2dxbv4tg/Nobg2IMK5aQn+aNJg7CzveuGS9zfgQ
         iAEPvz/iWuHanGjGgGt/1rNy0pFulsHg6YnyMQW7TePLp1xg7mvu3JD0R+qhDmZnrrFd
         7a7DyW8qTacEfCzWTvQif/x5iXFeO0Ae/57zHfjkLQi6JxhT2lMiiGxrT6RNO7hrC3ow
         GsBA+WWOXuX0u7x4idTpUy/AvDBbJx8jOlHyV16QxytISqpT22FKpx8Gos1Gjnc2dZDH
         RT7hUeFVFHRQOgewF040Ng0alDy7ew/J8XJSNT0ktLCLq5J7WnFSRCzzPoBLQS4D5npS
         WwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674720; x=1781279520;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8nGKygQkHUwQC80rJNI9ybnw4Obautm/GK0xUhE4dko=;
        b=oqsLjADAaXAComvYlLsGQmFzeLYdJg7PVDx1qVzI5IGqDiFstss4Fzy24tBOqTnnrH
         EvTuCjyKKa3fUxRgVHu5WegIMXga0cb/dNKCGd7ezYXZe3aJfIv8XT0mTncCAoT8+hh+
         f5OJVY50azwjgyEGVpbRYzFijRkdIxPGlkSnTAB27dBnJclZHn6PMjKZYAUNd++zkiCZ
         dpwfy7bz8erZSgAQJGq/Abpw1YOoQLVz+mu8HEtaOtuoX0crGWzUomYikbv5IGJX15aD
         45dBM7xJdsqt4CcEmpzWOW0txrqYmQC0L8r2MvrflhAKvyGz4otiSgRq3E6gNZS319g8
         2c7A==
X-Forwarded-Encrypted: i=1; AFNElJ+Z7wmLAstiJXWW2a/clN3N63rcjnbDgaTt9Lyhx2V6jHXj49w9FTdXGvJc5LOws1UCeIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDhFVn530DVUlGIwVqmuZAm1XGoYR9jNdyp5l0O50Wg+Gi/isv
	uIMNBFfQEK8BhH/0Ea4FFRF/cigI659r/pAq4VOcU9+1oXJiO9Y5m5rr
X-Gm-Gg: Acq92OFSn3Dl3zV0stxaPB6Fhtyx5uYdHkKwacEWtfEr1CgSL4JCp+9U+93N3gcsG8f
	QnoKtt5LIdzH3Vj//fhXG37bDMz0ibErFbkU6bp1yfoADx5ZgkKhFyAWDFTE7lrjR/xGSrxfdFr
	qqMcjdz2cL2GmA8bwM/nksmsQuDiybgGvWh4lAGWX1q7stVn48zBYtW0bhA8JqRRNgltHTb/hTP
	cbz1wWmw8OCL6amhEdWcIwrKYR3Y/3wSO/IIq4sbx14v8xiFg5x7Vqdpvk8wKHWVAfaUWrvWSun
	W3QVJaHpooZxkPU2Q8ILy/TsPV5t6ztEqI8SD+AcLTFrjegfB2CwxQznBY25rDYsdIQ7LA+DcFR
	8oMXEE3i3ntMy8UFWzS/W7M924h6r84Ma/7dZJZIix5/nvyA6vHwZlLALuxl0ABmUcUETGlPORm
	9A//Qs/37kSMzhKYfMvvWv6/TE2H5/tXyaDXv1GtH34maVYNDsH40S3BZkdj4bNedMws+0mcM=
X-Received: by 2002:a05:6122:20a2:b0:59e:b127:fc6f with SMTP id 71dfb90a1353d-5ac53c944c8mr2226236e0c.2.1780674719617;
        Fri, 05 Jun 2026 08:51:59 -0700 (PDT)
Received: from smtpclient.apple ([2804:7f1:c241:abe4:8c1d:3d1b:d7cb:e7e9])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96414115a93sm7095512241.9.2026.06.05.08.51.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2026 08:51:59 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
From: Daniel Almeida <dwlsalmeida@gmail.com>
In-Reply-To: <20260604101552.4232733b@fedora-2.home>
Date: Fri, 5 Jun 2026 12:51:35 -0300
Cc: Philipp Stanner <phasta@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Shankari Anand <shankari.ak0208@gmail.com>,
 manos@pitsidianak.is,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org,
 rcu@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <82F71A28-076F-4100-A702-840018937D1B@gmail.com>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-5-phasta@kernel.org>
 <4F8E8E04-5AB5-4E6B-9194-5FC467E2313F@collabora.com>
 <20260603191405.4c75badb@fedora-2.home>
 <09096455-BA79-4E61-AD88-44DA57C5BEA8@gmail.com>
 <20260604101552.4232733b@fedora-2.home>
To: Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: Apple Mail (2.3826.700.81)


>>=20
>>>>=20
>>>> Consider a fence design where signal() consumes self. Now consider =
this:
>>>>=20
>>>> ```
>>>> impl FenceCb for MyCallback {
>>>> fn called(&mut self) {
>>>>  // Can't move the fence out, so we have to put an Option<T> just =
to be able
>>>>  // to move.
>>>>  if let Some(f) =3D self.some_fence.take() {
>>>>    f.signal();
>>>>  }
>>>> }
>>>> ```
>>>>=20
>>>> This used to be the case when our version of the job queue used the =
"proxy
>>>> fence" design:
>>>>=20
>>>>=20
>>>> ```
>>>> // Callback on the hw fence
>>>> impl FenceCb for MyCallback {
>>>> fn called(&mut self) {
>>>>  if let Some(f) =3D self.submit_fence.take() {
>>>>    f.signal();
>>>>  } =20
>>>=20
>>> I'm pretty sure lockdep won't like it anyway, because this is nested
>>> locking of the same lock class. For such proxies, we'll need to =
teach
>>> lockdep about the nesting like has been recently done on
>>> dma_fence_array & co. But I'm digressing. =20
>>=20
>> Yeah, but this is more about resource transfer in general, not
>> this pattern specifically.
>>=20
>> I agree that this has issues, and yes, lockdep complained back
>> then :)
>=20
> The thing is, there's so many aspects that could go wrong because of =
the
> context this callback is called in. Nested locking is one of them,
> the fact we can't sleep is another. And with rust it's even worse,
> because of the implicit drops that will happen when you take ownership
> of resources (taking sleeping locks to remove resources from a dataset
> for instance).
>=20
> So, by passing self by value to the ::callback(), you're basically
> telling users "hey, BTW, don't forget to defer the drop to some
> workqueue if you think it's not atomic-safe". And how can users know
> that the thing they're about to drop can be dropped in atomic context?


Can=E2=80=99t we create a token type that signals we=E2=80=99re in =
atomic context? If
we pass this token type as an argument, perhaps lockdep can check it for =
us?

Perhaps

enum SomeFancyName {
  Atomic(AtomicToken)
  NotAtomic,
}

signaled(self, atomic: AtomicToken) {
  ..
}

> They basically have to audit the ::drop() of all the resources they
> embed in their type implementing FenceCb. Not only that, but they also
> have to design the thing so the deferral of this ::drop() doesn't
> allocate, because, obviously, allocating in atomic context is
> tricky/fallible. AFAIK, none of this can be spot at compile-time (I
> remember Gary/Danilo mentioning that we could teach the klint about
> some of these rules). This would leave us with runtime checks like
> might_sleep(), but most of the C putters (xxx_put(object)) don't have
> might_sleep() in the path where the decref doesn't lead to a refcnt=3D0
> situation.
>=20
> TLDR; Call this PTSD if you want, but this is the sort of bugs I
> struggled with on the C side, and I can predict that the exact same
> will happen in rust drivers if we expose the FenceCb as it is designed
> here and we don't have a way to check the soundness of the FenceCb
> implementations at compile time.
>=20
> The other option (the one I've been advocating for from the start), is
> to not let drivers implement FenceCb (make it private), but instead
> have a bunch of implementations that we know are safe. Here's a list =
of
> implementations that I think would unblock most of the drivers use
> cases:
>=20
> - wakeup a thread
> - complete a completion object
> - schedule a WorkItem
> - schedule a kthread_worker (once we get a proper rust abstraction for
>  that)

This can also work too, I guess.

>=20
> It doesn't mean we can't have optimized FenceCb implementations that =
do
> a lot more in the callback() path instead of deferring to a
> workqueue/thread, but at least those would have to be implemented in
> dma_fence.rs, and the dma_fence.rs maintainers can then carefully =
audit
> the code as part of the review process, which we know is not really =
the
> case when changes touch drivers code only.
>=20
> FWIW, I think the FenceProxy design you were describing falls into
> this "must be carefully audited" bucket, and should be implemented in
> dma_fence.rs.
>=20
>>=20
>>>=20
>>>> }
>>>> ```
>>>>=20
>>>> Although this is not the case anymore, since we phased out this =
design given
>>>> Christian's recent work. Still, we should ideally not require =
Option<T> here in
>>>> general just to make resource transfer possible. =20
>>>=20
>>> I see. OTOH, don't we need to make this inner data movable if we =
want
>>> to cancel the FenceCb before the fence is signaled anyway? And =
that's
>>> most certainly a case we have in the teardown path. =20
>>=20
>> Can you expand a bit on what you mean here?
>=20
> Never mind, I was confusing two different iterations of the code here.
> I thought the Option<T> you were mentioning was in
> FenceCbRegistration<T>, with some explicit ::cancel() function that
> would return Option<T> so the user can get its resources back when it
> cancels the registration, and also know whether the callback was =
called
> or not. But this is all gone now, and all we can do is drop the
> registration, which will automatically drop the inner T.



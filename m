Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D311FF1C7
	for <rcu@vger.kernel.org>; Thu,  4 Jun 2026 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780533811; cv=none; b=UGvbfs60brYa15P05UQkvpfK4miUbuPCOI97m+gdhzd/Mq/IoT2EIyAAcgsxx8Zq6E/UeXztoZ8qGhZEVeaBdHNEZrVcLMyUaIzLF3kU02z+EFI5IKZtrp4Zl+br428N2zn6V03eDijkpyYyjmKdhBzWRdJtrYz+2Bao96ZbZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780533811; c=relaxed/simple;
	bh=gj4bcJ8tjxayhWwgX9WJSdtsCrztau9lrcqdIlpVaDk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dMIJGY6CbWPD5c+WgkzCtezS2CBZz+T1IOekGLwNNE5GPth4fVcX9h/u21sfwJ/lARPRX3C6+EvSAGwH7B+RaEfINrrhbvqJUdlnXEdHnqffsFpuPkzUoFW5KjS/BiPagz0EaVJpCTe7T3vwr1uwiUPKr8DoHKTss0Rkv3t5Aso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov1dSpPH; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov1dSpPH"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso25100e0c.1
        for <rcu@vger.kernel.org>; Wed, 03 Jun 2026 17:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780533809; x=1781138609; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rym8UMbIPSnQ16D68tiaqUk5iYRBwLoCnDZwF31rnjM=;
        b=Ov1dSpPHl1JK3m11++irJKd/Vz+ipI+0hxhIEo2ZDuVmhi69EZqxC3nzSTJWIIONEc
         BgNukYkbh72tOkVI+wm1wobJyxkUrMu5/nr3kaiJ/YDsN8HAxorWKZbtJ4UCTqnjS+gB
         bfq7a7fiQvrCDqUBumCtR2KNWLusLXj1uhGcTK7QIdE8J6G92AiqwNkJsXwdlm62nQI/
         e/bgRAXhZQePDEr3MGz18qCOGkrTiXo0aNBhgdQhRC0C4qQOqcxYRHTw/quDlVDI2Fbi
         94OlBiqggMXR9tNG3gdbhy634DH0luSsT6YIP5IMcXL4659Sm9QMLd8zcHwrUZaZ5sbz
         Q1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780533809; x=1781138609;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rym8UMbIPSnQ16D68tiaqUk5iYRBwLoCnDZwF31rnjM=;
        b=f5883izGfDZDIZivG12q+dD/W1zI6MTbmUztzgGjAZd0DPuOZcJNBjJKopV4KaaJLQ
         SJPrHWJSmwBWy2w5nt2YAWnrb3BjDaYN+i+bgp5yAbRl08zfxLGBXhYueCJi83HeNX9K
         dhKPNNZkrJOJf3RsrGCeRFHQej8KmPGSN+a1wI3rBTgcZ+FNeR3zjgLb1bxQBYej6owT
         5uTOWsRD7Z9QuGE4DGZrAGcH4TXtEb0UgqNcYHOKl2QQnSkZbNUGzoWm4P6i1BpCcx1F
         8QNrDDXm78Bjk/j/i7+ZI+R7lzrSgIz1wx/8HFtTkDqvox30H+GbePYQmaVz1gbKPsYX
         tz8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/qgqgbFr0eftnJe/T1IvbZn88mMu1DZeP51pm23hKP3ZA4uesnjQMRxBY8XuNNJMuxE7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKoJKEbKz/rrmuW4EY49aKzo+qo99cwhLwk9A+nJVIRbMNKSxV
	8RtvbPZhTsi8FYbYCyLI6f/e2Z37P/GJluP314qfW+ML2eR+sniVX1Eo
X-Gm-Gg: Acq92OFgIqF07HZxb+ICIell5ppvHF+vSSCizTouP98SlRh1E5LSrTRGtDGfmH+u4yX
	R9echxKajG2fuMIUVgT71m0UWRTNwc+rSxoh5pHtpm/KB5XZaYA6H0JwvEQJYYh06BNkSHjaKMS
	EIq7QcoMCzuBYVGYZeWkHazaYZArdH+PRxWqG6IdJs9CYe+XADwfba/w7PahQ5/Nbq4McBxUxqg
	FW+72Y79kslpIK7ACa/yMq94JihJDRRaQwLbeeMtZc42ZfU/FQxP6XqQ0LpKNOkVFjrYMydNAE1
	VglNyBn/jk04mTSlLA1CnD5gc3aggS7LJooSN430RjJIEYmw07SbxQwKSkLZQH3YhqfEFkNqNAk
	i8G9KqUCqQvmdrPzttdWlvpa4ibU7iQjch5pVdwCY627Lf1yJctV4a0vRGiasjbizsoOHBhutdh
	VEfcWm9/M5uEHiHJbJPuhs6sk6aPMAyOfiuY+urN1QV80yIY/yhgcI
X-Received: by 2002:a05:6122:e250:b0:56f:6cc0:681e with SMTP id 71dfb90a1353d-5a6e20460f6mr4443168e0c.1.1780533809510;
        Wed, 03 Jun 2026 17:43:29 -0700 (PDT)
Received: from smtpclient.apple ([179.165.169.30])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d6dc3d3fsm4139948e0c.5.2026.06.03.17.43.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2026 17:43:28 -0700 (PDT)
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
In-Reply-To: <20260603191405.4c75badb@fedora-2.home>
Date: Wed, 3 Jun 2026 21:43:05 -0300
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
Message-Id: <09096455-BA79-4E61-AD88-44DA57C5BEA8@gmail.com>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-5-phasta@kernel.org>
 <4F8E8E04-5AB5-4E6B-9194-5FC467E2313F@collabora.com>
 <20260603191405.4c75badb@fedora-2.home>
To: Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: Apple Mail (2.3826.700.81)



> On 3 Jun 2026, at 14:14, Boris Brezillon =
<boris.brezillon@collabora.com> wrote:
>=20
> On Wed, 3 Jun 2026 13:41:02 -0300
> Daniel Almeida <dwlsalmeida@gmail.com> wrote:
>=20
>>> +    /// Called when the fence is signaled.
>>> +    ///
>>> +    /// This is called from the fence signaling path, which may be =
in interrupt
>>> +    /// context or with locks held, which is why `self` is only =
borrowed, so that
>>> +    /// it cannot drop. Implementations must not sleep or perform
>>> +    /// long-running operations.
>>> +    ///
>>> +    /// An implementation likely wants to inform itself (e.g., =
through a work item)
>>> +    /// within this callback that the associated =
[`FenceCbRegistration`] can now be
>>> +    /// dropped.
>>> +    fn called(&mut self); =20
>>=20
>> This is a central point. We ideally would want this to consume self, =
because we
>> may want to move things out of the callback. =20
>=20
> This one comes from me. The rationale being that ::called() is called
> from an atomic context, and the resources attached to the callback =
data
> might require acquiring other sleeping locks to be released, and
> sometimes you don't even notice immediately because said resources are
> refcounted, and the lock is only acquired when you happen to be the
> last owner. Yes, those can be caught at runtime if the C side is
> properly annotated with might_sleep(), but that's not always the case.
>=20
> If we defer the drop of the data only when the FenceCb is
> dropped/recycled, we're at least not constrained by this "runs in
> atomic context" thing.
>=20

This design does not solve it, because one can quite trivially get =
around this
restriction using Option<T> as I said. If your point is =E2=80=9Cdon=E2=80=
=99t run any drop() here=E2=80=9D,
then &mut self doesn=E2=80=99t do it.

>>=20
>> Consider a fence design where signal() consumes self. Now consider =
this:
>>=20
>> ```
>> impl FenceCb for MyCallback {
>> fn called(&mut self) {
>>   // Can't move the fence out, so we have to put an Option<T> just to =
be able
>>   // to move.
>>   if let Some(f) =3D self.some_fence.take() {
>>     f.signal();
>>   }
>> }
>> ```
>>=20
>> This used to be the case when our version of the job queue used the =
"proxy
>> fence" design:
>>=20
>>=20
>> ```
>> // Callback on the hw fence
>> impl FenceCb for MyCallback {
>> fn called(&mut self) {
>>   if let Some(f) =3D self.submit_fence.take() {
>>     f.signal();
>>   }
>=20
> I'm pretty sure lockdep won't like it anyway, because this is nested
> locking of the same lock class. For such proxies, we'll need to teach
> lockdep about the nesting like has been recently done on
> dma_fence_array & co. But I'm digressing.

Yeah, but this is more about resource transfer in general, not
this pattern specifically.

I agree that this has issues, and yes, lockdep complained back
then :)

>=20
>> }
>> ```
>>=20
>> Although this is not the case anymore, since we phased out this =
design given
>> Christian's recent work. Still, we should ideally not require =
Option<T> here in
>> general just to make resource transfer possible.
>=20
> I see. OTOH, don't we need to make this inner data movable if we want
> to cancel the FenceCb before the fence is signaled anyway? And that's
> most certainly a case we have in the teardown path.

Can you expand a bit on what you mean here?=

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA1A34F259;
	Wed, 17 Jun 2026 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781673284; cv=none; b=HuNt1k3eUZO/Lq2Qslw1p21xVjSxTjC2pPy7eH7RPWRXLX7alqkea6WD2SAYQ9Ha+rN+otbiI38jbsiZkCtb9wzpYTum3uuL3H1hVHMgRQ2KUwKPdBWw5icIrc3NQmpJK8BvPUUSva9rJOwLi9jQgDtO6ig7OxgRr/NFcKjgsWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781673284; c=relaxed/simple;
	bh=M+gSoTHVbv7i2uM3rLoXA4a1hph9Oc98006a7MHR9hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biAyaQ/f95JWVhJG02Itdk43vRyk65cBqtcDR/qRtcYKUoph5jR0g+tuijwBgMvEt7liF+y5lMsZoCMBfJm7pHhhdYHlGptxlKRBhPbsdcovJVL2whs0HElWcN9vUO39acDVRHaJiewTUEaLIHyB6GuOGNypBteK+Gj/+j8410g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vq5KoxGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vq5KoxGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5991F1F000E9;
	Wed, 17 Jun 2026 05:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781673281;
	bh=i4gI8nBuxA9HRcUwNvotK2yH1/Y4niKmJ4bOseHnoOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Vq5KoxGjOeZU7bfYcs6X2ic2+hFhWSKqGgqfdCjVZy2jo1ZH3yXx6tBFJUGVnDLPq
	 FRkbuYQdKulgt+hMMWNOJ6rg/hgsSsWtQgRZBsc8wIALCQdjtTY+90vF3lTjx+CJ76
	 gc7RwVd0S2MmHruzJzyn/jJf3x+enPN8Yk/c3tVX11PsHcEakhw30+CDNpaiGZxbLi
	 vo2iyxTE4uBv23I3XtYp5Km71YP+rjdtnogZPG5Ynv8IuBnmu/0SrQfqKiazfIrc2K
	 MzKx0UlxQIeCPhRWYE7Rlj1opOvG/qB7x+PPd2g3llsJgPCPP5lcop1iW+bs50TTtT
	 3GVL74u3KPyoA==
Message-ID: <40591888-3a87-433e-b3d2-cda1cab543be@kernel.org>
Date: Wed, 17 Jun 2026 14:14:16 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 6/9] mm/slab: allow kfree_rcu_sheaf() on
 PREEMPT_RT
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-6-70a54f3775bb@kernel.org>
 <f3a56a5a-f10b-46dc-bc99-28449ade1661@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <f3a56a5a-f10b-46dc-bc99-28449ade1661@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kEBv9bKx3bhSjfXvp2FnnpK0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------kEBv9bKx3bhSjfXvp2FnnpK0
Content-Type: multipart/mixed; boundary="------------vb0IaWkZAOplq9hp2tUYiTMN";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <40591888-3a87-433e-b3d2-cda1cab543be@kernel.org>
Subject: Re: [PATCH for-next v3 6/9] mm/slab: allow kfree_rcu_sheaf() on
 PREEMPT_RT
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-6-70a54f3775bb@kernel.org>
 <f3a56a5a-f10b-46dc-bc99-28449ade1661@kernel.org>
In-Reply-To: <f3a56a5a-f10b-46dc-bc99-28449ade1661@kernel.org>

--------------vb0IaWkZAOplq9hp2tUYiTMN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/17/26 2:24 AM, Vlastimil Babka (SUSE) wrote:
> On 6/15/26 13:06, Harry Yoo (Oracle) wrote:
>> As suggested by Vlastimil Babka, kfree_rcu_sheaf() can be used
>> on PREEMPT_RT if we always assume spinning is not allowed on PREEMPT_R=
T.
>> This is because local_trylock and spinlock_t are safe to use with
>> trylock variant as long as the kernel does not spin and the context is=

>> not NMI and not hardirq.
>>
>> Now that __kfree_rcu_sheaf() knows how to handle allow_spin =3D false,=

>> relax the limitation and try the sheaves path on PREEMPT_RT as well.
>>
>> Keep the lockdep map on non RT kernels. However, do not use the lockde=
p
>> map on PREEMPT_RT to avoid suppressing valid lockdep warnings.
>>
>> Link: https://lore.kernel.org/linux-mm/6811cc17-8ee4-48c8-8cbf-6bf4d9f=
98162@kernel.org
>> Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>=20
> LGTM, but maybe unnecessary pessimistic wrt call_rcu() on PREEMPT_RT?
> I thought (in the Link: above) we'd only need to downgrade allow_spin t=
o
> false on PREEMPT_RT for handling sheaves movement from/to barn and
> alloc_empty_sheaf(), but call_rcu() would be safe from kfree_rcu() even=
 on
> RT?

Indeed. Good point, thanks!

Hmm, but I'm not sure that it's worth the complexity given that
PREEMPT_RT tries very hard to avoid disabling IRQs...

> Or is the irqs_disabled() condition rare enough so we don't care?

Given that most users don't call kfree_rcu() under raw spinlock or
IRQs-disabled section on PREEMPT_RT, I think it's okay to keep it as is
(it's not making things worse, at least) and wait for call_rcu_nolock()?

On a side note, I don't have much idea on what needs to call kfree_rcu()
under a raw spinlock, other than set_cpus_allowed_force(), which should
really be using kfree_nolock() instead of kfree_rcu() once we support
kmalloc() -> kfree_nolock():
> 	/*
> 	 * Because this is called with p->pi_lock held, it is not possible
> 	 * to use kfree() here (when PREEMPT_RT=3Dy), therefore punt to using
> 	 * kfree_rcu().
> 	 */
> 	kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);

Any thoughts, RCU/RT folks?

--=20
Cheers,
Harry / Hyeonggon

--------------vb0IaWkZAOplq9hp2tUYiTMN--

--------------kEBv9bKx3bhSjfXvp2FnnpK0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajItKAAKCRCGXBN6rc5S
1jLFAQDJjkqWNsckxRckQG/ifpkFidi3A6aFYgVvzxCG+/hQQwD+LUnZJI7/+UOa
K4FDOVTUA6hwmP3OMAXM1Q1fH4PjOwM=
=nbP0
-----END PGP SIGNATURE-----

--------------kEBv9bKx3bhSjfXvp2FnnpK0--

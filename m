Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E012C534;
	Thu, 25 Jun 2026 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782365250; cv=none; b=Lk67M5mE6SWT6Qp28F5kt3qvND2VBbPl13YkZ0bixBWldViJiC2PV2JNUCaXn+GNm7kAVaZ6YI54xCtxzLMaTtQiV7Rmv6aJF1Eu8JAp4GIagyvx+1o9tdoWtdbFHmDrc8Clq5DA5biDAeMeo424y67BjRQPYY46UNqPUFvaZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782365250; c=relaxed/simple;
	bh=16gLOvVg1+I9vrM7P9jWzIPMeQh/IJhgDY9+aNOXBAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeJwlMdoSwLVyEJ8PhaDkltfAS5Iqn3ug6ymXeUjLIxnHRwe0brozLF1XHsMc4L3E2mpeJbD1R0Iaj7t4A0kqRpBhzRfCmZrL1gRllxinVP0WrICOIoLkExV3jcfw1bYTIdiq7mAvTqH3wloeB23JIUiFSeDCCT4yeTMx1cWDzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMfGlucx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMfGlucx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7531F000E9;
	Thu, 25 Jun 2026 05:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782365248;
	bh=16gLOvVg1+I9vrM7P9jWzIPMeQh/IJhgDY9+aNOXBAM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UMfGlucxjCtnoosPgwHb0AUMixwX+WJ+i4FsrBedZL55zbcOs5lBJ1+R0wNt9bZpG
	 dw3r7UHuCmhwawC6FjPIAmf2C8GdgV33ptgxNQLw5nvQtfg1nO6WaMDDydxPYO1R9g
	 wKJyo4XyGTUfN53RX0t1pMTaIuXOphmH+RM8POA26SvE223MFAZlj80wyphGDYEThn
	 9p+HptNmFNo1hOvR7ECRYbnRBbHXb5JII4/BSBVdIB18aMom9YNoXfSd14Efu3oEO6
	 94rcJ8AQR0hcYlEI0Vt9urNhvqUYiW307twuZR1kIuS95TicAFKMKO/TBgOXKfJisy
	 glckMWm75eQog==
Message-ID: <529a9856-4a0d-4db0-9c97-43c0c462e396@kernel.org>
Date: Thu, 25 Jun 2026 14:27:17 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 7/9] mm/slab: introduce kfree_rcu_nolock()
To: XIAO WU <xiaowu.417@qq.com>, Vlastimil Babka <vbabka@kernel.org>,
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
 <20260615-kfree_rcu_nolock-v3-7-70a54f3775bb@kernel.org>
 <tencent_45CAE878B5922990DB102BE05A1BAD50DA09@qq.com>
 <e54ce8be-9480-4583-9c6a-d0dbe1378f53@kernel.org>
 <tencent_12A1049445F2CE248F20CB235AC111353A0A@qq.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <tencent_12A1049445F2CE248F20CB235AC111353A0A@qq.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HHB5JammkAG9i5v0ifUbiioD"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------HHB5JammkAG9i5v0ifUbiioD
Content-Type: multipart/mixed; boundary="------------5yZ5NYuEVU4HrXYvVZYNisDF";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: XIAO WU <xiaowu.417@qq.com>, Vlastimil Babka <vbabka@kernel.org>,
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
Message-ID: <529a9856-4a0d-4db0-9c97-43c0c462e396@kernel.org>
Subject: Re: [PATCH for-next v3 7/9] mm/slab: introduce kfree_rcu_nolock()
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-7-70a54f3775bb@kernel.org>
 <tencent_45CAE878B5922990DB102BE05A1BAD50DA09@qq.com>
 <e54ce8be-9480-4583-9c6a-d0dbe1378f53@kernel.org>
 <tencent_12A1049445F2CE248F20CB235AC111353A0A@qq.com>
In-Reply-To: <tencent_12A1049445F2CE248F20CB235AC111353A0A@qq.com>

--------------5yZ5NYuEVU4HrXYvVZYNisDF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/22/26 11:56 PM, XIAO WU wrote:
> Hi Harry,
>=20
> On Mon, Jun 22, 2026 at 02:28:44PM +0900, Harry Yoo wrote:
>> On 6/21/26 9:29 AM, XIAO WU wrote:
>> > I was able to reproduce this in QEMU with KASAN.=C2=A0 The trigger i=
s as
>> > simple as passing a large (>8KB) kmalloc buffer to the new function.=

>>
>> Thanks for taking a look, but this was intentional.
>>
>> I should have documented that only kmalloc_nolock() ->
>> kfree_rcu_nolock() is allowed and kmalloc() -> kfree_rcu_nolock()
>> is not allowed (yet).
>>
>> Since kmalloc_nolock() does not support large kmalloc, the warning
>> is not supposed to trigger. That is why I added only debug warnings.
>=20
> Thank you very much for taking the time to explain =E2=80=94 I really
> appreciate it, especially since I'm still learning my way around the
> mm/ subsystem.=C2=A0 You are absolutely right that kmalloc_nolock() ret=
urns
> NULL for sizes above KMALLOC_MAX_CACHE_SIZE, so a proper caller using
> the kmalloc_nolock() =E2=86=92 kfree_rcu_nolock() pairing would never h=
it this.
>=20
> I did notice one small thing that I wanted to gently bring up, though.
> Please forgive me if I'm missing something obvious here.
>=20
> When I was reading through the surrounding code to understand the
> pattern better, I noticed that kfree_nolock() =E2=80=94 which has the s=
ame
> "only for kmalloc_nolock()" constraint (documented in the comment at
> mm/slub.c:6828-6835) =E2=80=94 actually does check for a NULL slab:
>=20
> =C2=A0 void kfree_nolock(const void *object)
> =C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 slab =3D virt_to_slab(object);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(!slab)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ONCE(1, "la=
rge_kmalloc is not supported by kfree_nolock()");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D slab->slab_cache;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>=20
> So kfree_nolock() gracefully returns with a warning even though it too
> expects only kmalloc_nolock() callers.=C2=A0 That pattern seemed really=

> sensible to me =E2=80=94 it costs almost nothing and prevents a panic i=
f
> someone ever passes the wrong pointer (which they shouldn't, but as you=

> mentioned, the constraint isn't documented on kfree_call_rcu_nolock()
> yet).
>
> I also wondered about the difference between WARN_ONCE (used in
> kfree_nolock) and VM_WARN_ON_ONCE (used in kfree_call_rcu_nolock).=C2=A0=
If
> I understand correctly, VM_WARN_ON_ONCE compiles away entirely on
> production kernels without CONFIG_DEBUG_VM, which would make the
> subsequent NULL dereference completely silent =E2=80=94 no warning, jus=
t a
> panic.

It would crash without debug option anyway, but warnings are there to
make it easier to point what's gone wrong.

And not testing the code path at least once with debug option is a big
problem :)

> And since you mentioned that kmalloc() =E2=86=92 kfree_rcu_nolock() sup=
port is
> planned for the future (the "yet") =E2=80=94 wouldn't this code path ne=
ed the
> NULL check at that point anyway?
>=20
> I was thinking something like this would make the function consistent
> with kfree_nolock() and also make it forward-compatible with the
> planned kmalloc() support:
>=20
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1266,10 +1266,16 @@ void kfree_call_rcu_nolock(struct rcu_head
> *head, void *ptr)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 struct slab *slab;
> =C2=A0=C2=A0=C2=A0=C2=A0 struct kmem_cache *s;
>=20
> -=C2=A0=C2=A0=C2=A0 VM_WARN_ON_ONCE(is_vmalloc_addr(ptr) || !virt_to_sl=
ab(ptr));
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 slab =3D virt_to_slab(ptr);
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * kmalloc_nolock() never produces large-kmall=
oc or vmalloc
> +=C2=A0=C2=A0=C2=A0=C2=A0 * addresses, but be defensive: fall back to d=
efer_kfree_rcu()
> +=C2=A0=C2=A0=C2=A0=C2=A0 * for unsupported pointer types, consistent w=
ith kfree_nolock().
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 if (unlikely(!slab))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fallback;

Just FYI, virt_to_slab() and virt_to_page()
don't work correctly for vmalloc addresses.

And I don't think silently making it work is good.

> +
> =C2=A0=C2=A0=C2=A0=C2=A0 s =3D slab->slab_cache;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 if (__kfree_rcu_sheaf(s, ptr, /* allow_spin =3D=
 */ false))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>=20
> +fallback:
> =C2=A0=C2=A0=C2=A0=C2=A0 defer_kfree_rcu(head);
> =C2=A0}
>=20
> Of course, this is just a suggestion =E2=80=94 you know this code far b=
etter
> than I do.=C2=A0 If you feel the current code is fine as-is with proper=

> documentation, I completely understand and won't press the point
> further.
>=20
> Either way, thank you again for the explanation, and for working on
> this series =E2=80=94 having kfree_rcu_nolock() available for BPF and o=
ther
> contexts will be really valuable.
>=20
> Thanks,
> XIAO

--------------5yZ5NYuEVU4HrXYvVZYNisDF--

--------------HHB5JammkAG9i5v0ifUbiioD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajy8NQAKCRCGXBN6rc5S
1oG6AQDcpJmCoSOVmh6QBfAn7SSLAj/dCrCVdlDGkux+9WPEAAEAwzyj8gI9j//s
tpMbnooH3cAwdhFTBanFE9AL924TWgk=
=XwYR
-----END PGP SIGNATURE-----

--------------HHB5JammkAG9i5v0ifUbiioD--

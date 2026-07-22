Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6732DEA6B;
	Wed, 22 Jul 2026 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704573; cv=none; b=rXT/6eWkRH1uEi9SdaRAtOn8buBTT3wxlZTN1h1Z4CQcZyJ4j3DgSaYBh5cHmXfDZdsEZveePENEoNdOj9zpMA3IXk+r1z/+C7gwsIcFsLddmVCXe+xgTNtEXe/nkKlpgNa/IjrpxnejPya8sxU3LQx6hI9nios+xF7s0WpcOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704573; c=relaxed/simple;
	bh=693vjRiYIWjTznoCO9BwIbJbyn7Sft9EHzTdPud4tSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDH+OCM5R/DQCkGf3wzp1kreONAZ2uBLCLvcP1J2ZirLo/sRn3vtmAGJXmVpJTTwJW5tifnNz9uuOX57qDHJcowIZooQvsTTkcRYRL5MjzBptrO/gKnNHMwTKNrfD7YKDwUa6dMK3UO49nqK7UP7o6WMSfdqeM4ueUNX+LE59zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc2KXFhL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc2KXFhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CF81F000E9;
	Wed, 22 Jul 2026 07:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784704571;
	bh=QczM2k3gjfBkQg6SLRGr4KO6x2nabmYHG3X/oqp3yTs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bc2KXFhLyD1DFGv9udYttAPL0u9PjXCUNwYk04HPyfgCvnAu9cGaUQrkVKvywTKP0
	 q6a4lSNIvV/Uj+o6GsQJz7gfTQhwKYCN2YV0cMHbW9FvAzXDNF/r4gRv347/cb4NkC
	 BVwlbm1iBJ/BBJaazXm5X/zPLqkS0JgXjeJxDBkvuFqjPh+YhL2ruH6sNcNAGmJzKc
	 qcOh6urXoStSQVqxwmwYJK0SDceGzyBkt3rXoQVi8NT1r16WBweAkE1aN19QvgPL/F
	 w1II5sds5nmCRYLsCDvcjrsmqp3Oygz24L/gQM/umdbjIO9AQIsbSR9uTfnPF3ijIC
	 NfIcK7iov/lCg==
Message-ID: <004d1215-a1da-448e-bf10-df637c7029f5@kernel.org>
Date: Wed, 22 Jul 2026 16:16:00 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab/for-next v4 1/8] mm/slab, slub_kunit: register kprobe
 to trigger _nolock APIs
To: hu.shengming@zte.com.cn
Cc: vbabka@kernel.org, akpm@linux-foundation.org, hao.li@linux.dev,
 cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev,
 ast@kernel.org, andrii@kernel.org, puranjay@kernel.org, ameryhung@gmail.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 joelagnelf@nvidia.com, josh@joshtriplett.org, boqun@kernel.org,
 urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, pfalcato@suse.de, surenb@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
References: <20260722112748588_IEr10bQdigv8c8bjw7Ck@zte.com.cn>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260722112748588_IEr10bQdigv8c8bjw7Ck@zte.com.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------l2diSXyS8PSFwRyJhRRP3Q53"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------l2diSXyS8PSFwRyJhRRP3Q53
Content-Type: multipart/mixed; boundary="------------80TQbEbkEElO0TKxmuJVujmY";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: hu.shengming@zte.com.cn
Cc: vbabka@kernel.org, akpm@linux-foundation.org, hao.li@linux.dev,
 cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev,
 ast@kernel.org, andrii@kernel.org, puranjay@kernel.org, ameryhung@gmail.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 joelagnelf@nvidia.com, josh@joshtriplett.org, boqun@kernel.org,
 urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, pfalcato@suse.de, surenb@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <004d1215-a1da-448e-bf10-df637c7029f5@kernel.org>
Subject: Re: [PATCH slab/for-next v4 1/8] mm/slab, slub_kunit: register kprobe
 to trigger _nolock APIs
References: <20260722112748588_IEr10bQdigv8c8bjw7Ck@zte.com.cn>
In-Reply-To: <20260722112748588_IEr10bQdigv8c8bjw7Ck@zte.com.cn>

--------------80TQbEbkEElO0TKxmuJVujmY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/22/26 12:27 PM, hu.shengming@zte.com.cn wrote:
> Harry wrote:
>> Since kmalloc_nolock() always fails in NMI and hardirq contexts on
>> PREEMPT_RT, slub_kunit cannot properly test _nolock() APIs.
>>
>> Register a kprobe pre-handler to invoke kmalloc_nolock() and
>> kfree_nolock() in the middle of the slab allocator. However, do not
>> register the handler on UP kernels because that use case is not
>> well supported [1] in the kernel.
>>
>> To attach the pre-handler while s->cpu_sheaves->lock or n->list_lock
>> is held, add a wrapper function for lockdep_assert_held() that calls
>> a no-op function slab_attach_kprobe_locked() on debug builds. The
>> function is optimized away when neither CONFIG_PROVE_LOCKING nor
>> CONFIG_DEBUG_VM is selected and register_kprobe() fails.
>>
>> The function calls barrier() to prevent the compiler from optimizing
>> away its callsites. Otherwise, the compiler may consider the function
>> does not have any side effect and remove callsites.
>>
>> Compared to using plain kprobe, this has two advantages: 1) it avoids
>> hardcoding function names in the test, and 2) it can trigger those API=
s
>> in the middle of a function, where the lock is expected to be held as
>> annotated with lockdep.
>>
>> While it was proposed [2] to use kunit function redirection to test
>> this, it is currently infeasible as some lock helpers don't have
>> symbols.
>>
>> Factor out the nested loop that calls kmalloc and friends to
>> test_kmalloc_kfree(), and call them in
>> test_kmalloc_kfree_nolock_{perf,kprobe}(), each being an independent
>> test case. During the refactoring, drop alloc_fail handling as it
>> doesn't provide much benefits.
>=20
> Nice test addition!
>=20
> Reviewed-by: Shengming Hu <hu.shengming@zte.com.cn>

Thanks a lot for reviewing, Shengming!

Just FYI, I'm going to adjust a nit pointed out by sashiko
that kmalloc_obj(*objects[j], gfp) is wrong because objects is an array
of void pointers. (which is fixed later in the series)

> Nit below:
>> +static void test_kmalloc_kfree_nolock_perf(struct kunit *test)
>> +{
>> +    struct test_nolock_context ctx =3D { .test =3D test };
>> =20
>> -    kunit_info(test, "callback_count: %d, alloc_ok: %d, alloc_fail: %=
d\n",
>> -           ctx.callback_count, ctx.alloc_ok, ctx.alloc_fail);
>> +    if (!enable_perf_events(&ctx))
>> +        kunit_skip(test, "Failed to enable perf event, skipping");
>> =20
>> -    if (alloc_fail)
>> -        kunit_skip(test, "Allocation failed");
>> +    test_kmalloc_kfree();
>> +
>> +    disable_perf_events(&ctx);
>> +    KUNIT_EXPECT_EQ(test, 0, slab_errors);
>> +}
>> +#endif
>> +
>=20
> Maybe it would be worth checking that the perf event actually fired:
>=20
>     KUNIT_EXPECT_GT(test, ctx.callback_count, 0);
>=20
> Otherwise, the test could pass without the callback.

I'm not sure if that would be useful though.

Ideally we want to make sure every code path that handles
allow_spin =3D false is tested, but it's tricky to measure that and
also it's tricky to make sure those paths are properly tested
(especially with perf events).

callback_count is not a good indicator to measure test coverage.

(I use GCOV to make sure we have reasonable coverage,
 but it's hard to turn that into a test case...)

--=20
Cheers,
Harry / Hyeonggon

--------------80TQbEbkEElO0TKxmuJVujmY--

--------------l2diSXyS8PSFwRyJhRRP3Q53
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCamBuMAAKCRCGXBN6rc5S
1sPeAQDxKa0DMrDQTezN00ksgEUR3eb05xC3gVwrShymZlkh5wEA7tBOlrr/Ntis
S3x7DXHLG0TmEitCZ5rUhYKcT3diOQI=
=g7jN
-----END PGP SIGNATURE-----

--------------l2diSXyS8PSFwRyJhRRP3Q53--

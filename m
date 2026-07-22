Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C221147011A;
	Wed, 22 Jul 2026 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706095; cv=none; b=fMsowZEQTYR7U3v4DTYmSXkG4hz5pKbXrPt5pa5V7jh0mD3pxEpBZnY0y4l/BCQaztLWzXoNXZqUy7a4wyWPLlbA0dkaVrkHOiQwvcrVQ3absZK8oUpiuzSlyHGT4MX3PQx1Jdjn4hZFuJTOqS2Djtu4ECYYN7mtqiOVVXKoHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706095; c=relaxed/simple;
	bh=/bZ14wfD1VjQUxGa8o5N4AZcT3y7eFbvR1Xq4PugpWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pzrtb9IyrqpZhoxjNHAZ9TJlHrRsxXLh35FwYYHP9ncCASti0hYec6Fu315+J+Y7ywtGd9PkmKW/chJHm/xDc3BSuYpp/NMSSHwqOeTYpzZ8nl03p+mXN1+Rr8uFgrCSWjhjw8bDhREE7EnM5XzI1j4xA37G4kZgpzSGzxw7nQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNRnnssp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNRnnssp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CA81F00A3E;
	Wed, 22 Jul 2026 07:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784706093;
	bh=DkYFTwjHZKjxyQiTfx2FZv9AZzQHiWm6hGSqFhQTJEA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MNRnnsspjTW0pzTMK5CPKpT0g2s6VB5tP+5QE1fzCeTK2Bls7R/VJjVNStr7r7Rzh
	 khGSgVTXYRD+HeREZxwu1HENZxuUWBnMmazGlw67xobMup9yQfYB9gt7NyxkHp8wej
	 PMQuk4u1dbvNNkBKu5gAQWqaIWDBNky0TmADf30ZsBuXTUuXvmb405cY9sviVI99ML
	 THOB9xbIic/p1T+70WNH1txce2GznY/7mBgJTfpr4/5KPCv10rWUFXtn6yaDRz2MJl
	 wBgslpphnM3PyQ9oY79iDcVqMoXSvtV090gBbJmCIeqwDTZxaJW8/xXC09gpPEGgkB
	 nXflDdRwU5IOA==
Message-ID: <8c4ca514-70b5-4387-8222-1bf36268a459@kernel.org>
Date: Wed, 22 Jul 2026 16:41:21 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab/for-next v4 5/8] mm/slab: allow kfree_rcu_sheaf() on
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
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Shengming Hu <hu.shengming@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-5-964e03c41a4e@kernel.org>
 <12c63386-f96e-421e-b34c-00548d016f69@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <12c63386-f96e-421e-b34c-00548d016f69@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zvuw01Ri0HTIKPpVv3AuC0Ax"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zvuw01Ri0HTIKPpVv3AuC0Ax
Content-Type: multipart/mixed; boundary="------------kPOdFZ6UV65n843BaCudyxTR";
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
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Shengming Hu <hu.shengming@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <8c4ca514-70b5-4387-8222-1bf36268a459@kernel.org>
Subject: Re: [PATCH slab/for-next v4 5/8] mm/slab: allow kfree_rcu_sheaf() on
 PREEMPT_RT
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-5-964e03c41a4e@kernel.org>
 <12c63386-f96e-421e-b34c-00548d016f69@kernel.org>
In-Reply-To: <12c63386-f96e-421e-b34c-00548d016f69@kernel.org>

--------------kPOdFZ6UV65n843BaCudyxTR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/21/26 7:46 PM, Vlastimil Babka (SUSE) wrote:
> On 7/20/26 14:44, Harry Yoo (Oracle) wrote:
>> As suggested by Vlastimil Babka [1], kfree_rcu_sheaf() can be used
>> on PREEMPT_RT if we always assume spinning is not allowed on PREEMPT_R=
T.
>> This is because local_trylock and spinlock_t are safe to use with
>> trylock and unlock as long as the kernel does not spin and the context=

>> is not NMI and not hardirq.
>>
>> Now that __kfree_rcu_sheaf() knows how to handle SLAB_FREE_NOLOCK,
>> relax the limitation and try the sheaves path on PREEMPT_RT as well.
>>
>> Keep the lockdep map on non RT kernels. However, do not use the lockde=
p
>> map on PREEMPT_RT to avoid suppressing valid lockdep warnings.
>>
>> As pointed by Vlastimil Babka [2], on PREEMPT_RT it is unnecessary to
>> defer call_rcu() under IRQ-disabled section or raw spinlock. However,
>> let us avoid adding more complexity as the scenario is not supposed
>> to be common on PREEMPT_RT, with a hope that call_rcu_nolock() will be=

>> soon supported in RCU.
>>
>> Link: https://lore.kernel.org/linux-mm/6811cc17-8ee4-48c8-8cbf-6bf4d9f=
98162@kernel.org [1]
>> Link: https://lore.kernel.org/linux-mm/40591888-3a87-433e-b3d2-cda1cab=
543be@kernel.org [2]
>> Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>=20
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks!

> Nit:
>=20
>> ---
>>  mm/slab_common.c | 12 ++++++++++--
>>  mm/slub.c        | 17 ++++++++++-------
>>  2 files changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 9c9ae1384f47..8c631bf97cd5 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1595,6 +1595,14 @@ static bool kfree_rcu_sheaf(void *obj)
>>  {
>>  	struct kmem_cache *s;
>>  	struct slab *slab;
>> +	unsigned int free_flags =3D SLAB_FREE_DEFAULT;
>> +
>> +	/*
>> +	 * It is not safe to spin on PREEMPT_RT because the kernel might be
>> +	 * holding a raw spinlock and slab acquires sleeping locks.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>> +		free_flags =3D SLAB_FREE_NOLOCK;
>> =20
>>  	if (is_vmalloc_addr(obj))
>>  		return false;
>> @@ -1605,7 +1613,7 @@ static bool kfree_rcu_sheaf(void *obj)
>> =20
>>  	s =3D slab->slab_cache;
>>  	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) =3D=3D numa_me=
m_id()))
>> -		return __kfree_rcu_sheaf(s, obj, SLAB_FREE_DEFAULT);
>> +		return __kfree_rcu_sheaf(s, obj, free_flags);
>> =20
>>  	return false;
>>  }
>> @@ -1954,7 +1962,7 @@ void kvfree_call_rcu(struct rcu_head *head, void=
 *ptr)
>>  	if (!head)
>>  		might_sleep();
>> =20
>> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
>> +	if (kfree_rcu_sheaf(ptr))
>>  		return;
>> =20
>>  	// Queue the object but don't yet schedule the batch.
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 8afa6b47b1f2..deac315d0f23 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -6065,12 +6065,13 @@ static void rcu_free_sheaf(struct rcu_head *he=
ad)
>>   * kvfree_call_rcu() can be called while holding a raw_spinlock_t. Si=
nce
>>   * __kfree_rcu_sheaf() may acquire a spinlock_t (sleeping lock on PRE=
EMPT_RT),
>>   * this would violate lock nesting rules. Therefore, kvfree_call_rcu(=
) avoids
>> - * this problem by bypassing the sheaves layer entirely on PREEMPT_RT=
=2E
>> + * this problem by passing allow_spin =3D false on PREEMPT_RT.
>=20
> by passing SLAB_FREE_NOLOCK ?

Ouch, I noticed this but forgot to update.
Will adjust, thanks.

--=20
Cheers,
Harry / Hyeonggon

--------------kPOdFZ6UV65n843BaCudyxTR--

--------------zvuw01Ri0HTIKPpVv3AuC0Ax
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCamB0IQAKCRCGXBN6rc5S
1jngAP4qNZOJWiF6EPduiXRQDLujh5HTcZdsJh5hjtd1kWD2owEA+iqD7S6dRH85
+bQsgf5IcYFp+JR12z5Ggt14BJ0+iwE=
=8to1
-----END PGP SIGNATURE-----

--------------zvuw01Ri0HTIKPpVv3AuC0Ax--

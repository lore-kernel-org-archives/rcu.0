Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD834A791;
	Wed, 17 Jun 2026 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781674381; cv=none; b=QfIL6Fi2OErw3o9Sg9TkoYTBaNDREqvYg6KsB+wnk66JaospLymzBWGFRJHjIO/+gpeTn5gJ6uJmrvspY+pSDDyjXzPWJoozA4pg8zAqpsKuklHEAfyT5/IcMSmZkyolSNLoalP62r7wsc0xIOGoGN8V/wjC/GMIf/c2K0/qutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781674381; c=relaxed/simple;
	bh=jGEuNpic4qZyQr9xTfusui6vESYaBx+XTLnP6gs8AvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqImvLx2DBezd0sR6Ua1EfwQiawc96sJa+QZtERVO4yqx8NVp9tVf4wR+hJdUYcLr4YfMghJ1zak9/YxOrHKdr+r7PNgaIAnPQmOXNDN2xhQY6El1v4Ddf6x1te//aRBl6u2L0vV+KP/sNv8KXR4c7ZaQi8Q8xhTzJ1fkc82cOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMCuyKZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMCuyKZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877061F000E9;
	Wed, 17 Jun 2026 05:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781674379;
	bh=ZCy0RGVwhFQ7leuqrM8fySPSwmvrPlB9/5amWSSk2xU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aMCuyKZAe8lfdvxd9tXY5nOBo75gNBoltsHEPiWGh202rk9fIzGH/nd47z8zj+b/Z
	 Aub3vtYaviTBghykfLFvwDEFrwja9TuiNu58TIkNKnDTUsDKe6ibWQnrqcy9yRR/Gl
	 PySfsN8XOIsxsihzAc+6iRyO2uvYsp4tUyxckBeU8gxidmki9vnmFmO9bmu7EwU7fg
	 3phTLDqLdMa8RzJWw3uVxxnMzXxClIfePk+XS1zbS9bKa0taO4Le/uvZmD3KjdLTgS
	 5JDSuADJDc6H8PMHd+j0Ba9Da8TpLsfeGiq0yFeb3uzwT1B3M00zWb4LPiN00NnMNc
	 x9DAvj4bue+GQ==
Message-ID: <e8940857-4f71-4a34-ad80-81584f7378c8@kernel.org>
Date: Wed, 17 Jun 2026 14:32:52 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 3/9] mm/slab: handle the !allow_spin case in
 kfree_rcu_sheaf()
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
 <20260615-kfree_rcu_nolock-v3-3-70a54f3775bb@kernel.org>
 <4d7ebcd5-f3b7-4c73-94f1-b7d3ac12a521@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <4d7ebcd5-f3b7-4c73-94f1-b7d3ac12a521@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gZ9AQq0y4SZlPtbwhYO0tskz"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gZ9AQq0y4SZlPtbwhYO0tskz
Content-Type: multipart/mixed; boundary="------------oyYMwnEgsJOBwiuqZXNKiyCU";
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
Message-ID: <e8940857-4f71-4a34-ad80-81584f7378c8@kernel.org>
Subject: Re: [PATCH for-next v3 3/9] mm/slab: handle the !allow_spin case in
 kfree_rcu_sheaf()
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-3-70a54f3775bb@kernel.org>
 <4d7ebcd5-f3b7-4c73-94f1-b7d3ac12a521@kernel.org>
In-Reply-To: <4d7ebcd5-f3b7-4c73-94f1-b7d3ac12a521@kernel.org>

--------------oyYMwnEgsJOBwiuqZXNKiyCU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/16/26 4:55 PM, Vlastimil Babka (SUSE) wrote:
> On 6/15/26 13:05, Harry Yoo (Oracle) wrote:
>> Teach kfree_rcu_sheaf() how to handle the !allow_spin case. Try to get=

>> an empty sheaf from pcs->spare or the barn even when spinning is not
>> allowed. Unlike __pcs_replace_full_main(), try harder to allocate
>> an empty sheaf because the fallback path will be more expensive than
>> kfree_nolock().
>=20
> You mean that it will try to allocate an empty sheaf, while
> __pcs_replace_full_main() doesn't with allow_spin =3D=3D false.
> I just noticed the comment there is a bit stale... nevermind.

That function

>> When trylock fails or the kernel observes non-NULL pcs->rcu_free after=

>> lock acquisition, free the sheaf instead of putting it to the barn.
>> This is rare and not worth complicating the code.
>>
>> Since call_rcu() cannot be called in an unknown context,
>> kfree_rcu_sheaf() fails when the rcu sheaf becomes full.
>>
>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>> ---
>>  mm/slab.h        |  2 +-
>>  mm/slab_common.c |  2 +-
>>  mm/slub.c        | 39 ++++++++++++++++++++++++++++++---------
>>  3 files changed, 32 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 509f330654b8..b1bd33a16544 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -429,7 +429,7 @@ static inline bool is_kmalloc_normal(struct kmem_c=
ache *s)
>>  	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUN=
T));
>>  }
>> =20
>> -bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
>> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_sp=
in);
>>  void flush_all_rcu_sheaves(void);
>>  void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
>> =20
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index b6426d7ceec9..bc1a8ec938d9 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1605,7 +1605,7 @@ static bool kfree_rcu_sheaf(void *obj)
>> =20
>>  	s =3D slab->slab_cache;
>>  	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) =3D=3D numa_me=
m_id()))
>> -		return __kfree_rcu_sheaf(s, obj);
>> +		return __kfree_rcu_sheaf(s, obj, /* allow_spin =3D */ true);
>> =20
>>  	return false;
>>  }
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 87ca154ccd80..b0d38d515386 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2815,7 +2815,8 @@ static inline struct slab_sheaf *alloc_empty_she=
af(struct kmem_cache *s,
>>  	return __alloc_empty_sheaf(s, gfp, alloc_flags, s->sheaf_capacity);
>>  }
>> =20
>> -static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf =
*sheaf)
>> +static void __free_empty_sheaf(struct kmem_cache *s, struct slab_shea=
f *sheaf,
>> +			       bool allow_spin)
>>  {
>>  	/*
>>  	 * If the sheaf was created with SLAB_ALLOC_NO_RECURSE flag then its=

>> @@ -2827,11 +2828,20 @@ static void free_empty_sheaf(struct kmem_cache=
 *s, struct slab_sheaf *sheaf)
>>  		mark_obj_codetag_empty(sheaf);
>> =20
>>  	VM_WARN_ON_ONCE(sheaf->size > 0);
>> -	kfree(sheaf);
>> +
>> +	if (likely(allow_spin))
>> +		kfree(sheaf);
>> +	else
>> +		kfree_nolock(sheaf);
>=20
> Hmm what if the sheaf wasn't allocated with kmalloc_nolock()?
>=20
>>  	stat(s, SHEAF_FREE);
>>  }
>> =20
>> +static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf =
*sheaf)
>> +{
>> +	__free_empty_sheaf(s, sheaf, /* allow_spin =3D */ true);
>> +}
>> +
>>  static unsigned int
>>  refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned in=
t min,
>>  	       unsigned int max);
>> @@ -3132,7 +3142,6 @@ static struct slab_sheaf *barn_get_empty_sheaf(s=
truct node_barn *barn,
>>   * intended action due to a race or cpu migration. Thus they do not c=
heck the
>>   * empty or full sheaf limits for simplicity.
>>   */
>> -
>>  static void barn_put_empty_sheaf(struct node_barn *barn, struct slab_=
sheaf *sheaf)
>>  {
>>  	unsigned long flags;
>> @@ -6065,7 +6074,7 @@ static void rcu_free_sheaf(struct rcu_head *head=
)
>>   */
>>  static DEFINE_WAIT_OVERRIDE_MAP(kfree_rcu_sheaf_map, LD_WAIT_CONFIG);=

>> =20
>> -bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_sp=
in)
>>  {
>>  	struct slub_percpu_sheaves *pcs;
>>  	struct slab_sheaf *rcu_sheaf;
>> @@ -6081,9 +6090,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, vo=
id *obj)
>>  	pcs =3D this_cpu_ptr(s->cpu_sheaves);
>> =20
>>  	if (unlikely(!pcs->rcu_free)) {
>> -
>>  		struct slab_sheaf *empty;
>>  		struct node_barn *barn;
>> +		unsigned int alloc_flags =3D SLAB_ALLOC_DEFAULT;
>> +		gfp_t gfp =3D GFP_NOWAIT;
>> =20
>>  		/* Bootstrap or debug cache, fall back */
>>  		if (unlikely(!cache_has_sheaves(s))) {
>> @@ -6103,7 +6113,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, voi=
d *obj)
>>  			goto fail;
>>  		}
>> =20
>> -		empty =3D barn_get_empty_sheaf(barn, true);
>> +		empty =3D barn_get_empty_sheaf(barn, allow_spin);
>=20
> Here we might be getting a sheaf allocated previously with kmalloc().

Right.

>> =20
>>  		if (empty) {
>>  			pcs->rcu_free =3D empty;
>> @@ -6112,20 +6122,25 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, v=
oid *obj)
>> =20
>>  		local_unlock(&s->cpu_sheaves->lock);
>> =20
>> -		empty =3D alloc_empty_sheaf(s, GFP_NOWAIT, SLAB_ALLOC_DEFAULT);
>> +		if (unlikely(!allow_spin)) {
>> +			alloc_flags =3D SLAB_ALLOC_TRYLOCK;
>> +			gfp =3D 0;
>=20
> Maybe __GFP_NOWARN?

Ouch. Good catch. Thanks! Will do.

> Here we would get a sheaf with kmalloc_nolock() so that's ok even if it=
's
> later freed by someone else by kfree(), right.
>=20
>> +		}
>> +
>> +		empty =3D alloc_empty_sheaf(s, gfp, alloc_flags);
>> =20
>>  		if (!empty)
>>  			goto fail;
>> =20
>>  		if (!local_trylock(&s->cpu_sheaves->lock)) {
>> -			barn_put_empty_sheaf(barn, empty);
>> +			__free_empty_sheaf(s, empty, allow_spin);
>=20
> Well we could still use the barn with allow_spin =3D=3D true.

Initially I did

if (!__barn_put_empty_sheaf(barn, empty, allow_spin))
	__free_empty_sheaf(s, empty, allow_spin);

but I ended up just calling __free_empty_sheaf() because it's
pretty rare to hit... no strong opinion though.

> But more crucially, here we might be freeing with kfree_nolock() a shea=
f
> from the barn previously allocated with kmalloc()?

Well, we don't release and reacquire the local lock when we got an empty
sheaf from the barn, so it doesn't free the sheaf from the barn?

That was indeed very subtle and I got confused :D.

When we free a sheaf in this function, it's always allocated in current
context?

> Maybe we need to track if it's the case and defer-free it or something.=

>=20
> Also maybe there could be a wrapper kfree_maybe_nolock() (~better name?=
)
> That means "I want to kfree safely in kfree_nolock() context something =
that
> MIGHT have been kmalloc()"
> And maybe depending on the debugging options that make kmalloc() ->
> kfree_nolock() incompatible, if those are not enabled, it wouldn't have=
 to
> defer, but proceed normally?

But I really like the idea of supporting kmalloc() -> kfree_nolock(),
and I think it's worth exploring that.

Thanks!

--=20
Cheers,
Harry / Hyeonggon

>>  			goto fail;
>>  		}
>> =20
>>  		pcs =3D this_cpu_ptr(s->cpu_sheaves);
>> =20
>>  		if (unlikely(pcs->rcu_free))
>> -			barn_put_empty_sheaf(barn, empty);
>> +			__free_empty_sheaf(s, empty, allow_spin);
>>  		else
>>  			pcs->rcu_free =3D empty;
>>  	}
>> @@ -6143,6 +6158,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, vo=
id *obj)
>>  	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
>>  		rcu_sheaf =3D NULL;
>>  	} else {
>> +		if (unlikely(!allow_spin)) {
>> +			/* call_rcu() cannot be called in an unknown context */
>> +			rcu_sheaf->size--;
>> +			local_unlock(&s->cpu_sheaves->lock);
>> +			goto fail;
>> +		}
>>  		pcs->rcu_free =3D NULL;
>>  		rcu_sheaf->node =3D numa_node_id();
>>  	}

--------------oyYMwnEgsJOBwiuqZXNKiyCU--

--------------gZ9AQq0y4SZlPtbwhYO0tskz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajIxhAAKCRCGXBN6rc5S
1m+4AP9ew2whcCln80iVmFOKVQp6yA+tZBtPYjgxhkggCH1lBgD+Ot0nZKepZ2Jp
pVPDKTSYJm7mbApT5N01TQjdmN0Srwo=
=rHGs
-----END PGP SIGNATURE-----

--------------gZ9AQq0y4SZlPtbwhYO0tskz--

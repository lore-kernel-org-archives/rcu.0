Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC901E2614;
	Mon, 29 Jun 2026 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782720085; cv=none; b=dxiREtYG+DY1kZo4Tw/RCSsWGqDsfyBcyKsMH+k64UzMW2m0kniIJ8olIht7+DNR9P4yUgrKZuqK2erhPGju4bn+vdDXC9Rl33rsQ+pSoPd4Q8/crUEG1W1h2Fl/sRkKUyMZhneZh2vTH2EMcF4PgVLvERnDeLhU4pswjRH+B3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782720085; c=relaxed/simple;
	bh=6WtfEtDwRgZKtWJGqAWFdEHEncKVrRvsJrNAIoGHYDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZQE5OymF27l9bgREBheeVTzhE4C5EDOEbXPnztV6cZmIvX3UPAkrw9ppYCEszK17VB0IuL2sKwT4mFlKhCb72ONW6m+EsNIfzRjLkQBjfCG6AVScbHT9z22sbqrBeDSrx8Vtq7g9ku/dFK9AhKmYCfIS/8cnsg/ph+B6oS2vkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlN4ld7B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlN4ld7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EDE1F000E9;
	Mon, 29 Jun 2026 08:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782720083;
	bh=3LVSjuJQKF56hy+riBeL/zblhV4LkNcEAKxGC0pcQPg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mlN4ld7BkQYjyRTJK3kyWD4NufZhPV2GoGmPHHzeR/q5CzFBmiitR8vc1db+oPA49
	 wlUU+nB4lViDFMxuGBs7huTGjqMBsiaZenPP417l0HlRaY4/kAxEGwWRpz6QwLAd/Y
	 oxPJHxgxLsygyni6rSv5WQndKe2n6nqt+YAwzQNADIIIlQW/FBqQZT3HTKlgIp011S
	 J/IkEE2lomuIKOdNXvzgQ2ljK3+N5YPgG09MDmxyEzQ5XOI7NLg8FIMVQnPYWFH/Qs
	 PNEEogqpZMLvxtmUmiHDPlVqtBe/5RCa2e5vqY5bfDIYXSJQDioYy/oeNRLa4eEfkR
	 I1oOwobvw5JWQ==
Message-ID: <872bd673-3d45-4111-8a41-31185db3ece5@kernel.org>
Date: Mon, 29 Jun 2026 17:01:15 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 3/9] mm/slab: handle the !allow_spin case in
 kfree_rcu_sheaf()
To: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>,
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
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 rcu@vger.kernel.org, bpf@vger.kernel.org
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-3-70a54f3775bb@kernel.org>
 <ajvn5-2yJxykPlbP@pedro-suse>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <ajvn5-2yJxykPlbP@pedro-suse>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------s820ITmkaB0kEH48e0odpSeB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------s820ITmkaB0kEH48e0odpSeB
Content-Type: multipart/mixed; boundary="------------Wp0Llgz6JnGFUEROBnwNWjFi";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>,
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
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 rcu@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <872bd673-3d45-4111-8a41-31185db3ece5@kernel.org>
Subject: Re: [PATCH for-next v3 3/9] mm/slab: handle the !allow_spin case in
 kfree_rcu_sheaf()
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-3-70a54f3775bb@kernel.org>
 <ajvn5-2yJxykPlbP@pedro-suse>
In-Reply-To: <ajvn5-2yJxykPlbP@pedro-suse>

--------------Wp0Llgz6JnGFUEROBnwNWjFi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/24/26 11:28 PM, Pedro Falcato wrote:
> On Mon, Jun 15, 2026 at 08:05:57PM +0900, Harry Yoo (Oracle) wrote:
>> Teach kfree_rcu_sheaf() how to handle the !allow_spin case. Try to get=

>> an empty sheaf from pcs->spare or the barn even when spinning is not
>> allowed. Unlike __pcs_replace_full_main(), try harder to allocate
>> an empty sheaf because the fallback path will be more expensive than
>> kfree_nolock().
>>
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
>=20
> Since this is stacked on top of the slab alloc flags work, could it pas=
s slab
> alloc flags instead of allow_spin?

Good point.

Hmm, I thought we'll eventually introduce SLAB_FREE_ flags rather than
reusing SLAB_ALLOC_ flags (and then translate SLAB_FREE_NOLOCK to
SLAB_ALLOC_NOLOCK when allocating sheaves) rather than reusing
SLAB_ALLOC_ flags...

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
>=20
> which would make this logic more natural.

Right.

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
>
> and this as well (alloc_empty_sheaf() could derive gfp from whatever yo=
u
> passed it, by simply knowing alloc_flags =3D TRYLOCK -> gfp =3D 0
> (or gfp &=3D ~__GFP_RECLAIM)).

Right.

--=20
Cheers,
Harry / Hyeonggon


--------------Wp0Llgz6JnGFUEROBnwNWjFi--

--------------s820ITmkaB0kEH48e0odpSeB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCakImSwAKCRCGXBN6rc5S
1n9DAP9zhlN5ijXwjntBc0wlfFJAuqZardZzqd1PLSXx1SrTyAEA20oNG98gOTzG
A1Uncfq79JGJcEnkaLo9tcyk4f9Xog4=
=KrR/
-----END PGP SIGNATURE-----

--------------s820ITmkaB0kEH48e0odpSeB--

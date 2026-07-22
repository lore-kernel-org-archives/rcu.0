Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368C4195A3;
	Wed, 22 Jul 2026 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705345; cv=none; b=jwnnlNE51ofs6Zq53vP/191jVdxXx8iFnWb71SDCT/3dqYvMAjmKlj448w3PlgXvLSq8XhORa9iixpy9cP9cTa2TsMOTczmyS5rprCmf2Qwwl0+tZMBBX8sZMfWs9Ri5s6N2TNGT5mvW/GNB0co/5jBBAua4OzOpdZuZkamHR1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705345; c=relaxed/simple;
	bh=RiRK01IvlckUScgeNWGOPdPHw/zeYWLvwWkfa6wkKxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9mK2/IRFpKwjWqTXFlmqOD+Fpe0PtKKJjiJB7mrvpnW/f5lOZrNpi5Fw2BWkVDtEODeFKuUApLikRpjmbOvrpVPJz4UptdFByCfxYgOjSjRDwNqj0Om0hZPYJCDpMhgZ+OUKY/jG5iTmhOShrFEAjML+LtlY2MECIw4G7USZnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR1tq1df; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR1tq1df"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B939B1F000E9;
	Wed, 22 Jul 2026 07:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784705342;
	bh=8zaevow8IizUqrNUcZdF6Ch67AOjnnMBszvEW0bHxEE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eR1tq1dfYU3pPLytxYWoMVbWt34/wZDF68rS7EULqxvYoLvXO5reb0PEIU1z3P/sv
	 59BDy79IjRDD3KzwI4clF3F8lJigz9echcgr5En4CVUC1SPUI2XP5cc21m1c4rerb9
	 SXOFndIfgoe46aMUrRfmYVtxRcKoP9z81kVYtK+5WYl8VBmyL6017eBAKA4UNOoJPX
	 neQKetZ/7SZc0x8ubFK+ANzV+5efW46xojRoHhGkW2SfdsLaSWbj5o2qoPPLhecLlb
	 B04zwWJYf73qNeqn1w5xA4Nkvqe1ajUthU8vq6Vl4lAdai8YVPFkhnuuaHoHyM4S2j
	 QggDqSqh9TTIQ==
Message-ID: <0ce88f37-f231-4a00-b06b-95b0910c2db0@kernel.org>
Date: Wed, 22 Jul 2026 16:28:45 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab/for-next v4 2/8] mm/slab: handle the !allow_spin case
 in kfree_rcu_sheaf()
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
 <20260720-kfree_rcu_nolock-v4-2-964e03c41a4e@kernel.org>
 <1d0d8021-62d2-4c42-a2a6-a7e8ce2f5d37@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <1d0d8021-62d2-4c42-a2a6-a7e8ce2f5d37@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------58QvpuwGaHyC0C8BQWDhp8Ia"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------58QvpuwGaHyC0C8BQWDhp8Ia
Content-Type: multipart/mixed; boundary="------------40SV3jDSYoI2dLADM2Om5ZNL";
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
Message-ID: <0ce88f37-f231-4a00-b06b-95b0910c2db0@kernel.org>
Subject: Re: [PATCH slab/for-next v4 2/8] mm/slab: handle the !allow_spin case
 in kfree_rcu_sheaf()
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-2-964e03c41a4e@kernel.org>
 <1d0d8021-62d2-4c42-a2a6-a7e8ce2f5d37@kernel.org>
In-Reply-To: <1d0d8021-62d2-4c42-a2a6-a7e8ce2f5d37@kernel.org>

--------------40SV3jDSYoI2dLADM2Om5ZNL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/21/26 7:07 PM, Vlastimil Babka (SUSE) wrote:
> On 7/20/26 14:44, Harry Yoo (Oracle) wrote:
>> Teach kfree_rcu_sheaf() how to handle the !allow_spin case. Try to get=

>> an empty sheaf from pcs->spare or the barn even when spinning is not
>> allowed. Unlike __pcs_replace_full_main(), try harder to allocate
>> an empty sheaf because the fallback path will be more expensive than
>> kfree_nolock().
>>
>> Now that slab has internal alloc_flags to describe context, introduce
>> free_flags analogously and convert free_flags to alloc_flags when
>> allocating memory in the free path. alloc_empty_sheaf() now strips
>> __GFP_RECLAIM when SLAB_ALLOC_NOLOCK is specified.
>>
>> When trylock fails or the kernel observes non-NULL pcs->rcu_free after=

>> lock acquisition, free the sheaf instead of putting it to the barn.
>> This is rare and not worth complicating the code.
>>
>> Since call_rcu() cannot be called in an unknown context,
>> kfree_rcu_sheaf() fails when the rcu sheaf becomes full.
>>
>> Link: https://lore.kernel.org/linux-mm/872bd673-3d45-4111-8a41-31185db=
3ece5@kernel.org
>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>=20
> LGTM.
>=20
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks a lot for reviewing, Vlastimil!

> Nits below:
>=20
>> ---
>>  mm/slab.h        | 18 +++++++++++++++++-
>>  mm/slab_common.c |  2 +-
>>  mm/slub.c        | 36 ++++++++++++++++++++++++++++--------
>>  3 files changed, 46 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 281a65233795..85ef2ebc9812 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -429,7 +445,7 @@ static inline bool is_kmalloc_normal(struct kmem_c=
ache *s)
>>  	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUN=
T));
>>  }
>> =20
>> -bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
>> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int =
free_flags);
>>  void flush_all_rcu_sheaves(void);
>>  void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
>> =20
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index b6426d7ceec9..e07b4e6d6679 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1605,7 +1605,7 @@ static bool kfree_rcu_sheaf(void *obj)
>> =20
>>  	s =3D slab->slab_cache;
>>  	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) =3D=3D numa_me=
m_id()))
>> -		return __kfree_rcu_sheaf(s, obj);
>> +		return __kfree_rcu_sheaf(s, obj, SLAB_FREE_DEFAULT);
>> =20
>>  	return false;
>>  }
>> diff --git a/mm/slub.c b/mm/slub.c
>> index e32a68677537..0c350274fbff 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2814,10 +2814,14 @@ static inline struct slab_sheaf *alloc_empty_s=
heaf(struct kmem_cache *s,
>> =20
>>  	gfp &=3D ~OBJCGS_CLEAR_MASK;
>> =20
>> +	if (alloc_flags & SLAB_ALLOC_NOLOCK)
>> +		gfp &=3D ~__GFP_RECLAIM;
>=20
> So in general we expect gfp and alloc flags to be compatible and warn i=
f
> they are not. This now performs an auto-adjustment, which makes it unus=
ual.

That's fair.

> But AFAICS only one caller relies on it - __kfree_rcu_sheaf(). So maybe=
 we
> could just do it there?

Will do. I don't have strong preference on this.

>>  	return __alloc_empty_sheaf(s, gfp, alloc_flags, s->sheaf_capacity);
>>  }
>> =20
>> -static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf =
*sheaf)
>> +static void __free_empty_sheaf(struct kmem_cache *s, struct slab_shea=
f *sheaf,
>> +			       bool allow_spin)
>=20
> Why not free_flags instead of allow_spin? Since you already introduced =
them.

Indeed I tried that but gave up on doing that as part of series
after realizing free_empty_sheaf() alone has 12 callers :)

But I think it's worth teaching those functions (including
free_empty_sheaf()) to handle SLAB_ALLOC_* and SLAB_FREE_* flags
rather than propagating allow_spin.

--=20
Cheers,
Harry / Hyeonggon

--------------40SV3jDSYoI2dLADM2Om5ZNL--

--------------58QvpuwGaHyC0C8BQWDhp8Ia
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCamBxLQAKCRCGXBN6rc5S
1lmSAP9lYDgvsDB/HErz8AaTnBiLvXlODJbuM/n6AnzN174nqQD/e4Fyvp2AXL7v
i1a62GaFBxE4ZzdiDFmrY9G+9EoQZgs=
=AE3u
-----END PGP SIGNATURE-----

--------------58QvpuwGaHyC0C8BQWDhp8Ia--

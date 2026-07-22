Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E9D2D47F4;
	Wed, 22 Jul 2026 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706009; cv=none; b=e9PXJDM5zuprgm/qGZt2NcNsaiFL79HjdJQard/yYWh6amfEnYyZD5k0QYz88lwCkT1j75zxgBqM0cmW0nH+jVXQZBPQdKc7M0gself1z7IgICMr/sSwa9wAoWZdc3DzdsX2HWFKc3sNFMGl3CbMTb7MW8nalDKPNMVAJJxwWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706009; c=relaxed/simple;
	bh=4zPSwPeTAWXtW4M117o6fCrOQvH8wWLubrBigGejR6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GABDAzjwbS/IscK3/xZYh2jTwA97MUipOpw5ggL66QV2E4cd4UMOfxqrccBNbpZbdTmk4aBc1t4cxT6M7z9H4LE6LUy9u6rsVNVJ8FqpX/wMXRpH0TnSletWr6oQ+HA1mkvjLph7hsdWepNoA3MCwUfvWN3X3KLj71OZjwQB6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd3Jt86V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd3Jt86V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E341F00A3A;
	Wed, 22 Jul 2026 07:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784706007;
	bh=EOWpF0SWGu5KolaqJIGzoxc0o70j8bo0gsvJlnQPkgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Wd3Jt86Vu53iEttc61YcYnQiAaDSf7xapZZfaILjhiLL6m2B8pGv8pSJC2Uf5svkx
	 CLdz0CIPv6sjynwuf65K4CdVjvdaSzz2AgR6BflE1W4zU8NYmNJR99efOHc06MKsNR
	 F8MgQtsjqVxajUqNz5iilfuisAnH3fjz5j2Ou60sWxVE7Iyq/xgJREpm6Zn/djRrjB
	 r2rFXj+5zWPw59AnDsOknXqCO312vjHc+FkL+hTnPjMD4jzXyP0zH9J9bXL95n6g72
	 WwRj2+3JORAcdQFrN1VtGeKwvBQQnafW4qhinXdDpxURaz5ELpy0FbAk0lAUbpGhZ1
	 LJ+Yr/49wz6cA==
Message-ID: <8d971637-0ba7-41f1-a3c3-13e9e0bf7184@kernel.org>
Date: Wed, 22 Jul 2026 16:39:54 +0900
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
 <0ce88f37-f231-4a00-b06b-95b0910c2db0@kernel.org>
 <c66cf308-943d-4fc3-ae84-e81bdbb384ec@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <c66cf308-943d-4fc3-ae84-e81bdbb384ec@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zKUBDNrRhwRulzNhyQZFGYIc"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zKUBDNrRhwRulzNhyQZFGYIc
Content-Type: multipart/mixed; boundary="------------d5K15x0Qu9OuIwg0efEzg03i";
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
Message-ID: <8d971637-0ba7-41f1-a3c3-13e9e0bf7184@kernel.org>
Subject: Re: [PATCH slab/for-next v4 2/8] mm/slab: handle the !allow_spin case
 in kfree_rcu_sheaf()
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-2-964e03c41a4e@kernel.org>
 <1d0d8021-62d2-4c42-a2a6-a7e8ce2f5d37@kernel.org>
 <0ce88f37-f231-4a00-b06b-95b0910c2db0@kernel.org>
 <c66cf308-943d-4fc3-ae84-e81bdbb384ec@kernel.org>
In-Reply-To: <c66cf308-943d-4fc3-ae84-e81bdbb384ec@kernel.org>

--------------d5K15x0Qu9OuIwg0efEzg03i
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/22/26 4:37 PM, Vlastimil Babka (SUSE) wrote:
> On 7/22/26 09:28, Harry Yoo wrote:
>>> Nits below:
>>>
>>>> ---
>>>>  mm/slab.h        | 18 +++++++++++++++++-
>>>>  mm/slab_common.c |  2 +-
>>>>  mm/slub.c        | 36 ++++++++++++++++++++++++++++--------
>>>>  3 files changed, 46 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/mm/slab.h b/mm/slab.h
>>>> index 281a65233795..85ef2ebc9812 100644
>>>> --- a/mm/slab.h
>>>> +++ b/mm/slab.h
>>>> @@ -429,7 +445,7 @@ static inline bool is_kmalloc_normal(struct kmem=
_cache *s)
>>>>  	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCO=
UNT));
>>>>  }
>>>> =20
>>>> -bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
>>>> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned in=
t free_flags);
>>>>  void flush_all_rcu_sheaves(void);
>>>>  void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
>>>> =20
>>>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>>>> index b6426d7ceec9..e07b4e6d6679 100644
>>>> --- a/mm/slab_common.c
>>>> +++ b/mm/slab_common.c
>>>> @@ -1605,7 +1605,7 @@ static bool kfree_rcu_sheaf(void *obj)
>>>> =20
>>>>  	s =3D slab->slab_cache;
>>>>  	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) =3D=3D numa_=
mem_id()))
>>>> -		return __kfree_rcu_sheaf(s, obj);
>>>> +		return __kfree_rcu_sheaf(s, obj, SLAB_FREE_DEFAULT);
>>>> =20
>>>>  	return false;
>>>>  }
>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>> index e32a68677537..0c350274fbff 100644
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>>> @@ -2814,10 +2814,14 @@ static inline struct slab_sheaf *alloc_empty=
_sheaf(struct kmem_cache *s,
>>>> =20
>>>>  	gfp &=3D ~OBJCGS_CLEAR_MASK;
>>>> =20
>>>> +	if (alloc_flags & SLAB_ALLOC_NOLOCK)
>>>> +		gfp &=3D ~__GFP_RECLAIM;
>>>
>>> So in general we expect gfp and alloc flags to be compatible and warn=
 if
>>> they are not. This now performs an auto-adjustment, which makes it un=
usual.
>>
>> That's fair.
>>
>>> But AFAICS only one caller relies on it - __kfree_rcu_sheaf(). So may=
be we
>>> could just do it there?
>>
>> Will do. I don't have strong preference on this.
>=20
> Thanks!
>=20
>>>>  	return __alloc_empty_sheaf(s, gfp, alloc_flags, s->sheaf_capacity)=
;
>>>>  }
>>>> =20
>>>> -static void free_empty_sheaf(struct kmem_cache *s, struct slab_shea=
f *sheaf)
>>>> +static void __free_empty_sheaf(struct kmem_cache *s, struct slab_sh=
eaf *sheaf,
>>>> +			       bool allow_spin)
>>>
>>> Why not free_flags instead of allow_spin? Since you already introduce=
d them.
>>
>> Indeed I tried that but gave up on doing that as part of series
>> after realizing free_empty_sheaf() alone has 12 callers :)
>=20
> Yeah but I meant __free_empty_sheaf() only. It's fine to leave the wrap=
per
> without the new parameter for the most common case, like you did.

Ah, I see!
Right, that's reasonable and will do.

>> But I think it's worth teaching those functions (including
>> free_empty_sheaf()) to handle SLAB_ALLOC_* and SLAB_FREE_* flags
>> rather than propagating allow_spin.
>=20
> It doesn't have to be now :)

Yeah :)

Thanks!

--=20
Cheers,
Harry / Hyeonggon

--------------d5K15x0Qu9OuIwg0efEzg03i--

--------------zKUBDNrRhwRulzNhyQZFGYIc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCamBzygAKCRCGXBN6rc5S
1mj6AQCEDuXSXD84vwoWMnvh3SAH6pQ7Ngs8xt8xR+bK8mwudgEAue6ODAgbBFy7
JAlMoRPioGz3QAzAlg9IcFHlo0egHwM=
=MCiF
-----END PGP SIGNATURE-----

--------------zKUBDNrRhwRulzNhyQZFGYIc--

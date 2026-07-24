Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C03093D8;
	Fri, 24 Jul 2026 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893410; cv=none; b=FhF/tQA+TeGSYcIPgLAXAvBdo+Zo45ilEvjDqXxfNRdY3a1G+C2fRuhJgFiAXAgqSAZdp3UliL3OJCUDDKKDWfuW1nOisDPPUad8/4+j/4son4gfz37pe61yMW8Wmq4LErly3sx1Ks36w/P9Gb6nf5qMu6a6IjhU1LVZLwHnvjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893410; c=relaxed/simple;
	bh=Bgkc/Fzprh2UqUl5OYsU+uLe0fUU3Nj97awtpzxzIyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roIv0pClASb1nriOiSOJLm6Sk5yVaf1vE0fFTMcioM/iNhZrwZTd6ZnCb5Ds+rTLBbMFhmsIq7ohr4OGWUC0EwPlQ6yZpu9UBfeb0iQoLhwaBOPqCFGH/gEEIZIOxHtoOzaXaN9jv1UfwtyN3PU9yEXM2XTlH3u+FCYJqntiZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAmVci8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAmVci8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502641F000E9;
	Fri, 24 Jul 2026 11:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784893397;
	bh=ZK9f+lQKq3T7Qui1zvAcmW2bLdT9jRcsFf+gQYXibzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KAmVci8prSKWVWJDnnMjbYXecaey/m2kdgGlten0/MtSDBWAlDx8QxRDeBkvN21bU
	 45Dte5iInWRKBTstP++cGXcQNrRvBS5+5pFA8rdY/80T1Wo/lwhVk6IKJ91I/G/PmI
	 vnX16dokZr9anglrKFOakFh6Uv2BfmfYE9NDELvBOGm/W1wrAyq2y+YdryL+mCTAU5
	 A7cQeUv80a1u4/TR8ixPULvU6UFLlT1rsV1s0u8GnFPEft6rYwHZiivLCJeayyktUf
	 B8DUmSJcSqr4XH8tsArVvYzCbNBgSqd/UpxitfmykLMDSyG7/UM6tHePNDjf7ROgK/
	 EHim5TRRJEilA==
Message-ID: <07adab0f-12cc-4f48-bf23-4aaef67ab405@kernel.org>
Date: Fri, 24 Jul 2026 20:42:52 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab/for-next v4 4/8] mm/slab: extend deferred free
 mechanism to handle rcu sheaves
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
References: <20260723182727858gUQJ4TgRU2b6v1kdgpkfV@zte.com.cn>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260723182727858gUQJ4TgRU2b6v1kdgpkfV@zte.com.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tmAUU7aaQUfp05UMAY0PS3Nq"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------tmAUU7aaQUfp05UMAY0PS3Nq
Content-Type: multipart/mixed; boundary="------------l88ZLZ879gKaeoF6sUZa3ymK";
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
Message-ID: <07adab0f-12cc-4f48-bf23-4aaef67ab405@kernel.org>
Subject: Re: [PATCH slab/for-next v4 4/8] mm/slab: extend deferred free
 mechanism to handle rcu sheaves
References: <20260723182727858gUQJ4TgRU2b6v1kdgpkfV@zte.com.cn>
In-Reply-To: <20260723182727858gUQJ4TgRU2b6v1kdgpkfV@zte.com.cn>

--------------l88ZLZ879gKaeoF6sUZa3ymK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/23/26 7:27 PM, hu.shengming@zte.com.cn wrote:
> Harry wrote:
>> __kfree_rcu_sheaf() cannot invoke call_rcu() when spinning is not
>> allowed and IRQs are disabled. To relax the limitation, extend the
>> deferred free fallback so that a full rcu sheaf can be submitted to
>> call_rcu() via the existing IRQ work.
>>
>> Since the deferred mechanism does more than deferred freeing of object=
s,
>> rename the struct to deferred_percpu_work and adjust names accordingly=
=2E
>>
>> When a sheaf is queued on an IRQ work, it is detached from
>> pcs->rcu_free but call_rcu() is not invoked until the irq_work runs.
>> To keep the kvfree_rcu barrier's promise, call irq_work_sync() on each=

>> CPU before calling rcu_barrier().
>>
>> In the meantime, remove the TODO item as apparently there is no simple=

>> and effective way to achieve that. This is because, unlike sheaves,
>> kfree_rcu() batches objects from different caches together.
>>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>> ---
>>  mm/slab.h        |  2 +-
>>  mm/slab_common.c |  7 ++---
>>  mm/slub.c        | 85 +++++++++++++++++++++++++++++++++--------------=
---------
>>  3 files changed, 53 insertions(+), 41 deletions(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index e07b4e6d6679..9c9ae1384f47 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -551,7 +551,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
>>      }
>> =20
>>      /* Wait for deferred work from kmalloc/kfree_nolock() */
>> -    defer_free_barrier();
>> +    deferred_work_barrier();
>> =20
>>      cpus_read_lock();
>>      mutex_lock(&slab_mutex);
>=20
> Hi Harry,

Hi Shengming,

> I noticed that your fix in [1] serializes defer_free_barrier() to
> avoid concurrent irq_work_sync() waiters.

Right.

> However, this patch still calls the renamed deferred_work_barrier()
> outside that serialization scope, including the new call sites in
> kvfree_rcu_barrier_on_cache() and flush_all_rcu_sheaves().

Good point!

I didn't _fix_ that as part of this patch since that would be confusing
and the fix didn't land the mainline or slab yet.

> Is this series expected to depend on [1], with these call sites
> moved under the same serialization? Or am I missing something?

I was thinking of rebasing the fixes as there won't be much conflicts,
nobody except for sashiko complained about this, and we're not going to
backport them anyway.

> [1]
> https://lore.kernel.org/all/20260624-kmalloc-nolock-fixes-v1-4-fdf4d173=
51dd@kernel.org/
>=20
> thanks,
>=20
> --
> With Best Regards,
> Shengming

--=20
Cheers,
Harry / Hyeonggon

--------------l88ZLZ879gKaeoF6sUZa3ymK--

--------------tmAUU7aaQUfp05UMAY0PS3Nq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCamNPvAAKCRCGXBN6rc5S
1jS3AP96xAV6tdo5fPUAIVGuhE+lXKoppDkmuQX1EC4XtI9KRgD/XzVEu0/IvVjA
KfYQg+G7K9N5IJAuVGvicUoHa7EZrw4=
=NZpC
-----END PGP SIGNATURE-----

--------------tmAUU7aaQUfp05UMAY0PS3Nq--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06BC473C6A;
	Wed, 22 Jul 2026 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706184; cv=none; b=L40gWYfMpDyOS/9vt+5hFKTunZVaQ17ZNtQOHrfBxlMe9Aqkbc8tW5a3G17jhBUFJ9Jr8igLFVoDOcZZd6QItou0rJWM8kmKo+ddh1P5hwJNrKw4jTOq55LokXAhx5V2RxRC1zKcbuAAAdd56JnDMnAce/vvDOsvaRtNQLHJ2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706184; c=relaxed/simple;
	bh=vw6aECGNcSucd+DP8F++GffzANZ94TJ6H+0NGWn+Cwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6e6WNXZuhsZrYN6U+5HcRBIpjaJkeMWhyzbLMdE4zqNoqEv0aFMQWWJDGq1x4Vd4c6MFI+PKTp3N2MmEx5YKsySte4W3bAPKefraTjX58mXUCdTIJa/7UmZv7bYmbfDLPBJ+oWWE9EFwcF8vtUb511AOsZtr1LELgivfXLufjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebWyYhT/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebWyYhT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA451F00A3A;
	Wed, 22 Jul 2026 07:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784706179;
	bh=8U9RMhwokOKMZq1o2LzyxZKmoBd6qWII0YPk4ynCuMU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ebWyYhT/wa2nWhacIPmvVJQzvzTXDlVJ96VITfDN5Jjar/Caw0wg39bD1SP1dKETX
	 gGcHws7ZzFTjOFv+WW1+UFwXcy/bKZuB6kT8vrqVnB1/hYEvv+DhfxQgk/SP1G2wDH
	 wPuaQcAKsmxLYHm10IedGfP258I1sqRRe9Lj2ruUgnqQfxJzubsXEKIixVMVA6myJU
	 5+EJyrg4BqYBwBtkMyoW/nP05SP/0jNrbNhAcNyCBfScuAxAHdBq++BKNbolsm52J8
	 vmmE+RXFBXJ3DLnflfRNGs4en5imzeBWwGyJG+GSj+lizYX7FOQBI6pM/9dkHJ3S6v
	 ICu/hNLhR+81Q==
Message-ID: <29fb9c96-5685-4974-afe5-c76f48eeba45@kernel.org>
Date: Wed, 22 Jul 2026 16:42:46 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab/for-next v4 6/8] mm/slab: introduce struct
 kvfree_rcu_head for kvfree_rcu batching
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
 <20260720-kfree_rcu_nolock-v4-6-964e03c41a4e@kernel.org>
 <cd11b015-7c59-4ce4-8eb0-8040fbb2cdfc@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <cd11b015-7c59-4ce4-8eb0-8040fbb2cdfc@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rHmQ19i50j0kL2o2vIw30Byv"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rHmQ19i50j0kL2o2vIw30Byv
Content-Type: multipart/mixed; boundary="------------77Phiovz4D8FAfavJFkTxfks";
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
Message-ID: <29fb9c96-5685-4974-afe5-c76f48eeba45@kernel.org>
Subject: Re: [PATCH slab/for-next v4 6/8] mm/slab: introduce struct
 kvfree_rcu_head for kvfree_rcu batching
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-6-964e03c41a4e@kernel.org>
 <cd11b015-7c59-4ce4-8eb0-8040fbb2cdfc@kernel.org>
In-Reply-To: <cd11b015-7c59-4ce4-8eb0-8040fbb2cdfc@kernel.org>

--------------77Phiovz4D8FAfavJFkTxfks
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/21/26 8:06 PM, Vlastimil Babka (SUSE) wrote:
> On 7/20/26 14:44, Harry Yoo (Oracle) wrote:
>> rcu_head is overkill for kvfree_rcu() because the callback
>> function is always either kfree(), vfree(), or free_large_kmalloc(),
>> and thus there is no need for a function pointer.
>>
>> kvfree_rcu batching reuses the field to store the start address
>> of an object, however, this is not strictly needed because we can
>> calculate the start address in the slowpath. For the purpose of
>> kvfree_rcu batching, it is sufficient to implement a linked list using=

>> a single pointer.
>>
>> Introduce a new struct called kvfree_rcu_head (the name was suggested
>> by Vlastimil Babka), which is similar to rcu_head but is only a single=

>> pointer to build a linked list, without a function pointer, when
>> CONFIG_KVFREE_RCU_BATCHED=3Dy.
>>
>> When kvfree_rcu is not batched, kvfree_rcu_head is the same size
>> as rcu_head. Note that shrinking struct kvfree_rcu_head on
>> CONFIG_KVFREE_RCU_BATCHED=3Dn kernels would inevitably require additio=
nal
>> complexity and also some sort of batching (which defeats the purpose o=
f
>> the config option) because it cannot fall back to call_rcu().
>>
>> For now there are no user-visible changes to the API. k[v]free_rcu()
>> simply casts rcu_head to kvfree_rcu_head. While this does not affect
>> the API, it allows kfree_rcu_nolock() to reuse kvfree_rcu batching
>> as a fallback when trylock or sheaf allocation fails.
>>
>> Stop storing the object pointer in rcu_head.func and instead calculate=

>> the object's start address in kvfree_rcu_list(). Factor out the existi=
ng
>> logic to calculate the start address from kvfree_rcu_cb() to
>> kvmalloc_obj_start_addr().
>>
>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>=20
> Nice.
>=20
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks!

> Nit:
>=20
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -351,6 +351,33 @@ static inline int objs_per_slab(const struct kmem=
_cache *cache,
>>  	return slab->objects;
>>  }
>> =20
>> +/* kvfree_rcu_head offset can be only less than page size */
>> +static inline void *kvmalloc_obj_start_addr(void *head)
>> +{
>> +	void *obj =3D head;
>> +
>> +	if (unlikely(is_vmalloc_addr(obj))) {
>> +		obj =3D (void *) PAGE_ALIGN_DOWN((unsigned long)obj);
>> +	} else {
>> +		struct page *page =3D virt_to_page(obj);
>> +		struct slab *slab =3D page_slab(page);
>=20
> Can use virt_to_slab().

Ah, right. We don't call free_large_kmalloc() here.

>> +
>> +		if (!slab) {
>> +			obj =3D (void *) PAGE_ALIGN_DOWN((unsigned long)obj);
>> +		} else if (is_kfence_address(obj)) {
>> +			obj =3D kfence_object_start(obj);
>> +		} else {
>> +			struct kmem_cache *s =3D slab->slab_cache;
>> +			unsigned int idx =3D __obj_to_index(s, slab_address(slab), obj);
>> +
>> +			obj =3D slab_address(slab) + s->size * idx;
>> +			obj =3D fixup_red_left(s, obj);
>> +		}
>> +	}
>> +
>> +	return obj;
>> +}
>> +
>>  /*
>>   * State of the slab allocator.
>>   *

--=20
Cheers,
Harry / Hyeonggon


--------------77Phiovz4D8FAfavJFkTxfks--

--------------rHmQ19i50j0kL2o2vIw30Byv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCamB0dwAKCRCGXBN6rc5S
1obAAQCqHfelJX+qi5duTvHrT8jGkOgRfpF+LiWvdac7y5+2pAEAryoulTJ2FIDf
tKqBX1pWil296y3KUUzK/9SUjWszIAk=
=N3ce
-----END PGP SIGNATURE-----

--------------rHmQ19i50j0kL2o2vIw30Byv--

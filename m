Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A25379960;
	Wed, 22 Jul 2026 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708139; cv=none; b=lqyzyZjPhCuqLiTUiGEGXiTuifR5h13u7C3+BzDqDNQ6srDWLYtcJSsbys0BXS+66cUb9iLG8cT7lciEnjaZXh+hYOEDcx5mJGi4qj63Qx9s29W8ZR63JuCu0PEpnOlufYx7ztDs6EzHFIkbvLsuRxLWUM+ywE8ApuWW2diRZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708139; c=relaxed/simple;
	bh=YYl4RhMGqKxFsF3on5o1+fIP9ZLXeMSq+QLh1+8PG0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thMY/eOcHMzqi7T0ZWQ74YANpXw0xnECkJi06607mDNNPvkQk0gehMPn7HOBlfmevNYPAysNr1lgjxXqKgyRLowaj1CBjH0BpfitS/nkcZq1RKChpCfD5sEAGC4XCAj1UGvazN7VOV4y1iRDdiLlOEWxg0kQmHAdllWFnUsX/vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRKjrsWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRKjrsWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD2F1F000E9;
	Wed, 22 Jul 2026 08:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784708138;
	bh=oiQsEs9po9PWz4IpdUW1ReK/rKr+M/MEauJC/KMRWQ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LRKjrsWezbJfn+IiAK9NpF7++JQjNh8wH8+WWFa26zO4Im3nk1jIku2/eOsPNn6u4
	 bseMnOB1axaX13tscsBS3wqQiVVKhRSLd7H29STW3ObSeZyCX6Y1T7xh0eohCLjX5O
	 pcaxFYROIzSUOtNlVMH46jSDu5RhsnrNebSAwwGMftuLirx+JwzkcCBla93KXhonIk
	 kNzrSMcqRcIMdVkg75wcu7NKIxM86LMjKImaWlyTPVjP0aFMPWmFHxerQnJTEHjLSF
	 FL3+oBndNl1AzCBU4lrP8hmUQYLIWZFSqH2Mz0zIrrZrW4gPQ2wRbQj6UW+eKyVP8x
	 IDByCUs18fM5Q==
Message-ID: <734ecdc6-f415-41d8-9357-7fc11379e4da@kernel.org>
Date: Wed, 22 Jul 2026 17:15:24 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab/for-next v4 7/8] mm/slab: introduce
 kfree_rcu_nolock()
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
 <20260720-kfree_rcu_nolock-v4-7-964e03c41a4e@kernel.org>
 <c7607f25-5336-4f64-9244-9476dcc8ff3d@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <c7607f25-5336-4f64-9244-9476dcc8ff3d@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------J0AkE62Qm6KEox29YcLjb809"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------J0AkE62Qm6KEox29YcLjb809
Content-Type: multipart/mixed; boundary="------------Zum3HQTusEj7uNFO4KwvsLy9";
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
Message-ID: <734ecdc6-f415-41d8-9357-7fc11379e4da@kernel.org>
Subject: Re: [PATCH slab/for-next v4 7/8] mm/slab: introduce
 kfree_rcu_nolock()
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-7-964e03c41a4e@kernel.org>
 <c7607f25-5336-4f64-9244-9476dcc8ff3d@kernel.org>
In-Reply-To: <c7607f25-5336-4f64-9244-9476dcc8ff3d@kernel.org>

--------------Zum3HQTusEj7uNFO4KwvsLy9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/21/26 10:09 PM, Vlastimil Babka (SUSE) wrote:
> On 7/20/26 14:44, Harry Yoo (Oracle) wrote:
>> Currently, k[v]free_rcu() cannot be called in unknown context since
>> it could lead to a deadlock when called in the middle of k[v]free_rcu(=
).
>>
>> Make users' lives easier by introducing kfree_rcu_nolock() variant,
>> now that kfree_rcu_sheaf() is available on PREEMPT_RT and
>> __kfree_rcu_sheaf() handles unknown context.
>>
>> kfree_rcu_nolock() falls back to the kvfree_rcu batching when sheaves
>> path fails.
>=20
> From the code I would say it falls back to defer_kfree_rcu(), which is =
an
> irq_work that does kvfree_rcu batching?

Indeed that was what I intended to say, but I messed up while
writing it :-) Will fix that.

> Otherwise the sentence would contradict the following:
>
>> In most cases, the sheaves path is expected to succeed
>> and it's unnecessary to add complexity to the existing kvfree_rcu
>> batching by teaching it how to handle unknown context.
>=20
> This talks about trying to perform the batching immediately without def=
ering.

You mean the earlier sentence "kfree_rcu_nolock() falls back to the
kvfree_rcu batching when sheaves path fails", right?

>> Since defer_kfree_rcu() can be called on caches without sheaves, move
>> deferred_work_barrier() and rcu_barrier() outside the branch in
>> kvfree_rcu_barrier_on_cache().
>>
>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>=20
> Other than that and a comment correction below, LGTM.
>=20
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks!

>> ---
>>  include/linux/rcupdate.h | 19 +++++++++++++++++++
>>  mm/slab_common.c         | 28 ++++++++++++++++++++++++++--
>>  mm/slub.c                | 24 +++++++++++++++++++++++-
>>  3 files changed, 68 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>> index ef5bb6981133..ce0fd401352e 100644
>> --- a/include/linux/rcupdate.h
>> +++ b/include/linux/rcupdate.h
>> @@ -1099,6 +1099,7 @@ static inline void rcu_read_unlock_migrate(void)=

>>   * In mm/slab_common.c, no suitable header to include here.
>>   */
>>  void kvfree_call_rcu(struct kvfree_rcu_head *head, void *ptr);
>> +void kfree_call_rcu_nolock(struct kvfree_rcu_head *head, void *ptr);
>> =20
>>  /*
>>   * The BUILD_BUG_ON() makes sure the rcu_head offset can be handled. =
See the
>> @@ -1124,6 +1125,24 @@ do {								\
>>  		kvfree_call_rcu(NULL, (void *) (___p));		\
>>  } while (0)
>> =20
>> +/**
>> + * kfree_rcu_nolock() - a version of kfree_rcu() that can be called i=
n any context.
>> + * @ptr: pointer to kfree for double-argument invocations.
>> + * @kvrhf: the name of the struct kvfree_rcu_head within the type of =
@ptr.
>> + *
>> + * Objects that are not allocated via kmalloc_nolock() are not suppor=
ted.
>=20
> Is this true? If __kfree_rcu_sheaf() succeeds, rcu_sheaf is either flus=
hed
> normally (call_rcu with rcu_free_sheaf()) or via the irq_work doing the=

> same. The defer_kfree_rcu() fallback ends up doing a normal
> kvfree_call_rcu(). I don't see any path that ends up doing kfree_nolock=
().
> Am I missing something?

I added this limitation because I thought it doesn't make sense
to support this when we don't support large kmalloc and vmalloc in
unknown context.

Perhaps too limiting than it should be though.

>> + * kfree_rcu_nolock() supports 2-arg variant only.
>> + */
>> +#define kfree_rcu_nolock(ptr, kvrhf)						\
>> +do {										\
>> +	typeof (ptr) ___p =3D (ptr);						\
>> +										\
>> +	if (___p) {								\
>> +		BUILD_BUG_ON(offsetof(typeof(*(ptr)), kvrhf) >=3D 4096);		\
>> +		kfree_call_rcu_nolock(&((___p)->kvrhf), (void *) (___p));	\
>> +	}									\
>> +} while (0)
>> +
>>  /*
>>   * Place this after a lock-acquisition primitive to guarantee that
>>   * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applie=
s

--=20
Cheers,
Harry / Hyeonggon

--------------Zum3HQTusEj7uNFO4KwvsLy9--

--------------J0AkE62Qm6KEox29YcLjb809
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCamB8HQAKCRCGXBN6rc5S
1hFYAPwLQ01L3lAeQg0ZDcFbF72rH/98pNkQxh5OCV8Mp/HczwD9EC+wNsSqKXwf
So24hkqJiRfI/5vgRW5WwTakc0peTQo=
=WsKZ
-----END PGP SIGNATURE-----

--------------J0AkE62Qm6KEox29YcLjb809--

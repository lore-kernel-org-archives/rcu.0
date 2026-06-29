Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326743EEAF2;
	Mon, 29 Jun 2026 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782721154; cv=none; b=mtdUUu5ahcR2fDP5bn/BBktYI/6MaSmScTDNvdweI3uSQydmYPdWWtJFfdwc4e9Ungq2Uyl6uQGt17LnSqYp1TEjiK9a0/FMcRTVUG0WlRNMN+AovQ01IdWhjphYI8FAZFWqNqyi5d1gpf9Sf6tKVAmCsMBFRTsm/+6xHFBEkb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782721154; c=relaxed/simple;
	bh=7opxL7Vly13tH3l4OihyiiK0l+G5qmr999lpyb4Oq1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFesI6usiLegmx4VpQT7SD0zeGuGZz/gjR0Kvco1Z14yWjYl9NljC2UwxV/EEDcfjEBIuJpvD9bUSHj5gIlvqtI7Neq2vpJXNmuFU9xR6W+Yf61Y39i24G4yr4aYiNLVV3j5U0Y6gqepHr7SCGjZAb7sxCZlQAcsbToTRmql0CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0POJnWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0POJnWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3345A1F000E9;
	Mon, 29 Jun 2026 08:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782721151;
	bh=MZGohl8o0Xi4Sw0uZbCmVZVFuovj8uht9Jky77XzxYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a0POJnWWk9ffjgZuRxp3Xl1Ko7Fd1mFeGrnnmbmrrMA3HWIC+dBIu/1pEDHFjovB1
	 gIrp7QtAeYN74W3QDb4cqypY1atSqrRrj4lAruTKrkF50SudutWlUbr0ckVRNNNHaU
	 rcKajXP8DvD4Zz4aDxRkBfmugpUGtkrNtcgHCEcIUtq4eSlyH3fHEYmyhTv0bcNcaR
	 OTr77NDEnDum2neyY387k7QBXDtQ3l02OdsTD4Qf4AvMXTkFuxv8eDU5wc5SgR2Ea3
	 HFaHZjr9rYx3l0y8tEwRXvFDfUWVcEgjcjMxyLlLeQGpU0PtblG7gAae/KbDugIZ84
	 ukSShW0IL4tHQ==
Message-ID: <1f4d68e5-7ea7-45f8-8286-fc276178c7ed@kernel.org>
Date: Mon, 29 Jun 2026 17:19:03 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 4/9] mm/slab: use call_rcu() in unknown
 context if irqs are enabled
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
 <20260615-kfree_rcu_nolock-v3-4-70a54f3775bb@kernel.org>
 <ajvpq2Ay-nRH7s-X@pedro-suse>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <ajvpq2Ay-nRH7s-X@pedro-suse>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GaUI6z90zVa0zdq40fRpqq00"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------GaUI6z90zVa0zdq40fRpqq00
Content-Type: multipart/mixed; boundary="------------0gIw2wbsDQjCNZaQoAyGLTmg";
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
Message-ID: <1f4d68e5-7ea7-45f8-8286-fc276178c7ed@kernel.org>
Subject: Re: [PATCH for-next v3 4/9] mm/slab: use call_rcu() in unknown
 context if irqs are enabled
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-4-70a54f3775bb@kernel.org>
 <ajvpq2Ay-nRH7s-X@pedro-suse>
In-Reply-To: <ajvpq2Ay-nRH7s-X@pedro-suse>

--------------0gIw2wbsDQjCNZaQoAyGLTmg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/24/26 11:30 PM, Pedro Falcato wrote:
> On Mon, Jun 15, 2026 at 08:05:58PM +0900, Harry Yoo (Oracle) wrote:
>> call_rcu() disables IRQs with local_irq_save() to protect its per-cpu
>> data structures. Therefore, if IRQs are not disabled, they cannot be
>> corrupted by reentrance into call_rcu(). So fall back to the deferred
>> path only when !allow_spin && irqs_disabled().
>>
>> The RCU subsystem does not guarantee this contractually, and this
>> optimization relies on RCU's implementation details. Ideally, it shoul=
d
>> be removed once call_rcu_nolock() is supported by the RCU subsystem.
>>
>> Link: https://lore.kernel.org/linux-mm/CAADnVQKRVD5ZSnEKbZZU7w86gHbGHU=
ug2pvzpgZTngNS+fg4rw@mail.gmail.com
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>> ---
>>  mm/slub.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index b0d38d515386..6a3552b70683 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -6158,8 +6158,8 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, voi=
d *obj, bool allow_spin)
>>  	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
>>  		rcu_sheaf =3D NULL;
>>  	} else {
>> -		if (unlikely(!allow_spin)) {
>> -			/* call_rcu() cannot be called in an unknown context */
>> +		/* call_rcu() disables IRQs to protect percpu data structures */
>> +		if (unlikely(!allow_spin && irqs_disabled())) {
>=20
> Perhaps this could be more neatly exposed by RCU? something like
> maybe_in_call_rcu().

Make sense if we need to keep this optimization for a long time, but
hopefully RCU would support call_rcu_nolock() soon (apparently Paul has
a plan [1]), rather than introducing maybe_in_call_rcu() just to drop
it soon.

But I don't have a strong opinion on this and
I'd leave that to RCU folks.

> Also, it's a bit odd that you're introducing code and
> then subsequently patching over it with an improvement. Maybe this coul=
d be
> squashed into patch 3?

I was hoping having it as a separate patch to make it easier for RCU
folks to take a look and provide ack or nack :)

[1]
https://lore.kernel.org/linux-mm/03da8742-3790-4428-84b8-11911bf44c9e@pau=
lmck-laptop/

--=20
Cheers,
Harry / Hyeonggon

--------------0gIw2wbsDQjCNZaQoAyGLTmg--

--------------GaUI6z90zVa0zdq40fRpqq00
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCakIqdwAKCRCGXBN6rc5S
1hymAQDnrjBNhyfghMOQ1Y5XsS5xCPbM5nzOMMvxwieKQiGerQD/TIjtJEpF5Zy6
02PvBcB4Ksu+B1/s6N8O0omOEQOq6Q0=
=1j6o
-----END PGP SIGNATURE-----

--------------GaUI6z90zVa0zdq40fRpqq00--

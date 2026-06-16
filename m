Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E963C3542E5;
	Tue, 16 Jun 2026 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585859; cv=none; b=OZ/74SxJc7acWjYsjybr7JI58Xkoaa4wNdz5tGE9UjpF2U1Kso96Epw8OhfOm1vpHopcf8Ijvm4AgtKCaVdIpEoqflACmjLo7SKhwrhvDWV7UFytrngaZ3zvmQzgDG+YFMO+h5Cnvi/Gsol7R5TVtt+UTf544Tb/vImOpDZvzzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585859; c=relaxed/simple;
	bh=Bp/aybc+Fw0mk1v4eOxPCUpmO4mwvF90GnzTNmTxuc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZAZ+OUgAkCVqjBJbJfZdOyIkMLc0nVaXtRBFggixFpIJtKJPfYujmzGkJCvyoEqfsrwIagfcRCMI76bY7sCiWBWN7AzY6qEcF5YIvT2PhCNpK0H/f+NQnOmZOc+wGNMS03vkUpF8kRA3QLhB2xAoVIPgS+2KBUUotowQKyZHeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i981j6Qm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i981j6Qm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108641F000E9;
	Tue, 16 Jun 2026 04:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781585857;
	bh=JuQtaqTB4nsvLfp0tjVnNx6v78IJDyXO+cU/C/K0qxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i981j6QmlqgwZM0yJoyYkQzMcjjnFHvu2sw3xxnDhjlfL6pX+C+62ccK5LsczeiYY
	 Lp+zeQN+s/SZrqON0LcvyqrwkL48kgp6xuY+3BI6mXMrTody+/05GOu4DMeakEcxTZ
	 JR0nsRNbrej3X2cSiRzVMpeC2jy2mr0UXNqSoG0xf8dULCHzQiEfi0KsIa1N28y2P/
	 des0h9UCgforAe1V/Z14ajWu/MeYBvo62RKxCIk1bed9eaxMppli1Zztot9RTvkY9h
	 xUll88R4cWh0Atg8eHAv61wHFC9AjNQja9krZ0j+C1OxQ7PqDpt1FEfQabMlgKJ4c1
	 VhXvIJYL7Hf0w==
Message-ID: <1f95030c-0671-40ce-88fd-69a1127237d0@kernel.org>
Date: Tue, 16 Jun 2026 13:57:30 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 0/9] mm/slab: introduce kfree_rcu_nolock() and
 improve slub_kunit coverage
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>,
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
 <DJ9WNQFQ2B2R.1JSNL1RNABV6Q@gmail.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <DJ9WNQFQ2B2R.1JSNL1RNABV6Q@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0aQfkGi0vp62EoirKhGNqyKE"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0aQfkGi0vp62EoirKhGNqyKE
Content-Type: multipart/mixed; boundary="------------kz1RVuIKqjrpvUfzfdOKNjp9";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>,
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
Message-ID: <1f95030c-0671-40ce-88fd-69a1127237d0@kernel.org>
Subject: Re: [PATCH for-next v3 0/9] mm/slab: introduce kfree_rcu_nolock() and
 improve slub_kunit coverage
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <DJ9WNQFQ2B2R.1JSNL1RNABV6Q@gmail.com>
In-Reply-To: <DJ9WNQFQ2B2R.1JSNL1RNABV6Q@gmail.com>

--------------kz1RVuIKqjrpvUfzfdOKNjp9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/16/26 5:28 AM, Alexei Starovoitov wrote:
> On Mon Jun 15, 2026 at 4:05 AM PDT, Harry Yoo (Oracle) wrote:
>> Not the best time to post a series, but didn't want to delay posting
>> the series for too long. no pressures ;)  This is aimed to be queued
>> for review and testing after the merge window closes.
>>
>> This series is based on next-20260612, and is also available on
>> git.kernel.org [3].
>>
>> To RCU folks: It would be great if you could kindly take a quick look =
at
>> patch 4 and either ack or nack the patch ;)
>>
>> To BPF folks: Ulad asked to share workloads to measure performance
>> of kfree_rcu_nolock(). Unfortunately, I focused more on correctness
>> and have not spent much effort on that. It would be nice if BPF folks
>> could help evaluate it on their relevant workloads.
>=20
> kfree_rcu_nolock() needs to replace bpf_mem_alloc which is backbone
> of bpf maps and bpf local storage.

> So all of the selftests/bpf/benchs/run_bench_*.sh

Didn't notice it was a thing, thanks!

> will exercise it one way or the other the replacement is complete.
> In other words performance is absolutely critical.
>
>> To PREEMPT_RT folks: The most relevant part is allowing
>> kfree_rcu_sheaf() on PREEMPT_RT (patch 6). It carefully avoids sleepin=
g
>> by acquiring the locks via local_trylock() or spin_trylock_irqsave()
>> to avoid sleeping within a raw spinlock. When trylock or unlock is
>> unsafe, kmalloc_nolock() always fails.
>>
>> Changes since RFC v2
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Reduced complexity and intrusiveness (Uladzislau Rezki)
>> -------------------------------------------------------
>>
>> While discussing concerns about the complexity of adding allow_spin
>> handling with Ulad (Thanks!), I realized that adding complexity to the=

>> kvfree_rcu batching is not strictly necessary: only slab objects need =
to
>> be batched, they are already batched by rcu sheaves, and slab already
>> supports unknown context. So it is enough to implement only a minimal
>> fallback for the sheaves path.
>>
>> I tried to avoid making intrusive changes to the existing kvfree_rcu
>> path as much as possible. struct rcu_ptr is renamed to kfree_rcu_head
>> following Vlastimil's suggestion, and it is used only in the
>> kfree_rcu_nolock() path for now.
>>
>> As a result, the complexity is significantly reduced and the series
>> became much less intrusive. This is also reflected well in the diffsta=
t
>> below.
>=20
> Overall looks good to me.

Thanks!

> btw sashiko was confused in few cases.
> Not everything that it flags needs a fix. Sometimes it's not an issue a=
t all.
> It only sounds like one.

Right, most of the comments are false positives.
But there is one comment that looks like a real bug...

Sashiko wrote:
> This is a pre-existing issue, but can concurrent lockless calls to
> deferred_work_barrier() cause an rcuwait race on PREEMPT_RT, leading to=

> permanent task hangs?
>
> The function iterates over all CPUs, invoking irq_work_sync() on each
> CPU's deferred work object. On PREEMPT_RT, irq_work_sync() relies on
> rcuwait_wait_event() to block until completion,

Yes. If CONFIG_PREEPMT_RT is enabled and irq_work doesn't have
IRQ_WORK_HARD_IRQ, irq_work_sync() calls rcuwait_wait_event().

> and the rcuwait
> synchronization primitive strictly allows only one waiter at a time.

Hmm yeah, include/linux/rcuwait.h says:
| The caller is responsible for locking around rcuwait_wait_event(),
| and [prepare_to/finish]_rcuwait() such that writes to @task are
| properly serialized.

> Because deferred_work_barrier() is called without any global
> serialization (for instance, in kmem_cache_destroy() and
> kvfree_rcu_barrier_on_cache(), and now in flush_all_rcu_sheaves()),

Yes, without slab_mutex held.

> multiple threads can enter irq_work_sync() for the same work object
> concurrently.
>=20
> This overwrites the waiter task pointer, meaning only one task will be
> woken up when the work completes, leaving the other tasks hanging
> permanently in an uninterruptible sleep.

I think this is indeed a pre-existing issue that needs to be resolved.
Looks like we now have one more bug to fix ;-)

--=20
Cheers,
Harry / Hyeonggon

--------------kz1RVuIKqjrpvUfzfdOKNjp9--

--------------0aQfkGi0vp62EoirKhGNqyKE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajDXugAKCRCGXBN6rc5S
1vZEAQDurL03QvXhFDoJpREYt4Pq3uvJV2fqE7TNTAFfOooefQEAp57qIxNBol8F
8WVsYmh64E0qC0iSp7wTPtY13dK3JA0=
=A+n3
-----END PGP SIGNATURE-----

--------------0aQfkGi0vp62EoirKhGNqyKE--

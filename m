Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2FE2F8EB0;
	Mon, 15 Jun 2026 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781523836; cv=none; b=PqLbG6q7bjg/dFgmrPbIccIIF+X9vG9H5/V6GQkFA3vJQH19nMvgycZRrqme5naPJGggYIuMtAGRxgO9O/pgZ2DlP1ho+7RsYlVhYSJK7uE+bRXeSafGekYkhtgiiygOynVsm20f9P/vY6a10kR4+XO/53PuHl37XDwDY44GcSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781523836; c=relaxed/simple;
	bh=RCiIXvizblKQpQa/TTrmhxPru5a0n9e1kAiCcPlZzWM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=np9vX1Kyzhr8d8CZvg43ixp2ZBJs/cq57coePzvYpX+ALuyl6XdiSlGHThnV0UkZWLWim6J/hAhHK0+ysd26Fodvd1ETLiax41cMLP7Mx808raN9MX2r0bDEOJFDJICAVvjvId51ttYMr2B1MzMEHx1dsf7OVRntfYH7Jl9uvnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuYLpI/W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuYLpI/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80E51F000E9;
	Mon, 15 Jun 2026 11:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781523835;
	bh=DyvOEHKVCEkg7/agKguOd/UADGZvo/0DOwYS+FJxvWA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=fuYLpI/WXj53VFQJ9EzBpY0RaK6so1ueSSvXPbByr1lDhJGL+yNCu22OC49iaWqGH
	 VDudECuLAi+mQoTMfzLDDxdYZdLH0RAUjnulVFr8Y2kHE/g5IVoApAMZdPqQHxXiSm
	 qdlTWdFtKGn+2FEFia/jh+N2Eo6i/vj+9I10WE/IFnJgk23vsmAVWWkIBH9Ah5TRoG
	 pKjxRsJD6jtPjVadSvwo3ZLUq9IkIRdICH1luUOHHUuQe76ks/XGNN5c/O8IY+V5xa
	 TURqXwiv/vq5VXXDaROxVG8GGjP+h+7rRuvVXCUsFuxrU2gic1QEcxmwAShjw3G7qY
	 squlwVnqH8qtQ==
Message-ID: <9c120401-0e1e-41d8-b662-10339e302c91@kernel.org>
Date: Mon, 15 Jun 2026 20:43:44 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 0/9] mm/slab: introduce kfree_rcu_nolock() and
 improve slub_kunit coverage
From: Harry Yoo <harry@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>,
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
Content-Language: en-US
In-Reply-To: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------10ViNcef5i8ibbRYt2VHD6RX"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------10ViNcef5i8ibbRYt2VHD6RX
Content-Type: multipart/mixed; boundary="------------J2SxSCJedZHomL0Ld69od8Yj";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>,
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
Message-ID: <9c120401-0e1e-41d8-b662-10339e302c91@kernel.org>
Subject: Re: [PATCH for-next v3 0/9] mm/slab: introduce kfree_rcu_nolock() and
 improve slub_kunit coverage
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
In-Reply-To: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>

--------------J2SxSCJedZHomL0Ld69od8Yj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Now I'm investigating and fixing pre-existing two kmalloc_nolock() bugs
and (hopefully) planning to post the fixes later this week.

I will later rebase the this series onto Vlastimil's slab_alloc_flags v3
and the kmalloc_nolock() fixes, and address human and sashiko's
comments.

But this should be enough for review.

Thanks!

On 6/15/26 8:05 PM, Harry Yoo (Oracle) wrote:
> Not the best time to post a series, but didn't want to delay posting
> the series for too long. no pressures ;)  This is aimed to be queued
> for review and testing after the merge window closes.
>=20
> This series is based on next-20260612, and is also available on
> git.kernel.org [3].
>=20
> To RCU folks: It would be great if you could kindly take a quick look a=
t
> patch 4 and either ack or nack the patch ;)
>=20
> To BPF folks: Ulad asked to share workloads to measure performance
> of kfree_rcu_nolock(). Unfortunately, I focused more on correctness
> and have not spent much effort on that. It would be nice if BPF folks
> could help evaluate it on their relevant workloads.
>=20
> To PREEMPT_RT folks: The most relevant part is allowing
> kfree_rcu_sheaf() on PREEMPT_RT (patch 6). It carefully avoids sleeping=

> by acquiring the locks via local_trylock() or spin_trylock_irqsave()
> to avoid sleeping within a raw spinlock. When trylock or unlock is
> unsafe, kmalloc_nolock() always fails.
>=20
> Changes since RFC v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Reduced complexity and intrusiveness (Uladzislau Rezki)
> -------------------------------------------------------
>=20
> While discussing concerns about the complexity of adding allow_spin
> handling with Ulad (Thanks!), I realized that adding complexity to the
> kvfree_rcu batching is not strictly necessary: only slab objects need t=
o
> be batched, they are already batched by rcu sheaves, and slab already
> supports unknown context. So it is enough to implement only a minimal
> fallback for the sheaves path.
>=20
> I tried to avoid making intrusive changes to the existing kvfree_rcu
> path as much as possible. struct rcu_ptr is renamed to kfree_rcu_head
> following Vlastimil's suggestion, and it is used only in the
> kfree_rcu_nolock() path for now.
>=20
> As a result, the complexity is significantly reduced and the series
> became much less intrusive. This is also reflected well in the diffstat=

> below.
>=20
> RFC v2 diffstat:
>   8 files changed, 514 insertions(+), 163 deletions(-)
>=20
> v3 diffstat:
>   6 files changed, 370 insertions(+), 105 deletions(-)
>=20
> v3 diffstat (slub_kunit improvements - patch 1, 2, 9 excluded):
>   5 files changed, 199 insertions(+), 66 deletions(-)
>=20
> kfree_rcu_sheaf() PREEMPT_RT support (Vlastimil Babka)
> ------------------------------------------------------
>=20
> As suggested by Vlastimil (Thanks!), kfree_rcu_sheaf() can now be used
> on PREEMPT_RT as well, by always assuming allow_spin is false on
> PREEMPT_RT.
>=20
> slub_kunit enhancements
> -----------------------
>=20
> - Currently the test is skipped when there is no hardware PMU. This can=

>   happen on machines without a PMU, or in virtualized environments
>   (e.g., automated testing or virtme). Implement a fallback based on SW=

>   perf events so that the test can still run in such environments, even=

>   though the coverage is slightly smaller.
>=20
> - While testing on PREEMPT_RT, I found that kmalloc_nolock() fails ever=
y
>   time, so the fallback path is not properly tested. This is a limitati=
on
>   of perf events: the handler is called in NMI (HW perf events) or
>   interrupt context (SW perf events), where kmalloc_nolock() cannot
>   succeed.
>=20
>   slub_kunit now registers a kprobe pre-handler at the points in the sl=
ab
>   allocator where lockdep_assert_held() is invoked. The pre-handler cal=
ls
>   kmalloc_nolock() and friends, to improve coverage on PREEMPT_RT inste=
ad
>   of relying on perf events.
>=20
> One thing that needs to be further explored
> -------------------------------------------
>=20
> The global deferred_free_by_rcu (introduced by patch 8) list for the
> fallback should probably be per-CPU [5].
>=20
> Actual Cover Letter
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This series improves kmalloc_nolock() and kfree_nolock() coverage
> in slub_kunit (patch 1 and 2) and introduces kfree_rcu_nolock() for
> an unknown context as suggested by Alexei Starovoitov.
>=20
> Unknown context means the caller does not know whether spinning on a lo=
ck
> is safe (e.g., a BPF program attached to an arbitrary kernel function o=
r
> in NMI context).
>=20
> The slab allocator already supports unknown context via kmalloc_nolock(=
)
> and kfree_nolock(), but te slab allocator does not support freeing
> objects by RCU in unknown context.
>=20
> It is not ideal to have completely separate batching for unknown contex=
t
> because the worst scenario where spinning on a lock would lead to
> deadlock is very rare, and in most cases, it is safe to use the
> existing mechanism (kfree_rcu_sheaf()).
>=20
> Since most part of the slab allocator already supports unknown context
> and sheaves support batching kvfree_rcu() calls for slab objects,
> implement kfree_rcu_nolock() with minimal changes by teaching
> kfree_rcu_sheaf() how to support unknown context and making
> it a little bit harder to allocate an empty sheaf, instead of making
> intrusive changes to the existing kvfree_rcu batching logic.
>=20
> kfree_rcu_nolock() tries to free the object to the rcu sheaf if
> trylock succeeds. Once the rcu sheaf becomes full, it is submitted to
> RCU via call_rcu() if spinning is allowed or IRQs are enabled (to avoid=

> calling call_rcu() in the middle of call_rcu()). Otherwise, call_rcu()
> is deferred via irq work.
>=20
> In unknown context, when there is no sheaf available, kfree_rcu_sheaf()=

> falls back to defer_kfree_rcu(), which inserts the object to a global
> lockless list [5] and those objects are freed after synchronize_rcu() i=
n
> a workqueue.
>=20
> Unlike kfree_rcu(), only the 2-argument variant is supported.
> This is because the last resort of the 1-arg variant is
> synchronize_rcu(), which cannot be used in an unknown context.
>=20
> As suggested by Alexei Starovoitov, kfree_rcu_nolock() can be used with=

> struct kfree_rcu_head (8 bytes), which is smaller than struct rcu_head
> (16 bytes).
>=20
> For more background and future plans, please see [4].
>=20
> [1] RFC v1: https://lore.kernel.org/linux-mm/20260206093410.160622-1-ha=
rry.yoo@oracle.com
>=20
> [2] RFC v2: https://lore.kernel.org/linux-mm/20260416091022.36823-1-har=
ry@kernel.org
>=20
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/harry/linux.git/log=
/?h=3Dkfree_rcu_nolock-v3r3
>=20
> [4] kmalloc_nolock() follow-ups, including kfree_rcu_nolock(),
>     https://lore.kernel.org/linux-mm/esepccfhqg7m6jo76ns2znj2cnuaepx2xv=
w5zaygtwohq4psma@563ypprp6rr3
>=20
> [5] However, we should probably make the list percpu because,
>     unlike RFC v2, it can be triggered more frequently under memory
>     pressure.
>=20
>     https://lore.kernel.org/linux-mm/805c33d7-3a7b-470c-bd9d-065717a3e3=
e2@paulmck-laptop
>=20
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
> Harry Yoo (Oracle) (9):
>       slub_kunit: fall back to SW perf events when HW PMU is not availa=
ble
>       mm/slab, slub_kunit: register kprobe to trigger _nolock APIs
>       mm/slab: handle the !allow_spin case in kfree_rcu_sheaf()
>       mm/slab: use call_rcu() in unknown context if irqs are enabled
>       mm/slab: extend deferred free mechanism to handle rcu sheaves
>       mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT
>       mm/slab: introduce kfree_rcu_nolock()
>       mm/slab: introduce struct kfree_rcu_head and use in kfree_rcu_nol=
ock()
>       slub_kunit: extend the test for kfree_rcu_nolock()
>=20
>  include/linux/rcupdate.h |  12 +++
>  include/linux/types.h    |   4 +
>  lib/tests/slub_kunit.c   | 174 ++++++++++++++++++++++++++++------
>  mm/slab.h                |   5 +-
>  mm/slab_common.c         |  38 ++++++--
>  mm/slub.c                | 242 ++++++++++++++++++++++++++++++++++-----=
--------
>  6 files changed, 370 insertions(+), 105 deletions(-)
> ---
> base-commit: c425609d6ac4012c8bbf01ec2e10e801b1923a7b
> change-id: 20260615-kfree_rcu_nolock-e5502555992f
>=20
> Best regards,

--=20
Cheers,
Harry / Hyeonggon

--------------J2SxSCJedZHomL0Ld69od8Yj--

--------------10ViNcef5i8ibbRYt2VHD6RX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCai/lcAAKCRCGXBN6rc5S
1mXxAP4+e/OYEoIRSjG5ySSQjKnJWweua3EF2N5shwcUUTRkvQD/U83GisrSL79q
EVrJpmNKT3n6zrZKzJ+O/XCk5dMxrA4=
=a5NM
-----END PGP SIGNATURE-----

--------------10ViNcef5i8ibbRYt2VHD6RX--

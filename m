Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5531DDC32;
	Fri, 22 Nov 2024 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275136; cv=none; b=qVaF76xJDQg7+bwQFumR3/bTvcWqlYBJfZwZkQohQJsfJsP+q8cxHTCaJRuSUuxacJDg0yZsRxvqyaL3uRcCx1xawSDq8+JLu82GC+7borcelo3DRk11m2QbWJSxpA4y9hkg3oneD7Y9cdOmT03gN2i3FsXgkMBW+dIUdQz+QdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275136; c=relaxed/simple;
	bh=Xg+DaoAsALEyo18syRnOL6zaKvc5waW7/iMILZVGyaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syDwyFcDoBIEr3kfKzk3tq14CJZRtFKpmAsT5apIxi4RRRUmM8xP/i6o7lrXZhyT6Brx/XEoHX85P1hXKFCLYBu8ylH96HZZMAry45KpLAnvl8ZT682wOlJqe8Hb3qFd3tMA5urQAHYc1kHwjzAReEVIqVao/Q2wxzzbPgwCTPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k/c6S05b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gxXo0Zpw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k/c6S05b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gxXo0Zpw"
Date: Fri, 22 Nov 2024 12:32:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732275132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXjERXwGoyz9ImH0OMqUpjRgs/7YUUrAyzys/z/9r0k=;
	b=k/c6S05bPuDrImjm8Fw2qYvcj4mTSjZ9qt6zOhnYnC/mGr0YO959GgXEX26faTyCFz4Nz+
	Pem5zExC15Sg2I07wHAoCFMlb+V3bGY9L7bteS9f/PiRdZSCV3r58/Jzjfu2Wbnq/fLmtR
	H1Pl3jx8N4xp00twLXnjB57bDvKEk6LxRORDGuk6J2lU1DwfYyAsGDfIiOXeVXYZ+0P6b5
	hic4DPcoYR4PZQDlZdm/QzgJo2hamgJknpx5TkyP9ut319fveGdQ+W0FNIH5CTLtlM/QLB
	ctAXFRgA10RqXhtkB9LQOucJn49BcljwAoBypGl6KgTlX2xg81Ijh4PSNqDcPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732275132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXjERXwGoyz9ImH0OMqUpjRgs/7YUUrAyzys/z/9r0k=;
	b=gxXo0ZpwlI393YrU+pT27Eb0NRpvEvxrhTtR0c4V04Uoryoueah5nEIxdBvaMlhIl6sX4X
	h2YKQi/K542hcPBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	syzbot <syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com>,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com,
	kasan-dev <kasan-dev@googlegroups.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Waiman Long <longman@redhat.com>, dvyukov@google.com,
	vincenzo.frascino@arm.com, paulmck@kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
	Thomas Gleixner <tglx@linutronix.de>, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH] kasan: Remove kasan_record_aux_stack_noalloc().
Message-ID: <20241122113210.QxE7YOwK@linutronix.de>
References: <67275485.050a0220.3c8d68.0a37.GAE@google.com>
 <ee48b6e9-3f7a-49aa-ae5b-058b5ada2172@suse.cz>
 <b9a674c1-860c-4448-aeb2-bf07a78c6fbf@suse.cz>
 <20241104114506.GC24862@noisy.programming.kicks-ass.net>
 <CANpmjNPmQYJ7pv1N3cuU8cP18u7PP_uoZD8YxwZd4jtbof9nVQ@mail.gmail.com>
 <20241119155701.GYennzPF@linutronix.de>
 <CA+fCnZfzJcbEy0Qmn5GPzPUx9diR+3qw+4ukHa2j5xzzQMF8Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+fCnZfzJcbEy0Qmn5GPzPUx9diR+3qw+4ukHa2j5xzzQMF8Kw@mail.gmail.com>

On 2024-11-19 20:36:56 [+0100], Andrey Konovalov wrote:
> > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > index 6310a180278b6..b18b5944997f8 100644
> > --- a/mm/kasan/generic.c
> > +++ b/mm/kasan/generic.c
> > @@ -521,7 +521,7 @@ size_t kasan_metadata_size(struct kmem_cache *cache=
, bool in_object)
> >                         sizeof(struct kasan_free_meta) : 0);
> >  }
> >
> > -static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_f=
lags)
>=20
> Could you add a comment here that notes the usage, something like:
>=20
> "This function avoids dynamic memory allocations and thus can be
> called from contexts that do not allow allocating memory."
>=20
> > +void kasan_record_aux_stack(void *addr)
> >  {
=E2=80=A6
Added but would prefer to add a pointer to stack_depot_save_flags()
which has this Context: paragraph. Would that work?
Now looking at it, it says:
|  * Context: Any context, but setting STACK_DEPOT_FLAG_CAN_ALLOC is requir=
ed if
|  *          alloc_pages() cannot be used from the current context. Curren=
tly
|  *          this is the case for contexts where neither %GFP_ATOMIC nor
|  *          %GFP_NOWAIT can be used (NMI, raw_spin_lock).

If I understand this correctly then STACK_DEPOT_FLAG_CAN_ALLOC must not
be specified if invoked from NMI. This will stop
stack_depot_save_flags() from allocating memory the function will still
acquire pool_lock, right?
Do we need to update the comment saying that it must not be used from
NMI or do we make it jump over the locked section in the NMI case?

Sebastian

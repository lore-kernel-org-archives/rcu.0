Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84198423EB9
	for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186253; cv=none; b=PwSiDiSizTt9p2oERC1chH39DR/MfJhxUT82JNDrMb6SrwkZkp7yfr3+3IbbDTvfrN3i0heExbBJgeVD/+kakMpZQB741eLqWCRtk0/W0oq45WGgSWjgxpQyd5qenyztJkIYfPL6eczV92Si8dEwHG9aLkZ3xoJVlc3j+CJt+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186253; c=relaxed/simple;
	bh=iy/SdBU3TpsksnSLzBwHjuItVhqAd9Qd1yMloChUkvU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iu8aF6rONHoBHwgavHYLWy5S76I6uCEEa3pO8u6uO13cCTY/9GP1XkXQ0H9hglWYPPzEeBpq5TJlHRk529H4sKi5i9D2xfhVlaEo9uQBNVDxbI8pXJBriXdkY5+mha9s80EapOu3iqCkVb5r/juhMtmtUuwZBHVCfX0xPOwqRs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFVprN8K; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFVprN8K"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so4187595e9.0
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790186250; x=1790791050; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZM7a9TUy0yGa9yHYdPb2K9Zh2v6o2Z/OI8Zrysz2UxI=;
        b=pFVprN8K2eRVadnE959NVaVYldmYnnO9lZuFVK3dSy57CW8mYCvycPLP7bhe9mBZd2
         6+2IDz++U8B2nbEbNeT/YfqrI2Ni1b/njmZubAF86pmCpFbBc73CHnbC3bBUoCQw5R9B
         i9qKUM42c5kVtEAemizZu8HtoR4441/srA8Gmo2L07LoO4cpfezAm2A1t0ZGa6DUL23C
         O8OSn3aHkV6X7F0iaSsF5ZYLQ1E3yvgPtFkhc6uxCYTvygaBCtoI3ZV/mjjx+3PnhBz2
         ChHNHq+9jfpm0XI2k+sjOPbCE8+dO1VR9da8PKWxZPppG1smS3ysXc10Y+mEPl7Z9FOb
         DChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790186250; x=1790791050;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZM7a9TUy0yGa9yHYdPb2K9Zh2v6o2Z/OI8Zrysz2UxI=;
        b=nO8fYLwYv84KSjT2GevBeO/g85e18QmngV2EDegcCakA3eRc5uNC7gfG8+f4u9dLmU
         jS2Ir+OrNrTglWw4MxzdtgaBjwtAMUMbMfG1zR51KkX04k70YEtYFnDh1ksdp9BgEnke
         vgB4bau9U2LZWgyT2nkgb2qHIorCC9Bqi1rXxfhgzs5iiOMIKc2gAV/9CX9P313HcTI5
         ljUBjHHhX3bSFfPpXLLwbGsJTGKZF7PT28J8UldTFdbZyUxxkT7UN2s48onpsKU9FspL
         ck+nPiFgYIasCMnP548CwI0iEJEmmwtV3oXjLtzstMdRLSE6sqxXrQUIktXh7wQlJnGL
         wK1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwl7gXnB2vqSPJqygweBwMav+meMUgXHVcvyG7fqyB0a0XeT1ZqJbPBMJpkWkqwUFrsjVs=@vger.kernel.org
X-Gm-Message-State: AFuF++m8W2yqLPFR2ZKMkOkGDSXUTXNRFACNpZKJnts55coap/OGNYBF
	8PsQwWo/b8HbhVtNRXjwlWD5EbXokOd9tzN+ZAbtacmXeKCQhhUchgSc
X-Gm-Gg: AYBFou3OavvUJNQlSaXLey7+bQo8zp9VvHlux+bqKSt6jbsYdGwQPq3JW+NsHKyj21i
	FY7dTVWPKHDNz9KxsENE7ZyB7CgQedzyoSp5BirdS5aMI8WNml9fjAX+Hv7zeCUZz5+l7V/VpEe
	Px3ILN5LLeakk21SIjpnaClFJVHsY/wKLMnbs5MBQipr/45T5WYQs0sQVlxCC0fe2Dmw2DQODrk
	D5j1MJ6kLMiA+oqYSgNOJQzxTjTAWQD+9UWTh4AY2QZxQRsHuOBNRsMMd8WIHIcdQWTiY3okaXQ
	vq+sZafolr0vcVsfoF9oHbL/tx7GO4v/DLHIiMNSppTae5f855qTD1ab9+zHUpdGD4LLaqAksBo
	Z87zIQ8EEIKZi5j7EdtzMCM9+bizF3HXM0hGwjuA0suOBO/mF3ZGUtX/oqH6/KriDrVKRMoJkAX
	xvwb2ea8WsdQ2i6sO+1N+lPsEg2/N63su2H+moxseW8ssxjH8+kFHU6f7n0OL5tpTC57yJlNakn
	wd5zGVseoEagAM9jwGl+tV8tBNCnqnmC8GyBxL3Oh37iKf2Rv/6iPoJc61BORaK2GQLac/P85ht
	XnqlDKLz5p6avktMAA6LnPKLP/8uvEXELcI0ZrhBHmhRFMWh59O7CBMPvfc=
X-Received: by 2002:a05:600c:620c:b0:499:8ff5:8ecc with SMTP id 5b1f17b1804b1-49fdf0fe786mr53450445e9.15.1790186249358;
        Wed, 23 Sep 2026 10:57:29 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5bba615sm3700945e9.7.2026.09.23.10.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 10:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 19:57:28 +0200
Message-Id: <DLMW293TO3P3.3SKQ637LNLYQR@gmail.com>
Cc: "Puranjay Mohan" <puranjay12@gmail.com>, <bpf@vger.kernel.org>,
 <rcu@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH bpf-next v6 0/4] bpf: Add bpf_call_rcu() and
 bpf_call_rcu_tasks_trace()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260922200208.3203834-1-puranjay@kernel.org>
 <CAEf4BzaifaWk+oHu-berWcKuS6Y5WfkcFTKZW-iMCPxG0=5i0w@mail.gmail.com>
 <CANk7y0g8Mh-je_o_nyXQ3zsGVeAsz2qMfgDtv4j-MXhAJ7PcMA@mail.gmail.com>
 <DLMNTHW945RO.TLPGJHZRWHUY@gmail.com>
 <CAEf4BzaR=oQz13GVxM+DjLkyjCjFmETvj9=bAuccLNKCXHJPaw@mail.gmail.com>
 <DLMUP8JM4L3U.1A9R0QUFFIQV9@gmail.com>
 <CAEf4BzYvSXNKu2qtBHEvmFg8sm3yJS_2xRUmuQhfjfx79VfgNQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYvSXNKu2qtBHEvmFg8sm3yJS_2xRUmuQhfjfx79VfgNQ@mail.gmail.com>

On Wed Sep 23, 2026 at 6:59 PM CEST, Andrii Nakryiko wrote:
> On Wed, Sep 23, 2026 at 9:53=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>>
>> On Wed Sep 23, 2026 at 6:45 PM CEST, Andrii Nakryiko wrote:
>> > On Wed, Sep 23, 2026 at 4:29=E2=80=AFAM Kumar Kartikeya Dwivedi
>> > <memxor@gmail.com> wrote:
>> >>
>> >> On Wed Sep 23, 2026 at 12:37 PM CEST, Puranjay Mohan wrote:
>> >> > On Wed, Sep 23, 2026 at 12:41=E2=80=AFAM Andrii Nakryiko
>> >> > <andrii.nakryiko@gmail.com> wrote:
>> >> >>
>> >> >> On Tue, Sep 22, 2026 at 1:02=E2=80=AFPM Puranjay Mohan <puranjay@k=
ernel.org> wrote:
>> >> >> >
>> >> >> > Changelog:
>> >> >> > v5: https://lore.kernel.org/all/20260921191407.1742386-1-puranja=
y@kernel.org/
>> >> >> > Changes in v6:
>> >> >> > - Size struct bpf_rcu_head at 48 bytes rather than 64, matching =
what the
>> >> >> >   inline state uses (Alexei)
>> >> >> > - Trim patch 1's changelog: drop the reasoning about possible fu=
ture
>> >> >> >   layouts and about what the other async kfuncs return
>> >> >> > - Rebase on bpf-next/master
>> >> >> >
>> >> >> > v4: https://lore.kernel.org/all/20260915154248.3612028-1-puranja=
y@kernel.org/
>> >> >> > Changes in v5:
>> >> >> > - Rename the "hash_map" subtest to "bad_map" so that it matches =
its
>> >> >> >   helper test_call_rcu_bad_map() (bpf-ci)
>> >> >> > - Bump the callback counter after chain_err in the selftest call=
back.
>> >> >> >   Userspace polls that counter and then reads chain_err, so it c=
ould
>> >> >> >   still see the initial value before the re-arm had stored one, =
which
>> >> >> >   let the chain subtest's assertion pass without checking anythi=
ng
>> >> >> > - Say in patch 1 why embedding struct rcu_head in a uapi struct =
is
>> >> >> >   acceptable here (Mykyta, Paul, Alexei)
>> >> >> > - Rebase on bpf-next/master
>> >> >> > v3: https://lore.kernel.org/all/20260915143640.36292-1-puranjay@=
kernel.org/
>> >> >> > Changes in v4:
>> >> >> > - Drop an unrelated hunk in bpf_async_update_prog_callback() tha=
t turned
>> >> >> >   PTR_ERR(prog) into -EBADF.  That is the shared bpf_timer/bpf_w=
q path
>> >> >> >   and bpf_prog_inc_not_zero() returns -ENOENT, so it would have =
changed
>> >> >> >   the errno bpf_timer_set_callback() and bpf_wq_set_callback() r=
eport to
>> >> >> >   userspace (Sashiko).  No other changes from v3
>> >> >> > v2: https://lore.kernel.org/all/20260915114240.3269184-1-puranja=
y@kernel.org/
>> >> >> > Changes in v3:
>> >> >> > - Move the bpf_call_rcu_tasks_trace() verifier bits from patch 1=
 to
>> >> >> >   patch 3; patch 1 alone emitted "resolve_btfids: unresolved sym=
bol
>> >> >> >   bpf_call_rcu_tasks_trace" (Sashiko)
>> >> >> > - Poll the callback counter with an acquire load (Sashiko)
>> >> >> > - teardown: v2 only checked that the program was eventually free=
d, which
>> >> >> >   passes even if nothing was ever armed.  Also assert that the c=
hain ran,
>> >> >> >   and read the -EPERM back through an independent .bss fd
>> >> >> > - Use kern_sync_rcu() instead of open coding the grace-period wa=
it
>> >> >> > - Return -EBADF rather than -ENOENT when the calling program is =
going
>> >> >> >   away, matching bpf_task_work_schedule()
>> >> >> > - mismatch_map now pins the bpf_rcu_head label the new code emit=
s; it
>> >> >> >   passed with that branch removed.  Add a two_heads test, and wa=
it for
>> >> >> >   each grace period separately in the chain test
>> >> >> > - Commit messages: correct the -EPERM parity claim, explain the =
inline
>> >> >> >   callback state and the struct size, motivate the tasks trace f=
lavour
>> >> >> > v1: https://lore.kernel.org/all/20260907134552.1772405-1-puranja=
y@kernel.org/
>> >> >> > Changes in v2:
>> >> >> > - Rebase on bpf-next/master
>> >> >> > - Use rcu_read_lock_dont_migrate() over open coding (Alexei)
>> >> >> > - Improve re-arming selftest to detect failure (Sashiko)
>> >> >> >
>> >> >> > BPF programs that manage their own objects have no way to run th=
eir own
>> >> >> > logic once an RCU grace period has elapsed.  bpf_obj_drop() defe=
rs a
>> >> >> > free, but returning an index to an allocator or unpinning a reso=
urce
>> >> >> > once readers are done has no equivalent.  sched_ext's BPF librar=
y works
>> >> >> > around this today by pushing freed nodes onto a list and having =
a
>> >> >> > userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then=
 run a
>> >> >> > BPF program to reclaim them; it is the first intended user.
>> >> >> >
>> >> >> > Add:
>> >> >> >
>> >> >> >         int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
>> >> >> >                          int (*callback)(struct bpf_map *map, vo=
id *key,
>> >> >> >                                          void *value));
>> >> >> >
>> >> >> > and bpf_call_rcu_tasks_trace(), same signature, which also waits=
 for
>> >> >> > sleepable programs.
>> >> >> >
>> >> >> > @rh is a struct bpf_rcu_head embedded in a value of @map, so the
>> >> >> > callback runs as callback(map, key, value) for the element it li=
ves in
>> >> >> > and needs no cookie.  The field is only accepted in BPF_MAP_TYPE=
_ARRAY,
>> >> >>
>> >> >> Isn't restricting this to BPF_MAP_TYPE_ARRAY unnecessarily restric=
tive
>> >> >> in practice? Do other APIs of similar kind have this limitation? E=
.g.,
>> >> >> bpf_task_work_schedule() or timer, I don't think they limit user t=
o
>> >> >> just ARRAY maps, it's way too inflexible.
>> >> >
>> >> > Right, bpf_timer and bpf_task_work take HASH/LRU_HASH/ARRAY. They c=
an
>> >> > because they can cancel: on element delete bpf_obj_free_fields() ca=
lls
>> >>
>> >> bpf_obj_cancel_fields(). bpf_obj_free_fields() is no longer called ex=
cept when
>> >> the object is being freed finally.
>> >>
>> >> > bpf_task_work_cancel_and_free(), which reaches task_work_cancel(), =
so
>> >> > a pending callback never runs against a recycled element.
>> >> > A queued RCU callback cannot be cancelled. rcu_barrier() is the onl=
y
>> >> > thing that waits for one, and it sleeps, so it is not callable from=
 an
>> >> > element delete. Array elements are never freed individually, which =
is
>> >> > what makes it safe.
>> >>
>> >> If cancel is a noop, can you not simply skip it on map update?
>> >>
>> >> It is a bit unfortunate we can't provide cancel semantics, it will be=
 yet
>> >> another divergence from how all other async callbacks work...sigh.
>> >>
>> >> >
>> >> > I can think of a complicated way to support hash maps but that woul=
d
>> >> > need making the state dynamically allocated and finding a way to
>> >> > cancel the callbacks. But I would do it as a follow-up if there is =
a
>> >> > real use case.
>> >>
>> >> That would mean allocation and frees, it is already quite expensive a=
s is for a
>> >> call_rcu() primitive (with the refcount bumps and atomics).
>> >
>> > maybe so, but as is ARRAY is a severe limitation and makes a lot of
>> > cases either unusable or requiring extra sequential ID allocation
>> > logic to remap some HASH map entry to index in an ARRAY map, just so
>> > you can call rcu callback for a given kernel object stored in HASH
>> > map.
>> >
>> > E.g., think about keep as set of sockets, or tasks, or whatnot in HASH
>> > or RHASHTABLE (especially the latter one with support for resizing).
>> > How would you do bpf_call_rcu() for them with unduly complications,
>> > limitations and a lot of waste (unlike HASH you can't have lazy memory
>> > allocation).
>>
>> Yeah, I don't disagree. We would also need to support storing them in mo=
re map
>> types to make it woth with arenas (which was one of the motivations for =
the
>> feature).
>>
>> Perhaps it is better to make cancel a noop / unsupported and skip it whe=
n a map
>> element is deleted. That will be the easiest path to enabling it, but it=
 does
>> create (perhaps surprising) divergence from some of the other async call=
back
>> primitives.
>
> I don't see much need for cancellation, but a more useful/sane
> behavior would be rearming on subsequent calls to bpf_call_rcu(). This
> would also handle update/delete/reuse of entries. Not sure how hard it
> is to support that in kernel's call_rcu() implementation, though, but
> that would solve the problem, because it should always be OK to delay
> call_rcu() callback, but not the other way around (which is what would
> happen today because we will ignore subsequent bpf_call_rcu() calls).
>

Hm. One of the design points for this was maintaining our own lists and usi=
ng
more lower level RCU primitives to poll for the grace period. I wonder if s=
ome
of this could be made easier that way. I will think a bit more about this.

We could probably also do the waiting_for_gp amortization that memalloc.c o=
n top.

>>
>> That said, I do think performance should be a consideration for this API=
; maybe
>> unlike other ones, I would expect that this could be called very frequen=
tly. I
>
> I'm not sure why this has to be super high frequency API to use, tbh.
> You'd normally use this when cleaning up when some kernel object is
> freed, no? Sure that can be relatively frequent, but not to the point
> where we should be *that* concerned with refcount or atomics overhead
> per se (multi-cpu cache bouncing of refcounting is a concern, but not
> sure what you can do about that).
>

Yeah it depends, but I think you can make the other case as well.  Going by
optimizations made in memalloc.c for hashtab, imagine implementing an arena=
 hash
table using this stuff. You'd definitely want it to be as cheap as possible=
 and
approach the kernel implementation.

If multiple CPUs dispatching it leads to constant cache line bouncing, it w=
ill
fail to scale with number of CPUs. The user then does their own batching to
amortize the cost and pace the calls, but it's just more complexity pushed =
down
on the callers, and it might build up memory pressure because items are now=
 not
being freed as quickly and hit locks in the allocator (one of the main reas=
ons
BPF maps have memory reuse semantics, to avoid exhausting caches and hittin=
g
allocator locks).

Anyway, I know we kicked the can down the road for now on prog refcounts, a=
nd
can cache allocations etc. to amortize the cost there, but I hope that I co=
uld
illustrate why I think it might be more sensitive to performance difference=
s
than some of the other primitives.

>> had concerns about prog refcount increment as well, but didn't really br=
ing it
>> up since it is something that can be addressed after the fact (maybe usi=
ng pcpu
>> refs). But once we promise supporting cancellation, it is hard to walk t=
hat
>> back. I think it's less of a concern for other async cb types. In practi=
ce,
>> except to support map semantics I don't know if anyone will use cancella=
tion API
>> either, the kernel side never grew such support.
>>
>> Anyway, overall the best path to me seems to be just enabling it as is a=
nd
>
> you mean enabling for HASH or keeping it for ARRAY only? If the
> latter, my concern is that to support HASH we might need to change the
> internal structure and break that 48-byte size, so we should probably
> decide all this before we get this into the next Linux release.

I did mean enabling it in other maps, yes, sorry, I think I wrote it in a
confusing manner. I was just speculating that we can bail on cancelling and=
 see
whether we can make it work. I probably need to spend a little more time
thinking it through.

All of that said, it seems there's a more discussion to be had about this, =
and
it probably landed too early. I would prefer if we could resolve these ques=
tions
without operating under some time pressure just because it might go out in =
the
next release.

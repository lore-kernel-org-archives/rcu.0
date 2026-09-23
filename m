Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F83C37AF
	for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182412; cv=none; b=fS9RD24o2WkbiYKwUEzq3IUEMfAyn+ZR2m363hqxyepIit3A4ojjpqZBZBYuK1Sq0S96KxQRM4BsEDaiPz+Bgi4/4LK9I54K6v0ToDEF/uQTHCgfmWEoH/wLqyvIL70M3SVZGBbofDCy9txoSzuWP6MxokIPhCFAMmBtuQAZjAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182412; c=relaxed/simple;
	bh=p/0KZ68LGr2iJJaK0QtwantBUJwpkmc/lQxRK1SBwvI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Pi92xzmy9fYYuHvzJykCNluWKNSjcWY/RjIROBZjPUqQh8KZvWqhi9/rOKsBd9/pEFnSWv143YZ/Hh+1RN9MKj9cfQnDjMS5f8TWsZLGCks+FWvruBPV6RuznLY1HrbUhxch119rIJ4pl1URbCr5q2Mph57fERnBlAfW+kYdgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgq4g0Bo; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgq4g0Bo"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-49cd71f9909so2320115e9.1
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790182409; x=1790787209; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ed3QXESutta5PNgIuWlBBjkorsQK7Sz7FQtCM4TE32s=;
        b=bgq4g0BoqaCqSt5G1eNc1DZXIF4Owmeg157qMKh39k5eZdJ3KnNZi2+cLlDrDd36qu
         YcAiCFzNFWTWCxfw8zv0onxTyX9jqxtbwLT0+xFunQclVVagTkGEs8VJsQUyAuWDozbU
         tF5NRSJ6lrtoVJMs/TVaAbX27FhwxJ838/nOUdnNHP3RGaOJawIGrL17c2bPyGlHg+1R
         IMMyDskVOtGgrwMgBrvTnngVrpxM0RoLR5k9Dnk+w+5mDdaX22cXS4Q3Wc7ZQ1lgM6+o
         3m6AI9I0PYRoC1i9N5zr6HwcX9BzpP9EKEh6nUPS0y0TnElcdyJH2R3zstgsJV8K7vag
         xxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182409; x=1790787209;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ed3QXESutta5PNgIuWlBBjkorsQK7Sz7FQtCM4TE32s=;
        b=AtGcLH3CEi9TbtFMV3tb4BtkR1mNZv6iy/4a1dPAlxnqEgkGQECRdilfKsqst/h0gY
         4mn1N51P/7OIgTTGK9bhLi7DuiL5++vvy7g3gBnXTNizHoEXKmLHPg8aL+r1ksiJdrKK
         07CL78TW8dQRk8bfkoizBX0gZVXaFY9ery/XOyx1TWkF5hquGkaKJBe8eL8Wh51YaMqV
         V3cnr1X6QOTiBS/zCtQ5kvGlPL6U/dajSCbYm7xQy+zBwTFIoIGhrExm3pUepnqpjlZr
         zqXbx2DbH4Ac13v+erLh7RweoU7HEAr2U0Xr+nTj0aCDan2Q4k+MTih/WvLpH8tbWRHm
         xCcA==
X-Forwarded-Encrypted: i=1; AKwUvBwa6trBu0aktjhbblFtPkNjh4aGtt30l1pk8Ep5d8Fd2wJbRY4/iI5kyofIMDO4kFUe5RM=@vger.kernel.org
X-Gm-Message-State: AFuF++nkaCgDXDsoeGemUu8DTewSQa2CjYusT/loNsufOH2nl+CdYxvG
	rTZmgOume/TcuQewUX6TmQjm4UDKrfT+YbjwbVCuv3bANpB/2TjbnoWQ
X-Gm-Gg: AYBFou1aJSSi3DXbOWblnOH10+sQsaMMgDzuGS2bLlAW5UkRTOrpaVhL6SbmCzUBcOl
	Bexur5ki5IOyNHegrUYKC3/rFPsMnBEGZ6lg74IjffxPEVPmlj+FVCbhSbxiNLecvbgaZhlxE9g
	NY22QAaAhCKJp/ohLRVGPOKZQ6xOh3glFqu3p7RNRQed+QJWk9WAh/do8/1cOOFQo6JDIvrWsjK
	EedXN9p52eBrgzAjCBvAnKLS7DAAKLHyLFi/Zc8n3mJInIKfgIu75sfE+gETGWjlpqGhc/A194e
	iZuBkeC4swiagxwl+jnlgnpql1X1pFWHLEYtibOLzBDy2gwomXRa2xVPz30GC/J/LCKvzS3Tv/K
	5XZf47R2Z3AE3anrleRGbQ/Qja+dIie8GOzCIMVEE4k56PYOmjPTFpRRAAh0Upqz/oJ1FypxpkZ
	vdvdcXhGmcG/TgZ2bGSL74xhRSHyugFIBo1zG41JkoCXd4i2I7bXNWZ2ZEY8YssDz4hyLd8StdZ
	ilkmQRSNiZSQfu4yBixxDzcrjR531nDwCYHA6Q6YmdBt+pL1wQyFsn1bWpniUa0xVCln1GA/S1L
	6H/Zsq/y+p7HDbPCW9HiTK745El0YbUKIbegQSgcqrFYElBB
X-Received: by 2002:a05:600c:c493:b0:49f:ce78:3564 with SMTP id 5b1f17b1804b1-49fdee0a323mr46208655e9.21.1790182408356;
        Wed, 23 Sep 2026 09:53:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1c0f6csm107711875e9.3.2026.09.23.09.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 09:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 18:53:27 +0200
Message-Id: <DLMUP8JM4L3U.1A9R0QUFFIQV9@gmail.com>
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
In-Reply-To: <CAEf4BzaR=oQz13GVxM+DjLkyjCjFmETvj9=bAuccLNKCXHJPaw@mail.gmail.com>

On Wed Sep 23, 2026 at 6:45 PM CEST, Andrii Nakryiko wrote:
> On Wed, Sep 23, 2026 at 4:29=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>>
>> On Wed Sep 23, 2026 at 12:37 PM CEST, Puranjay Mohan wrote:
>> > On Wed, Sep 23, 2026 at 12:41=E2=80=AFAM Andrii Nakryiko
>> > <andrii.nakryiko@gmail.com> wrote:
>> >>
>> >> On Tue, Sep 22, 2026 at 1:02=E2=80=AFPM Puranjay Mohan <puranjay@kern=
el.org> wrote:
>> >> >
>> >> > Changelog:
>> >> > v5: https://lore.kernel.org/all/20260921191407.1742386-1-puranjay@k=
ernel.org/
>> >> > Changes in v6:
>> >> > - Size struct bpf_rcu_head at 48 bytes rather than 64, matching wha=
t the
>> >> >   inline state uses (Alexei)
>> >> > - Trim patch 1's changelog: drop the reasoning about possible futur=
e
>> >> >   layouts and about what the other async kfuncs return
>> >> > - Rebase on bpf-next/master
>> >> >
>> >> > v4: https://lore.kernel.org/all/20260915154248.3612028-1-puranjay@k=
ernel.org/
>> >> > Changes in v5:
>> >> > - Rename the "hash_map" subtest to "bad_map" so that it matches its
>> >> >   helper test_call_rcu_bad_map() (bpf-ci)
>> >> > - Bump the callback counter after chain_err in the selftest callbac=
k.
>> >> >   Userspace polls that counter and then reads chain_err, so it coul=
d
>> >> >   still see the initial value before the re-arm had stored one, whi=
ch
>> >> >   let the chain subtest's assertion pass without checking anything
>> >> > - Say in patch 1 why embedding struct rcu_head in a uapi struct is
>> >> >   acceptable here (Mykyta, Paul, Alexei)
>> >> > - Rebase on bpf-next/master
>> >> > v3: https://lore.kernel.org/all/20260915143640.36292-1-puranjay@ker=
nel.org/
>> >> > Changes in v4:
>> >> > - Drop an unrelated hunk in bpf_async_update_prog_callback() that t=
urned
>> >> >   PTR_ERR(prog) into -EBADF.  That is the shared bpf_timer/bpf_wq p=
ath
>> >> >   and bpf_prog_inc_not_zero() returns -ENOENT, so it would have cha=
nged
>> >> >   the errno bpf_timer_set_callback() and bpf_wq_set_callback() repo=
rt to
>> >> >   userspace (Sashiko).  No other changes from v3
>> >> > v2: https://lore.kernel.org/all/20260915114240.3269184-1-puranjay@k=
ernel.org/
>> >> > Changes in v3:
>> >> > - Move the bpf_call_rcu_tasks_trace() verifier bits from patch 1 to
>> >> >   patch 3; patch 1 alone emitted "resolve_btfids: unresolved symbol
>> >> >   bpf_call_rcu_tasks_trace" (Sashiko)
>> >> > - Poll the callback counter with an acquire load (Sashiko)
>> >> > - teardown: v2 only checked that the program was eventually freed, =
which
>> >> >   passes even if nothing was ever armed.  Also assert that the chai=
n ran,
>> >> >   and read the -EPERM back through an independent .bss fd
>> >> > - Use kern_sync_rcu() instead of open coding the grace-period wait
>> >> > - Return -EBADF rather than -ENOENT when the calling program is goi=
ng
>> >> >   away, matching bpf_task_work_schedule()
>> >> > - mismatch_map now pins the bpf_rcu_head label the new code emits; =
it
>> >> >   passed with that branch removed.  Add a two_heads test, and wait =
for
>> >> >   each grace period separately in the chain test
>> >> > - Commit messages: correct the -EPERM parity claim, explain the inl=
ine
>> >> >   callback state and the struct size, motivate the tasks trace flav=
our
>> >> > v1: https://lore.kernel.org/all/20260907134552.1772405-1-puranjay@k=
ernel.org/
>> >> > Changes in v2:
>> >> > - Rebase on bpf-next/master
>> >> > - Use rcu_read_lock_dont_migrate() over open coding (Alexei)
>> >> > - Improve re-arming selftest to detect failure (Sashiko)
>> >> >
>> >> > BPF programs that manage their own objects have no way to run their=
 own
>> >> > logic once an RCU grace period has elapsed.  bpf_obj_drop() defers =
a
>> >> > free, but returning an index to an allocator or unpinning a resourc=
e
>> >> > once readers are done has no equivalent.  sched_ext's BPF library w=
orks
>> >> > around this today by pushing freed nodes onto a list and having a
>> >> > userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then ru=
n a
>> >> > BPF program to reclaim them; it is the first intended user.
>> >> >
>> >> > Add:
>> >> >
>> >> >         int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
>> >> >                          int (*callback)(struct bpf_map *map, void =
*key,
>> >> >                                          void *value));
>> >> >
>> >> > and bpf_call_rcu_tasks_trace(), same signature, which also waits fo=
r
>> >> > sleepable programs.
>> >> >
>> >> > @rh is a struct bpf_rcu_head embedded in a value of @map, so the
>> >> > callback runs as callback(map, key, value) for the element it lives=
 in
>> >> > and needs no cookie.  The field is only accepted in BPF_MAP_TYPE_AR=
RAY,
>> >>
>> >> Isn't restricting this to BPF_MAP_TYPE_ARRAY unnecessarily restrictiv=
e
>> >> in practice? Do other APIs of similar kind have this limitation? E.g.=
,
>> >> bpf_task_work_schedule() or timer, I don't think they limit user to
>> >> just ARRAY maps, it's way too inflexible.
>> >
>> > Right, bpf_timer and bpf_task_work take HASH/LRU_HASH/ARRAY. They can
>> > because they can cancel: on element delete bpf_obj_free_fields() calls
>>
>> bpf_obj_cancel_fields(). bpf_obj_free_fields() is no longer called excep=
t when
>> the object is being freed finally.
>>
>> > bpf_task_work_cancel_and_free(), which reaches task_work_cancel(), so
>> > a pending callback never runs against a recycled element.
>> > A queued RCU callback cannot be cancelled. rcu_barrier() is the only
>> > thing that waits for one, and it sleeps, so it is not callable from an
>> > element delete. Array elements are never freed individually, which is
>> > what makes it safe.
>>
>> If cancel is a noop, can you not simply skip it on map update?
>>
>> It is a bit unfortunate we can't provide cancel semantics, it will be ye=
t
>> another divergence from how all other async callbacks work...sigh.
>>
>> >
>> > I can think of a complicated way to support hash maps but that would
>> > need making the state dynamically allocated and finding a way to
>> > cancel the callbacks. But I would do it as a follow-up if there is a
>> > real use case.
>>
>> That would mean allocation and frees, it is already quite expensive as i=
s for a
>> call_rcu() primitive (with the refcount bumps and atomics).
>
> maybe so, but as is ARRAY is a severe limitation and makes a lot of
> cases either unusable or requiring extra sequential ID allocation
> logic to remap some HASH map entry to index in an ARRAY map, just so
> you can call rcu callback for a given kernel object stored in HASH
> map.
>
> E.g., think about keep as set of sockets, or tasks, or whatnot in HASH
> or RHASHTABLE (especially the latter one with support for resizing).
> How would you do bpf_call_rcu() for them with unduly complications,
> limitations and a lot of waste (unlike HASH you can't have lazy memory
> allocation).

Yeah, I don't disagree. We would also need to support storing them in more =
map
types to make it woth with arenas (which was one of the motivations for the
feature).

Perhaps it is better to make cancel a noop / unsupported and skip it when a=
 map
element is deleted. That will be the easiest path to enabling it, but it do=
es
create (perhaps surprising) divergence from some of the other async callbac=
k
primitives.

That said, I do think performance should be a consideration for this API; m=
aybe
unlike other ones, I would expect that this could be called very frequently=
. I
had concerns about prog refcount increment as well, but didn't really bring=
 it
up since it is something that can be addressed after the fact (maybe using =
pcpu
refs). But once we promise supporting cancellation, it is hard to walk that
back. I think it's less of a concern for other async cb types. In practice,
except to support map semantics I don't know if anyone will use cancellatio=
n API
either, the kernel side never grew such support.

Anyway, overall the best path to me seems to be just enabling it as is and
declaring bpf_obj_cancel_fields() on this noop. Existing synchronization sh=
ould
be enough to ensure callback stops getting issued once element is finally f=
reed
back to kernel allocator.

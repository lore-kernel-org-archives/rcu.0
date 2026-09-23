Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEEE560ABD
	for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182766; cv=pass; b=rWN9lK0nbdCtaCjoyuBjVHfYQcQpUN3VIRpAwiVPMSwrh696Yo6p7hwLjR1UgxFEpF54DSrwRDMp1oN32Hkfx4yTche7R3qZ48fxtZHwUCpe2wH6oAkXGtmnLJPr5E24vUMutPC6qj6ssZ+35HGDG/oWfEsUYlL28sgwMQfKUqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182766; c=relaxed/simple;
	bh=fpFeo4eYe48WkeIhCW1725t5yHGdlJu7KUlFzUcu8KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RruYILosKv/gEOD/tkvKu2ZDrCcWel0i/peOw+qaVPQyfGIJ3xjq+g5a1Y58OqhRT3gtixShZVaJiJkHClPSetBn23fYU13ZgMf/DrfZ1VN4hEDlJ09yqPspPMHnQMS4n78U1KLRBiqQL43CNTw3rzev8DQcxcUsKyDLUKeItGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jruN/ida; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jruN/ida"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc75e33cc69so576595a12.0
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 09:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790182764; cv=none;
        d=google.com; s=arc-20260327;
        b=sGrGPZYV6LSd+ap2kbwNgL+HsKH01TvbE1H6Fu00jv/Izm8TJXKIrHtrhgeI4yZevY
         IMRE0MXguBhGm1oGbO/u4xlRrtP6CURTMNJAVlz2pMKVS5czdduf1oLS7O46FsQw3BRo
         rJEXNDVMSZzEw+CsW5bxlQiMJ9axEYUXovi6uxzJP9osFj6+gz7WfxmjxqOVSNfQGRd/
         txp1ANvF8SF0tUZG9iJIZGd6xQyp3xDuOL6iwORBf+3EoCzV5cSpG//CEF1rFxyGVI5K
         BUWregC1Fjd+UPYjpbtDBhOyHwbVceGpinP2OYueRnG4zwWGfZnJb0CbESc2sV3U6v6J
         nuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0z2LCGrolad0TmyiVW1oFKGlwCLwRV8kBWH095wFzDA=;
        fh=ETWnGMoE/wY+9/DDfygLHaMw6dNCiDNm3qAf42+65Zg=;
        b=hDOqtc3gTDjWGZAcWG0mR/HiNy+nShBCgsltpbJy1FmO2M1U3vkzPLZ7bcHpEUnucK
         aldGrDphiFkJpyvq1C0FusZ9QKKXWxWSJfYICCK8OCqetVVRkEfByM/aluzk3mHkyVdp
         4Nruc7nWUDeJM645zXYJtC4HFGdTs3I2AAWQ1+n0TuXAhaQz+SnMwGNblgNUmxsANKLt
         U3kaJjkNOcR2jRAYD9JTQkKYfbJ8v+tIpCo3AmNXGn4i/qhWvIXbSzw4xd4psCdHGDlg
         rl2ET+MRBLzcZKSNaJx0k9Q5Zmz8IhSjjZzydNpohnATn9jeLPT9jof634MV5RKICjyj
         IoMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790182764; x=1790787564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0z2LCGrolad0TmyiVW1oFKGlwCLwRV8kBWH095wFzDA=;
        b=jruN/ida6hri/DDSCHNk0vUzwwjYnQaag6c5gLvKhsn0rMxoQbwdh5jc+DVE1HJ6Zh
         bcJIHhQ4bKa4fzuWq/HZg3VGAFRK3w1fakm8xlwg9jGCgAdIoYdoJP2D3nirrqAyJrhr
         gE/snScjfGZiT3ensOIsa5KVoqAniDF4uM2ytY510OjzSC9YoDXcwhDmCZyGEXANm/cY
         CcpHGJutompK3j3ZpOPt9ZY79SALszCzYIuIvuqmQCpYlOOFjLaIjANoQxLGJyTeTzw5
         qq+Ir5QQ2EXt8QNUoy59ZIII4pgjFvPkmvoqYJlhGdvf72i3Ofro4SO1dIY0xw3rRBzl
         wLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182764; x=1790787564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0z2LCGrolad0TmyiVW1oFKGlwCLwRV8kBWH095wFzDA=;
        b=PFU3x5d69rP901INSkVZhw6MZpiywYqcm4ubkSfoH0iU2X1hYnUvOLXvvN53jqegIE
         sRiU/RFacNqLPEW9It0TxMWZgi+Vqot63IlKPQIuIw/cLNyqIarWsXd0zk10eh5RCjg8
         SLgWKMuWq8BlQmoXtjWcckF8RT8Emo+73/GFzt+8UrgY35Z6yvzQ7a7zG7YldcIhpo5C
         mFIea16kyh8fzVdBpIKV8d5uCRRnkXd8LMn+fiV5N6dyerp1/LMkh+rlKnJkLljcoMKF
         0I2r8OEXmAeOrOFRzjtZgiIvDF+3ct3Cc6IDzUfO3YyTdka9w/lLysuCtQbikpV7cjOM
         jnZg==
X-Forwarded-Encrypted: i=1; AKwUvByz9Fo80DmcLUiF5dh2OYwGPmhAnod0yJI5coh7Omrze177sPEYdcSOQzQw9BL8lEMCrYA=@vger.kernel.org
X-Gm-Message-State: AFuF++mvA39et4bbkP0fQAgbAMggPntlEqK5M9n1f3N35sFOcNZwR19h
	Ecwq46juI7l34D0dgEjGboloweBnJIZRoYjrR9YFkC5fhBUSei4FqdMnoIva6BbMWdIsHNv1AiD
	CdnXgbpg950JKP4+Q/HiD7TwwoOHKDds=
X-Gm-Gg: AYBFou18wcFyjZroEbaPAbRZtqe+pXb6KHzxBxuEormj8HDssSWIZc3uoGOAJu5+Cn4
	C949hqE9jGFpVOF+0jHFakgaeT+aSviQt1xvLI07uP+BTUR5mRQhAuaAqtNasdPHdoUi+KSgJMc
	RRPi/0BtQSMC4PSkHa7Y3QtEe9S6DFiO8iiYrZmgQNOr77+HewRU+eY9gouiejMOw6jPwWuCHFa
	vvpKAyQTFnQ9lFMMybPfvtVK8qdmJKVzgC0AyHZXFI5bpKjPseUeQD7OqQNPsX2gqJg05GKbyRo
	xVuk0m9E4NZobhySR2wILjKKiQVXvuQluAIQpUec3bud6FKpDpxqi7G8rUI33xyO0z28iABcKjc
	TrcvnCgQTq+ghQF1FTcPHIPdH1dhYPF/o/05uMAgwXA2gLB8=
X-Received: by 2002:a17:90b:384e:b0:39e:6c6a:4b79 with SMTP id
 98e67ed59e1d1-3a07e71edddmr3282813a91.67.1790182763374; Wed, 23 Sep 2026
 09:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922200208.3203834-1-puranjay@kernel.org> <CAEf4BzaifaWk+oHu-berWcKuS6Y5WfkcFTKZW-iMCPxG0=5i0w@mail.gmail.com>
 <CANk7y0g8Mh-je_o_nyXQ3zsGVeAsz2qMfgDtv4j-MXhAJ7PcMA@mail.gmail.com>
 <DLMNTHW945RO.TLPGJHZRWHUY@gmail.com> <CAEf4BzaR=oQz13GVxM+DjLkyjCjFmETvj9=bAuccLNKCXHJPaw@mail.gmail.com>
 <DLMUP8JM4L3U.1A9R0QUFFIQV9@gmail.com>
In-Reply-To: <DLMUP8JM4L3U.1A9R0QUFFIQV9@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Sep 2026 09:59:10 -0700
X-Gm-Features: AcwNN1XkieR63ESkFYu00SSuhZwXy-1HyU4HvCrhz9c9cjVo_EhV2eDt2QbBorI
Message-ID: <CAEf4BzYvSXNKu2qtBHEvmFg8sm3yJS_2xRUmuQhfjfx79VfgNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/4] bpf: Add bpf_call_rcu() and bpf_call_rcu_tasks_trace()
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, bpf@vger.kernel.org, rcu@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 9:53=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed Sep 23, 2026 at 6:45 PM CEST, Andrii Nakryiko wrote:
> > On Wed, Sep 23, 2026 at 4:29=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >>
> >> On Wed Sep 23, 2026 at 12:37 PM CEST, Puranjay Mohan wrote:
> >> > On Wed, Sep 23, 2026 at 12:41=E2=80=AFAM Andrii Nakryiko
> >> > <andrii.nakryiko@gmail.com> wrote:
> >> >>
> >> >> On Tue, Sep 22, 2026 at 1:02=E2=80=AFPM Puranjay Mohan <puranjay@ke=
rnel.org> wrote:
> >> >> >
> >> >> > Changelog:
> >> >> > v5: https://lore.kernel.org/all/20260921191407.1742386-1-puranjay=
@kernel.org/
> >> >> > Changes in v6:
> >> >> > - Size struct bpf_rcu_head at 48 bytes rather than 64, matching w=
hat the
> >> >> >   inline state uses (Alexei)
> >> >> > - Trim patch 1's changelog: drop the reasoning about possible fut=
ure
> >> >> >   layouts and about what the other async kfuncs return
> >> >> > - Rebase on bpf-next/master
> >> >> >
> >> >> > v4: https://lore.kernel.org/all/20260915154248.3612028-1-puranjay=
@kernel.org/
> >> >> > Changes in v5:
> >> >> > - Rename the "hash_map" subtest to "bad_map" so that it matches i=
ts
> >> >> >   helper test_call_rcu_bad_map() (bpf-ci)
> >> >> > - Bump the callback counter after chain_err in the selftest callb=
ack.
> >> >> >   Userspace polls that counter and then reads chain_err, so it co=
uld
> >> >> >   still see the initial value before the re-arm had stored one, w=
hich
> >> >> >   let the chain subtest's assertion pass without checking anythin=
g
> >> >> > - Say in patch 1 why embedding struct rcu_head in a uapi struct i=
s
> >> >> >   acceptable here (Mykyta, Paul, Alexei)
> >> >> > - Rebase on bpf-next/master
> >> >> > v3: https://lore.kernel.org/all/20260915143640.36292-1-puranjay@k=
ernel.org/
> >> >> > Changes in v4:
> >> >> > - Drop an unrelated hunk in bpf_async_update_prog_callback() that=
 turned
> >> >> >   PTR_ERR(prog) into -EBADF.  That is the shared bpf_timer/bpf_wq=
 path
> >> >> >   and bpf_prog_inc_not_zero() returns -ENOENT, so it would have c=
hanged
> >> >> >   the errno bpf_timer_set_callback() and bpf_wq_set_callback() re=
port to
> >> >> >   userspace (Sashiko).  No other changes from v3
> >> >> > v2: https://lore.kernel.org/all/20260915114240.3269184-1-puranjay=
@kernel.org/
> >> >> > Changes in v3:
> >> >> > - Move the bpf_call_rcu_tasks_trace() verifier bits from patch 1 =
to
> >> >> >   patch 3; patch 1 alone emitted "resolve_btfids: unresolved symb=
ol
> >> >> >   bpf_call_rcu_tasks_trace" (Sashiko)
> >> >> > - Poll the callback counter with an acquire load (Sashiko)
> >> >> > - teardown: v2 only checked that the program was eventually freed=
, which
> >> >> >   passes even if nothing was ever armed.  Also assert that the ch=
ain ran,
> >> >> >   and read the -EPERM back through an independent .bss fd
> >> >> > - Use kern_sync_rcu() instead of open coding the grace-period wai=
t
> >> >> > - Return -EBADF rather than -ENOENT when the calling program is g=
oing
> >> >> >   away, matching bpf_task_work_schedule()
> >> >> > - mismatch_map now pins the bpf_rcu_head label the new code emits=
; it
> >> >> >   passed with that branch removed.  Add a two_heads test, and wai=
t for
> >> >> >   each grace period separately in the chain test
> >> >> > - Commit messages: correct the -EPERM parity claim, explain the i=
nline
> >> >> >   callback state and the struct size, motivate the tasks trace fl=
avour
> >> >> > v1: https://lore.kernel.org/all/20260907134552.1772405-1-puranjay=
@kernel.org/
> >> >> > Changes in v2:
> >> >> > - Rebase on bpf-next/master
> >> >> > - Use rcu_read_lock_dont_migrate() over open coding (Alexei)
> >> >> > - Improve re-arming selftest to detect failure (Sashiko)
> >> >> >
> >> >> > BPF programs that manage their own objects have no way to run the=
ir own
> >> >> > logic once an RCU grace period has elapsed.  bpf_obj_drop() defer=
s a
> >> >> > free, but returning an index to an allocator or unpinning a resou=
rce
> >> >> > once readers are done has no equivalent.  sched_ext's BPF library=
 works
> >> >> > around this today by pushing freed nodes onto a list and having a
> >> >> > userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then =
run a
> >> >> > BPF program to reclaim them; it is the first intended user.
> >> >> >
> >> >> > Add:
> >> >> >
> >> >> >         int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
> >> >> >                          int (*callback)(struct bpf_map *map, voi=
d *key,
> >> >> >                                          void *value));
> >> >> >
> >> >> > and bpf_call_rcu_tasks_trace(), same signature, which also waits =
for
> >> >> > sleepable programs.
> >> >> >
> >> >> > @rh is a struct bpf_rcu_head embedded in a value of @map, so the
> >> >> > callback runs as callback(map, key, value) for the element it liv=
es in
> >> >> > and needs no cookie.  The field is only accepted in BPF_MAP_TYPE_=
ARRAY,
> >> >>
> >> >> Isn't restricting this to BPF_MAP_TYPE_ARRAY unnecessarily restrict=
ive
> >> >> in practice? Do other APIs of similar kind have this limitation? E.=
g.,
> >> >> bpf_task_work_schedule() or timer, I don't think they limit user to
> >> >> just ARRAY maps, it's way too inflexible.
> >> >
> >> > Right, bpf_timer and bpf_task_work take HASH/LRU_HASH/ARRAY. They ca=
n
> >> > because they can cancel: on element delete bpf_obj_free_fields() cal=
ls
> >>
> >> bpf_obj_cancel_fields(). bpf_obj_free_fields() is no longer called exc=
ept when
> >> the object is being freed finally.
> >>
> >> > bpf_task_work_cancel_and_free(), which reaches task_work_cancel(), s=
o
> >> > a pending callback never runs against a recycled element.
> >> > A queued RCU callback cannot be cancelled. rcu_barrier() is the only
> >> > thing that waits for one, and it sleeps, so it is not callable from =
an
> >> > element delete. Array elements are never freed individually, which i=
s
> >> > what makes it safe.
> >>
> >> If cancel is a noop, can you not simply skip it on map update?
> >>
> >> It is a bit unfortunate we can't provide cancel semantics, it will be =
yet
> >> another divergence from how all other async callbacks work...sigh.
> >>
> >> >
> >> > I can think of a complicated way to support hash maps but that would
> >> > need making the state dynamically allocated and finding a way to
> >> > cancel the callbacks. But I would do it as a follow-up if there is a
> >> > real use case.
> >>
> >> That would mean allocation and frees, it is already quite expensive as=
 is for a
> >> call_rcu() primitive (with the refcount bumps and atomics).
> >
> > maybe so, but as is ARRAY is a severe limitation and makes a lot of
> > cases either unusable or requiring extra sequential ID allocation
> > logic to remap some HASH map entry to index in an ARRAY map, just so
> > you can call rcu callback for a given kernel object stored in HASH
> > map.
> >
> > E.g., think about keep as set of sockets, or tasks, or whatnot in HASH
> > or RHASHTABLE (especially the latter one with support for resizing).
> > How would you do bpf_call_rcu() for them with unduly complications,
> > limitations and a lot of waste (unlike HASH you can't have lazy memory
> > allocation).
>
> Yeah, I don't disagree. We would also need to support storing them in mor=
e map
> types to make it woth with arenas (which was one of the motivations for t=
he
> feature).
>
> Perhaps it is better to make cancel a noop / unsupported and skip it when=
 a map
> element is deleted. That will be the easiest path to enabling it, but it =
does
> create (perhaps surprising) divergence from some of the other async callb=
ack
> primitives.

I don't see much need for cancellation, but a more useful/sane
behavior would be rearming on subsequent calls to bpf_call_rcu(). This
would also handle update/delete/reuse of entries. Not sure how hard it
is to support that in kernel's call_rcu() implementation, though, but
that would solve the problem, because it should always be OK to delay
call_rcu() callback, but not the other way around (which is what would
happen today because we will ignore subsequent bpf_call_rcu() calls).

>
> That said, I do think performance should be a consideration for this API;=
 maybe
> unlike other ones, I would expect that this could be called very frequent=
ly. I

I'm not sure why this has to be super high frequency API to use, tbh.
You'd normally use this when cleaning up when some kernel object is
freed, no? Sure that can be relatively frequent, but not to the point
where we should be *that* concerned with refcount or atomics overhead
per se (multi-cpu cache bouncing of refcounting is a concern, but not
sure what you can do about that).

> had concerns about prog refcount increment as well, but didn't really bri=
ng it
> up since it is something that can be addressed after the fact (maybe usin=
g pcpu
> refs). But once we promise supporting cancellation, it is hard to walk th=
at
> back. I think it's less of a concern for other async cb types. In practic=
e,
> except to support map semantics I don't know if anyone will use cancellat=
ion API
> either, the kernel side never grew such support.
>
> Anyway, overall the best path to me seems to be just enabling it as is an=
d

you mean enabling for HASH or keeping it for ARRAY only? If the
latter, my concern is that to support HASH we might need to change the
internal structure and break that 48-byte size, so we should probably
decide all this before we get this into the next Linux release.

> declaring bpf_obj_cancel_fields() on this noop. Existing synchronization =
should
> be enough to ensure callback stops getting issued once element is finally=
 freed
> back to kernel allocator.

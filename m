Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A48D3F86FB
	for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181943; cv=pass; b=KHr2NdJyzJ8uBWDI71yBKkeOnqSkub9APR/L9kVW4J0khlO5i0C8M0vt5L+Klw+pDbkBTB8B4dAPrItGFbjCuJGHPlXSthhkktQHAqAo7IlaN7L5TRnbMa1oQtUoLOuJXGXns3MneRux8aC3Ns7dMzlZdfKDHXCIBl5tPjwCkEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181943; c=relaxed/simple;
	bh=L+2zMzhb4tUlolCxg1C+yPPPYo1Gf6UujqbLr0kkEvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFznKc+nSqnc2mSod1f75x+6RH7fkwCms+t7nD7/rBFGpjmf20V4xq6HkK/DES+OumhvNvuPcPOrM6Nas7M7cmmFHBNVZFFdahL/g4bg47cE8FKd60lOwxV93C8b8TowHM73bt134UJnokmBSOlQ70vAG5ve+ZtD27RDhyi8s6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUKJdEUN; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUKJdEUN"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd4b43b20bso6085595ad.1
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 09:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790181937; cv=none;
        d=google.com; s=arc-20260327;
        b=j3ovSqOshuzAiMGDQw2hFu52eOyXgQEfa56C/uRdL0VzHvZAYemwXoMxOgESiEI1yr
         L6lZgI1ewewVWPEZJILdRJJ8nfUdroz0YTUkaxYzPXs3rDtoAXX+F/zqWwB+/51yZD7r
         A/CHGX9bp/C6dt2YRhR/Fyflm7zIUxyGyQSVJzA5TnKon6YN2Jy5EQFzNg867pfLbBV9
         eKOU7AOZO5aIxDHGVT1aOz0KGtgVx2ZeTZbdAGMJrfk7hv+Pdn9HgQTDhQknl/Gh6xV3
         sp/nnfR9oJDKje9CZ8fVA4cokPK1lqucyputmw5/NJFZW484eIgW7aWGtoXW4+yF9lR9
         oGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DSvCVSKVXY3Gl0Ib6FP+dcF6QEzuyebpmVGiNdTMdsM=;
        fh=/LSEPzilYxVSV2vM1VFzRXCvzcHuAKkQcn7rNsaLpH4=;
        b=ps8hgfw00ejbXFR9PuUelDPQ4vITRZpHbkxy3pBk6E35tbkFWKLpsBWva2kwwFL3Vx
         bwnVBjTuSjGTnhbqpTyCc8esnRsICyRjCbaYa5wK0uxyKnjusDufL+xb164uM+LTrQtP
         sASqDWfkxkObDbjmC3exhAqUX1fpZCEyjTSZsh1qLveS/Zs/hYCWT+LQBOI8MDGeJ72a
         ncg2caUzuVdS23Xqq2zCu/uyaYwADXpxYHq5f2f+TpwSLcGyHxpNIHCjieqeFmisC5/j
         DxDFwgGr9sSAvKcuPYgo3fsS9fAmRxli7j48GqDlE3m4+BbI5g1cPfYRWfZSW7XSfE2G
         xPqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790181937; x=1790786737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DSvCVSKVXY3Gl0Ib6FP+dcF6QEzuyebpmVGiNdTMdsM=;
        b=cUKJdEUNeg4p1mGNGK4fJREXWeb+WfSrTrXrpSGs3jE1nuve5qw9vM7LCGbwaotyGR
         58oJ3LDAM1l7hMwknjzB32yCNi+HXKvhWvkTdnyAJl6xMu5ZIluuozUeN2rbeKuhY3Bj
         mWTgDUW0NXN7oZgxLnYMaGBhefEh9MVUsuzjznsb93SIu8vxS5ec4qNzRX65QlZDOLu+
         9RUCVGm6dYpVzvcVmVCS9eEnB0daL7scMbCcY5KPHm6iJ/onLl3kDZ7e6idvLxztKogo
         OiClUXcSEvydH1s4KtnR0oqrzibbPdnTHw1c61UQeKZJGAa9LXFPopGrGtgFG+6Pwi6i
         4icA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181937; x=1790786737;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DSvCVSKVXY3Gl0Ib6FP+dcF6QEzuyebpmVGiNdTMdsM=;
        b=1Hj5ada9wL9jubGIaDN6ES601Ti0QVISvEOZ+yXBxxZNqpJuiqCAqVV3gekho2hJKf
         EQdwD3KXRNl83vEhAJgTZYjMgM495Gk0uG6DejAt7T5tYozCDbiEhaGOUHwXrcIsktBe
         g1Qix/DYKQMTCB7Hh63GCt5ej5OQgvTEC04yG2cAaSsjRohHwEDB9eeVR4JFCYCMZpP/
         LCMVDD6xUmZ9Bei4s6IO7cIqYSXC1/F+1tPrhgzJDnfrxxO2a+I8GOjYUJoPdqm3keok
         etiJIqfMNFmCHUmFfuPe3n3EL54+wc0C6oU/reibg3nFk/L7SGr+7cDAqustquRKlCdU
         If1A==
X-Forwarded-Encrypted: i=1; AKwUvBwS7LJ/yyV0tBxU87T10FXTDPNzxZrrj7CHXHDURY+CCY8clDX7BO+NOu4XANdKFsg5GdA=@vger.kernel.org
X-Gm-Message-State: AFuF++kAtqRcwH1n8e+RE5He3gQ+xXZuvp6XLT66QhE1BK0H4XCjvn82
	vf3uH23SCEyLw/zGNzRUcT22gUx7vIbNLgpanRwDSgdmLbigTp1FajBsbKuzOTa2bAsPZNA7nu0
	8agfyafOVlvMxB2Ru5L+9TG4+cC0N/oc=
X-Gm-Gg: AYBFou0WBRjbZ0RORKNo8HdaWHwfZvqnPaNfdryDQ+11kcO3hi3/lnP59WVgZcsIkaV
	l2JXUiAUd4D9p1Jxd4/OtdCQO0KiCQ4A3JakEBVPzpnvCpHnMM3JTaWzMSgtgfMSnAL/sjrvqW0
	B6PqeVxeGBuE03bSVnJszM8w/SSDdsZWQS8dDnLSGNw+uwac1m9NZrorJRfmzOcLavR052dN+ge
	MXWwxOWnHGc0Pv42SpATOQV+shV9mBuzUCRvzhiY8fzhlhwOxukYxxIgC+vxBukV2jgnWr4D5xg
	FJpz/QG+ZVLtyb5feoKH9vJmijj+KBOlGQogWAzTAOvnxwVgI4sqY1BbNWjaeBm7xl0sdP5yECg
	CZP82N70X9iKv/KE4MFUturXRLQSYGiIjy78I
X-Received: by 2002:a17:90b:4d0d:b0:39e:6c69:f47e with SMTP id
 98e67ed59e1d1-3a07e780406mr2692598a91.61.1790181936352; Wed, 23 Sep 2026
 09:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922200208.3203834-1-puranjay@kernel.org> <CAEf4BzaifaWk+oHu-berWcKuS6Y5WfkcFTKZW-iMCPxG0=5i0w@mail.gmail.com>
 <CANk7y0g8Mh-je_o_nyXQ3zsGVeAsz2qMfgDtv4j-MXhAJ7PcMA@mail.gmail.com> <DLMNTHW945RO.TLPGJHZRWHUY@gmail.com>
In-Reply-To: <DLMNTHW945RO.TLPGJHZRWHUY@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Sep 2026 09:45:24 -0700
X-Gm-Features: AcwNN1VI6k8tyBvNuMGIlSIV8i1zr8Kw0m2loWKMO_BouDh9dLnKWsi762pvE3w
Message-ID: <CAEf4BzaR=oQz13GVxM+DjLkyjCjFmETvj9=bAuccLNKCXHJPaw@mail.gmail.com>
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

On Wed, Sep 23, 2026 at 4:29=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed Sep 23, 2026 at 12:37 PM CEST, Puranjay Mohan wrote:
> > On Wed, Sep 23, 2026 at 12:41=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Tue, Sep 22, 2026 at 1:02=E2=80=AFPM Puranjay Mohan <puranjay@kerne=
l.org> wrote:
> >> >
> >> > Changelog:
> >> > v5: https://lore.kernel.org/all/20260921191407.1742386-1-puranjay@ke=
rnel.org/
> >> > Changes in v6:
> >> > - Size struct bpf_rcu_head at 48 bytes rather than 64, matching what=
 the
> >> >   inline state uses (Alexei)
> >> > - Trim patch 1's changelog: drop the reasoning about possible future
> >> >   layouts and about what the other async kfuncs return
> >> > - Rebase on bpf-next/master
> >> >
> >> > v4: https://lore.kernel.org/all/20260915154248.3612028-1-puranjay@ke=
rnel.org/
> >> > Changes in v5:
> >> > - Rename the "hash_map" subtest to "bad_map" so that it matches its
> >> >   helper test_call_rcu_bad_map() (bpf-ci)
> >> > - Bump the callback counter after chain_err in the selftest callback=
.
> >> >   Userspace polls that counter and then reads chain_err, so it could
> >> >   still see the initial value before the re-arm had stored one, whic=
h
> >> >   let the chain subtest's assertion pass without checking anything
> >> > - Say in patch 1 why embedding struct rcu_head in a uapi struct is
> >> >   acceptable here (Mykyta, Paul, Alexei)
> >> > - Rebase on bpf-next/master
> >> > v3: https://lore.kernel.org/all/20260915143640.36292-1-puranjay@kern=
el.org/
> >> > Changes in v4:
> >> > - Drop an unrelated hunk in bpf_async_update_prog_callback() that tu=
rned
> >> >   PTR_ERR(prog) into -EBADF.  That is the shared bpf_timer/bpf_wq pa=
th
> >> >   and bpf_prog_inc_not_zero() returns -ENOENT, so it would have chan=
ged
> >> >   the errno bpf_timer_set_callback() and bpf_wq_set_callback() repor=
t to
> >> >   userspace (Sashiko).  No other changes from v3
> >> > v2: https://lore.kernel.org/all/20260915114240.3269184-1-puranjay@ke=
rnel.org/
> >> > Changes in v3:
> >> > - Move the bpf_call_rcu_tasks_trace() verifier bits from patch 1 to
> >> >   patch 3; patch 1 alone emitted "resolve_btfids: unresolved symbol
> >> >   bpf_call_rcu_tasks_trace" (Sashiko)
> >> > - Poll the callback counter with an acquire load (Sashiko)
> >> > - teardown: v2 only checked that the program was eventually freed, w=
hich
> >> >   passes even if nothing was ever armed.  Also assert that the chain=
 ran,
> >> >   and read the -EPERM back through an independent .bss fd
> >> > - Use kern_sync_rcu() instead of open coding the grace-period wait
> >> > - Return -EBADF rather than -ENOENT when the calling program is goin=
g
> >> >   away, matching bpf_task_work_schedule()
> >> > - mismatch_map now pins the bpf_rcu_head label the new code emits; i=
t
> >> >   passed with that branch removed.  Add a two_heads test, and wait f=
or
> >> >   each grace period separately in the chain test
> >> > - Commit messages: correct the -EPERM parity claim, explain the inli=
ne
> >> >   callback state and the struct size, motivate the tasks trace flavo=
ur
> >> > v1: https://lore.kernel.org/all/20260907134552.1772405-1-puranjay@ke=
rnel.org/
> >> > Changes in v2:
> >> > - Rebase on bpf-next/master
> >> > - Use rcu_read_lock_dont_migrate() over open coding (Alexei)
> >> > - Improve re-arming selftest to detect failure (Sashiko)
> >> >
> >> > BPF programs that manage their own objects have no way to run their =
own
> >> > logic once an RCU grace period has elapsed.  bpf_obj_drop() defers a
> >> > free, but returning an index to an allocator or unpinning a resource
> >> > once readers are done has no equivalent.  sched_ext's BPF library wo=
rks
> >> > around this today by pushing freed nodes onto a list and having a
> >> > userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then run=
 a
> >> > BPF program to reclaim them; it is the first intended user.
> >> >
> >> > Add:
> >> >
> >> >         int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
> >> >                          int (*callback)(struct bpf_map *map, void *=
key,
> >> >                                          void *value));
> >> >
> >> > and bpf_call_rcu_tasks_trace(), same signature, which also waits for
> >> > sleepable programs.
> >> >
> >> > @rh is a struct bpf_rcu_head embedded in a value of @map, so the
> >> > callback runs as callback(map, key, value) for the element it lives =
in
> >> > and needs no cookie.  The field is only accepted in BPF_MAP_TYPE_ARR=
AY,
> >>
> >> Isn't restricting this to BPF_MAP_TYPE_ARRAY unnecessarily restrictive
> >> in practice? Do other APIs of similar kind have this limitation? E.g.,
> >> bpf_task_work_schedule() or timer, I don't think they limit user to
> >> just ARRAY maps, it's way too inflexible.
> >
> > Right, bpf_timer and bpf_task_work take HASH/LRU_HASH/ARRAY. They can
> > because they can cancel: on element delete bpf_obj_free_fields() calls
>
> bpf_obj_cancel_fields(). bpf_obj_free_fields() is no longer called except=
 when
> the object is being freed finally.
>
> > bpf_task_work_cancel_and_free(), which reaches task_work_cancel(), so
> > a pending callback never runs against a recycled element.
> > A queued RCU callback cannot be cancelled. rcu_barrier() is the only
> > thing that waits for one, and it sleeps, so it is not callable from an
> > element delete. Array elements are never freed individually, which is
> > what makes it safe.
>
> If cancel is a noop, can you not simply skip it on map update?
>
> It is a bit unfortunate we can't provide cancel semantics, it will be yet
> another divergence from how all other async callbacks work...sigh.
>
> >
> > I can think of a complicated way to support hash maps but that would
> > need making the state dynamically allocated and finding a way to
> > cancel the callbacks. But I would do it as a follow-up if there is a
> > real use case.
>
> That would mean allocation and frees, it is already quite expensive as is=
 for a
> call_rcu() primitive (with the refcount bumps and atomics).

maybe so, but as is ARRAY is a severe limitation and makes a lot of
cases either unusable or requiring extra sequential ID allocation
logic to remap some HASH map entry to index in an ARRAY map, just so
you can call rcu callback for a given kernel object stored in HASH
map.

E.g., think about keep as set of sockets, or tasks, or whatnot in HASH
or RHASHTABLE (especially the latter one with support for resizing).
How would you do bpf_call_rcu() for them with unduly complications,
limitations and a lot of waste (unlike HASH you can't have lazy memory
allocation).

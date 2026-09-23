Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB049EC6C
	for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790163004; cv=none; b=hWv6u5UAlC/7jsymcAcmOLSFTnwZsESyi192JjuNRSFmmth/Gmcm6qBf3D5KLBQ+PnJ4jsI0VRosBxxOj71p1YGZhu2/iwSv39vy9wZlb8XTC+g82bFvfzV6xOB6uvDCfFovc555w3p39Y230NwSnMp2eqK9uyRvoHiSot4SjSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790163004; c=relaxed/simple;
	bh=opWqWSXnGRjYbUf5OxwbuCPUUj3bvnft5t6/JcjWp8k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=kslVipJpyBBc4ZLmjIrSgxcVwvYVZ49TikSL4CN5VmoEOFdEZtjVP+Yqhhy9bTqh3VGNpllQCJ9Qipb2yjeL3bZdkXi9IQO8YiL8uiSsTi8MYU6UAcRHR2DzG9svZ9/0MiI5euh0u3kbjzUKnLI2MWQFm//zQo0pusvlguAKVMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKwmrzHO; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKwmrzHO"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484372811e5so165418f8f.0
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 04:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790162995; x=1790767795; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5TJi5pYYgXT5a+4BNFFHNYyeAaTkJJY7o8Za71zVW8k=;
        b=YKwmrzHOa8Jv1ydKrAvZTY/oA2BVptcvSs0NzieSMnhhSzRPBP3itghlC8DdbNmo6y
         TsHMHp13WPapCmW7KMnsR9Pw8FB6cd+STLcdgRrzLFOC1iVUTgXscIN9qg7Yl5MciA/B
         sApYddJeG2H3s4FoSWlCv11oYR+6NsKLzhOzoLakNt9T8HtrmhmLrT7+IMIG6ayTHUNp
         eK/SvtScLuH0Di4ocfk1qIKyZD5HXjGV3m+TBXzJnh767dn/7kiQc7XdMTDa59rHNh7x
         syspQfzoKMflix+pJmkJDBzzIrw2fv3Q/GZP+lxElsImzmJmTQasZHWrLtuC5A1ZkKIW
         LxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790162995; x=1790767795;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5TJi5pYYgXT5a+4BNFFHNYyeAaTkJJY7o8Za71zVW8k=;
        b=QYbFBTNZQD1JPLmDbMf+4uRjRXOCTO1c2cSwo3grQVsSeSggkJcXFtRWtm+P8nE0To
         Zag4vPGX2ulvX936YdQfutO6a4qh+o96tF1zdFyRdrBYWEbpIgfkcg1KiUQBfZXDiLF4
         L+T587p/uKqHTW1QGRahRozyZ0UY+F4f4T3s0Dqceq5faPi5YwD8H7glxPAN9jL9LZrV
         9J1fFZLKOT2hCwzoHLmr7jTgXuyFrJIBU8uUw03It9+7Ysuz3ajcMVAvhs8bLgAFSmrn
         28dTSUL6ifc7Hv9T4a9VCT1r5PGFSjtWHFZwiWLyqo7RIXg0yc/a94ANpAID6QSilakJ
         lppg==
X-Forwarded-Encrypted: i=1; AKwUvByZ6QG8OmYBQGsStMU7sM4ILY9KGhKHZbJKBeFfdMJWT32J47pO8Velr6rtxdqqiPY4YmA=@vger.kernel.org
X-Gm-Message-State: AFuF++nWkhC+B903zSDoFfxrgSDakhR6tIpnl3l7DB49sfmDDrlxzrZe
	2svUkOkvjLBq6tN3HPzgl4k6jKO/NYl3xU2FfWv3ewrtKkFthM3Zyy1+
X-Gm-Gg: AYBFou3YelLwOsh58lak0CXlhGq0vOIMzenWS3Rdty+8+FAi7o9/VKKo1lSUtgTAEwD
	ULcKP0igH2Wq6ip0y9PU02sp6pCZjaegIHuk/Yfmhs14W0l24qLU7klL/PMaNmF19Suz5Dwen+d
	q1vdH3SmJ2g7Opt9W0wE8uFFV6gmc0A0BpGJ15VTVjKnWeUn2z8FY0LZ/I664De8wkTFuZB/aaz
	wvFT0dMZQC8FUhJPri9kco+iG2l27KHQZv7nbs7CgyD+vQCHx6TAc2YPSUCM3RMyDziLXb+QEgz
	H4MIpVm4+csB1f/nrmjnRJtWW5zR4ezzJpGBKjZ9afPyhdT3jxKnHHa1fXh55bho0gf6QREuL9I
	c+K9m2yjyIG9MRHQgmSRLW2Muwbx08o4OdHURDIPfNJL17D3DZUXQF75ENxNMZjen6c2YsDqF4n
	rGlcVnonJN6DcmNcR7+q/eLHO8r4IWV8PemS4PHsqNIRwYIR4ub2324/NHABfJQv92ZyEcL3/zr
	PhstmzQ/rLzPEj/S4cORnQuL2ykmEfJGZGI5VWce2vq4DvyfYusk8Qupw1REmrxygKD9z/065av
	jIA+IVw0T69DtTMS8AS/ByULd94SlpdOoOZh8LJxdZd5iq3N
X-Received: by 2002:a05:6000:1886:b0:487:172:6293 with SMTP id ffacd0b85a97d-48867060a67mr3901721f8f.3.1790162994662;
        Wed, 23 Sep 2026 04:29:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c119sm6797699f8f.15.2026.09.23.04.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 04:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 13:29:53 +0200
Message-Id: <DLMNTHW945RO.TLPGJHZRWHUY@gmail.com>
Subject: Re: [PATCH bpf-next v6 0/4] bpf: Add bpf_call_rcu() and
 bpf_call_rcu_tasks_trace()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Puranjay Mohan" <puranjay12@gmail.com>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>
Cc: <bpf@vger.kernel.org>, <rcu@vger.kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Harry Yoo (Oracle)"
 <harry@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260922200208.3203834-1-puranjay@kernel.org>
 <CAEf4BzaifaWk+oHu-berWcKuS6Y5WfkcFTKZW-iMCPxG0=5i0w@mail.gmail.com>
 <CANk7y0g8Mh-je_o_nyXQ3zsGVeAsz2qMfgDtv4j-MXhAJ7PcMA@mail.gmail.com>
In-Reply-To: <CANk7y0g8Mh-je_o_nyXQ3zsGVeAsz2qMfgDtv4j-MXhAJ7PcMA@mail.gmail.com>

On Wed Sep 23, 2026 at 12:37 PM CEST, Puranjay Mohan wrote:
> On Wed, Sep 23, 2026 at 12:41=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Tue, Sep 22, 2026 at 1:02=E2=80=AFPM Puranjay Mohan <puranjay@kernel.=
org> wrote:
>> >
>> > Changelog:
>> > v5: https://lore.kernel.org/all/20260921191407.1742386-1-puranjay@kern=
el.org/
>> > Changes in v6:
>> > - Size struct bpf_rcu_head at 48 bytes rather than 64, matching what t=
he
>> >   inline state uses (Alexei)
>> > - Trim patch 1's changelog: drop the reasoning about possible future
>> >   layouts and about what the other async kfuncs return
>> > - Rebase on bpf-next/master
>> >
>> > v4: https://lore.kernel.org/all/20260915154248.3612028-1-puranjay@kern=
el.org/
>> > Changes in v5:
>> > - Rename the "hash_map" subtest to "bad_map" so that it matches its
>> >   helper test_call_rcu_bad_map() (bpf-ci)
>> > - Bump the callback counter after chain_err in the selftest callback.
>> >   Userspace polls that counter and then reads chain_err, so it could
>> >   still see the initial value before the re-arm had stored one, which
>> >   let the chain subtest's assertion pass without checking anything
>> > - Say in patch 1 why embedding struct rcu_head in a uapi struct is
>> >   acceptable here (Mykyta, Paul, Alexei)
>> > - Rebase on bpf-next/master
>> > v3: https://lore.kernel.org/all/20260915143640.36292-1-puranjay@kernel=
.org/
>> > Changes in v4:
>> > - Drop an unrelated hunk in bpf_async_update_prog_callback() that turn=
ed
>> >   PTR_ERR(prog) into -EBADF.  That is the shared bpf_timer/bpf_wq path
>> >   and bpf_prog_inc_not_zero() returns -ENOENT, so it would have change=
d
>> >   the errno bpf_timer_set_callback() and bpf_wq_set_callback() report =
to
>> >   userspace (Sashiko).  No other changes from v3
>> > v2: https://lore.kernel.org/all/20260915114240.3269184-1-puranjay@kern=
el.org/
>> > Changes in v3:
>> > - Move the bpf_call_rcu_tasks_trace() verifier bits from patch 1 to
>> >   patch 3; patch 1 alone emitted "resolve_btfids: unresolved symbol
>> >   bpf_call_rcu_tasks_trace" (Sashiko)
>> > - Poll the callback counter with an acquire load (Sashiko)
>> > - teardown: v2 only checked that the program was eventually freed, whi=
ch
>> >   passes even if nothing was ever armed.  Also assert that the chain r=
an,
>> >   and read the -EPERM back through an independent .bss fd
>> > - Use kern_sync_rcu() instead of open coding the grace-period wait
>> > - Return -EBADF rather than -ENOENT when the calling program is going
>> >   away, matching bpf_task_work_schedule()
>> > - mismatch_map now pins the bpf_rcu_head label the new code emits; it
>> >   passed with that branch removed.  Add a two_heads test, and wait for
>> >   each grace period separately in the chain test
>> > - Commit messages: correct the -EPERM parity claim, explain the inline
>> >   callback state and the struct size, motivate the tasks trace flavour
>> > v1: https://lore.kernel.org/all/20260907134552.1772405-1-puranjay@kern=
el.org/
>> > Changes in v2:
>> > - Rebase on bpf-next/master
>> > - Use rcu_read_lock_dont_migrate() over open coding (Alexei)
>> > - Improve re-arming selftest to detect failure (Sashiko)
>> >
>> > BPF programs that manage their own objects have no way to run their ow=
n
>> > logic once an RCU grace period has elapsed.  bpf_obj_drop() defers a
>> > free, but returning an index to an allocator or unpinning a resource
>> > once readers are done has no equivalent.  sched_ext's BPF library work=
s
>> > around this today by pushing freed nodes onto a list and having a
>> > userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then run a
>> > BPF program to reclaim them; it is the first intended user.
>> >
>> > Add:
>> >
>> >         int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
>> >                          int (*callback)(struct bpf_map *map, void *ke=
y,
>> >                                          void *value));
>> >
>> > and bpf_call_rcu_tasks_trace(), same signature, which also waits for
>> > sleepable programs.
>> >
>> > @rh is a struct bpf_rcu_head embedded in a value of @map, so the
>> > callback runs as callback(map, key, value) for the element it lives in
>> > and needs no cookie.  The field is only accepted in BPF_MAP_TYPE_ARRAY=
,
>>
>> Isn't restricting this to BPF_MAP_TYPE_ARRAY unnecessarily restrictive
>> in practice? Do other APIs of similar kind have this limitation? E.g.,
>> bpf_task_work_schedule() or timer, I don't think they limit user to
>> just ARRAY maps, it's way too inflexible.
>
> Right, bpf_timer and bpf_task_work take HASH/LRU_HASH/ARRAY. They can
> because they can cancel: on element delete bpf_obj_free_fields() calls

bpf_obj_cancel_fields(). bpf_obj_free_fields() is no longer called except w=
hen
the object is being freed finally.

> bpf_task_work_cancel_and_free(), which reaches task_work_cancel(), so
> a pending callback never runs against a recycled element.
> A queued RCU callback cannot be cancelled. rcu_barrier() is the only
> thing that waits for one, and it sleeps, so it is not callable from an
> element delete. Array elements are never freed individually, which is
> what makes it safe.

If cancel is a noop, can you not simply skip it on map update?

It is a bit unfortunate we can't provide cancel semantics, it will be yet
another divergence from how all other async callbacks work...sigh.

>
> I can think of a complicated way to support hash maps but that would
> need making the state dynamically allocated and finding a way to
> cancel the callbacks. But I would do it as a follow-up if there is a
> real use case.

That would mean allocation and frees, it is already quite expensive as is f=
or a
call_rcu() primitive (with the refcount bumps and atomics).

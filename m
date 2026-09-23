Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1AB3537FE
	for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187734; cv=pass; b=JgK+LfUqgLst00+/v9ISlCqgrr1CsWRvVWrkDg5uW6a0Ow478mLtrsoQGUzYmZ0TgNq7ZcRWD8yNo4fRUjTG6n029T0Qa2WMJQ7JVLXpWKKCjkaIcTOBgpWk6k0hE0wrZ8sx/mFFx+1jAJnBVzxSh1c+xVjg6fnoFd9AdGH/VVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187734; c=relaxed/simple;
	bh=11cawFbLLPft+PNHizAvjfbkctitjQBGRWVnhm+auiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+sf/aneS3rxa7ezGYTa2XnPZSPiFn+CP1EcZ/MddTeVpMnrEh6OqMoZNW8/oR5IkHTELiyYaM+iRgUk+wnqI5JKSgab+TqGqTS19Kwj7N9PtTzVA3DcKdN8pVOCv6U73wOqzbGBXhu8h7nbTUbA2GLkn0wyCOAXfEVxwT+ocOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzqLCzQs; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzqLCzQs"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso870370a91.3
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 11:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790187731; cv=none;
        d=google.com; s=arc-20260327;
        b=RgcW9wlw6G1qFDmaiFMHmatURnIFa5pglwEw7JQCV5aXBULVN9JKuQmy8Gki4JzVp4
         IK5fbhWc60a5imtPDlsW0FdWVVIq6b7gFeTJMYKrqS0g4g9RZ9T9upzogQYvBGMe19Rc
         pVVxUkIvi6CQXAv+HYgOMInszYvwNbP+QqAfBHqDw9Ku7MNC0NikUoCZZyL2qeNU/kBF
         mHlhoP/pPZJJ4vK/P5B12rdOEkZxMdUAlSAGsoWLOGRIaK/7wj7Pz13PMo9LFz/8ZpHT
         nXjkE6p8VwA0Lp96pBGOg2OfnN2BvHQCH+rAhm5M2++wlnsaSZaoVIVbYidRDd6xJuVk
         iyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=88+odGIjPlzutAmtwbpYGyOcBqEtWjqDDZKzco6iqS8=;
        fh=OWufzk1uTeRaAb+BnMHfMWdT/EMJf7zn+4SuF3tjwqI=;
        b=mCWENkefbIfuCN3wDH0YWoX/msu0Bo1S6ud7K30BKl/Gdu6FhFpFvM/8zMBMryHbaV
         huKgdd/35OEtOWanpbAbmc8JgRrjY2o2ZqoUL6fO0MJIORFHp4tWvk6PLLmsG3NwJbgM
         /p93EUA/8bDvCHj+fU0ZJy8u8SGRAVfy0cpVvLcmx4M22NbX7fkCiVh06YTiXlK+q0Ca
         NWE25VZ6UkscxKAyO0mjtExd67m1ssSJNFEbpeGPEcITmCuFGpwqi3Uu9zqG9XQiUo8g
         LEtorq2m+lerYS3c+RcVpL8DlKtUK55O8bTfNTRNM2Vw1RQNdFt6E8pOU/UFXFgn2RWn
         uBwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790187731; x=1790792531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=88+odGIjPlzutAmtwbpYGyOcBqEtWjqDDZKzco6iqS8=;
        b=GzqLCzQsOFRuyS72SiOPVJKL6i4AWrq1izzA0XDFPm+6KVQhWLNzJDhcPLQ5Ot7hTF
         9+DZIyHVC7djWM74oyQWj5ZE8EVv88uD3q/r43dp2aclMZkGQrrtImofUSjjLF1qGYg7
         M6ns1vj8crvivmrx87pSjTKcXSiXvZ9HXfOeHHLfyCVqS0yyqJdxDLmjj2CBUpbFY4EO
         pkap6rcltVYlOiHAC0saidvU4MZAAX3tHKtv/NEWV4Q3L+M03WtOPiu0tB43mAOcgOtJ
         GWcS2ogW/M0F3Ai2gCl63013XqI1lCERRMlkj0u+PICVKD/HmRxTDjQYQu8rgvVCsaOW
         y0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187731; x=1790792531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=88+odGIjPlzutAmtwbpYGyOcBqEtWjqDDZKzco6iqS8=;
        b=P1PXVcxn6uTWCHNohFr0FDcKFmtuuloRwg304ZDW9zw7NFn8KhsGbDn9xTUb3i1LCU
         a1QQAIIhe4eCq4nmuYzM42ZpepDE4kiUa9FZsB0oQK0T4VZ2UOSubHRLEeWF/KUfugfU
         6JJVU5+LwGPnhVl4rvcq6Z37HyQWpySC83sqiRziGAGINEshYLO30JxHSUZlV45MlWBc
         IGbDc5KHWJToo9q8roZZ8ncCwdmAGMdo5hu03IGr2Qu+ocsp/uZfjbFwBbQiy3tOeKsE
         Py6FuzTtwWyBmzDktmPnPfo1FEvix0sKNwxncAhOgUHVK8dZDDUg2kvYLre2cyLj9G1e
         Yawg==
X-Forwarded-Encrypted: i=1; AKwUvBy+F80Ctf7nwNa0erKLL4/4QV+O2So2cbpt5raHa3jc4+ck1K2XPV+V4lYU2WYn23ibsZk=@vger.kernel.org
X-Gm-Message-State: AFuF++khPoVWN4/1ERDLMrLGtrCHKKR4iCzj0fiZscLlXdsdrWpzwEng
	LHUtihqz8kXDEHctxwkTJAA1eJznICy8kvZ/8/anpcuRPNUrsQtnbKgUznIpfsMuIFBhOHkzlW9
	1E3u4beWsNfi+Jb9ggYkFPwOrHzWjERg=
X-Gm-Gg: AYBFou1kgZRvV0h5XiExvxSz1yZZ4aQT0OmfkEF30joPP2+/eG84YHgcaCX+DGfninF
	ikicxmu5y3wvdoVXvLp78wMtp/VrAuxwLmJnzZD8a3W7XzTaq55IKMG3CMszEbL77UYPzLIXgI0
	EEFGKHWGi5y+00yWfLydsSiMLOrU3BuTKbqq2L4nJpmM8up6bk6xJOywIPeqwZswDUoT49b5fPn
	p0JFTd6CQ9uno3uCgMp+dwdcZXLjh9n+E6qZSpf8wtZM/K6FPLG6amJiWO7QM0eyShFH69MEcIT
	PSKsloT1lMgjSSNw6PJ0fpz58GYMctJEBNhVSnvv8oNvQeoHnJWgvgRf/U+MFPOhFTHRADilKY9
	blQzgiWqltkHgwrqUK2eL8GECePB8aov924RZhTCXDwXR2Wg=
X-Received: by 2002:a17:90b:4a89:b0:3a0:7d88:c2ac with SMTP id
 98e67ed59e1d1-3a0986f22d8mr17415a91.18.1790187731046; Wed, 23 Sep 2026
 11:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922200208.3203834-1-puranjay@kernel.org> <CAEf4BzaifaWk+oHu-berWcKuS6Y5WfkcFTKZW-iMCPxG0=5i0w@mail.gmail.com>
 <CANk7y0g8Mh-je_o_nyXQ3zsGVeAsz2qMfgDtv4j-MXhAJ7PcMA@mail.gmail.com>
 <DLMNTHW945RO.TLPGJHZRWHUY@gmail.com> <CAEf4BzaR=oQz13GVxM+DjLkyjCjFmETvj9=bAuccLNKCXHJPaw@mail.gmail.com>
 <DLMUP8JM4L3U.1A9R0QUFFIQV9@gmail.com> <CAEf4BzYvSXNKu2qtBHEvmFg8sm3yJS_2xRUmuQhfjfx79VfgNQ@mail.gmail.com>
 <DLMW293TO3P3.3SKQ637LNLYQR@gmail.com>
In-Reply-To: <DLMW293TO3P3.3SKQ637LNLYQR@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Sep 2026 11:21:57 -0700
X-Gm-Features: AcwNN1WWNZMM5GMrE5zVY1W5c3em9FTOBOzaKWYY2BaTP7btglnF-rUPQg0_biM
Message-ID: <CAEf4BzYLZtHvD9s8N9UA-VmHUD1zKO=kQhKDvxLHHWQsFgu_cw@mail.gmail.com>
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

On Wed, Sep 23, 2026 at 10:57=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed Sep 23, 2026 at 6:59 PM CEST, Andrii Nakryiko wrote:
> > On Wed, Sep 23, 2026 at 9:53=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >>
> >> On Wed Sep 23, 2026 at 6:45 PM CEST, Andrii Nakryiko wrote:
> >> > On Wed, Sep 23, 2026 at 4:29=E2=80=AFAM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >>
> >> >> On Wed Sep 23, 2026 at 12:37 PM CEST, Puranjay Mohan wrote:
> >> >> > On Wed, Sep 23, 2026 at 12:41=E2=80=AFAM Andrii Nakryiko
> >> >> > <andrii.nakryiko@gmail.com> wrote:
> >> >> >>
> >> >> >> On Tue, Sep 22, 2026 at 1:02=E2=80=AFPM Puranjay Mohan <puranjay=
@kernel.org> wrote:
> >> >> >> >
> >> >> >> > Changelog:
> >> >> >> > v5: https://lore.kernel.org/all/20260921191407.1742386-1-puran=
jay@kernel.org/
> >> >> >> > Changes in v6:
> >> >> >> > - Size struct bpf_rcu_head at 48 bytes rather than 64, matchin=
g what the
> >> >> >> >   inline state uses (Alexei)
> >> >> >> > - Trim patch 1's changelog: drop the reasoning about possible =
future
> >> >> >> >   layouts and about what the other async kfuncs return
> >> >> >> > - Rebase on bpf-next/master
> >> >> >> >
> >> >> >> > v4: https://lore.kernel.org/all/20260915154248.3612028-1-puran=
jay@kernel.org/
> >> >> >> > Changes in v5:
> >> >> >> > - Rename the "hash_map" subtest to "bad_map" so that it matche=
s its
> >> >> >> >   helper test_call_rcu_bad_map() (bpf-ci)
> >> >> >> > - Bump the callback counter after chain_err in the selftest ca=
llback.
> >> >> >> >   Userspace polls that counter and then reads chain_err, so it=
 could
> >> >> >> >   still see the initial value before the re-arm had stored one=
, which
> >> >> >> >   let the chain subtest's assertion pass without checking anyt=
hing
> >> >> >> > - Say in patch 1 why embedding struct rcu_head in a uapi struc=
t is
> >> >> >> >   acceptable here (Mykyta, Paul, Alexei)
> >> >> >> > - Rebase on bpf-next/master
> >> >> >> > v3: https://lore.kernel.org/all/20260915143640.36292-1-puranja=
y@kernel.org/
> >> >> >> > Changes in v4:
> >> >> >> > - Drop an unrelated hunk in bpf_async_update_prog_callback() t=
hat turned
> >> >> >> >   PTR_ERR(prog) into -EBADF.  That is the shared bpf_timer/bpf=
_wq path
> >> >> >> >   and bpf_prog_inc_not_zero() returns -ENOENT, so it would hav=
e changed
> >> >> >> >   the errno bpf_timer_set_callback() and bpf_wq_set_callback()=
 report to
> >> >> >> >   userspace (Sashiko).  No other changes from v3
> >> >> >> > v2: https://lore.kernel.org/all/20260915114240.3269184-1-puran=
jay@kernel.org/
> >> >> >> > Changes in v3:
> >> >> >> > - Move the bpf_call_rcu_tasks_trace() verifier bits from patch=
 1 to
> >> >> >> >   patch 3; patch 1 alone emitted "resolve_btfids: unresolved s=
ymbol
> >> >> >> >   bpf_call_rcu_tasks_trace" (Sashiko)
> >> >> >> > - Poll the callback counter with an acquire load (Sashiko)
> >> >> >> > - teardown: v2 only checked that the program was eventually fr=
eed, which
> >> >> >> >   passes even if nothing was ever armed.  Also assert that the=
 chain ran,
> >> >> >> >   and read the -EPERM back through an independent .bss fd
> >> >> >> > - Use kern_sync_rcu() instead of open coding the grace-period =
wait
> >> >> >> > - Return -EBADF rather than -ENOENT when the calling program i=
s going
> >> >> >> >   away, matching bpf_task_work_schedule()
> >> >> >> > - mismatch_map now pins the bpf_rcu_head label the new code em=
its; it
> >> >> >> >   passed with that branch removed.  Add a two_heads test, and =
wait for
> >> >> >> >   each grace period separately in the chain test
> >> >> >> > - Commit messages: correct the -EPERM parity claim, explain th=
e inline
> >> >> >> >   callback state and the struct size, motivate the tasks trace=
 flavour
> >> >> >> > v1: https://lore.kernel.org/all/20260907134552.1772405-1-puran=
jay@kernel.org/
> >> >> >> > Changes in v2:
> >> >> >> > - Rebase on bpf-next/master
> >> >> >> > - Use rcu_read_lock_dont_migrate() over open coding (Alexei)
> >> >> >> > - Improve re-arming selftest to detect failure (Sashiko)
> >> >> >> >
> >> >> >> > BPF programs that manage their own objects have no way to run =
their own
> >> >> >> > logic once an RCU grace period has elapsed.  bpf_obj_drop() de=
fers a
> >> >> >> > free, but returning an index to an allocator or unpinning a re=
source
> >> >> >> > once readers are done has no equivalent.  sched_ext's BPF libr=
ary works
> >> >> >> > around this today by pushing freed nodes onto a list and havin=
g a
> >> >> >> > userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and th=
en run a
> >> >> >> > BPF program to reclaim them; it is the first intended user.
> >> >> >> >
> >> >> >> > Add:
> >> >> >> >
> >> >> >> >         int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
> >> >> >> >                          int (*callback)(struct bpf_map *map, =
void *key,
> >> >> >> >                                          void *value));
> >> >> >> >
> >> >> >> > and bpf_call_rcu_tasks_trace(), same signature, which also wai=
ts for
> >> >> >> > sleepable programs.
> >> >> >> >
> >> >> >> > @rh is a struct bpf_rcu_head embedded in a value of @map, so t=
he
> >> >> >> > callback runs as callback(map, key, value) for the element it =
lives in
> >> >> >> > and needs no cookie.  The field is only accepted in BPF_MAP_TY=
PE_ARRAY,
> >> >> >>
> >> >> >> Isn't restricting this to BPF_MAP_TYPE_ARRAY unnecessarily restr=
ictive
> >> >> >> in practice? Do other APIs of similar kind have this limitation?=
 E.g.,
> >> >> >> bpf_task_work_schedule() or timer, I don't think they limit user=
 to
> >> >> >> just ARRAY maps, it's way too inflexible.
> >> >> >
> >> >> > Right, bpf_timer and bpf_task_work take HASH/LRU_HASH/ARRAY. They=
 can
> >> >> > because they can cancel: on element delete bpf_obj_free_fields() =
calls
> >> >>
> >> >> bpf_obj_cancel_fields(). bpf_obj_free_fields() is no longer called =
except when
> >> >> the object is being freed finally.
> >> >>
> >> >> > bpf_task_work_cancel_and_free(), which reaches task_work_cancel()=
, so
> >> >> > a pending callback never runs against a recycled element.
> >> >> > A queued RCU callback cannot be cancelled. rcu_barrier() is the o=
nly
> >> >> > thing that waits for one, and it sleeps, so it is not callable fr=
om an
> >> >> > element delete. Array elements are never freed individually, whic=
h is
> >> >> > what makes it safe.
> >> >>
> >> >> If cancel is a noop, can you not simply skip it on map update?
> >> >>
> >> >> It is a bit unfortunate we can't provide cancel semantics, it will =
be yet
> >> >> another divergence from how all other async callbacks work...sigh.
> >> >>
> >> >> >
> >> >> > I can think of a complicated way to support hash maps but that wo=
uld
> >> >> > need making the state dynamically allocated and finding a way to
> >> >> > cancel the callbacks. But I would do it as a follow-up if there i=
s a
> >> >> > real use case.
> >> >>
> >> >> That would mean allocation and frees, it is already quite expensive=
 as is for a
> >> >> call_rcu() primitive (with the refcount bumps and atomics).
> >> >
> >> > maybe so, but as is ARRAY is a severe limitation and makes a lot of
> >> > cases either unusable or requiring extra sequential ID allocation
> >> > logic to remap some HASH map entry to index in an ARRAY map, just so
> >> > you can call rcu callback for a given kernel object stored in HASH
> >> > map.
> >> >
> >> > E.g., think about keep as set of sockets, or tasks, or whatnot in HA=
SH
> >> > or RHASHTABLE (especially the latter one with support for resizing).
> >> > How would you do bpf_call_rcu() for them with unduly complications,
> >> > limitations and a lot of waste (unlike HASH you can't have lazy memo=
ry
> >> > allocation).
> >>
> >> Yeah, I don't disagree. We would also need to support storing them in =
more map
> >> types to make it woth with arenas (which was one of the motivations fo=
r the
> >> feature).
> >>
> >> Perhaps it is better to make cancel a noop / unsupported and skip it w=
hen a map
> >> element is deleted. That will be the easiest path to enabling it, but =
it does
> >> create (perhaps surprising) divergence from some of the other async ca=
llback
> >> primitives.
> >
> > I don't see much need for cancellation, but a more useful/sane
> > behavior would be rearming on subsequent calls to bpf_call_rcu(). This
> > would also handle update/delete/reuse of entries. Not sure how hard it
> > is to support that in kernel's call_rcu() implementation, though, but
> > that would solve the problem, because it should always be OK to delay
> > call_rcu() callback, but not the other way around (which is what would
> > happen today because we will ignore subsequent bpf_call_rcu() calls).
> >
>
> Hm. One of the design points for this was maintaining our own lists and u=
sing
> more lower level RCU primitives to poll for the grace period. I wonder if=
 some
> of this could be made easier that way. I will think a bit more about this=
.
>
> We could probably also do the waiting_for_gp amortization that memalloc.c=
 on top.
>
> >>
> >> That said, I do think performance should be a consideration for this A=
PI; maybe
> >> unlike other ones, I would expect that this could be called very frequ=
ently. I
> >
> > I'm not sure why this has to be super high frequency API to use, tbh.
> > You'd normally use this when cleaning up when some kernel object is
> > freed, no? Sure that can be relatively frequent, but not to the point
> > where we should be *that* concerned with refcount or atomics overhead
> > per se (multi-cpu cache bouncing of refcounting is a concern, but not
> > sure what you can do about that).
> >
>
> Yeah it depends, but I think you can make the other case as well.  Going =
by
> optimizations made in memalloc.c for hashtab, imagine implementing an are=
na hash
> table using this stuff. You'd definitely want it to be as cheap as possib=
le and
> approach the kernel implementation.
>
> If multiple CPUs dispatching it leads to constant cache line bouncing, it=
 will
> fail to scale with number of CPUs. The user then does their own batching =
to
> amortize the cost and pace the calls, but it's just more complexity pushe=
d down
> on the callers, and it might build up memory pressure because items are n=
ow not
> being freed as quickly and hit locks in the allocator (one of the main re=
asons
> BPF maps have memory reuse semantics, to avoid exhausting caches and hitt=
ing
> allocator locks).
>
> Anyway, I know we kicked the can down the road for now on prog refcounts,=
 and
> can cache allocations etc. to amortize the cost there, but I hope that I =
could
> illustrate why I think it might be more sensitive to performance differen=
ces
> than some of the other primitives.

no, that's a good point, but I think the solution here is to make
prog's refcount more scalable by using per-cpu refcount approach,
right?

>
> >> had concerns about prog refcount increment as well, but didn't really =
bring it
> >> up since it is something that can be addressed after the fact (maybe u=
sing pcpu
> >> refs). But once we promise supporting cancellation, it is hard to walk=
 that
> >> back. I think it's less of a concern for other async cb types. In prac=
tice,
> >> except to support map semantics I don't know if anyone will use cancel=
lation API
> >> either, the kernel side never grew such support.
> >>
> >> Anyway, overall the best path to me seems to be just enabling it as is=
 and
> >
> > you mean enabling for HASH or keeping it for ARRAY only? If the
> > latter, my concern is that to support HASH we might need to change the
> > internal structure and break that 48-byte size, so we should probably
> > decide all this before we get this into the next Linux release.
>
> I did mean enabling it in other maps, yes, sorry, I think I wrote it in a

ah ok, +1 to that

> confusing manner. I was just speculating that we can bail on cancelling a=
nd see
> whether we can make it work. I probably need to spend a little more time
> thinking it through.
>

I think there is, I'll let Puranjay provide details as we just had a
discussion offlist.

> All of that said, it seems there's a more discussion to be had about this=
, and
> it probably landed too early. I would prefer if we could resolve these qu=
estions
> without operating under some time pressure just because it might go out i=
n the
> next release.

+1

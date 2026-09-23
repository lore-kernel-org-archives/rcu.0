Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314EC53A881
	for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188271; cv=pass; b=uaASguqH0kXxsYtKFICGUIRlXFx127BCIaJhAQpsulyskKmUz/juIN5C+FjWsABZ7XHPS5hzQeMPiIEdnPLnuQnienlF878+d4FL3GN+hKIXibT4XNW71piZJXFnjXGJV8pXnbZcu4LRzx9G4UF+qo61piinjGYj6M6Mpk5GYRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188271; c=relaxed/simple;
	bh=j4/9KJiLkBgZyjyNl0jjdxNrTtRNLUxDgeWAm6hFdCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkphRLqyKnd/bvQCeEemiKMmP5oBm1gssTWKCHY5VsoK3bR/nU6LviVpNiLyWIwfmoxzJ+U2FFA5+18BT68o+nr+62qQYFgMcrPkNuIp6GE+8TYRoSKlev5FKumklSLjyaJ9ejFVZ8I1g8cACWbj1WB7nK4tdVf14oOT5OOI8zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lfg8FNyp; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lfg8FNyp"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55eff0so189632166b.0
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 11:31:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790188264; cv=none;
        d=google.com; s=arc-20260327;
        b=PeBkHzQo912cidtKGMkQDxRAFuA7CkTY5J1kFhfaAujvs7/YWDM7Dz9SNz5w5VP/OO
         nnBvu2ZNKJUkvEJTPiy67hddKYmle0VW7ffToqIXqHuoj6SlVBg2WYE6D0Mt10O0WoVL
         c/bM+4rP9Jsf1JglFeR7xuuyjwfUK4dPSBqB8zqoBWRt89aRnygbtbltLnOCVNSialCs
         niXBWrmBnLrzdqf1bl3aaejf6+ScQU91KnJeM/BHwbsDIiPbJHLcLmplbL8Dxlb+0rKd
         nzLhJCfny9L6+01VBT4DPWKF0zgUTKMwkA7r+7Y3cuYTK366SvuY+EvWaH3cif4VH2fd
         o+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QLRtIK1HV7RL2kaKITJEfn4tf/nV5+biLozvh6Vj3kY=;
        fh=EmjXLQaqdZAnmORyYp3h6WePu/CZPNZzGx3fUn3X9fE=;
        b=DtZ+5Cf1pc5+r639+6QnCPFjnpHvASSc3wfIN0bYYrNjJOodvRiC+7LrkL9FNgWen3
         2UN6gknrajkg3GOQiepS4N9v4G9GZcOakpaSo9rJNvd8J2OIjU/RL3Eu/zn03Xe5SCgM
         RMraqt4PdthxRjbHQN+e2mGRinFpU0igV6EtIx9JR4I9mdYOULtWN5bF8kXy+4HJuRW0
         lZjgu6gZvxd4GjmrplBEuJ+xMa4qPz1Px3U6t3Ibe6aX7P0+rZWbJNa0dA1EeJtlpaOE
         5nNd1da2OyLG26rYDe1fTikeXf973JCffxzUi2K1VjctEz443dOrHEl344fP4AlwOZim
         KdYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790188264; x=1790793064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QLRtIK1HV7RL2kaKITJEfn4tf/nV5+biLozvh6Vj3kY=;
        b=Lfg8FNypIwSOwlvwH9rkKAdDVHLjk8n+mgxSMVJZovRqZoPEjnNze14rd1QOmLSY9G
         W6EeLj37ptj9XNe3HuLUOkmJjTvcIMB0lEdr+RFs6/s6E2YvWacXgZTHIGQsBOC1iy+C
         ysdv52SRI2Ux4/dSUhHgbufY8WoUw+RCwuQ8ulxKAJs3xZMk5Ptax3qeqvyynYAvmhr7
         ifxWSnuiEjhGNa4sgK2+9AEWrxjdFDGcrFEoLp6I4gy3BcWFtLN7fRIsx4kUyUp8TWDd
         XqgtDVrr+tdeQyyWi7Gmvp7XGQTyvnPp8+vd+VKwPmWLmVeMjFIBubC21Ic2jeACfIp8
         3/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790188264; x=1790793064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QLRtIK1HV7RL2kaKITJEfn4tf/nV5+biLozvh6Vj3kY=;
        b=weeCSxaGyEQ2Bcj9Wi/vpBvnQNVCOnCLD3wQ+KyWsrIyEcG6hpPvqxHAVZyfD9lTMs
         aOHrqtdf7Xt/DIj+p5qdAJwaQmHgTkO+RTX0ZgSi6XMPq4FEbClSZqLRis+zxUHn/syq
         b+bg+g/cuoVGjqx5X61/tsw2Qci1jIt9eu++6kanFtyVkW8xaeeJiV6nlEJDljxfBskW
         ejAJ9yMSbzdKvLsvHvzQYMD0pprpkoMLYU/74P/woqEVvYtWmefmZddN80aBevOcuWYY
         LMktRAdWZZM74W/1JgLLJE7dZj52u0V1j4lUctgWdxpxCE6ur3Hc5AznubR6RMJ9kKB5
         SBng==
X-Forwarded-Encrypted: i=1; AKwUvBw/7tXJofkdkbCODYq7iMSEeOoF5+3AyiXfM6qYINK5uTUvoZ0+LY/sAriFvHKCxuGFK/4=@vger.kernel.org
X-Gm-Message-State: AFuF++kywjo/FOlZjwJHdnNzbOBQ3yyWy34vJDfifuiQTgfm1J18mWmD
	e/aCEED061D094ceeFxBcvIlipDRGYAM8736dWdb2by2pWcP7WepZSwffPZ8LSK47mButE0rjVs
	Py/oaxKqlWEueIfWReR8dEkO01G+c2F2R5sv6AgVjumSt
X-Gm-Gg: AYBFou3BuEwhZmbKZH5u5Y+UO99Ax3AmAQxagJ8clEMfQNi/oRGUYmStVsnUJzizsnB
	PaJQe/XLxRDVpCCkFbRhmebZzizh82RMv1wV8xUym760zypQuWF4HKcbZOkwLXGB93sWrhbLn6z
	vI4dSIn+EFXJGPWMEJFWICl9Zw+yd0RSuMGlWzJdFNw5I3xmW+FX4Hnk9dgokMTtz7Cq20SXUb8
	D64uK1ywWU/JrTNHE+KFv3GAxxsMkfbERnkRyXxxSmwFVJnPZPJ1pgjfwaeKKQvNJCn5+J20Fia
	STrSpkOi1A88p9RJdNT3mAMu/p6aZJ2z+qLlRMpiJQrX7CjWpkwtNhKTwGK4KYuCCTKE0C8=
X-Received: by 2002:a17:907:c012:b0:c21:8a0f:56dc with SMTP id
 a640c23a62f3a-c2ac2374e05mr1030566b.4.1790188264140; Wed, 23 Sep 2026
 11:31:04 -0700 (PDT)
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
 <DLMW293TO3P3.3SKQ637LNLYQR@gmail.com> <CAEf4BzYLZtHvD9s8N9UA-VmHUD1zKO=kQhKDvxLHHWQsFgu_cw@mail.gmail.com>
In-Reply-To: <CAEf4BzYLZtHvD9s8N9UA-VmHUD1zKO=kQhKDvxLHHWQsFgu_cw@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 23 Sep 2026 19:30:50 +0100
X-Gm-Features: AclHuK8B00p-06KeQFd2nYgFnDtv4DH6-28nhTXglWVSacRwLrr4vEAwJk2eBFk
Message-ID: <CANk7y0g01QX-0ZqtF9FhL-9pmrLtXqyRVsyQo1UE9A-wTaO16A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/4] bpf: Add bpf_call_rcu() and bpf_call_rcu_tasks_trace()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, rcu@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 7:22=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 23, 2026 at 10:57=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Wed Sep 23, 2026 at 6:59 PM CEST, Andrii Nakryiko wrote:
> > > On Wed, Sep 23, 2026 at 9:53=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > >>
> > >> On Wed Sep 23, 2026 at 6:45 PM CEST, Andrii Nakryiko wrote:
> > >> > On Wed, Sep 23, 2026 at 4:29=E2=80=AFAM Kumar Kartikeya Dwivedi
> > >> > <memxor@gmail.com> wrote:
> > >> >>
> > >> >> On Wed Sep 23, 2026 at 12:37 PM CEST, Puranjay Mohan wrote:
> > >> >> > On Wed, Sep 23, 2026 at 12:41=E2=80=AFAM Andrii Nakryiko
> > >> >> > <andrii.nakryiko@gmail.com> wrote:
> > >> >> >>
> > >> >> >> On Tue, Sep 22, 2026 at 1:02=E2=80=AFPM Puranjay Mohan <puranj=
ay@kernel.org> wrote:
> > >> >> >> >
> > >> >> >> > Changelog:
> > >> >> >> > v5: https://lore.kernel.org/all/20260921191407.1742386-1-pur=
anjay@kernel.org/
> > >> >> >> > Changes in v6:
> > >> >> >> > - Size struct bpf_rcu_head at 48 bytes rather than 64, match=
ing what the
> > >> >> >> >   inline state uses (Alexei)
> > >> >> >> > - Trim patch 1's changelog: drop the reasoning about possibl=
e future
> > >> >> >> >   layouts and about what the other async kfuncs return
> > >> >> >> > - Rebase on bpf-next/master
> > >> >> >> >
> > >> >> >> > v4: https://lore.kernel.org/all/20260915154248.3612028-1-pur=
anjay@kernel.org/
> > >> >> >> > Changes in v5:
> > >> >> >> > - Rename the "hash_map" subtest to "bad_map" so that it matc=
hes its
> > >> >> >> >   helper test_call_rcu_bad_map() (bpf-ci)
> > >> >> >> > - Bump the callback counter after chain_err in the selftest =
callback.
> > >> >> >> >   Userspace polls that counter and then reads chain_err, so =
it could
> > >> >> >> >   still see the initial value before the re-arm had stored o=
ne, which
> > >> >> >> >   let the chain subtest's assertion pass without checking an=
ything
> > >> >> >> > - Say in patch 1 why embedding struct rcu_head in a uapi str=
uct is
> > >> >> >> >   acceptable here (Mykyta, Paul, Alexei)
> > >> >> >> > - Rebase on bpf-next/master
> > >> >> >> > v3: https://lore.kernel.org/all/20260915143640.36292-1-puran=
jay@kernel.org/
> > >> >> >> > Changes in v4:
> > >> >> >> > - Drop an unrelated hunk in bpf_async_update_prog_callback()=
 that turned
> > >> >> >> >   PTR_ERR(prog) into -EBADF.  That is the shared bpf_timer/b=
pf_wq path
> > >> >> >> >   and bpf_prog_inc_not_zero() returns -ENOENT, so it would h=
ave changed
> > >> >> >> >   the errno bpf_timer_set_callback() and bpf_wq_set_callback=
() report to
> > >> >> >> >   userspace (Sashiko).  No other changes from v3
> > >> >> >> > v2: https://lore.kernel.org/all/20260915114240.3269184-1-pur=
anjay@kernel.org/
> > >> >> >> > Changes in v3:
> > >> >> >> > - Move the bpf_call_rcu_tasks_trace() verifier bits from pat=
ch 1 to
> > >> >> >> >   patch 3; patch 1 alone emitted "resolve_btfids: unresolved=
 symbol
> > >> >> >> >   bpf_call_rcu_tasks_trace" (Sashiko)
> > >> >> >> > - Poll the callback counter with an acquire load (Sashiko)
> > >> >> >> > - teardown: v2 only checked that the program was eventually =
freed, which
> > >> >> >> >   passes even if nothing was ever armed.  Also assert that t=
he chain ran,
> > >> >> >> >   and read the -EPERM back through an independent .bss fd
> > >> >> >> > - Use kern_sync_rcu() instead of open coding the grace-perio=
d wait
> > >> >> >> > - Return -EBADF rather than -ENOENT when the calling program=
 is going
> > >> >> >> >   away, matching bpf_task_work_schedule()
> > >> >> >> > - mismatch_map now pins the bpf_rcu_head label the new code =
emits; it
> > >> >> >> >   passed with that branch removed.  Add a two_heads test, an=
d wait for
> > >> >> >> >   each grace period separately in the chain test
> > >> >> >> > - Commit messages: correct the -EPERM parity claim, explain =
the inline
> > >> >> >> >   callback state and the struct size, motivate the tasks tra=
ce flavour
> > >> >> >> > v1: https://lore.kernel.org/all/20260907134552.1772405-1-pur=
anjay@kernel.org/
> > >> >> >> > Changes in v2:
> > >> >> >> > - Rebase on bpf-next/master
> > >> >> >> > - Use rcu_read_lock_dont_migrate() over open coding (Alexei)
> > >> >> >> > - Improve re-arming selftest to detect failure (Sashiko)
> > >> >> >> >
> > >> >> >> > BPF programs that manage their own objects have no way to ru=
n their own
> > >> >> >> > logic once an RCU grace period has elapsed.  bpf_obj_drop() =
defers a
> > >> >> >> > free, but returning an index to an allocator or unpinning a =
resource
> > >> >> >> > once readers are done has no equivalent.  sched_ext's BPF li=
brary works
> > >> >> >> > around this today by pushing freed nodes onto a list and hav=
ing a
> > >> >> >> > userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and =
then run a
> > >> >> >> > BPF program to reclaim them; it is the first intended user.
> > >> >> >> >
> > >> >> >> > Add:
> > >> >> >> >
> > >> >> >> >         int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
> > >> >> >> >                          int (*callback)(struct bpf_map *map=
, void *key,
> > >> >> >> >                                          void *value));
> > >> >> >> >
> > >> >> >> > and bpf_call_rcu_tasks_trace(), same signature, which also w=
aits for
> > >> >> >> > sleepable programs.
> > >> >> >> >
> > >> >> >> > @rh is a struct bpf_rcu_head embedded in a value of @map, so=
 the
> > >> >> >> > callback runs as callback(map, key, value) for the element i=
t lives in
> > >> >> >> > and needs no cookie.  The field is only accepted in BPF_MAP_=
TYPE_ARRAY,
> > >> >> >>
> > >> >> >> Isn't restricting this to BPF_MAP_TYPE_ARRAY unnecessarily res=
trictive
> > >> >> >> in practice? Do other APIs of similar kind have this limitatio=
n? E.g.,
> > >> >> >> bpf_task_work_schedule() or timer, I don't think they limit us=
er to
> > >> >> >> just ARRAY maps, it's way too inflexible.
> > >> >> >
> > >> >> > Right, bpf_timer and bpf_task_work take HASH/LRU_HASH/ARRAY. Th=
ey can
> > >> >> > because they can cancel: on element delete bpf_obj_free_fields(=
) calls
> > >> >>
> > >> >> bpf_obj_cancel_fields(). bpf_obj_free_fields() is no longer calle=
d except when
> > >> >> the object is being freed finally.
> > >> >>
> > >> >> > bpf_task_work_cancel_and_free(), which reaches task_work_cancel=
(), so
> > >> >> > a pending callback never runs against a recycled element.
> > >> >> > A queued RCU callback cannot be cancelled. rcu_barrier() is the=
 only
> > >> >> > thing that waits for one, and it sleeps, so it is not callable =
from an
> > >> >> > element delete. Array elements are never freed individually, wh=
ich is
> > >> >> > what makes it safe.
> > >> >>
> > >> >> If cancel is a noop, can you not simply skip it on map update?
> > >> >>
> > >> >> It is a bit unfortunate we can't provide cancel semantics, it wil=
l be yet
> > >> >> another divergence from how all other async callbacks work...sigh=
.
> > >> >>
> > >> >> >
> > >> >> > I can think of a complicated way to support hash maps but that =
would
> > >> >> > need making the state dynamically allocated and finding a way t=
o
> > >> >> > cancel the callbacks. But I would do it as a follow-up if there=
 is a
> > >> >> > real use case.
> > >> >>
> > >> >> That would mean allocation and frees, it is already quite expensi=
ve as is for a
> > >> >> call_rcu() primitive (with the refcount bumps and atomics).
> > >> >
> > >> > maybe so, but as is ARRAY is a severe limitation and makes a lot o=
f
> > >> > cases either unusable or requiring extra sequential ID allocation
> > >> > logic to remap some HASH map entry to index in an ARRAY map, just =
so
> > >> > you can call rcu callback for a given kernel object stored in HASH
> > >> > map.
> > >> >
> > >> > E.g., think about keep as set of sockets, or tasks, or whatnot in =
HASH
> > >> > or RHASHTABLE (especially the latter one with support for resizing=
).
> > >> > How would you do bpf_call_rcu() for them with unduly complications=
,
> > >> > limitations and a lot of waste (unlike HASH you can't have lazy me=
mory
> > >> > allocation).
> > >>
> > >> Yeah, I don't disagree. We would also need to support storing them i=
n more map
> > >> types to make it woth with arenas (which was one of the motivations =
for the
> > >> feature).
> > >>
> > >> Perhaps it is better to make cancel a noop / unsupported and skip it=
 when a map
> > >> element is deleted. That will be the easiest path to enabling it, bu=
t it does
> > >> create (perhaps surprising) divergence from some of the other async =
callback
> > >> primitives.
> > >
> > > I don't see much need for cancellation, but a more useful/sane
> > > behavior would be rearming on subsequent calls to bpf_call_rcu(). Thi=
s
> > > would also handle update/delete/reuse of entries. Not sure how hard i=
t
> > > is to support that in kernel's call_rcu() implementation, though, but
> > > that would solve the problem, because it should always be OK to delay
> > > call_rcu() callback, but not the other way around (which is what woul=
d
> > > happen today because we will ignore subsequent bpf_call_rcu() calls).
> > >
> >
> > Hm. One of the design points for this was maintaining our own lists and=
 using
> > more lower level RCU primitives to poll for the grace period. I wonder =
if some
> > of this could be made easier that way. I will think a bit more about th=
is.
> >
> > We could probably also do the waiting_for_gp amortization that memalloc=
.c on top.
> >
> > >>
> > >> That said, I do think performance should be a consideration for this=
 API; maybe
> > >> unlike other ones, I would expect that this could be called very fre=
quently. I
> > >
> > > I'm not sure why this has to be super high frequency API to use, tbh.
> > > You'd normally use this when cleaning up when some kernel object is
> > > freed, no? Sure that can be relatively frequent, but not to the point
> > > where we should be *that* concerned with refcount or atomics overhead
> > > per se (multi-cpu cache bouncing of refcounting is a concern, but not
> > > sure what you can do about that).
> > >
> >
> > Yeah it depends, but I think you can make the other case as well.  Goin=
g by
> > optimizations made in memalloc.c for hashtab, imagine implementing an a=
rena hash
> > table using this stuff. You'd definitely want it to be as cheap as poss=
ible and
> > approach the kernel implementation.
> >
> > If multiple CPUs dispatching it leads to constant cache line bouncing, =
it will
> > fail to scale with number of CPUs. The user then does their own batchin=
g to
> > amortize the cost and pace the calls, but it's just more complexity pus=
hed down
> > on the callers, and it might build up memory pressure because items are=
 now not
> > being freed as quickly and hit locks in the allocator (one of the main =
reasons
> > BPF maps have memory reuse semantics, to avoid exhausting caches and hi=
tting
> > allocator locks).
> >
> > Anyway, I know we kicked the can down the road for now on prog refcount=
s, and
> > can cache allocations etc. to amortize the cost there, but I hope that =
I could
> > illustrate why I think it might be more sensitive to performance differ=
ences
> > than some of the other primitives.
>
> no, that's a good point, but I think the solution here is to make
> prog's refcount more scalable by using per-cpu refcount approach,
> right?
>
> >
> > >> had concerns about prog refcount increment as well, but didn't reall=
y bring it
> > >> up since it is something that can be addressed after the fact (maybe=
 using pcpu
> > >> refs). But once we promise supporting cancellation, it is hard to wa=
lk that
> > >> back. I think it's less of a concern for other async cb types. In pr=
actice,
> > >> except to support map semantics I don't know if anyone will use canc=
ellation API
> > >> either, the kernel side never grew such support.
> > >>
> > >> Anyway, overall the best path to me seems to be just enabling it as =
is and
> > >
> > > you mean enabling for HASH or keeping it for ARRAY only? If the
> > > latter, my concern is that to support HASH we might need to change th=
e
> > > internal structure and break that 48-byte size, so we should probably
> > > decide all this before we get this into the next Linux release.
> >
> > I did mean enabling it in other maps, yes, sorry, I think I wrote it in=
 a
>
> ah ok, +1 to that
>
> > confusing manner. I was just speculating that we can bail on cancelling=
 and see
> > whether we can make it work. I probably need to spend a little more tim=
e
> > thinking it through.
> >
>
> I think there is, I'll let Puranjay provide details as we just had a
> discussion offlist.

I think I can come up with a way for supporting hashmaps, by keeping
the element alive until the callback has run rather than trying to
cancel it.

On delete the map asks the head first: that sets a dead bit and
reports whether a callback is still outstanding. If one is, the
element stays unlinked but is not returned to the allocator; the
callback does that at the end through a new map_release_elem(), since
only the map knows whether that is a freelist push or
bpf_mem_cache_free(). The dead bit stops it being armed again, so
there is a definite last callback and exactly one side releases the
element.

That needs one more bit of state in the head that covers the rcu_head,
which RCU dequeues before invoking so the callback can still re-arm,
and a count that covers the element, which has to live until the last
callback
returns. Both fit in the u32 already there, so struct bpf_rcu_head
does not grow and there is no allocation.

What do you think of this approach??

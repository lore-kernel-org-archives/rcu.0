Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B1221FB4
	for <rcu@vger.kernel.org>; Thu, 27 Nov 2025 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764271765; cv=none; b=IGI7EO5o9ahNXVW2PwXmjRqoxRBMeAHSvTSN83ILGRy6iO5mE/T8oAQoE4fkDTfsV8KGG1yxM7ixJz5mSp0pQYPBIbWraYUQ2djc4XqCPyxC8ziqUio1L7snwd67abQWyjvc8pqPpl5nKNVocVRrRL82oUZ2WMniEtz50mSZwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764271765; c=relaxed/simple;
	bh=k5fxLNRqsW+8ryiSr+lWXV0En8JIsiil8v85H9BzdfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iaz0vBJ+rJVm1/sVG57HZ5TIIdO7jsiw/mU4YRrRap6DQJfzK1PZxE1E/bIewbl/WFq0Vy0ag5A+2ZxIro+AxRwUkrjvDQvDSbntklSiFNtVMOb4r6L27QSJnVmvayPQg3uE5d3sE2mj6j+PzahJPx2PXYvR+06jYTZBmL5yMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vBZklfQR; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBZklfQR"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee243b98caso289681cf.1
        for <rcu@vger.kernel.org>; Thu, 27 Nov 2025 11:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764271762; x=1764876562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoIF1SGGEVRiz/EuDnanHFl7GK3C8LRxCxceA/BH30I=;
        b=vBZklfQRebQXKQxyOEr17+YGz2VRgHzstipaQf5wLd9/9Y3GVbAdPn0QJDLlB43YvL
         izCCFdBegHCudbU51PzUEjfoNOnTdl3Ltw9t10w1NNgkCu38KbEo4izZ3REM5hqDL5BA
         lP4mESNSqKoCL3r/xLrthcnzEFOVpdC4qOIpru4m4rkluHZksJs3eypZE8CeKjgzK0yZ
         lfgK0EPE1RrOYFMMrGOepUVpiCr8BmGHOVzQ/9/iGoTZ7/zqV39HIzvLu89DTufSd6gM
         cZVMtXGq7giNoXytorwL0C//nyOP/vJwBQ3aN3knYYwmPAWXfSjd8lfEIJyhbxF65sz9
         5Wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764271762; x=1764876562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DoIF1SGGEVRiz/EuDnanHFl7GK3C8LRxCxceA/BH30I=;
        b=cmVOzUusnxnX5PJRU2KuyAK/btuabV2oCyu7pXrba6MMpg5+pckXfPAUCK7mCEn25R
         NO+T1rg1FKLpZd5OBZtq8H6FKaPLAQQdvBWe8b54EsQGONY5amwqp6hAUG0fRd/eslAC
         T2421AWJ0whGsRp8Z3vJ0uuV1WII6nOmNo3N4YEr0rOmvG6H1FtYogvdn2C11r2sqHGJ
         y6bKJLRfPC3zUvUN9+0cGrHB/f9qgSIbNBPa93k5SF2WJx4e6vsEr1I+P3lr1W0qWmT1
         N6ySwZkpGOxSfVrLRkDd1NAZABH+1cRgD4uXzHkafV0FKqYNqa0mCntG1sP9GE8fYy6x
         IDVw==
X-Forwarded-Encrypted: i=1; AJvYcCVMp20qwVkIL/Vafcd6m7A5ha794w5dup0KuymKnz0c3KaZ4abmsc3mQ9nPLRtUel/O204=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31vbjgfEPBo/piUxu2MBQKf36YySzsrzAXUjIQ+iRlFIZyiCS
	OUcMyL/6c/xT04Y8bJiKo45YiA9lEolgV029TAq9NokkWH0fAopFp50HzP2uyBSRC3OBUZ1vNlu
	aKh2RnDPtSjIpHQWk4DkpolIUAYIUJDPxgSKgYChA
X-Gm-Gg: ASbGncttfkvUiuVNSRKvuhAIVrQVNrU1uKXItc29/dkFMc6dvWNjHaFZTUruFw8Z3vW
	Dj6CHlxwALw1X5Py7rFN2iEpxlrBITufHWZsqAFkZdy1RFkKkvHx7hWWrCF2jVeT6eszBPZ/nxS
	lwuylEEKw1Kz36SajoHvyZm1QZDEEjSdyafZvH1fyIYl4MeD7WPtX0ZIuDMcsullOFgXxA3ByyS
	a0Ei3wbxghtyUratrN8HdrxO3N8mqMUtV9J34gaI3YBIZ90DrCxmoCVohQ+fbYQtwEncT97qQ/L
	eIQX
X-Google-Smtp-Source: AGHT+IGxLUEzc3Reot726IcmLgjq3nKIC/pLTC27EX/OZL86TUpoASPm9EUrUhNIVGTyzCyI1smo65AvyrNtEbv7AJM=
X-Received: by 2002:a05:622a:346:b0:4ed:b665:3779 with SMTP id
 d75a77b69052e-4efd0cadedemr5566471cf.16.1764271761856; Thu, 27 Nov 2025
 11:29:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz> <0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org>
 <aQge2rmgRvd1JKxc@harry> <1bda09da-93be-4737-aef0-d47f8c5c9301@suse.cz> <1c34bf75-0ea3-490d-b412-288c7452904e@kernel.org>
In-Reply-To: <1c34bf75-0ea3-490d-b412-288c7452904e@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 27 Nov 2025 11:29:10 -0800
X-Gm-Features: AWmQ_bnMUm6fpw8I5CiW8EnlZf9RdB2BGr-Nmfr3npUmVluTVAnisr9aMXu_kzM
Message-ID: <CAJuCfpFTMQD6oyR_Q1ds7XL4Km7h2mmzSv4z7f5fFnQ14=+g_A@mail.gmail.com>
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching kfree_rcu() operations
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Uladzislau Rezki <urezki@gmail.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	bpf@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 6:01=E2=80=AFAM Daniel Gomez <da.gomez@kernel.org> =
wrote:
>
>
>
> On 05/11/2025 12.25, Vlastimil Babka wrote:
> > On 11/3/25 04:17, Harry Yoo wrote:
> >> On Fri, Oct 31, 2025 at 10:32:54PM +0100, Daniel Gomez wrote:
> >>>
> >>>
> >>> On 10/09/2025 10.01, Vlastimil Babka wrote:
> >>>> Extend the sheaf infrastructure for more efficient kfree_rcu() handl=
ing.
> >>>> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
> >>>> addition to main and spare sheaves.
> >>>>
> >>>> kfree_rcu() operations will try to put objects on this sheaf. Once f=
ull,
> >>>> the sheaf is detached and submitted to call_rcu() with a handler tha=
t
> >>>> will try to put it in the barn, or flush to slab pages using bulk fr=
ee,
> >>>> when the barn is full. Then a new empty sheaf must be obtained to pu=
t
> >>>> more objects there.
> >>>>
> >>>> It's possible that no free sheaves are available to use for a new
> >>>> rcu_free sheaf, and the allocation in kfree_rcu() context can only u=
se
> >>>> GFP_NOWAIT and thus may fail. In that case, fall back to the existin=
g
> >>>> kfree_rcu() implementation.
> >>>>
> >>>> Expected advantages:
> >>>> - batching the kfree_rcu() operations, that could eventually replace=
 the
> >>>>   existing batching
> >>>> - sheaves can be reused for allocations via barn instead of being
> >>>>   flushed to slabs, which is more efficient
> >>>>   - this includes cases where only some cpus are allowed to process =
rcu
> >>>>     callbacks (Android)
> >>>>
> >>>> Possible disadvantage:
> >>>> - objects might be waiting for more than their grace period (it is
> >>>>   determined by the last object freed into the sheaf), increasing me=
mory
> >>>>   usage - but the existing batching does that too.
> >>>>
> >>>> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> >>>> implementation favors smaller memory footprint over performance.
> >>>>
> >>>> Also for now skip the usage of rcu sheaf for CONFIG_PREEMPT_RT as th=
e
> >>>> contexts where kfree_rcu() is called might not be compatible with ta=
king
> >>>> a barn spinlock or a GFP_NOWAIT allocation of a new sheaf taking a
> >>>> spinlock - the current kfree_rcu() implementation avoids doing that.
> >>>>
> >>>> Teach kvfree_rcu_barrier() to flush all rcu_free sheaves from all ca=
ches
> >>>> that have them. This is not a cheap operation, but the barrier usage=
 is
> >>>> rare - currently kmem_cache_destroy() or on module unload.
> >>>>
> >>>> Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fai=
l to
> >>>> count how many kfree_rcu() used the rcu_free sheaf successfully and =
how
> >>>> many had to fall back to the existing implementation.
> >>>>
> >>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >>>
> >>> Hi Vlastimil,
> >>>
> >>> This patch increases kmod selftest (stress module loader) runtime by =
about
> >>> ~50-60%, from ~200s to ~300s total execution time. My tested kernel h=
as
> >>> CONFIG_KVFREE_RCU_BATCHED enabled. Any idea or suggestions on what mi=
ght be
> >>> causing this, or how to address it?
> >>
> >> This is likely due to increased kvfree_rcu_barrier() during module unl=
oad.
> >
> > Hm so there are actually two possible sources of this. One is that the
> > module creates some kmem_cache and calls kmem_cache_destroy() on it bef=
ore
> > unloading. That does kvfree_rcu_barrier() which iterates all caches via
> > flush_all_rcu_sheaves(), but in this case it shouldn't need to - we cou=
ld
> > have a weaker form of kvfree_rcu_barrier() that only guarantees flushin=
g of
> > that single cache.
>
> Thanks for the feedback. And thanks to Jon who has revived this again.
>
> >
> > The other source is codetag_unload_module(), and I'm afraid it's this o=
ne as
> > it's hooked to evey module unload. Do you have CONFIG_CODE_TAGGING enab=
led?
>
> Yes, we do have that enabled.

Sorry I missed this discussion before.
IIUC, the performance is impacted because kvfree_rcu_barrier() has to
flush_all_rcu_sheaves(), therefore is more costly than before.

>
> > Disabling it should help in this case, if you don't need memory allocat=
ion
> > profiling for that stress test. I think there's some space for improvem=
ent -
> > when compiled in but memalloc profiling never enabled during the uptime=
,
> > this could probably be skipped? Suren?

I think yes, we should be able to skip kvfree_rcu_barrier() inside
codetag_unload_module() if profiling was not enabled.
kvfree_rcu_barrier() is there to ensure all potential kfree_rcu()'s
for module allocations are finished before destroying the tags. I'll
need to add an additional "sticky" flag to record that profiling was
used so that we detect a case when it was enabled, then disabled
before module unloading. I can work on it next week.

> >
> >> It currently iterates over all CPUs x slab caches (that enabled sheave=
s,
> >> there should be only a few now) pair to make sure rcu sheaf is flushed
> >> by the time kvfree_rcu_barrier() returns.
> >
> > Yeah, also it's done under slab_mutex. Is the stress test trying to unl=
oad
> > multiple modules in parallel? That would make things worse, although I'=
d
> > expect there's a lot serialization in this area already.
>
> AFAIK, the kmod stress test does not unload modules in parallel. Module u=
nload
> happens one at a time before each test iteration. However, test 0008 and =
0009
> run 300 total sequential module unloads.
>
> ALL_TESTS=3D"$ALL_TESTS 0008:150:1"
> ALL_TESTS=3D"$ALL_TESTS 0009:150:1"
>
> >
> > Unfortunately it will get worse with sheaves extended to all caches. We
> > could probably mark caches once they allocate their first rcu_free shea=
f
> > (should not add visible overhead) and keep skipping those that never di=
d.
> >> Just being curious, do you have any serious workload that depends on
> >> the performance of module unload?
>
> Can we have a combination of a weaker form of kvfree_rcu_barrier() + trac=
king?
> Happy to test this again if you have a patch or something in mind.
>
> In addition and AFAIK, module unloading is similar to ebpf programs. Ccin=
g bpf
> folks in case they have a workload.
>
> But I don't have a particular workload in mind.

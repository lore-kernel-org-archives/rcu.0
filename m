Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5F3D3D1F
	for <rcu@vger.kernel.org>; Wed, 20 May 2026 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271310; cv=none; b=dY1QVR0xdMGpzycTzO7dIiUETig23iFeJz4R16dM3cxqqPrT4lLFLmLut1trgk++9HCzg64pbvCFsGwjvRnsrzX+zoBDiNozmU9mSO78fBq8/XSop+lcXgbcAX54E0LgX/mGBsJ4Zi0mtnaFQa3LNhmVZyaAwPUabGD+mx7wCg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271310; c=relaxed/simple;
	bh=IaHSadIy3bIJ6MlGxzJTk1EmaP/jdnaOO0MMUSYvTuM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhgqsXVFR6Ln/VfLLT1F0ULG9ivXE/0ZDPSyfCicnjIh0LmidVwE4kpiGYTuuZL2BsBTMDplJt+IZrLb55cPGYJtQ40vbZS1TQfizmKBJ27V1KNcEAA2htgwRYN9EuIUyJ6AXiY5PyaZLMxPZwYCzcE5vxYLI0oCgowM4dTAwWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6rKixEU; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6rKixEU"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso5254473e87.1
        for <rcu@vger.kernel.org>; Wed, 20 May 2026 03:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779271307; x=1779876107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+vsRneuQukq1VCZsxvt5EboIhJTKy6gqyaaIC0kDxc=;
        b=W6rKixEUYedl5cHO4t8Ed4I9qpID8TVWAnvHYF7DGPcrdWkMBd56M2dO8Nt90cTwqr
         bFT1ILXtRFJAguLb/WIPl2uFR+yfMLs3Di+KGRdG96ytzZQ+PULbbeRgenoYoEKclL9N
         kXu48tP1rlkojIXUNNN458qjt2ewJAbqEkl0M2R3uwmygQZz7/HckV/XU9uTuEjsW1r5
         F99PkFge4sgPgKKwDpV40pUJX8s7OUPUuj4WwhBHRIvNvgQWuSyiivcGjJ78TMrSlqDi
         SQET/uz1NTlUL/hz3xmR+Fh7+cN+3Yvyzwqj7EduWzsyWp3Gt8I3D0Ugmfb3vnOeNmHw
         3OxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271307; x=1779876107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+vsRneuQukq1VCZsxvt5EboIhJTKy6gqyaaIC0kDxc=;
        b=ZiV0/1jaDlmBGd5sl8N+iGSNbebYCBWwoRQfjAoMrcokdBFz3y2GVvGC8D4XH8Ezcy
         jwtd6RGubkwx6i4/+RLiwtEUaIDkp3znTebe11EdA1FQ7F60al1gSba6eNijFZSIeUCW
         KWs77OnaLdkj5QH/mHk0ig5AhlRNsxbGttgx6slTsqBoYxWIkJDDktW//MH5SayOnqg0
         si/1QdYW8VmyGsnrGCWNsbpl4OQ0F5XXMMUafCWSeJDUvg4Ogb/D/MSPGjLsqtVyOzLI
         AlkVwYbaHYMQrzjdMOnWqwuQfqMmOjMo3ZdGcwfxjuNRjChO759xnLgrkjGDYNLAO/dQ
         NrOA==
X-Forwarded-Encrypted: i=1; AFNElJ/1Lksr6fbMIi4GKgeQBeiqmbGDPZQyNyYlf/J9l3VYHPVfQE2O85pFfi0K8mi2uzLckbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFRjfmsKqzq3sOxqJ1Oy6OYTILS7ofzLFUsjzBu2g58+ctgERJ
	LR16Rh9qGCurJo5te4OpkDETunK+F9TeNjPwl5jOqQnYjSmDRB4RhJD9
X-Gm-Gg: Acq92OEe3IXWuXFCxK2Ql+JC3mhQwtu4qcOi+5SUVglpB1mb+V+LdsYtXfpY82/Hu64
	rfJ1mkE37RnDdqS9/QhxuTt6W4GsYoG8qb+wrkYIqcp7actKgts6Jwnv6c6HTsEGxYNgmHzYpku
	Ul2dN9cB98kjCt2262sQct1rJP1Ii0mw3i6wVv6CHDuGJjsjE/pTpZYg8NIImx18xPItPBW/s9D
	LtKWFSKGVbjOfCBndJ/qDP6NBG0AZpux79ALkTWw2M11JrNdiPLt/s+CqbdtYicd/GP2bBgiNwP
	YtyLKEPe204Q85ygFngOv9stKk+BzkScS8Of1B0EmHhdZLZTVWA5NTFpPDTUVZSPDxj+MDguzMW
	ZZvpJPLxsAQJG1dsbMxL8Sj+PCl/+vqe6RxjZxZMheEfSJ09apQmKib/P4bMGl1gq
X-Received: by 2002:a05:6512:3b96:b0:5a8:6391:4fe5 with SMTP id 2adb3069b0e04-5aa0e7647c2mr8015525e87.26.1779271306104;
        Wed, 20 May 2026 03:01:46 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164cb606sm4795698e87.63.2026.05.20.03.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:01:45 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 20 May 2026 12:01:44 +0200
To: Harry Yoo <harry@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH 4/8] mm/slab: introduce kfree_rcu_nolock()
Message-ID: <ag2GiLJSA2Rguxf3@milan>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org>
 <aejeVK0J_jHSfVhD@milan>
 <aemevSofweaUSx0n@hyeyoo>
 <aeoD_Ts6hLsgNc9-@pc636>
 <3s4jafam3la72a6y3dkfvhtzxk3fsngb2cka3bpfqrirl5m633@pz3vzizefoxb>
 <afNG0jNQNYeZ940g@pc636>
 <82d2145a-9b41-4ee4-b980-e7bd5d12f035@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82d2145a-9b41-4ee4-b980-e7bd5d12f035@kernel.org>

On Tue, May 19, 2026 at 04:44:30PM +0900, Harry Yoo wrote:
> [Resending as it's rejected by mailing lists due to my broken email
>  setup. Apologies for the noise.]
> 
> *shows up late again after LSFMM and processing some backlog*
> 
> On 4/30/26 9:10 PM, Uladzislau Rezki wrote:
> > Hello, Harry!
> > 
> > > 
> > > Hi Ulad. Apologies for the delayed response.
> > > I meant to reply sooner but sidetracked by other issues.
> > > 
> > No problem, sometimes i also can lag because of other tasks :)
> > 
> > > Your questions are fair, but let me try to clarify
> > > the current situation.
> > > 
> > > And before diving into details, I would like to reiterate that
> > > there are potentially two points to discuss here:
> > > 
> > > Point 1. Can we justify complicating subsystems by passing
> > > 	 `allow_spin` parameter all over the place?
> > > 
> > Yes, we can. But as i noted i see some drawbacks :)
> > 
> > - all new incoming patches have to respect that new third argument;
> 
> That is true :)
> 
This is i would like to avoid :)

> > - the fallback mechanism which uses irq-work is not optimal in my
> >    opinion:
> 
> In most cases it would not fall back because most likely trylock would
> succeed. If most of the calls do not fall back, a bit of suboptimality
> on the fallback path is acceptable.
> 
> >      a) We introduce an extra window between queuing a pointer, mark
> >         irq-work to be executed and then reenter the kfree_rcu() with
> >         no-sync flag and now we need to wait a GP for them. But the GP
> >         might be already passed for such pointers. So we potentially
> >         need more time to offload. This is rather minus.
> > 
> >      b) Since it is for BPF, allow_spin is always false, thus only
> >         fallback path is used. Decoupling comes to mind.
> 
> No, allow_spin == true means spinning on a lock is safe. If allow_spin
> is false, it would do a trylock instead of spinning, and it is expected
> to succeed most of the time. As long as trylock succeeds, it uses the
> same data structures as the existing kvfree_rcu batching without fallback.
> 
> > 
> >      c)
> > 
> > Why should we mix those? What it is worth to do, is to prevent mixing
> > "unknown path which is for BPF/others" with generic kfree_rcu().
> 
> Because we want to reuse the existing kvfree_rcu batching infrastructure
> without reinventing a new feature to do the same thing.
> 
> The intent is to avoid the fallback in most cases when allow_spin is
> false, with fallback being there for correctness.
>
The problem is that, it is a random behaviour with trylocking, i.e.
it is not deterministic. If you apply some noise you end up in kicking
two paths anyway.

If the idea is to reuse "existing kvfree_rcu batching" you need to
access the array in lock-free way. If you can do that, i would agree
with it.

> 
> > > Point 2. Can we avoid adding this complexity to kvfree_rcu() and
> > > 	 let slab handle it instead? (as mentioned in [4])
> > > 
> > it depends if BPF people want to free a pointer using RCU machinery?
> > Do you know if that an intention?
> 
> They want to free slab objects after RCU grace period. Freeing slab
> objects without involving RCU is already supported by kfree_nolock().
> (There are other use cases as well, as recently posted in [1])
> 
> I meant RCU sheaves can handle freeing slab objects after RCU grace
> period, and kfree_rcu_nolock() users don't need to handle vmalloc pages.
> So technically we don't have to add this complexity to kvfree_rcu
> batching and handle it in slab.
> 
> But to do that, we shouldn't disable kfree_rcu_sheaf() completely on RT.
> Apparently Vlastimil has a suggestion to address this, and I'm going to
> digest his suggestion and explore that aspect.
> 
> [1] https://lore.kernel.org/linux-mm/esepccfhqg7m6jo76ns2znj2cnuaepx2xvw5zaygtwohq4psma@563ypprp6rr3
> 
> [2] https://lore.kernel.org/linux-mm/6811cc17-8ee4-48c8-8cbf-6bf4d9f98162@kernel.org
> 
> > > On Point 1: IMHO it could be justified, but at the same time I hope we
> > > end up avoiding more complexity in the long term by working on Point 2.
> > > 
> > > This reply focuses only on Point 1 and explains why it could be
> > > justified.
> > > 
> > > On Thu, Apr 23, 2026 at 01:35:25PM +0200, Uladzislau Rezki wrote:
> > > > On Thu, Apr 23, 2026 at 01:23:25PM +0900, Harry Yoo (Oracle) wrote:
> > > > > On Wed, Apr 22, 2026 at 04:42:28PM +0200, Uladzislau Rezki wrote:
> > > > > How much performance do we sacrifice compared to
> > > > > letting them go through the kvfree_rcu() fastpath?
> > > > 
> > > > Freeing an object over RCU from
> > > > NMI context is a corner case. It is __not_ generic.
> > > 
> > > First, I want to clarify that kfree_rcu_nolock() is not just for NMI
> > > context. It is intended to be used when the context is unknown (because
> > > it can be called in an arbitrary code locations).
> > > 
> > When we say "unknown" to me it sounds like a worst case, which is NMI :)
> 
> If we say "allow_spin = false assumes the most restrictive context, such
> as NMI context", that is misleading. It sounds like we always fall back,
> but we don't. Even when the context is unknown, fallback isn't required
> most of the time.
> 
> So I would like to say "the context is unknown", meaning that
> technically kvfree_rcu could be re-entered in the middle of kvfree_rcu
> and we need to be able to handle that for correctness (although in most
> cases there's no re-entry and no fallback).
> 
> > > There are two kinds of problematic situations where BPF programs
> > > are attached to:
> > > 
> > >    - 1) a tracepoint or a function that can be invoked in a critical
> > >         section (w/ a lock held), or
> > > 
> > >    - 2) a function that can be called in an NMI context, which might
> > >         preempt an arbitrary context holding a lock.
> > > 
> > > While 1) and 2) are not (I think) dominant use cases, and although
> > > most of users can legally call kvfree_rcu(), BPF can't use kvfree_rcu()
> > > and must consider the most restrictive contexts.
> > > 
> > > > We even do not have(now
> > > > in mainline) users because we never support it from NMI,
> > > > just like call_rcu().
> > > 
> > > Unfortunately, we've had this use case (of allocating memory for BPF
> > > programs) for a long time in the mainline. There are two current
> > > approaches to mitigate the limitation:
> > > 
> > >    - 1) Pre-allocate all memory. e.g.) allocate all hash table elements
> > >         when creating a BPF map, rather than allocating them on demand.
> > >         This ensures correctness but sacrifices memory.
> > > 
> > >    - 2) Use the BPF-specific memory allocator [1] [2] to allocate memory
> > >         on demand and avoid preallocation. While this wastes less memory
> > >         than 1) and also maintains performance, it is re-inventing yet
> > >         another memory allocator.
> > > 
> > >         Also, the allocator reinvented kfree_rcu batching as well.
> > > 
> > > Now, we're trying to avoid 1) and 2) as much as possible and use
> > > kmalloc_nolock() instead [3].
> > > 
> > > > If BPF needs
> > > > it, then the first question which comes to mind is not about performance.
> > > > It is how to support this case in kfree_rcu() without adding noticeable
> > > > complexity or overhead or hacks to the generic path without making it harder
> > > > to maintain.
> > > 
> > > Since there will be only few subsystems that needs it, and because
> > > they already use it on production systems, I don't see much value in
> > > maintaining a simple implementation if that compromises performance
> > > (and thus make the transition harder).
> > > 
> > > > Performance wise you noted, you mean:
> > > > 
> > > > a) call latency(this is probably the most important for NMI)?
> > > > b) memory footprint?
> > > > c) pointer-chasing overhead?
> > > 
> > > I think it's either
> > > 
> > > - The performance of kfree_rcu_nolock() itself (a), or
> > > - Not distrubing workloads running on the machine (b and c)
> > > 
> > > depending on what people use BPF for.
> > > 
> > Are you aware of any specific workloads which we can run? To test
> > and see what we have when it comes to performance metrics? I mean
> > exact uses cases with exact steps who to trigger them?
> > 
> > That would be useful to see on behaviour.
> 
> I'll share once I find what BPF folks are using for performance
> benchmarks. (Which means I'm not aware at the moment :D)
> 
Please share.

--
Uladzislau Rezki

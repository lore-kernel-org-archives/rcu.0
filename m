Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09801F238D;
	Tue, 21 Jan 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737468864; cv=none; b=QkL9Cklol8/satZHDTVi7nGGd8P69KVI0PHDzdedNjB3GkiH8Po0/4LRF9HjD1ajF6Fmz5n96ol0Fg/ky3xxCu7rDTzzEc7KzoAT36cbvP9B4X2c4K/p6R5+9XioN6YpCYZxdmsyUTXbKNxwgFnTH/ypIgqFRmcDplxqTYfOsgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737468864; c=relaxed/simple;
	bh=s0cSh+afDKsjRtKKcIlm4glLB1LrODLQV8oxJGscMic=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fM5aU9HemELrFV+pvaxn2wEMmUxifpsMM2goVgSl6SWq37wlgRjrHU/PnAmgFeCQMbtOsC6SI2DfRYz7b1vhtddkrU1mpVrsZJi1L6OfOWkPTq1dk22BfpXfL4+KXLJ7w27ZU3TodTjUmDbq1Veik/mUKfJrPeYm6gaDRsoAjvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhgDuXtu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhgDuXtu"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so7090321e87.1;
        Tue, 21 Jan 2025 06:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737468860; x=1738073660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gIQOpzR6yNWoD8ipC5V3XjuHm0att9yM9ZGjy6IN9+A=;
        b=AhgDuXtuqylDMQUkDJpXVpasDPAsNuAsiufRBrs9StwcG8uY07nsvEK1kRX4fFgFiN
         bAOYOrc8Ofnj6qWjFHdcg/ysKWzQRbO2GrVuCAejoERYdC7InoJnGHu2YkQRJV+LrKyD
         3WQboaAfNUZzIl79mqFgTwHlf2INYVAp2eGw83ZvtZ7G/8VtKpNh0sDoyB0stvna1hX5
         Piy2qFZCrP/K5qcWPne/vxSIrzZhDQNRpxgLafQgcws4wVeo4B4/lqPrvw2ki6BPTost
         XJZa7/Ee6BptGs3OD0wm14Yz1WHnImYjqllfTebV7mdhksvlDWX+Yu1RpfBzV5c0IS2u
         wjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737468860; x=1738073660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIQOpzR6yNWoD8ipC5V3XjuHm0att9yM9ZGjy6IN9+A=;
        b=ni+DTRVnsdOK+yArWqoBQ2+NJ9XiEU0bZPBS0vAw+JcCO0cQzBOeQ/ubyYLl9dSsew
         Vh+7fQfBHmep4Z56PnZoBwYJLB9NKjyA9b4YS+KaFZqfvG2JkUMcXTG2GSijpmZCiv+x
         D8l71oEJ1G57nd3g7qoNYXU7/mRgmeQ/TToDXGPCp6KkeJsOk75DoCR6CbwFlgAfCQxU
         Yt53PHsDExRXIoOz3RtloELqfdEVDrD5uiZDj7N19AHAztpJTvkEVre9GJZgjsn8i4xE
         5QaBJfJw8FrFRcCVSb9zPXAdJ3d8eHGGH/6wlLbapLN3vYuoFNhBAfFg4mCwomiznw9i
         FhvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeI5FuDG1vz0L0Xq5tPXE+akmdlUwAwanoCUQXJC4qE4zG7/PoYgJlQB5FUO847GTducRw+P5G2Fwq7jc=@vger.kernel.org, AJvYcCXm5OPXOhoJAG2BkiIZBNAR3pqRImsx4CLyPjTRo1fna5oSnpjujd0j3wyePY9f7MOVLh4/@vger.kernel.org
X-Gm-Message-State: AOJu0YxhqYUtYcPHm4ncbtAvnsHfy4WMCOsVT54Xa3YbHW5HtQNxAOZB
	JbN6/D396WE/LWwTaHZRkghl1FCTq1Tghz7v67On2zFDl30Rrk+YXb/2Bw==
X-Gm-Gg: ASbGncu2DC/2+qupT72FDFdm2W8yga4zsa4sC+LhcuGyOsuroAvQucVZ5TDjJWwaqnH
	kFpmySPwIBHaEC6YmQ+IPJAr/4/M26b92x6lUktL6QitqeicpTi9F4Ts1VD/saFERdmyR1uR/Rb
	y8XOUAttld/uuqkBvgek7M7xvxH2I/Ahh/b0+ef5qRCOlzLraAjdYn6ff8u2dwMDFR+az1eXKfg
	TI77n5PfX6ek4N7XY3O5wOs6EgMQYDZGqFZ6tloRb6FFA0D1tqzm/hlHvdkCMbNVhSmx7Mcz1r/
	I0ap5c2hLiFPVuk+ehTMRJUq
X-Google-Smtp-Source: AGHT+IHKF0UuYdysDJKBFPcl8RzGq0GxCejrD8bcJH7pNQ+0ZFK0IdVFdZ2wHHhQ10dForpl27zR0A==
X-Received: by 2002:ac2:5de1:0:b0:542:2e05:313b with SMTP id 2adb3069b0e04-5439bfb74b3mr4867627e87.21.1737468859654;
        Tue, 21 Jan 2025 06:14:19 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af0e8ffsm1867778e87.59.2025.01.21.06.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:14:18 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 21 Jan 2025 15:14:16 +0100
To: Vlastimil Babka <vbabka@suse.cz>, paulmck@kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
Message-ID: <Z4-ruJ3KVD3PieZi@pc636>
References: <17476947-d447-4de3-87bb-97d5f3c0497d@suse.cz>
 <Z2AJCI3cIR9ETFFu@pc636>
 <d352db4f-4bb8-4300-b235-bbd1bdb3aa21@suse.cz>
 <Z2BKLzOGv_Ki_7fj@pc636>
 <6fb206de-0185-4026-a6f5-1d150752d8d0@suse.cz>
 <Z2BNWpkruY6rJv6A@pc636>
 <5bb80786-220d-45d2-bd35-51876df4203c@paulmck-laptop>
 <55931fdd-1d5f-4ffd-8496-fe436171dee2@suse.cz>
 <Z4-iDAONPyf7ljBU@pc636>
 <970317a9-0283-4eec-94ae-63056659d7de@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970317a9-0283-4eec-94ae-63056659d7de@suse.cz>

On Tue, Jan 21, 2025 at 02:49:13PM +0100, Vlastimil Babka wrote:
> On 1/21/25 2:33 PM, Uladzislau Rezki wrote:
> > On Mon, Jan 20, 2025 at 11:06:13PM +0100, Vlastimil Babka wrote:
> >> On 12/16/24 17:46, Paul E. McKenney wrote:
> >>> On Mon, Dec 16, 2024 at 04:55:06PM +0100, Uladzislau Rezki wrote:
> >>>> On Mon, Dec 16, 2024 at 04:44:41PM +0100, Vlastimil Babka wrote:
> >>>>> On 12/16/24 16:41, Uladzislau Rezki wrote:
> >>>>>> On Mon, Dec 16, 2024 at 03:20:44PM +0100, Vlastimil Babka wrote:
> >>>>>>> On 12/16/24 12:03, Uladzislau Rezki wrote:
> >>>>>>>> On Sun, Dec 15, 2024 at 06:30:02PM +0100, Vlastimil Babka wrote:
> >>>>>>>>
> >>>>>>>>> Also how about a followup patch moving the rcu-tiny implementation of
> >>>>>>>>> kvfree_call_rcu()?
> >>>>>>>>>
> >>>>>>>> As, Paul already noted, it would make sense. Or just remove a tiny
> >>>>>>>> implementation.
> >>>>>>>
> >>>>>>> AFAICS tiny rcu is for !SMP systems. Do they benefit from the "full"
> >>>>>>> implementation with all the batching etc or would that be unnecessary overhead?
> >>>>>>>
> >>>>>> Yes, it is for a really small systems with low amount of memory. I see
> >>>>>> only one overhead it is about driving objects in pages. For a small
> >>>>>> system it can be critical because we allocate.
> >>>>>>
> >>>>>> From the other hand, for a tiny variant we can modify the normal variant
> >>>>>> by bypassing batching logic, thus do not consume memory(for Tiny case)
> >>>>>> i.e. merge it to a normal kvfree_rcu() path.
> >>>>>
> >>>>> Maybe we could change it to use CONFIG_SLUB_TINY as that has similar use
> >>>>> case (less memory usage on low memory system, tradeoff for worse performance).
> >>>>>
> >>>> Yep, i also was thinking about that without saying it :)
> >>>
> >>> Works for me as well!
> >>
> >> Hi, so I tried looking at this. First I just moved the code to slab as seen
> >> in the top-most commit here [1]. Hope the non-inlined __kvfree_call_rcu() is
> >> not a show-stopper here.
> >>
> >> Then I wanted to switch the #ifdefs from CONFIG_TINY_RCU to CONFIG_SLUB_TINY
> >> to control whether we use the full blown batching implementation or the
> >> simple call_rcu() implmentation, and realized it's not straightforward and
> >> reveals there are still some subtle dependencies of kvfree_rcu() on RCU
> >> internals :)
> >>
> >> Problem 1: !CONFIG_SLUB_TINY with CONFIG_TINY_RCU
> >>
> >> AFAICS the batching implementation includes kfree_rcu_scheduler_running()
> >> which is called from rcu_set_runtime_mode() but only on TREE_RCU. Perhaps
> >> there are other facilities the batching implementation needs that only
> >> exists in the TREE_RCU implementation
> >>
> >> Possible solution: batching implementation depends on both !CONFIG_SLUB_TINY
> >> and !CONFIG_TINY_RCU. I think it makes sense as both !SMP systems and small
> >> memory systems are fine with the simple implementation.
> >>
> >> Problem 2: CONFIG_TREE_RCU with !CONFIG_SLUB_TINY
> >>
> >> AFAICS I can't just make the simple implementation do call_rcu() on
> >> CONFIG_TREE_RCU, because call_rcu() no longer knows how to handle the fake
> >> callback (__is_kvfree_rcu_offset()) - I see how rcu_reclaim_tiny() does that
> >> but no such equivalent exists in TREE_RCU. Am I right?
> >>
> >> Possible solution: teach TREE_RCU callback invocation to handle
> >> __is_kvfree_rcu_offset() again, perhaps hide that branch behind #ifndef
> >> CONFIG_SLUB_TINY to avoid overhead if the batching implementation is used.
> >> Downside: we visibly demonstrate how kvfree_rcu() is not purely a slab thing
> >> but RCU has to special case it still.
> >>
> >> Possible solution 2: instead of the special offset handling, SLUB provides a
> >> callback function, which will determine pointer to the object from the
> >> pointer to a middle of it without knowing the rcu_head offset.
> >> Downside: this will have some overhead, but SLUB_TINY is not meant to be
> >> performant anyway so we might not care.
> >> Upside: we can remove __is_kvfree_rcu_offset() from TINY_RCU as well
> >>
> >> Thoughts?
> >>
> > For the call_rcu() and to be able to reclaim over it we need to patch the
> > tree.c(please note TINY already works):
> > 
> > <snip>
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index b1f883fcd918..ab24229dfa73 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2559,13 +2559,19 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >                 debug_rcu_head_unqueue(rhp);
> > 
> >                 rcu_lock_acquire(&rcu_callback_map);
> > -               trace_rcu_invoke_callback(rcu_state.name, rhp);
> > 
> >                 f = rhp->func;
> > -               debug_rcu_head_callback(rhp);
> > -               WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> > -               f(rhp);
> > 
> > +               if (__is_kvfree_rcu_offset((unsigned long) f)) {
> > +                       trace_rcu_invoke_kvfree_callback("", rhp, (unsigned long) f);
> > +                       kvfree((void *) rhp - (unsigned long) f);
> > +               } else {
> > +                       trace_rcu_invoke_callback(rcu_state.name, rhp);
> > +                       debug_rcu_head_callback(rhp);
> > +                       WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> > +                       f(rhp);
> > +               }
> >                 rcu_lock_release(&rcu_callback_map);
> 
> Right so that's the first Possible solution, but without the #ifdef. So
> there's an overhead of checking __is_kvfree_rcu_offset() even if the
> batching is done in slab and this function is never called with an offset.
>
Or fulfilling a missing functionality? TREE is broken in that sense
whereas a TINY handles it without any issues. 

It can be called for SLUB_TINY option, just call_rcu() instead of
batching layer. And yes, kvfree_rcu_barrier() switches to rcu_barrier().

>
> After coming up with Possible solution 2, I've started liking the idea
> more as RCU could then forget about the __is_kvfree_rcu_offset()
> "callbacks" completely, and the performant case of TREE_RCU + batching
> would be unaffected.
> 
I doubt it is a performance issue :)

>
> I'm speculating perhaps if there was not CONFIG_SLOB in the past, the
> __is_kvfree_rcu_offset() would never exist in the first place? SLAB and
> SLUB both can determine start of the object from a pointer to the middle
> of it, while SLOB couldn't.
> 
We needed just to reclaim over RCU. So, i do not know. Paul probably
knows more then me :)

> >                 /*
> > <snip>
> > 
> > Mixing up CONFIG_SLUB_TINY with CONFIG_TINY_RCU in the slab_common.c
> > should be avoided, i.e. if we can, we should eliminate a dependency on
> > TREE_RCU or TINY_RCU in a slab. As much as possible.
> > 
> > So, it requires a more closer look for sure :)
> 
> That requires solving Problem 1 above, but question is if it's worth the
> trouble. Systems running TINY_RCU are unlikely to benefit from the batching?
> 
> But sure there's also possibility to hide these dependencies in KConfig,
> so the slab code would only consider a single (for example) #ifdef
> CONFIG_KVFREE_RCU_BATCHING that would be set automatically depending on
> TREE_RCU and !SLUB_TINY.
> 
It is for small systems. We can use TINY or !SMP. We covered this AFAIR
that a single CPU system should not go with batching:

#ifdef SLUB_TINY || !SMP || TINY_RCU

or:

config TINY_RCU
	bool
	default y if !PREEMPT_RCU && !SMP
+	select SLUB_TINY


Paul, more input?

--
Uladzislau Rezki

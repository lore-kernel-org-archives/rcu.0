Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6AA3FFADC
	for <rcu@vger.kernel.org>; Thu, 30 Apr 2026 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551065; cv=none; b=hkAggGcfhuO3sIA8Iw1NcuyJNdqAvesy8XBL8oD5Z6ysATOaibUVucgmfOzd6Ms8Of2NqeadYiHX505eCEZvmZYBpi+80oUxnPtyVvnnrCprwcZBlYLMraFhkIF3bdQOm7HJ/6miiT6yXOALSOi0TV87wqrnKX0+YbMxKHcq0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551065; c=relaxed/simple;
	bh=UeMZdvydeo3t22LoSaW6/DX+kcp2q0/JAz1hNDNMCA0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYaxouEKwbQkLl3YzxaSE2Az73B6ov89MdYLP18mDqsbl7snQpT5bumYdlCTK5iCSi6PJL5Y30C/tzfgKyGno4JuFCRQCCc44s8SyYwOWXcs6bw1NLiEQlQx44YBfG3k2biI0FXCKXByWXkooZqFnfYEmMrvk2Pkm538t7oJAKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzByj9IY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzByj9IY"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a40b2bc96dso846355e87.3
        for <rcu@vger.kernel.org>; Thu, 30 Apr 2026 05:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777551062; x=1778155862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t1qpxAkuAsOwU5i725XJCGiCdOGB9mh34dV03O6Zark=;
        b=YzByj9IY63ORNA386+zCVGO5R3Zw1m97dEnQVXRa4RmEQyF5+n1Ru79RNitwigAP8d
         BR2OX0apDiV7Utx3W55ttUQtPYGYvE0WJUOf0F7+uT7xIRqlCp2ZERssCxrRJYSgEceE
         hN3eVs70idcHe9YLVcBZON1Sr2FTNpQAq6qW8AJrRj+BwC4BMIrHL2H4O0lkSPFDQX82
         5SRYmZN9paJonDFtq3Wsal+q74gNYXb9P67PNsKkvpKXUPivUQSZ2+BpV3dTMROPXjQQ
         +V8TyAuyc8GTY6eAZoj81A7PNZZjXcvmuYNSsIGfz8shCA5NSMU8xa6PFV+GdCMY8qKg
         mqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777551062; x=1778155862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1qpxAkuAsOwU5i725XJCGiCdOGB9mh34dV03O6Zark=;
        b=qSa2ZGVOBLEnY/+cmQHWxepK6gnME1S16Q5kzPPFQ6byu+fFsRwO0n7tdL8ikwYdfi
         XVZPixcpBLWosDuZB8oBAEyeGv5oWwtE09nzaVVI5xykH9e3wTbX2hmbGxgIrthTZJiU
         CevWg8nZi+WQeUEBitFH2tXea0P5z0l2LIf6SEhNYxGGF2efIDZGHZh1AoPTiuIeUT2d
         fXvWuFag1yh5VlhKx5lV+nEWYcK2fxuvVrruVIBCO09ZGwgdGWh+WX4/bDljxanQmXu9
         SpX200P5G+RSiUY4yDMAvnnV17Ljcj72mBp9yf4YZPbGkqgU3LgyuljykEplxYO8Vs8Q
         Q1HQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7Ilu6/o4LAOx7VhHQptMdwDxSaaRPvt30FdQLT4MW2hxHP1WcVt80IBAq7xe+KxXLKvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Cw2rQhfMnwKM1b+jeObaOQhZ2x0nrFcD+UKapkPC9VFide8b
	Q5kPY0hkPdnzNDL8P7Y0KXT5jVAx3XmTauTh3BfhiZV0Rj1Qh7hKZk1P
X-Gm-Gg: AeBDies2wqAsDZAVLz1u6kUz0RQur/93z2GqzAc7D8fOafkZik0F9uZUfGMDYA+3QxM
	DkNtrftNa1kSfV8R6MkjHS8NXDbmX38BitDbUpyluBjvdtjOk6wVGOLXsQEHF6X5uriajFCFR5d
	2koSwJF9xQOC7SHyTunqHdisl6HCWHAD0FUEPWm+qgyxXpIqwWlfTypw1+3rhKneMAII1xuj6WG
	vtl1sgLnKR4onPEjn8CsqKlIPg61rJefwQyVRELIWIIZBzvN86WXJPDp9ioLUljICzHC9aJ7Yq3
	eKdN4hxuEe/ratztQw+PaZzfd4zpLTb0uIOvC+jI/Knt5IWBiv779xqpDrj47fiH27i+kQbTNBD
	NUJAZh6TpGqU+kOkOhTlSX3oXaVMtpUIiM/JWmZL3KBrdUPmQeHYwa8T1sX4t9jQmqfViWoLF5R
	1a08/F2i/+OS4W2NT4zvBPg8m4Ie+eiA3PQNwHSafIomV1EEHlNIytkinx
X-Received: by 2002:a05:6512:1092:b0:5a4:1add:c574 with SMTP id 2adb3069b0e04-5a8522b1d5emr849686e87.5.1777551061318;
        Thu, 30 Apr 2026 05:11:01 -0700 (PDT)
Received: from pc636 (host-95-203-5-23.mobileonline.telia.com. [95.203.5.23])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a74a769570sm1386080e87.66.2026.04.30.05.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 05:11:00 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 30 Apr 2026 14:10:58 +0200
To: "Harry Yoo (Oracle)" <harry@kernel.org>
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
	linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/slab: introduce kfree_rcu_nolock()
Message-ID: <afNG0jNQNYeZ940g@pc636>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org>
 <aejeVK0J_jHSfVhD@milan>
 <aemevSofweaUSx0n@hyeyoo>
 <aeoD_Ts6hLsgNc9-@pc636>
 <3s4jafam3la72a6y3dkfvhtzxk3fsngb2cka3bpfqrirl5m633@pz3vzizefoxb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3s4jafam3la72a6y3dkfvhtzxk3fsngb2cka3bpfqrirl5m633@pz3vzizefoxb>

Hello, Harry!

>
> Hi Ulad. Apologies for the delayed response.
> I meant to reply sooner but sidetracked by other issues.
> 
No problem, sometimes i also can lag because of other tasks :)

> Your questions are fair, but let me try to clarify
> the current situation.
> 
> And before diving into details, I would like to reiterate that
> there are potentially two points to discuss here:
> 
> Point 1. Can we justify complicating subsystems by passing
> 	 `allow_spin` parameter all over the place?
> 
Yes, we can. But as i noted i see some drawbacks :)

- all new incoming patches have to respect that new third argument;
- the fallback mechanism which uses irq-work is not optimal in my
  opinion:
    a) We introduce an extra window between queuing a pointer, mark
       irq-work to be executed and then reenter the kfree_rcu() with
       no-sync flag and now we need to wait a GP for them. But the GP
       might be already passed for such pointers. So we potentially
       need more time to offload. This is rather minus.

    b) Since it is for BPF, allow_spin is always false, thus only
       fallback path is used. Decoupling comes to mind.

    c) 

Why should we mix those? What it is worth to do, is to prevent mixing
"unknown path which is for BPF/others" with generic kfree_rcu().

It is easier to go that way and more cleaner, IMO. We need less code
and we fix a specific requirements.

>
> Point 2. Can we avoid adding this complexity to kvfree_rcu() and
> 	 let slab handle it instead? (as mentioned in [4])
> 
it depends if BPF people want to free a pointer using RCU machinery?
Do you know if that an intention?

> On Point 1: IMHO it could be justified, but at the same time I hope we
> end up avoiding more complexity in the long term by working on Point 2.
> 
> This reply focuses only on Point 1 and explains why it could be
> justified.
> 
> On Thu, Apr 23, 2026 at 01:35:25PM +0200, Uladzislau Rezki wrote:
> > On Thu, Apr 23, 2026 at 01:23:25PM +0900, Harry Yoo (Oracle) wrote:
> > > On Wed, Apr 22, 2026 at 04:42:28PM +0200, Uladzislau Rezki wrote:
> > > How much performance do we sacrifice compared to
> > > letting them go through the kvfree_rcu() fastpath?
> >
> > Freeing an object over RCU from
> > NMI context is a corner case. It is __not_ generic.
> 
> First, I want to clarify that kfree_rcu_nolock() is not just for NMI
> context. It is intended to be used when the context is unknown (because
> it can be called in an arbitrary code locations).
> 
When we say "unknown" to me it sounds like a worst case, which is NMI :)

> There are two kinds of problematic situations where BPF programs
> are attached to:
> 
>   - 1) a tracepoint or a function that can be invoked in a critical
>        section (w/ a lock held), or
> 
>   - 2) a function that can be called in an NMI context, which might
>        preempt an arbitrary context holding a lock.
> 
> While 1) and 2) are not (I think) dominant use cases, and although
> most of users can legally call kvfree_rcu(), BPF can't use kvfree_rcu()
> and must consider the most restrictive contexts.
> 
> > We even do not have(now
> > in mainline) users because we never support it from NMI,
> > just like call_rcu().
> 
> Unfortunately, we've had this use case (of allocating memory for BPF
> programs) for a long time in the mainline. There are two current
> approaches to mitigate the limitation:
> 
>   - 1) Pre-allocate all memory. e.g.) allocate all hash table elements
>        when creating a BPF map, rather than allocating them on demand.
>        This ensures correctness but sacrifices memory.
> 
>   - 2) Use the BPF-specific memory allocator [1] [2] to allocate memory
>        on demand and avoid preallocation. While this wastes less memory
>        than 1) and also maintains performance, it is re-inventing yet
>        another memory allocator.
> 
>        Also, the allocator reinvented kfree_rcu batching as well.
> 
> Now, we're trying to avoid 1) and 2) as much as possible and use
> kmalloc_nolock() instead [3].
> 
> > If BPF needs
> > it, then the first question which comes to mind is not about performance.
> > It is how to support this case in kfree_rcu() without adding noticeable
> > complexity or overhead or hacks to the generic path without making it harder
> > to maintain.
> 
> Since there will be only few subsystems that needs it, and because
> they already use it on production systems, I don't see much value in
> maintaining a simple implementation if that compromises performance
> (and thus make the transition harder).
> 
> > Performance wise you noted, you mean:
> > 
> > a) call latency(this is probably the most important for NMI)?
> > b) memory footprint?
> > c) pointer-chasing overhead?
> 
> I think it's either
> 
> - The performance of kfree_rcu_nolock() itself (a), or
> - Not distrubing workloads running on the machine (b and c)
> 
> depending on what people use BPF for.
> 
Are you aware of any specific workloads which we can run? To test
and see what we have when it comes to performance metrics? I mean
exact uses cases with exact steps who to trigger them?

That would be useful to see on behaviour.

Thank you!

--
Uladzislau Rezki

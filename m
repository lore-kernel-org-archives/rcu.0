Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD571D5CDD
	for <rcu@vger.kernel.org>; Sat,  4 Jan 2025 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736024185; cv=none; b=jZ1r6fRmDelTfw8KoqRcNszLjbj7p9N0WUNxwl6lL6KquMwl6TVudTgKizUqlIdTWcjSFDk207/u4N83oCSLk4z5/ojtEa0Bc2PQnmzxuLKeo9q3GpmIvIIho1S2LIP4x89AKQaKcYP/r6WwOB4TJFNWgf9rNKCgbo381I28t7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736024185; c=relaxed/simple;
	bh=6KBJecC06S1chS9LMLYYaaLDS0o0cxF0HWrHTQxw1Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEdGn4UT697gBmo6gk+lkQ2Yw4notAwa+1YyCq5M1k1ePMYJJ7A7TV6/yJ5V3In/VJ3voZkoAOGjlmblwZWZEyyUpy69V/YI2s2W50VVOshY09a+xof9F3+INwGdnXnT14TdeYYyolhjkhs1+6IIIcsOe0tsipFWTv2PI55I61o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke928T2M; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke928T2M"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-386329da1d9so6058349f8f.1
        for <rcu@vger.kernel.org>; Sat, 04 Jan 2025 12:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736024181; x=1736628981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l39P4RACVW18QiRc1FwJxKt4TShQMGGpGm+N8iwlnuA=;
        b=ke928T2MfsXPBE0HRm6R+HKmKgepaeO0N8ZUkGgiwoOx5hfho7aCXXvZfQ739fRTeu
         zXzDJDHQAVOOonpdWxPirBgeQyDXrTrX13nZ1IQmG7N9pshbg1UuOtViIdQurdXQBZhZ
         34fWdwg95Nw2yLuwrfDZZMFjUtMb5jIINQDJo6iLILLIKOazF8/HrbQ+Tdi5loNJOILZ
         szB/RlYbPZAgYs2yR9vJ0yDFFU/r27NgmDLMLhjVp2BUFspFJta+nFidi4CdgxSoL5n6
         Ap0b4N99F1Y/g6WgCPNFQsySGSKTHZPbkXj+m3SslptAffh1UKLrMF/EHD1AKpLq7LLu
         WHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736024181; x=1736628981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l39P4RACVW18QiRc1FwJxKt4TShQMGGpGm+N8iwlnuA=;
        b=M5mCpnWFl8pUROA4BL2tX3iiz7GAs9upV73rbx93GNTfQF/aSgmhhHTApQtFhjLMC3
         TrM5ApMFiySxHQuFhOtJn9jMipc4VfIMZj7sNSxgnRHEC9d5OzG54d6q9uzTW4vjn+vP
         nrHw/iK6/T36q0jbDLfhX/1UsYu9dVpSk+OgXNjG2diAY4+OTYK7Cwh2DiYZ+mJsxIiq
         3nAHFz+f8x3Y2CvFIiJlAphga41RfAMSVpxLeNz9fc/A7gejPOWc1X/5vpqK+DV1io8X
         FOVzIeeF0Z+brJxVdncvm2cjBOLNN1BOGbAvMDefgSpfpwkAywRv3S0Obq89Wzta9jPo
         sfww==
X-Gm-Message-State: AOJu0Yy1NWxfeS3qUoAgoy5Zw8EXIJvY5eSONVq6PmrcQZznxStGQrrJ
	RN7FVFfHL1RcZWf3nVaBhfmHUnHRl+WxJx5kjL4hVZ4CcXD5UCEw
X-Gm-Gg: ASbGnctLj7k0jUcSmVBe6AordCHxdwZvbkskaf+AMqv9OCVeHHfBfg4SWWIMFCn/M+b
	fN4uX01KWF1S6pUre+FYyi0A4PliEa6icVQcghHT0j9y2CR+51101kb4j/rq39wuPchDRlj38cp
	exnFLUfFD5Ux0Eqx8lBfZVMAUcpB2ds6fO3l4PT+7vEhmrRh84c4IUCsTPGHDP47R1FFYc3xdv/
	ec2dUtvycwJtmf1RP9Tk+jk3XdxjYpBPHooSTtMDUOXy9qe3yN3+wD1gjsm7CbRBcFESc+B51hH
	6tOC3HznyeBMRg==
X-Google-Smtp-Source: AGHT+IHydBlTtze8qgu5rA2dENndEsJl3ELc9Cs7w+9kweVrj8WrGCoblsH/ph+CudueOLlp3a1ayQ==
X-Received: by 2002:a05:6000:1866:b0:38a:20d9:32e6 with SMTP id ffacd0b85a97d-38a223ff35bmr46246522f8f.45.1736024181101;
        Sat, 04 Jan 2025 12:56:21 -0800 (PST)
Received: from ed.ac.uk (vpn-fn-230.net.ed.ac.uk. [192.41.114.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e69sm43496492f8f.35.2025.01.04.12.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 12:56:20 -0800 (PST)
Date: Sat, 4 Jan 2025 20:56:19 +0000
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, kmanaouil.dev@gmail.com
Subject: Re: Taking page faults in RCU critical sections
Message-ID: <20250104205619.juog4hsn4vramp6u@ed.ac.uk>
References: <20250102182343.vlgzo6wjf5abqxol@ed.ac.uk>
 <afa3b043-0591-463e-8b61-21db547a25ad@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afa3b043-0591-463e-8b61-21db547a25ad@paulmck-laptop>

On Thu, Jan 02, 2025 at 11:16:11AM -0800, Paul E. McKenney wrote:
> On Thu, Jan 02, 2025 at 06:23:43PM +0000, Karim Manaouil wrote:
> > Hi Paul,
> > 
> > First, I wish you a happy new year!
> 
> Hello, Karim, and a very happy square new year to you and yours as well!
> I have added the rcu email list in case someone else has ideas.
> 
> > I am working on implementing page migration for some types of kernel
> > memory. My technique is to remap those kernel pages in vmap/vmalloc 
> > area and allow the kernel to take page faults during page migration.
> > 
> > However, I have the problem of spinlocks and RCU critical sections.
> > A page fault can occur while the kernel is inside an RCU read critical
> > section. For example, in fs/dcache.c:dget_parent():
> > 
> > rcu_read_lock()
> > seq = raw_seqcount_begin(&dentry->d_seq);
> > rcu_read_unlock()
> > 
> > If the kernel page where "dentry" belongs to is undergoing migration,
> > a page fault could occur on the CPU executing the code above, when the
> > migration thread (running on another CPU) clears the corresponding 
> > PTE entry in vmap and flushes the TLB (but the new page is not mapped
> > yet).
> > 
> > The page table entries are replaced by migration entries, and the CPU,
> > on which the page fault happened, will have to wait or spin in the page
> > fault handler until the migration is complete (success or failure).
> > 
> > With calssical RCU, I cannot wait in the page fault handler (like it's
> > done in migration_entry_wait()) because that's explicit blocking and 
> > that's prohihited.
> 
> Indeed it is, and by design.
> 
> > I tried to spin in the fault handler with something like
> > 
> > for (;;) {
> > 	pte = ptep_get_lockless(ptep);
> > 	if (pte_none(pte) || pte_present(pte))
> > 		break;
> > 	cpu_relax();
> > }
> > 
> > But the entire system stopped working (I assume because rcu_synchronise()
> > on other CPUs is waiting for us and we are waiting for other CPUs, so a
> > deadlock situation).
> > 
> > I realised that I need something like preempt RCU. Would the cpu_relax()
> > above work with preempt RCU?
> 
> You would need something like cond_resched(), but you cannot use this
> within an RCU read-side critical section.  And spinning in this manner
> within a fault handler is not a good idea.  You will likely get lockups
> and stalls of various sorts.
> 
> Preemptible RCU permits preemption, but not unconditional blocking.
> The reason for this is that a preempted reader can be subjected to RCU
> priority boosting, but if a reader were to block, priority boosting
> would not help.
> 
> The reason that we need priority boosting to help is that blocked RCU
> readers stall the current RCU grace period, which means that any memory
> waiting to be freed continues waiting, eventually resulting in OOM.
> Of course, OOMs are not good for your kernel's uptime, hence the
> restriction against general blocking in RCU readers.

I believe not only OOM, but it could also lead to a deadlock, as I observed 
in my small experiments. Basically, one CPU (0) was blocked inside an RCU
region, waiting for another CPU (1), running the page migration/compaction
thread, but the migration thread itself (on CPU1) was trying to free some 
memory and it had to first wait for the existing RCU readers, amongst them
CPU0, and that lead to circular waiting (CPU0 waiting for CPU1, but
CPU1 ends up waiting for CPU0).

> Please note that spinlocks have this same restriction.  Sleeping while
> holding a spinlock can result in deadlock, which is even worse for your
> kernel's uptime.
> 
> > Do you have any ideas for how to properly approach this problem?
> 
> Here are a few to start with:
> 
> 0.	Look at the existing code that migrates processes and/or kernels
> 	from one system to another, and then do whatever they do.
> 
> 1.	Allocate the needed memory up front, before acquiring the
> 	spinlocks and before entering the RCU readers.
> 
> 2.	Move the existing spinlocks to mutexes and the existing uses
> 	of RCU to SRCU, perhaps using srcu_read_lock_lite().  But note
> 	that a great deal of review and benchmarking will be necessary
> 	to prove that there are no regressions.  And that changes of
> 	this sort in mm almost always result in regressions.
> 
> 	So I strongly advise you not to take this approach lightly.
> 
> 3.	Your ideas here!

For (0), it seems that most of the solutions along those lines are "stop
the world" kind of solutions, which is not ideal.

I thought about (2) before I sent you the email, but then I was
skeptical for the same reasons you listed.

I believe that another variation of (2) is the solution to this problem.

In fact, there is a very small window in which an RCU reader can trigger
a page fault, which is the window between flushing the TLB and updating
the page table entry.

This makes think that to prevent the deadlock situation above, I need to 
make sure that the page migration/compaction path should never wait for RCU
readers. In this case, the RCU reader will wait (spinning) for a bounded
amount of time which is the amount of time needed to close the window
described above: copy the contents of the old page to the new page, update
the page table entry and make the writes visible to the spinning RCU reader,
no blocking, no scheduling and no grace periods to wait for.

Do you think this is a sane approach? Obviously one down side is
burning CPU cycles while spinning, but it should be a small enough
amount of time.


> > Last question, do I need the -rt kernel for preempt RCU?
> 
> No, CONFIG_PREEMPT=y suffices.
> 
> Note that CONFIG_PREEMPT_RT=y, AKA -rt, also makes spinlocks (but not
> raw spinlocks) be limited sleeplocks, and thus allows RCU read-side
> critical sections to block when acquiring these sleeping "spinlocks".
> But this is OK, because all of this is still subject to priority boosting.
> 
> 							Thanx, Paul

Thank you!

-- 
Best,
Karim
Edinburgh University

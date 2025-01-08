Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91D86321
	for <rcu@vger.kernel.org>; Wed,  8 Jan 2025 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359290; cv=none; b=tSSmveIZUUmVzm813/SAPh17cTUm0RZu+o9LkZ+lnPQoMd4C6PN7L/XMESNUCGXBeMCmHtx1ZFeOpJdz4QNm5JKhki2o9ksgzN7U537C4HN9sWmMbSYf+aACgMdyXmhaphvKSUIHYWXinPp95j1rnUKbz5FkJkpIBkwbyJ4IEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359290; c=relaxed/simple;
	bh=650dGSI96g/7njRYZPYKjsOdkiWarvyMIogkEwLDb80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5hrEIs6VaKZvQ6NJpYfyoY6F0+R5aNFYChO//YmoTk0cLiMAPthXXNWVHijn+v/Bvqg78tQ5vCqckFU3jvRFRxx+FNvZjS+Wq/c5ibMV3DE3zGx5k6/L19YGsGISHZNTl7xddJpMA89BoyKsZv5wnN2XaWyPPqdr3vlRZctIoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIF6aRQg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIF6aRQg"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso57938f8f.1
        for <rcu@vger.kernel.org>; Wed, 08 Jan 2025 10:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736359287; x=1736964087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IYdRsSl+pV7tRZUF3cMAFxjF9wTTuqFQrvJNJjwFYTQ=;
        b=OIF6aRQgj7/r9g2Z6doMve/d8BM/5iWEDVVh8j2oRJ5Hw7+7WB/jgsxJfJEQZoyR3r
         23ec8VNmbakMF6YtG2za7VA6l+Bftfy1q9blMXUdok+TagEk/TAC7X6H+YES6R4nNMsA
         zPfifk4NYdteOxwg4S88vNDfYJajoOr5LBemI6Vr1dMWBbcEjcFboIzMx2sOJU6unEdw
         Vzvuw3X1W9cverQXhLQEoexArhlXGFe+p0/aga2Iiim9nT+EhWbR2RHYPoIrbhG1u9Kn
         g8ita8fm8LmAIKm0Z0Y3GkUHD2FmKrgr50yI7wowTikFdeggJgRlDe0XGzY/T6tYDDjh
         DKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736359287; x=1736964087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYdRsSl+pV7tRZUF3cMAFxjF9wTTuqFQrvJNJjwFYTQ=;
        b=VZedsIGMeXYAB2X8T7X1m+HIQUvNFsQknqHRzSGwI7vLmNFRTOuy+PiUNNAguu5OAm
         Em1h74gmYjRhEbBT9NBXtkEpc258ltvBm41a9I0eo1m1ZIaDPw3RJKXOMtEMNnf0CDcy
         T7Mt8qS/pIpI86cvkHBVaSZvCzpt5TZCukgY7On+7uphMUyVKrJFZfv5owa1XcrzdzVp
         6JTYztMVSzjWhdzHM0muaKoW237HdXJ3TkSOA537Rnl2Kxb294KOv+fEmORfb/JBN0JV
         yNhg721ulS1twn3aA+sGMXqXYH5uyI/nq2i5Zuti5FVupimC74hLpTdhIBXvHNJaeerB
         eD/g==
X-Gm-Message-State: AOJu0Ywk+SbT15Flk5UknLoKKgk7NC8W3m4lUsx3gAaqkATjNjWtNl1w
	4+sVpedpxhCMbefbldvUJQMOBPSgclEHBnFOQOI7ErYjYh9/7tpZtJw8GQ==
X-Gm-Gg: ASbGncspAF4CIMVHxp9bTU5WFIPGrOWInpM7yQsXPQMUqhtUpX5pJq+1uqtFxZifi7T
	e2//44gWDYJX2yse2rgVZ5fUmE4JEE0C4mRYx16xQoRLPI8vWPCIeEJpECY3AuJtwzg4ugo0XnO
	ZoThit2TCXBXHtId9lATkSHOwZmK5FZKUdAStgkOy0S0UIB78CCM+1XG5rQfRlvoe92E0EediPg
	XqVBBKE7hAkncUOgVnFsemWSV0TlFLPu0L+MSRHo4LY631xISAVYfYEDxjkk93Fi6yyrK/JetwT
	nDp3ipSKS/pwNw==
X-Google-Smtp-Source: AGHT+IG9addoRBybG+cSQGvErOFEcZNMlzo4YKgc+GQPB90+Eb3CirUoa6I79hLWof53BK9kSLAWSw==
X-Received: by 2002:a05:6000:154a:b0:385:eeb9:a5bb with SMTP id ffacd0b85a97d-38a872de3femr3472310f8f.17.1736359286230;
        Wed, 08 Jan 2025 10:01:26 -0800 (PST)
Received: from ed.ac.uk (vpn-fn-230.net.ed.ac.uk. [192.41.114.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c6ad3e3sm55242669f8f.0.2025.01.08.10.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 10:01:25 -0800 (PST)
Date: Wed, 8 Jan 2025 18:01:24 +0000
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: Taking page faults in RCU critical sections
Message-ID: <20250108180124.bm2xsajhgirzc2al@ed.ac.uk>
References: <20250102182343.vlgzo6wjf5abqxol@ed.ac.uk>
 <afa3b043-0591-463e-8b61-21db547a25ad@paulmck-laptop>
 <20250104205619.juog4hsn4vramp6u@ed.ac.uk>
 <b64b0008-40df-426e-9a9e-a1f80ac63f90@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64b0008-40df-426e-9a9e-a1f80ac63f90@paulmck-laptop>

On Sun, Jan 05, 2025 at 11:21:29AM -0800, Paul E. McKenney wrote:
> On Sat, Jan 04, 2025 at 08:56:19PM +0000, Karim Manaouil wrote:
> > On Thu, Jan 02, 2025 at 11:16:11AM -0800, Paul E. McKenney wrote:
> > > On Thu, Jan 02, 2025 at 06:23:43PM +0000, Karim Manaouil wrote:
> > > > Hi Paul,
> > > > 
> > > > First, I wish you a happy new year!
> > > 
> > > Hello, Karim, and a very happy square new year to you and yours as well!
> > > I have added the rcu email list in case someone else has ideas.
> > > 
> > > > I am working on implementing page migration for some types of kernel
> > > > memory. My technique is to remap those kernel pages in vmap/vmalloc 
> > > > area and allow the kernel to take page faults during page migration.
> > > > 
> > > > However, I have the problem of spinlocks and RCU critical sections.
> > > > A page fault can occur while the kernel is inside an RCU read critical
> > > > section. For example, in fs/dcache.c:dget_parent():
> > > > 
> > > > rcu_read_lock()
> > > > seq = raw_seqcount_begin(&dentry->d_seq);
> > > > rcu_read_unlock()
> > > > 
> > > > If the kernel page where "dentry" belongs to is undergoing migration,
> > > > a page fault could occur on the CPU executing the code above, when the
> > > > migration thread (running on another CPU) clears the corresponding 
> > > > PTE entry in vmap and flushes the TLB (but the new page is not mapped
> > > > yet).
> > > > 
> > > > The page table entries are replaced by migration entries, and the CPU,
> > > > on which the page fault happened, will have to wait or spin in the page
> > > > fault handler until the migration is complete (success or failure).
> > > > 
> > > > With calssical RCU, I cannot wait in the page fault handler (like it's
> > > > done in migration_entry_wait()) because that's explicit blocking and 
> > > > that's prohihited.
> > > 
> > > Indeed it is, and by design.
> > > 
> > > > I tried to spin in the fault handler with something like
> > > > 
> > > > for (;;) {
> > > > 	pte = ptep_get_lockless(ptep);
> > > > 	if (pte_none(pte) || pte_present(pte))
> > > > 		break;
> > > > 	cpu_relax();
> > > > }
> > > > 
> > > > But the entire system stopped working (I assume because rcu_synchronise()
> > > > on other CPUs is waiting for us and we are waiting for other CPUs, so a
> > > > deadlock situation).
> > > > 
> > > > I realised that I need something like preempt RCU. Would the cpu_relax()
> > > > above work with preempt RCU?
> > > 
> > > You would need something like cond_resched(), but you cannot use this
> > > within an RCU read-side critical section.  And spinning in this manner
> > > within a fault handler is not a good idea.  You will likely get lockups
> > > and stalls of various sorts.
> > > 
> > > Preemptible RCU permits preemption, but not unconditional blocking.
> > > The reason for this is that a preempted reader can be subjected to RCU
> > > priority boosting, but if a reader were to block, priority boosting
> > > would not help.
> > > 
> > > The reason that we need priority boosting to help is that blocked RCU
> > > readers stall the current RCU grace period, which means that any memory
> > > waiting to be freed continues waiting, eventually resulting in OOM.
> > > Of course, OOMs are not good for your kernel's uptime, hence the
> > > restriction against general blocking in RCU readers.
> > 
> > I believe not only OOM, but it could also lead to a deadlock, as I observed 
> > in my small experiments. Basically, one CPU (0) was blocked inside an RCU
> > region, waiting for another CPU (1), running the page migration/compaction
> > thread, but the migration thread itself (on CPU1) was trying to free some 
> > memory and it had to first wait for the existing RCU readers, amongst them
> > CPU0, and that lead to circular waiting (CPU0 waiting for CPU1, but
> > CPU1 ends up waiting for CPU0).
> 
> Yes, making an RCU read-side critical section wait, whether directly or
> indirectly, on an RCU grace period is a good way to achieve deadlock.
> 
> > > Please note that spinlocks have this same restriction.  Sleeping while
> > > holding a spinlock can result in deadlock, which is even worse for your
> > > kernel's uptime.
> > > 
> > > > Do you have any ideas for how to properly approach this problem?
> > > 
> > > Here are a few to start with:
> > > 
> > > 0.	Look at the existing code that migrates processes and/or kernels
> > > 	from one system to another, and then do whatever they do.
> > > 
> > > 1.	Allocate the needed memory up front, before acquiring the
> > > 	spinlocks and before entering the RCU readers.
> > > 
> > > 2.	Move the existing spinlocks to mutexes and the existing uses
> > > 	of RCU to SRCU, perhaps using srcu_read_lock_lite().  But note
> > > 	that a great deal of review and benchmarking will be necessary
> > > 	to prove that there are no regressions.  And that changes of
> > > 	this sort in mm almost always result in regressions.
> > > 
> > > 	So I strongly advise you not to take this approach lightly.
> > > 
> > > 3.	Your ideas here!
> > 
> > For (0), it seems that most of the solutions along those lines are "stop
> > the world" kind of solutions, which is not ideal.
> 
> How about the solutions that are not "stop the world"?
> 
> > I thought about (2) before I sent you the email, but then I was
> > skeptical for the same reasons you listed.
> 
> Fair enough!
> 
> > I believe that another variation of (2) is the solution to this problem.
> > 
> > In fact, there is a very small window in which an RCU reader can trigger
> > a page fault, which is the window between flushing the TLB and updating
> > the page table entry.
> > 
> > This makes think that to prevent the deadlock situation above, I need to 
> > make sure that the page migration/compaction path should never wait for RCU
> > readers. In this case, the RCU reader will wait (spinning) for a bounded
> > amount of time which is the amount of time needed to close the window
> > described above: copy the contents of the old page to the new page, update
> > the page table entry and make the writes visible to the spinning RCU reader,
> > no blocking, no scheduling and no grace periods to wait for.
> > 
> > Do you think this is a sane approach? Obviously one down side is
> > burning CPU cycles while spinning, but it should be a small enough
> > amount of time.
> 
> Maybe?
> 
> If you are running in a guest OS, can vCPU preemption cause trouble?
> There are lots of moving parts in TLB flushing, so have you checked all
> the ones that you need to in this case?

Great points! I'll investigate the vCPU preeemption case. Thanks, Paul!

> One (rough!) rule of thumb is that if you can use a spinlock to protect
> the race window you are concerned about, then it is OK to spin waiting
> for that race window from within an RCU read-side critical section.
> 
> But as always, this rule is no substitute for understanding the
> interactions.

I think that should be the case. I am trying to run real world tests and
see how it goes. I am cleaning SLUB to make it easier to isolate slab
folios and then I'll have the chance to get some early
results/observations.

Thanks for the feedback, Paul!
> 							Thanx, Paul
> 
> > > > Last question, do I need the -rt kernel for preempt RCU?
> > > 
> > > No, CONFIG_PREEMPT=y suffices.
> > > 
> > > Note that CONFIG_PREEMPT_RT=y, AKA -rt, also makes spinlocks (but not
> > > raw spinlocks) be limited sleeplocks, and thus allows RCU read-side
> > > critical sections to block when acquiring these sleeping "spinlocks".
> > > But this is OK, because all of this is still subject to priority boosting.
> > > 
> > > 							Thanx, Paul
> > 
> > Thank you!
> > 
> > -- 
> > Best,
> > Karim
> > Edinburgh University

-- 
Best,
Karim
Edinburgh University

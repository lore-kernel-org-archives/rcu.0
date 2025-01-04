Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23FE1D5CC4
	for <rcu@vger.kernel.org>; Sat,  4 Jan 2025 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736025328; cv=none; b=ms9IiJK/6XTd4HRnSmadU3i8ZiJ7V1wr/XVGykWMcfr+s8owtiDgtTW3G9xJbzHw5RMWn5vtHq2uds572U8czj3vaaggtyM5QmqhhX3ndpz4c+SVxNAKJjrmax96grX2dehvcysWJC96SSvY7lF/7Cz/InYVKmTNHzWM24iWkak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736025328; c=relaxed/simple;
	bh=VrSTH8pfQ8HPYFLkFEmvfwyvhyzEu1YyvKcTzx4CQoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWTJnGq5z3V+AAJUr11TUIKmkfUxiDJsn76TnXB8AUh4vSLxIpkL0ZqQNrc/EV27fyF3oXosHIMkgXLcyUfKQ01MP7SvROXHvgW3Qe9hg6tIOVDAUkQxHHTu/zCn27zGKXkcxV03X9EXwtI04uQfY/7a0G8ar5lR43wQT/X+if8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYn9s+tQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYn9s+tQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43626213fffso82841305e9.1
        for <rcu@vger.kernel.org>; Sat, 04 Jan 2025 13:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736025323; x=1736630123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GWgolHKaPvRRI3N7rRxTgXzx1FDg/uaN0c7CX6t6lv0=;
        b=XYn9s+tQ2Jqm21jHy9XnFDszkFqM3YtxEYNB63AATHNG1r3IzJQKw9RQ0MM2LLeel9
         B3Q59/ulKWs2Ful4r4xaDknHxwO1JNvG2bUCCyAXyRrFuNJ2ud3NIQTDaaOb/KOy9yBD
         PVZ0v3d1EUhuVrNF1d0Hcs8cRX/rBAKyAVB2gWlKkQks9DIfFFKQ5aQCLWGmlnv79Zy9
         EHp45MYyGtwzeb3lH4ZNZcJ131jnN0jrSoNho0pRDmVokq98/ZKdKfhUOzQMMhRv1yoN
         BGqkmKTi0ynQByowC27y3MHjiBG5BO1j1UyKCC4pAC7DorNjFNQHyl2JMpmcqtWojdXT
         iJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736025323; x=1736630123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWgolHKaPvRRI3N7rRxTgXzx1FDg/uaN0c7CX6t6lv0=;
        b=c33DFQM+6mHu/deMtK2fsnoh4H3nTSSTHXYwCDAgapqRSYRpg/IpEomh3gQdDDRmla
         eNicZYyIrJN+X+zYa5BG3pqlmfYoNZ0dgEiB2TDLa6Cvn9BXWbKZRQQoV/Gu65f/G22o
         BRdIsKy3BA7FcU7ZdS2hsGLxkODSZxQBzIIUZpRVsb2aYS23IFeHsE2Z2VOBgvz96K74
         e/lePgGdZWgtr9VOQ2/e9SEHybSNZBXZr0N0RjVxfzvyfwYng5eW+Amr7QAcKkasqdv1
         J5T75SxDCZ5HmgU4/LMykhCewQX9UFOlzrPjuZmzv1GmiinBAiAFambeWVBnJSGA7A1V
         b2ig==
X-Forwarded-Encrypted: i=1; AJvYcCUr9KYPfq6ukAxzFBPCARFYLdOau1KeL15zMcblOuTIdktqUWxJXzBJYgof0TozFDwW5sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXj+HeyKHMRHEQvLjzqFYF/ZhHJ0HU7aqdw6am9KSFbBKA/v55
	zc4UkNQjPbzKg+43iXspfCoiOwBFjOzidyIi+aRdXcgMYYqyZJOR
X-Gm-Gg: ASbGncvF9LOaT4OYNMPjJuslqZYh4ipliCghpDOTRPwlVxrzwzk0Vbq/3dlKLhd+wM9
	MBCtpS2Kqo0FU3wiGZU10CrRFSNWoOYnwIF66MK3Q1ztFyJsL/Hmo3RanfzB5cAhSsj2uCRKuB1
	nn3XxSCTpAT9P21d/pslV9CcXLhHPkoeFisZeUv1dfW/yMrg50B96jMnlDVNM6m8AJTSVNE8P7E
	QhKNhmEMIa9EdssyU+kyIK2y5NrpDRPuTZa1figkdQ1oH/ruaTGaZsmKEhnMwchIfoqcAomvmBx
	I7EThD2DCZOKJA==
X-Google-Smtp-Source: AGHT+IEh75Fprn/8dVapJquUj9nolGJ2+W64VzqXGcgieqY1t7SDruk+fD2Nfn7ZYRQN36RMygGQRQ==
X-Received: by 2002:a05:6000:1ac7:b0:386:4332:cc99 with SMTP id ffacd0b85a97d-38a1a233539mr47792935f8f.17.1736025322410;
        Sat, 04 Jan 2025 13:15:22 -0800 (PST)
Received: from ed.ac.uk (vpn-fn-230.net.ed.ac.uk. [192.41.114.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847d7fsm43858451f8f.60.2025.01.04.13.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 13:15:21 -0800 (PST)
Date: Sat, 4 Jan 2025 21:15:20 +0000
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, kmanaouil.dev@gmail.com
Subject: Re: Taking page faults in RCU critical sections
Message-ID: <20250104211520.kfvsu63m4fmvktt6@ed.ac.uk>
References: <20250102182343.vlgzo6wjf5abqxol@ed.ac.uk>
 <afa3b043-0591-463e-8b61-21db547a25ad@paulmck-laptop>
 <CAEXW_YT5W2R4ebof1Eo5hix1JasHm0Kz_nDOxM9Fv-k7iNGsmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YT5W2R4ebof1Eo5hix1JasHm0Kz_nDOxM9Fv-k7iNGsmQ@mail.gmail.com>

Hi Joel,

On Thu, Jan 02, 2025 at 07:58:09PM -0500, Joel Fernandes wrote:
> Hi Karim and Paul,
> 
> On Thu, Jan 2, 2025 at 2:16 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> On Thu, Jan 02, 2025 at 06:23:43PM +0000, Karim Manaouil wrote:
> > > First, I wish you a happy new year!
> > Hello, Karim, and a very happy square new year to you and yours as well!
> > I have added the rcu email list in case someone else has ideas.
> 
> Happy new year wishes to you all as well!
> 
> > > I am working on implementing page migration for some types of kernel
> > > memory. My technique is to remap those kernel pages in vmap/vmalloc
> > > area and allow the kernel to take page faults during page migration.
> > >
> > > However, I have the problem of spinlocks and RCU critical sections.
> > > A page fault can occur while the kernel is inside an RCU read critical
> > > section. For example, in fs/dcache.c:dget_parent():
> > >
> > > rcu_read_lock()
> > > seq = raw_seqcount_begin(&dentry->d_seq);
> > > rcu_read_unlock()
> > >
> > > If the kernel page where "dentry" belongs to is undergoing migration,
> > > a page fault could occur on the CPU executing the code above, when the
> > > migration thread (running on another CPU) clears the corresponding
> > > PTE entry in vmap and flushes the TLB (but the new page is not mapped
> > > yet).
> > >
> > > The page table entries are replaced by migration entries, and the CPU,
> > > on which the page fault happened, will have to wait or spin in the page
> > > fault handler until the migration is complete (success or failure).
> > >
> > > With calssical RCU, I cannot wait in the page fault handler (like it's
> > > done in migration_entry_wait()) because that's explicit blocking and
> > > that's prohihited.
> >
> > Indeed it is, and by design.
> 
> True. Interesting problem.
> 
> > > Do you have any ideas for how to properly approach this problem?
> >
> > Here are a few to start with:
> >
> > 0.      Look at the existing code that migrates processes and/or kernels
> >         from one system to another, and then do whatever they do.
> >
> > 1.      Allocate the needed memory up front, before acquiring the
> >         spinlocks and before entering the RCU readers.
> >
> > 2.      Move the existing spinlocks to mutexes and the existing uses
> >         of RCU to SRCU, perhaps using srcu_read_lock_lite().  But note
> >         that a great deal of review and benchmarking will be necessary
> >         to prove that there are no regressions.  And that changes of
> >         this sort in mm almost always result in regressions.
> >
> >         So I strongly advise you not to take this approach lightly.
> >
> > 3.      Your ideas here!
> 
> I am a bit nervous that if it is entirely possible to eliminate
> page-fault rabbit holes, what if the page fault handler itself causes
> a fault because it accesses some memory that was now backed by an
> invalid PTE?

You are right. However, it is very easy to prevent that from happening by
limiting migration for only certain types of kernel pages. In my patchset
(which I'm hoping to send soon), I only care about slab pages from certain
particular kmem caches. The page fault handler has no business to do with
the objects contained in those slabs, and therefore will never try to access
them and trigger a recursive page fault.

> To that end, I was wondering if any of the following approaches are possible:
> 
> 1. When the memory is being migrated, allow the old memory to still be
> accessible until the migration completes. Then "atomically" modify the
> PTE to point to the new memory. Orchestrate this in a way that no
> fault should occur.

This is impossible because to copy the contents of the old page to the
new page, you have to stabilise the old page by preventing concurrent
updates (by unmapping the page and flushing the TLB prior to copying),
which renders the page inaccessible to other CPUs, including the RCU
reader trying to dereference the objects contained in the page.

> 2. Try to see if page faults can be avoided entirely by not executing
> the offending code. In Android GC, a page movement algorithm is being
> explored AFAIK where there is a "stop the world" pause preventing code
> from executing until the memory is moved to the new location. mremap()
> is used in userspace to do this move so I admit this is a bit
> tangential, but conceptually the ideas are similar.

Hmm that's one possible way. Send an IPI to all the other CPUs prior to
unmapping the page and ask them to block while the kernel page is being
migrated. If you have many pages to migrate and migration is frequent,
this may not be appreciated at all.

> > > Last question, do I need the -rt kernel for preempt RCU?
> >
> > No, CONFIG_PREEMPT=y suffices.
> >
> > Note that CONFIG_PREEMPT_RT=y, AKA -rt, also makes spinlocks (but not
> > raw spinlocks) be limited sleeplocks, and thus allows RCU read-side
> > critical sections to block when acquiring these sleeping "spinlocks".
> > But this is OK, because all of this is still subject to priority boosting.
> 
> Should PREEMPT_RT kernels not throw warnings though when calling
> rcu_note_context_switch() in RCU read-side sections?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/rcu/tree_plugin.h#n331
> 
> I don't run a PREEMPT_RT kernel myself so I can't confirm if these
> warnings somehow don't appear, but I figured it would be good to
> double check in this discussion.
> 
> thanks,
> 
> - Joel

-- 
Best,
Karim
Edinburgh University

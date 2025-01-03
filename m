Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219F2E822
	for <rcu@vger.kernel.org>; Fri,  3 Jan 2025 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735865908; cv=none; b=LAvffuzg5OGnFhD11iQYJswC75y6ZQ9FPnXKEJplz7DTLXcJYCw9fLugPXm5W9EhN9WV3A/A/NAeAdLqWUIc1eyj/nWASHn2HeH0lizJyTegOwppaeR7VwH3oVH3zuHyK5TZ3/0zv6mt7z+gYnDZyrnKdD1/lJ6zyEOMvjZM3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735865908; c=relaxed/simple;
	bh=Xdb0ESE69oyCds7yC58Rx4Rm+5w/WQRhF3aMti8GMds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tgt3zr1fOOUbBWcILAlBoi50bvfx/kAvKt4wZFmaAsZ9+xV7qS+yJDgkrdcwmRfQ+TtW/StJ0We7t0bBJNNdZEN7lE+8k55pIYl+PENRxfbXGJJKOwAEdVsE9d3qZ2uA4wdVNaoP7T9XCBnF9AekbeY2tc4V0/2WThPJ1s/QcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=RV5CWk0q; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RV5CWk0q"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361c705434so85965495e9.3
        for <rcu@vger.kernel.org>; Thu, 02 Jan 2025 16:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1735865904; x=1736470704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrxXtxpP/KQaBOTTUsns38rorG+cZfbOfLLhbhhF/JA=;
        b=RV5CWk0qnT9qRyPHEz5t6WHhoPaqTr8Gk5yKxkxACKd07z7AziFskI761nt6ZnGn45
         5O+qyWO/UGhvkvm4gRo6P8B3TT4SAXAkTc8ENW3EDeKKXVqmrdYpqXWDSSkJqawKVIXu
         AlrYP4EWSNHWstVQJN4HVktD6aDVYbFSWFGe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735865904; x=1736470704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrxXtxpP/KQaBOTTUsns38rorG+cZfbOfLLhbhhF/JA=;
        b=k/YPXQVG1hzFxzueVJRk1Inkoe7qjlzC6SJ6Cj5WRWqKvYxjWPSfOnZEfXFAEn+YWY
         vFcW8s60TL9xb9nwhxKYs8KEF4lWLGGk4RxMoXZ9zNnViY+TwgvIAXQbLE6EXGgaQ+m2
         SsXB2vuDsWybHrOrUjnoyGyqX8lBP/W5rh12LOlUQ1zA5NeUIxwmQx1WuMfL+K7FXcg3
         uMbJHPf3/Mq7e3/OZzv7ZkFyezhqBfTZYdCT0GwJJ0UdnugeVGAAJHI7A83YcGgZTg8x
         8ZXNReSSlB+nGe9PbE1iuz6lEg/7m0efMEhJNq/JXCxQvok8Kh3ifaOsSI//M0VDVp5X
         r9VA==
X-Forwarded-Encrypted: i=1; AJvYcCX6pJ6NVWCZXneQudsAbVItsf0kyPW1M/gYWDt5oti3W4AmxyZZk67BksKtee0oIBIbhuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNLwvh/+7zGk2TkKN0dieLuDbr9GvsIyK5j8Q4mtOkvKZx1/Q
	fVWVSMfNAe4krIgPQ8ice9NCkIFcE29DXrFpXAqjwp6Ll+6y1zat04vhvPtdGdRyl1zkExUZ9A+
	eB8uN3hSbOZ66uLkCatq2M6rOIntFnk1STwafzg==
X-Gm-Gg: ASbGnculWav6lzsSzxV6sEEo1fxd61vrDLgQSq2oQGlfh+4vc2x9bPb93utrFHMD/20
	03Z043wM4cslt3e3bnGg34op5tO7M0ONfMzhy2A==
X-Google-Smtp-Source: AGHT+IGER1CaTtgKYuLeCe8OWdK3Fs4KPlCMIjrsFtDls5mCpVtf30KmrrKsOQuQUBis4+q17tk2SAy7sO6Kdn2bN4Y=
X-Received: by 2002:a7b:cd95:0:b0:436:30e4:4590 with SMTP id
 5b1f17b1804b1-43668b7a1d0mr346213315e9.32.1735865904502; Thu, 02 Jan 2025
 16:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102182343.vlgzo6wjf5abqxol@ed.ac.uk> <afa3b043-0591-463e-8b61-21db547a25ad@paulmck-laptop>
In-Reply-To: <afa3b043-0591-463e-8b61-21db547a25ad@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 2 Jan 2025 19:58:09 -0500
Message-ID: <CAEXW_YT5W2R4ebof1Eo5hix1JasHm0Kz_nDOxM9Fv-k7iNGsmQ@mail.gmail.com>
Subject: Re: Taking page faults in RCU critical sections
To: paulmck@kernel.org
Cc: Karim Manaouil <kmanaouil.dev@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Karim and Paul,

On Thu, Jan 2, 2025 at 2:16=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
On Thu, Jan 02, 2025 at 06:23:43PM +0000, Karim Manaouil wrote:
> > First, I wish you a happy new year!
> Hello, Karim, and a very happy square new year to you and yours as well!
> I have added the rcu email list in case someone else has ideas.

Happy new year wishes to you all as well!

> > I am working on implementing page migration for some types of kernel
> > memory. My technique is to remap those kernel pages in vmap/vmalloc
> > area and allow the kernel to take page faults during page migration.
> >
> > However, I have the problem of spinlocks and RCU critical sections.
> > A page fault can occur while the kernel is inside an RCU read critical
> > section. For example, in fs/dcache.c:dget_parent():
> >
> > rcu_read_lock()
> > seq =3D raw_seqcount_begin(&dentry->d_seq);
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

True. Interesting problem.

> > Do you have any ideas for how to properly approach this problem?
>
> Here are a few to start with:
>
> 0.      Look at the existing code that migrates processes and/or kernels
>         from one system to another, and then do whatever they do.
>
> 1.      Allocate the needed memory up front, before acquiring the
>         spinlocks and before entering the RCU readers.
>
> 2.      Move the existing spinlocks to mutexes and the existing uses
>         of RCU to SRCU, perhaps using srcu_read_lock_lite().  But note
>         that a great deal of review and benchmarking will be necessary
>         to prove that there are no regressions.  And that changes of
>         this sort in mm almost always result in regressions.
>
>         So I strongly advise you not to take this approach lightly.
>
> 3.      Your ideas here!

I am a bit nervous that if it is entirely possible to eliminate
page-fault rabbit holes, what if the page fault handler itself causes
a fault because it accesses some memory that was now backed by an
invalid PTE?

To that end, I was wondering if any of the following approaches are possibl=
e:

1. When the memory is being migrated, allow the old memory to still be
accessible until the migration completes. Then "atomically" modify the
PTE to point to the new memory. Orchestrate this in a way that no
fault should occur.

2. Try to see if page faults can be avoided entirely by not executing
the offending code. In Android GC, a page movement algorithm is being
explored AFAIK where there is a "stop the world" pause preventing code
from executing until the memory is moved to the new location. mremap()
is used in userspace to do this move so I admit this is a bit
tangential, but conceptually the ideas are similar.

> > Last question, do I need the -rt kernel for preempt RCU?
>
> No, CONFIG_PREEMPT=3Dy suffices.
>
> Note that CONFIG_PREEMPT_RT=3Dy, AKA -rt, also makes spinlocks (but not
> raw spinlocks) be limited sleeplocks, and thus allows RCU read-side
> critical sections to block when acquiring these sleeping "spinlocks".
> But this is OK, because all of this is still subject to priority boosting=
.

Should PREEMPT_RT kernels not throw warnings though when calling
rcu_note_context_switch() in RCU read-side sections?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ker=
nel/rcu/tree_plugin.h#n331

I don't run a PREEMPT_RT kernel myself so I can't confirm if these
warnings somehow don't appear, but I figured it would be good to
double check in this discussion.

thanks,

- Joel

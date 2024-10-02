Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251361D131E
	for <rcu@vger.kernel.org>; Wed,  2 Oct 2024 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891105; cv=none; b=BD3ZiRfqSm2vvlvKQovL0NjIFqvKJ45VjisaH2CXryIz7XcWqXlIaXEnV+w5JONOVf/e7baHcgwA1HbfHFMVNWfMFfTwrBZ2DQA97QFU2F7X8G6+gslUOeJeTN+i05u/0YYTgDyvDu3tRXsiMoU6vqVI9Njj4JLrGTIox4f2sCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891105; c=relaxed/simple;
	bh=CiGTgCjOlyk3hZM74g8+7FcOFj9hl0bMj4TBEfGDgLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdiufMnaashc2AE+Mamshu1en74RPe+9R+8NKVBVJy81CTniHdUqC6sW+0lRGPOxel2SN/o+um01nh5xwmCdCTK2SyzDcVqT9/POrpvD3aqlrJ/jJo+RkZUaT78VOsB8kMUb3mIGxxGGykRLxEQLQf5tphPOifRX4PouVxNr338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Nn8EUXtm; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Nn8EUXtm"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso875911fa.1
        for <rcu@vger.kernel.org>; Wed, 02 Oct 2024 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727891101; x=1728495901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fcw0AUFxqpg2EROaTPkK5EUAJwDwpjeNdNVYK6kfU4w=;
        b=Nn8EUXtmr1nVYBaMDRi3ssss1bBIO+kKbttSEY6DTIFq5y/VYLLPttmT+lpSAuUR6F
         2/FNNuaXTeVed8sEh8VXvD41tvKdcbX7Kw6JuLx6flIidfoHs8mxTTnk4CBkxZ3TrO4C
         Ps0lWJiDjgG+4DsZark334Psg6MTmFtqeSKrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727891101; x=1728495901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fcw0AUFxqpg2EROaTPkK5EUAJwDwpjeNdNVYK6kfU4w=;
        b=NEGog+aVof+eLdUAkmmN4dIBpGJVo43SRpCpzs4KQyATHYnnUXA2znziBVMiatAoaN
         FKpZzM+udesys79PXYCFaddtv0pzSUbu/B05WePWWD9Sko5T+HSv1tzQFr3LAA3CFnXm
         766X+I7Qo3PmL39ba5vjCTsswvOGql8OfS/LADSPiAvB7CtxKnSwIzEpfuItXbUg6IqQ
         FHyTFEOM5/05PJxnN5Ljr2WOvRytOf59oM2BnaOlEHqR9JNNSayZ9c31u1F2a1htMx0f
         xJECJx9iB0keXNiePCjWTHiFEJqVWpcz0pN/otKmXezokPEIGJpQhR3J8lIWAzX4/Qji
         g0ig==
X-Forwarded-Encrypted: i=1; AJvYcCW6yJmLqMd2GXF3K9LNT9t4GDR7KlfR1JuAfBWEJ/la0JMQGzA7PvSft661HU3SFUkqmyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMGpIBBw0a6V5hUmkBesLFMioplRWk4FlGV1pRJ1/MiN8xhlr
	98tA5Hdzf2LWVSuc7Kag0+WTXYBoICXbZeGH46zkjhsWgoNOdhLhG0ouoa3ZMwfPKVHz2naERbf
	mL34=
X-Google-Smtp-Source: AGHT+IGTDKFIeXAtu4Mium6IRn/McBdgSBTAdUxwydNf2UzG/f2C/GxQekDEM/bgQylhoDzYcSdvBw==
X-Received: by 2002:a2e:a989:0:b0:2f6:6198:1cfa with SMTP id 38308e7fff4ca-2fae10b46c3mr41991791fa.41.1727891100965;
        Wed, 02 Oct 2024 10:45:00 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27776cesm891345866b.40.2024.10.02.10.45.00
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 10:45:00 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c5b9bf9d8bso5103063a12.1
        for <rcu@vger.kernel.org>; Wed, 02 Oct 2024 10:45:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXH81iv4hgILnCvVPI6ZV0LOAwF/C3pWQr5CfSyF78PSw6HD80VdQOihNf9bSTLRT7r3HA=@vger.kernel.org
X-Received: by 2002:a2e:a9a5:0:b0:2f3:f1ee:2256 with SMTP id
 38308e7fff4ca-2fae10b46a2mr39398791fa.44.1727890772630; Wed, 02 Oct 2024
 10:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Oct 2024 10:39:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgztWbA4z85xKob4eS9P=Nt5h4j=HnN+Pc90expskiCRA@mail.gmail.com>
Message-ID: <CAHk-=wgztWbA4z85xKob4eS9P=Nt5h4j=HnN+Pc90expskiCRA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] sched+mm: Track lazy active mm existence with
 hazard pointers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, Mateusz Guzik <mjguzik@gmail.com>, 
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 18:04, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Hazard pointers appear to be a good fit for replacing refcount based lazy
> active mm tracking.

If the mm refcount is this expensive, I suspect we really shouldn't
use it at all.

The thing is, we don't _need_ to use the mm refcount - the reason the
lazy-tlb handling uses it is because we already had that refcount and
it was easy to extend on existing logic, not because it's really
required any more.

The lazy-tlb activation is basically "I'm switching to a kernel
thread, so I'll re-use the TLB state of the previous thread".

(And yes, it also has a secondary case of "I'm exiting, so I will turn
the mm I already have into a lazy one").

But in the actual task switch case, the previous thread hasn't _lost_
that mm, so we don't actually need to take the refcount at all.

We really just need to make sure to invalidate it before it's torn
down, but we do that *anyway* as part of TLB flushing.

(The exit case is actually different: we are setting it up to be lost,
although delayed - and the lazy count is the delay).

The only thing the refcount means is that we don't actually have to be
as careful when we actually *really* get rid of the MM. We can be a
bit laissez-faire about things because even if we weren't to
invalidate the lazy mm, it does have its own refcount, so we don't
much care.

But in reality, we're actually very careful about the active_mm
_anyway_, because of a fairly fundamental issue: the TLB shootdown and
PCID handling that we need to do even when mm's aren't lazy.

So we actually keep track of things like "which CPU's have seen this
MM state" in all the TLB code.

And even the exit case doesn't actually need the special thing - it
*does* need the "this CPU is still using this MM", but we have that
too as part of the TLB code - entirely independently of 'active_mm'.

So in many ways, I'm pretty sure not just the refcount, but all of
'active_mm', is largely pointless to begin with.

And if the refcount really is this big of a deal:

> nr threads (-t)     speedup
>    192               +28%

then we should probably just strive to get rid of 'active_mm' altogether.

Look, at least on x86 we ALREADY has a better replacement: it's the
percpu 'cpu_tlbstate'.

It basically duplicates all we do with active_mm and the whole "keep
track of old mm state" (the 'loaded_mm' member is basically the true
'active' mm), except it has some additional fixes:

 - it has some extra housekeeping data that the architecture wants
(for PCID updates etc)

 - it's actually atomic wrt the low-level code in ways that
'current->active_mm' isn't

So I think the real issue is that "active_mm" is an old hack from a
bygone era when we didn't have the (much more involved) full TLB
tracking.

               Linus

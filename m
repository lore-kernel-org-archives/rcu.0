Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1FBA20;
	Fri, 22 Nov 2024 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289351; cv=none; b=St66fQ99+zKJymFrMQRgDpWbku3onskZoHZgyZ8WepyoM8Hb42Wk0t9hIbEaE1S/SO2vIujzPbpgew/LXVRM1xPBXJfp2FSOdbC6v7RvlZVN+rKkxbhPro65rusya6Jo8ckT8f88ChCld092I3F/shHk87YuxSYVby3eoBX4n7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289351; c=relaxed/simple;
	bh=C4QfKyBiDFviZgGZUHzzD8wU4kNwvmBCMv6qAIMm/oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMJnJyjiP+hMhD7yM7VbqLqpARncHzuiNFhOWbqrGigyMvJtjllg/eDOnxQf/XTZUZNFSRhqSZVPcqHG8I87k/rKkoFe/tVHWarARHgAhvXxWEAICiVnEz4c3HfBXUW9lbW8Zr41/vqA6THwL0nGEktHvp+42lIP5cUsDVKH0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B2OLAuG6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZNbS6YZK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B2OLAuG6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZNbS6YZK"
Date: Fri, 22 Nov 2024 16:29:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732289348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X1Gjbn7bSatPmLMP7OcwtXOBlb5rE9gVl2DfyPsZLUU=;
	b=B2OLAuG6VG1KlURRaOQwrhrXRIqNfawyjYGQC1kw4242Z477wws9vI2sxTvLZFZylkWoAF
	cASIQp9m65nlLMjXkLyyafLvDf+EJFSaL/IuFRNQNGFC5gwdD7CK5TOYu5Gi074jcsCBc4
	GWpHOmb9Z3i3NpxAGZNKHY17iwYCFrzv60YgW0nNa0ukR4epz0MZR8XmdjawL3f+I7f4vM
	LTwRowOtXuT07PYxyvbM0Rcb3I5yEPoabRg2vrJbQG8jvTydXwjyS8MwefILBfBHc1Oz1R
	zRe5TXrSS6JOA89bSBLxXW966V8BDLsJ8jrkBnW05H52XLzRomOe63/uac3aQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732289348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X1Gjbn7bSatPmLMP7OcwtXOBlb5rE9gVl2DfyPsZLUU=;
	b=ZNbS6YZKwcTBvmOMUMJyOIS8J3Qs40yGMmEC+bJoPHH1KiSaWbmtaYw696eaaIi930pJan
	WEbQiUPwLD7YuTDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	syzbot <syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com>,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com,
	kasan-dev <kasan-dev@googlegroups.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Waiman Long <longman@redhat.com>, dvyukov@google.com,
	vincenzo.frascino@arm.com, paulmck@kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
	Thomas Gleixner <tglx@linutronix.de>, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH] kasan: Remove kasan_record_aux_stack_noalloc().
Message-ID: <20241122152905.iyjG97GS@linutronix.de>
References: <67275485.050a0220.3c8d68.0a37.GAE@google.com>
 <ee48b6e9-3f7a-49aa-ae5b-058b5ada2172@suse.cz>
 <b9a674c1-860c-4448-aeb2-bf07a78c6fbf@suse.cz>
 <20241104114506.GC24862@noisy.programming.kicks-ass.net>
 <CANpmjNPmQYJ7pv1N3cuU8cP18u7PP_uoZD8YxwZd4jtbof9nVQ@mail.gmail.com>
 <20241119155701.GYennzPF@linutronix.de>
 <CA+fCnZfzJcbEy0Qmn5GPzPUx9diR+3qw+4ukHa2j5xzzQMF8Kw@mail.gmail.com>
 <20241122113210.QxE7YOwK@linutronix.de>
 <Z0CcyfbPqmxJ9uJH@elver.google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0CcyfbPqmxJ9uJH@elver.google.com>

On 2024-11-22 16:01:29 [+0100], Marco Elver wrote:
> > Do we need to update the comment saying that it must not be used from
> > NMI or do we make it jump over the locked section in the NMI case?
> 
> Good point. It was meant to also be usable from NMI, because it's very
> likely to succeed, and should just take the lock-less fast path once the
> stack is in the depot.
> 
> But I think we need a fix like this for initial saving of a stack trace:
> 
> 
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 5ed34cc963fc..245d5b416699 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -630,7 +630,15 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
>  			prealloc = page_address(page);
>  	}
>  
> -	raw_spin_lock_irqsave(&pool_lock, flags);
> +	if (in_nmi()) {
> +		/* We can never allocate in NMI context. */
> +		WARN_ON_ONCE(can_alloc);
> +		/* Best effort; bail if we fail to take the lock. */
> +		if (!raw_spin_trylock_irqsave(&pool_lock, flags))
> +			goto exit;
> +	} else {
> +		raw_spin_lock_irqsave(&pool_lock, flags);
> +	}
>  	printk_deferred_enter();
>  
>  	/* Try to find again, to avoid concurrently inserting duplicates. */
> 
> 
> If that looks reasonable, I'll turn it into a patch.

Yes, looks reasonable.

Sebastian

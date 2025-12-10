Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1A0305046
	for <rcu@vger.kernel.org>; Wed, 10 Dec 2025 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765383509; cv=none; b=Dxw19/fuJyRhU1S5kybAJhanPKhyuK3Cm6mCbGQEyeg7c3N74ljl6yEk7CuZgou8GzasZL1yOAceCj0sfvWL5a9fzH/jM7te0IoKLNJX6dAbV+Byn4ILLgO6qu3eKIq2YK+4XmsaKeTlxNQB8OhvEEZwS7zabPfw1drpGCEn8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765383509; c=relaxed/simple;
	bh=8fukvFVHvNsSJut9kyMPtVjty3xkgDR42FqSOIyq0Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mB+gD7v3IZSVIeXZTTx12yWSvtjp9FeAmd22vS6ToL0kAlsukozsd5CQPKsKXhPRAaWiY1W7GUN6YLLhNZcEBt6owpkJJ/nIkMXoWeX1HKxu26Z3lR4CfWDwSQ6xE0yHwZHT2lXO6dYjjpESFwzIpSXzqQXpF820S/BahkiFtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Knpx6Ys; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Knpx6Ys"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477b91680f8so77529035e9.0
        for <rcu@vger.kernel.org>; Wed, 10 Dec 2025 08:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765383506; x=1765988306; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5R7EEgKhSIj0MssK61oG5hvlzLQojw/c9iQ7wtMJnfU=;
        b=4Knpx6Ys5jZM/3xzn4TkUlQ5MOn07tNXFGzWuQHetRSxVoOxFT3OFL1dI6aUzMhyEu
         xnYtbM7h+xr7oTrp7lflQAsqfG0dB83aJPa0N0Lzyw30KdGksmfQW3kYujbtnt3DkuVA
         fwmEmugctaKD9pNusDQNeXd1UfmY+fHvGPOWDw8BAfKfkIxSgy+w8UbI4YYUCqj4I6jX
         aI8c6m7cRh6B35onFu9uYiBhaBJoI1i9z8h4Mkeyxj9du9M621C5tHRNfX5XJmAb/f0q
         TuIXXyB2cjbM17BbTAqn37phQDIzp91gAiU1SG6JW6826VDNB+PT3RdVCI3rvFZjl/bg
         gWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765383506; x=1765988306;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5R7EEgKhSIj0MssK61oG5hvlzLQojw/c9iQ7wtMJnfU=;
        b=iwmzti3MmoM9ttKztj/+pYrowWVzQ5eIaTEOIZjRzvO0YwD8RkTqcpwXi6bDTowCxT
         jpbCYFIElu3XrlDDzv4raID1bYajovaGFHEYDVHzzRGLdkrxlzLPpkvJyRs8u/S6qkWI
         tlFgYTL4njv/Wj6QsNvvwezFrcl5NcW9n7n8UREigWrXPCZ9jn0VjGAJYzDCbeK2DIS6
         E/2XAcxMjfRzF6783SWoyxC/GuwFuQ0k5l7Tm587a8ZLsxAK1OyCVqmgwKn1Am6m1IJv
         D8UCgwyocNIjobfLwdJhshb8A/cuq7QnAqTxY+FQnOcb+cqARyef2J0FqCwyM4zB7dlC
         wrYw==
X-Forwarded-Encrypted: i=1; AJvYcCVW2lKtRper6LRaYFsK4aJ9en2P4Nbiy4wM6E3l6rT8RmEDlQPUqPDXDhMPswmMJ7r6i04=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8bMPDKCOB4HBRDAkiBwm8fUXndxRoMzHUIV5/kDDoKZYTP/C
	DgDzTeym6/cPamCSQg5SEKjJQyZX6453se4Nm7AijhGHl4FD1wYKh3zLbIa0Dee+uQ==
X-Gm-Gg: ASbGncv89ge2DM08KyKiFA1WU8M7J16FAs+f2YYFOGJ+1b6Oi3ZAIUjxl+SLjyQmEmv
	NWhhlY3iMUBcTbK60eB3MP56TPCkHpgvpLXGmqIOhny9iXLu692V1N1ahw14vS9Y71VFuwJM7+n
	9uZ56LnSuc0Md+ZcjFrC3O7OLo4qXPDN82wy2q3xnc9d1st10nBdR81oCCpD8PDn+1TahhLJmRf
	1Di1cAlEPjE8j3rdUCLzIP/uwMSCxQ1+Z2ZfKop843I+Kk7NQrd0EKsh5Kw8avZ42dYVn/MqT8j
	rKokxjePrX4I9RLWclXmh2SClytn8S8B+XrSY9FMSx7zBJhIKvy0sxv0S6kEA3MNgfx/9Ysyjf7
	+F7/muxwJRUBwNblVEiky4BJni7/cN5DhFG0oG2TB5jtTeiktd7b0rd5pjmtAfkhx1HxmNAnYct
	neDYzTUezMA8d1U3+N6Z3TLqHdO3xe4FPlJO1+t1K6TIOk/SM=
X-Google-Smtp-Source: AGHT+IE5gG+0fezF5tzXHFusF2dBV52zxvrbxnDDqwGYfilnFo0IcpTyJU4lWfuQsZFtfQAM3eL7LQ==
X-Received: by 2002:a05:600c:687:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-47a83cc5528mr15763325e9.20.1765383505415;
        Wed, 10 Dec 2025 08:18:25 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:2834:9:edfc:ec3:194e:c3b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d3a75a3sm45109085e9.6.2025.12.10.08.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 08:18:24 -0800 (PST)
Date: Wed, 10 Dec 2025 17:18:16 +0100
From: Marco Elver <elver@google.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ian Rogers <irogers@google.com>, Jann Horn <jannh@google.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
	Uladzislau Rezki <urezki@gmail.com>,
	Waiman Long <longman@redhat.com>, kasan-dev@googlegroups.com,
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-wireless@vger.kernel.org,
	llvm@lists.linux.dev, rcu@vger.kernel.org
Subject: Re: [PATCH v4 00/35] Compiler-Based Context- and Locking-Analysis
Message-ID: <aTmdSMuP0LUAdfO_@elver.google.com>
References: <20251120145835.3833031-2-elver@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120145835.3833031-2-elver@google.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

All,

On Thu, Nov 20, 2025 at 03:49PM +0100, Marco Elver wrote:
> Context Analysis is a language extension, which enables statically
> checking that required contexts are active (or inactive) by acquiring
> and releasing user-definable "context guards". An obvious application is
> lock-safety checking for the kernel's various synchronization primitives
> (each of which represents a "context guard"), and checking that locking
> rules are not violated.
[...] 
> A Clang version that supports `-Wthread-safety-pointer` and the new
> alias-analysis of context-guard pointers is required (from this version
> onwards):
> 
> 	https://github.com/llvm/llvm-project/commit/7ccb5c08f0685d4787f12c3224a72f0650c5865e
> 
> The minimum required release version will be Clang 22.
> 
> This series is also available at this Git tree:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git/log/?h=ctx-analysis/dev
[...] 

I realize that I sent this series at the end of the last release cycle,
and now we're in the merge window, along with LPC going on -- so it
wasn't the best timing (however, it might be something to discuss at
LPC, too :-) .. I'm attending virtually, however :-/).

How to proceed?

I'll be preparing a rebased and retested version of all this when
v6.19-rc1 is out. One outstanding recommendation from Linus was to
investigate compile-times, but as-is, it's unclear there's any notable
overhead per brief investigation: https://lore.kernel.org/all/aR-plHrWDMqRRlcI@elver.google.com/

From what I can tell most of this has to go through the locking tree,
given the potential for conflict there. However, it is possible to split
this up as follows:

Batch 1:

>   compiler_types: Move lock checking attributes to
>     compiler-context-analysis.h
>   compiler-context-analysis: Add infrastructure for Context Analysis
>     with Clang
>   compiler-context-analysis: Add test stub
>   Documentation: Add documentation for Compiler-Based Context Analysis
>   checkpatch: Warn about context_unsafe() without comment
>   cleanup: Basic compatibility with context analysis
>   lockdep: Annotate lockdep assertions for context analysis
>   locking/rwlock, spinlock: Support Clang's context analysis
>   compiler-context-analysis: Change __cond_acquires to take return value
>   locking/mutex: Support Clang's context analysis
>   locking/seqlock: Support Clang's context analysis
>   bit_spinlock: Include missing <asm/processor.h>
>   bit_spinlock: Support Clang's context analysis
>   rcu: Support Clang's context analysis
>   srcu: Support Clang's context analysis
>   kref: Add context-analysis annotations
>   locking/rwsem: Support Clang's context analysis
>   locking/local_lock: Include missing headers
>   locking/local_lock: Support Clang's context analysis
>   locking/ww_mutex: Support Clang's context analysis
>   debugfs: Make debugfs_cancellation a context guard struct
>   compiler-context-analysis: Remove Sparse support
>   compiler-context-analysis: Remove __cond_lock() function-like helper
>   compiler-context-analysis: Introduce header suppressions
>   compiler: Let data_race() imply disabled context analysis
>   MAINTAINERS: Add entry for Context Analysis

Batch 2: Everything below this can wait for the initial support in
mainline, at which point subsystem maintainers can pick them up if
deemed appropriate.

>   kfence: Enable context analysis
>   kcov: Enable context analysis
>   kcsan: Enable context analysis
>   stackdepot: Enable context analysis
>   rhashtable: Enable context analysis
>   printk: Move locking annotation to printk.c
>   security/tomoyo: Enable context analysis
>   crypto: Enable context analysis
>   sched: Enable context analysis for core.c and fair.c

Thanks,
	-- Marco

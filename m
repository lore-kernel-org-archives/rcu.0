Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F2B1802E
	for <rcu@vger.kernel.org>; Sat, 28 Sep 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727534994; cv=none; b=u8/Pfunv2e2pJ+JHNkswJpHa+RiX72F+m4H2jO3xnAY4i1OLGtxdnkx2FZvVOElR6DtML3rPJOo9cAtRjiaufjVtdHhOAFJ4+HfCbU3YY6QDpUGE6UWWu4cVdepxSWO/emjB9XW1MXF9bPHb3oR2YeJALxKzN4qeogNeSq1wnf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727534994; c=relaxed/simple;
	bh=W9jdtW9g7G/b2IlDh+2LPBLrbkqYnTJ5gfrPPG1M/yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfCDAAC4As5FzqnE/G8LVlebW/51f9CAEGRPJw4zRw2D5DFqtGYL0HYVnsoudQe3DbIEfr7e2Mgw2et9ubNB1/ciBIt0zqYZQ5GO/Ol/qkn0llyRHxkv/WfOcXNuvV0vcB0wHuJcSVXeMLEWWAMEFLXvptDWs2vc7jN2P0zh668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=e8Rcgt2l; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="e8Rcgt2l"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c582ca168fso21738536d6.2
        for <rcu@vger.kernel.org>; Sat, 28 Sep 2024 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1727534991; x=1728139791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1yi3s2Vi95xenb/4sW3OtKFLyrwZhQyIWMqCuz6AJtQ=;
        b=e8Rcgt2lsA7cI9LB+egxFW0zFYE/JiVpwcSTtb1iursRhcdtVn87nHAkDhoaeYjTq9
         IBrVsMv9EK/Bxi9XKEwD92TGNGbCjbhKgyfmpAO+eYqf+wcHs3XOGL9heiPy1Emo1QTT
         1xlnR/n7vFoh/IbR87Ll4vlWFVjtDHrcieNvomPtcsRSbrixHcINxfIoN/IJujKboFTm
         PsR35uC7AupbHFZkYai7a6iK8S3/hG9zBoO/uTFVqk0RHwh75FEoSTcxfcttFMBxXISp
         5BP892DoVEo+ldUR95YDvtK6MI39PgIAeKj9SRpO7iyGUAkfeRryFvXVSCS2faCw/fhQ
         R38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727534991; x=1728139791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yi3s2Vi95xenb/4sW3OtKFLyrwZhQyIWMqCuz6AJtQ=;
        b=BNg9rK9Le0eqKugWvdqt+BvqAKlmFLjYCFe0BhiWIakbp9BQ+n0WFPEwo+QSSeJUFh
         d6d44/MiXZHvxe3sf2kKpdeNXMXIkAbTsi08jg7MeTa6sbqmZzaWbTyKonI/23NiBJIV
         /9Q1sqUjT38W27oWEx8AVcX9leNWe3FlXW8pn8FwXZt9bYoXu6Tyqih2JNisrOxffVfy
         srHi+F83HMqA66ZFwhmaPz8VXq/qhNmo+Pqj67raOK4EkeuXJMuPC6lg4RigT9n6rHyU
         zfRDwwwl9J7Z7JHVRdioCPTFsHVX63AKoKQ92wUbVeuwm8V1tJUEW8XeUL3PqirCCmfu
         67zA==
X-Forwarded-Encrypted: i=1; AJvYcCV2M8XzYhz3JOIH9Ad2AY1THfZtNaSyNvP3l+UpjPsNKk+MHq3Cjb3vzw0bNMdh+0GotUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrkJWvfV6yEaUoqMleK7bHpqg+9v1sGYBojGBW+TqiF1SpBgQI
	c9dvsf04IXZJpv8hg7bp6xt/+9azfr8wobOFxrmmQpERdzzFDM0lYzBzcdB0kA==
X-Google-Smtp-Source: AGHT+IGYsBThwDk0+Q9GAkjd0Qrkf1rZeLvqxc9J+iXThiKd1XuEa4qWnG2xVu4bINYg8B5pAobCEg==
X-Received: by 2002:a05:6214:3bc3:b0:6cb:4e86:bb53 with SMTP id 6a1803df08f44-6cb4e86bc21mr44373516d6.43.1727534990879;
        Sat, 28 Sep 2024 07:49:50 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::abbf])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b66b507sm20259966d6.99.2024.09.28.07.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 07:49:49 -0700 (PDT)
Date: Sat, 28 Sep 2024 10:49:45 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
Message-ID: <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928135128.991110-2-mathieu.desnoyers@efficios.com>

On Sat, Sep 28, 2024 at 09:51:27AM -0400, Mathieu Desnoyers wrote:
> Compiler CSE and SSA GVN optimizations can cause the address dependency
> of addresses returned by rcu_dereference to be lost when comparing those
> pointers with either constants or previously loaded pointers.
> 
> Introduce ptr_eq() to compare two addresses while preserving the address
> dependencies for later use of the address. It should be used when
> comparing an address returned by rcu_dereference().
> 
> This is needed to prevent the compiler CSE and SSA GVN optimizations
> from replacing the registers holding @a or @b based on their

"Replacing" isn't the right word.  What the compiler does is use one 
rather than the other.  Furthermore, the compiler can play these games 
even with values that aren't in registers.

You should just say: "... from using @a (or @b) in places where the 
source refers to @b (or @a) (based on the fact that after the 
comparison, the two are known to be equal), which does not ..."

> equality, which does not preserve address dependencies and allows the
> following misordering speculations:
> 
> - If @b is a constant, the compiler can issue the loads which depend
>   on @a before loading @a.
> - If @b is a register populated by a prior load, weakly-ordered
>   CPUs can speculate loads which depend on @a before loading @a.

It shouldn't matter whether @a and @b are constants, registers, or 
anything else.  All that matters is that the compiler uses the wrong 
one, which allows weakly ordered CPUs to speculate loads you wouldn't 
expect it to, based on the source code alone.

> The same logic applies with @a and @b swapped.
> 
> The compiler barrier() is ineffective at fixing this issue.
> It does not prevent the compiler CSE from losing the address dependency:
> 
> int fct_2_volatile_barriers(void)
> {
>     int *a, *b;
> 
>     do {
>         a = READ_ONCE(p);
>         asm volatile ("" : : : "memory");
>         b = READ_ONCE(p);
>     } while (a != b);
>     asm volatile ("" : : : "memory");  <----- barrier()
>     return *b;
> }
> 
> With gcc 14.2 (arm64):
> 
> fct_2_volatile_barriers:
>         adrp    x0, .LANCHOR0
>         add     x0, x0, :lo12:.LANCHOR0
> .L2:
>         ldr     x1, [x0]    <------ x1 populated by first load.
>         ldr     x2, [x0]
>         cmp     x1, x2
>         bne     .L2
>         ldr     w0, [x1]    <------ x1 is used for access which should depend on b.
>         ret
> 
> On weakly-ordered architectures, this lets CPU speculation use the
> result from the first load to speculate "ldr w0, [x1]" before
> "ldr x2, [x0]".
> Based on the RCU documentation, the control dependency does not prevent
> the CPU from speculating loads.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Acked-by: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: John Stultz <jstultz@google.com>
> Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: maged.michael@gmail.com
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> Cc: rcu@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: lkmm@lists.linux.dev
> ---
>  include/linux/compiler.h | 62 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 2df665fa2964..f26705c267e8 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -186,6 +186,68 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  	__asm__ ("" : "=r" (var) : "0" (var))
>  #endif
>  
> +/*
> + * Compare two addresses while preserving the address dependencies for
> + * later use of the address. It should be used when comparing an address
> + * returned by rcu_dereference().
> + *
> + * This is needed to prevent the compiler CSE and SSA GVN optimizations
> + * from replacing the registers holding @a or @b based on their
> + * equality, which does not preserve address dependencies and allows the
> + * following misordering speculations:
> + *
> + * - If @b is a constant, the compiler can issue the loads which depend
> + *   on @a before loading @a.
> + * - If @b is a register populated by a prior load, weakly-ordered
> + *   CPUs can speculate loads which depend on @a before loading @a.
> + *
> + * The same logic applies with @a and @b swapped.

This could be more concise, and it should be more general (along the 
same lines as the description above).

> + *
> + * Return value: true if pointers are equal, false otherwise.
> + *
> + * The compiler barrier() is ineffective at fixing this issue. It does
> + * not prevent the compiler CSE from losing the address dependency:
> + *
> + * int fct_2_volatile_barriers(void)
> + * {
> + *     int *a, *b;
> + *
> + *     do {
> + *         a = READ_ONCE(p);
> + *         asm volatile ("" : : : "memory");
> + *         b = READ_ONCE(p);
> + *     } while (a != b);
> + *     asm volatile ("" : : : "memory");  <-- barrier()
> + *     return *b;
> + * }
> + *
> + * With gcc 14.2 (arm64):
> + *
> + * fct_2_volatile_barriers:
> + *         adrp    x0, .LANCHOR0
> + *         add     x0, x0, :lo12:.LANCHOR0
> + * .L2:
> + *         ldr     x1, [x0]  <-- x1 populated by first load.
> + *         ldr     x2, [x0]
> + *         cmp     x1, x2
> + *         bne     .L2
> + *         ldr     w0, [x1]  <-- x1 is used for access which should depend on b.
> + *         ret
> + *
> + * On weakly-ordered architectures, this lets CPU speculation use the
> + * result from the first load to speculate "ldr w0, [x1]" before
> + * "ldr x2, [x0]".
> + * Based on the RCU documentation, the control dependency does not
> + * prevent the CPU from speculating loads.

IMO, this lengthy explanation is not needed in the source code.  Just 
refer interested readers to the commit description.  You're repeating 
the same text verbatim, after all.

(Or if you firmly believe that this explanation _does_ belong in the 
code, then omit it from the commit description.  There's no need to say 
everything twice.)

Alan Stern

> + */
> +static __always_inline
> +int ptr_eq(const volatile void *a, const volatile void *b)
> +{
> +	OPTIMIZER_HIDE_VAR(a);
> +	OPTIMIZER_HIDE_VAR(b);
> +	return a == b;
> +}
> +
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>  
>  /**
> -- 
> 2.39.2
> 

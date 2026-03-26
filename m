Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700A3909AC
	for <rcu@vger.kernel.org>; Thu, 26 Mar 2026 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523869; cv=pass; b=gdkwX6e5JU65OE4nXmstiaYqUcs69JvijUN7VFCkw6JCyGn8FoNM15qlG2kUO7SU4Er74OVUPLMHPYUlzsvuIbng4dVQ9QDqKMgdPYuTOw4FExZVVBT8WaWqCNJ5Ob2Sb0jZeZetYsQ1sE25FtakEW8+wb21y85oLjhc3aTedgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523869; c=relaxed/simple;
	bh=9x2b5BRlpF4XW+4ZWPq2GCAzg7qoBQe5sxz0XEZTUeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agca7m60mTum4Q3buOBjgocLPZHoQ8dO+DrqIExKcy9HJph02xUlI+3vfCdeIOxMaN1PeFeOsIwjzGLyWoQ418poqvMX5zM6mCN3nwEF2uqiAxJyt66lQ7Zwv5iVP/9SQw0P+psr0EBjvlBB8jvIxnRHFmiWc0EbimTbvNWuTg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBC4QWTB; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBC4QWTB"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-667de793310so1428936a12.0
        for <rcu@vger.kernel.org>; Thu, 26 Mar 2026 04:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774523866; cv=none;
        d=google.com; s=arc-20240605;
        b=JofkmsgW4quKv17z0KfkPuKpPA87OeCltTLR66+QDcKT+ZUgypU/ErG1PmVFRFjpyB
         VFrzj45OCLrvFMJ/PfhDtwubUwZONDGTfZHg3LFvMgcMAB69NTGdZx+HqXgN0eYWZC3w
         1rcs5oOQdSTK1sUiE6h+lZBvhwQg4/97hmk6Q7ZQlSntKQ38A2IzijhSs1R/0WmgIX8N
         Br3KR3q0A+vQIe2R3Znyg2ffsCi92c9lbXhrZushhv7yPiMLHoXXokcBphuJq1+d6eMu
         j6gJPBd4sbjlx6qv9lGM/9yaJNEvEX1Vw0iRONfqWLKY6tUGj26YiMDa4jlzo7AFCXxE
         MIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HGPKj/TRzPmN2Ik58tT9FnvetsUYhm2GXve+aIyOCI8=;
        fh=zxVUVD8xwjjSclRQ0V5IjY0AaLUfJ5MJWc3uqwwWlSs=;
        b=jbs+Adx1d2VJF6yhCMmH+BlMI7/3xNLkPC3Ff2FN+82znwAnwzVNtLTgcOAqg+fvR7
         Mrpu8A0GnAkrJ+H/6JRE+UZMCSTF9vZzhGdW5juQWgMsLpNrXk1fpMCNZwo6fSjfBQSb
         SVsOdiVCr21jqcWsX2yb1b7fs1NszrlDn4wb9zVvjFNLhUvsfkwiW0LLj2+nhpd93NzF
         SN5iNiez0h9/iJTuA2KzGIzLquOEhxmbOO6rk/tz8ptX5mdxXOdR1yqbhZq3qGdohQYo
         lMjHUVHoD0s9yG6LWPAuaK8Dz22fz+zWX9RJUV8L26uvfA4pUvvdomfzs8hwbc0IH19E
         ImYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774523866; x=1775128666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGPKj/TRzPmN2Ik58tT9FnvetsUYhm2GXve+aIyOCI8=;
        b=ZBC4QWTBPCj5RUwOpdq6H1HPSMvY4acIeoVSa6ms/V1jA9gy2sTbmMHQcL3kL1cV0a
         JguV25hNss3TAyuNUOXEkWfyVXJkU3eVhiExCwOXUy+7T4FT2Vb5TqBsSwhEVXLeQwEy
         GTBctfga4HufmReLo9TAZGN4AyVf5UX5WuOUAJ0YRtZ8PLPxlNKtEed0gFxz7O3TH3QT
         9FB0Ejb4oQBKAga57mGas9jVZ7YAlRi1KY5UqTpyi83CpoJdnIqHT4JU9d9mdlowm80t
         zv1Pu7SYgns/g/njbY3VU98yXhOsEpQvBCplFpRBFgHLROCeYhTU2gEWamhzkNB8QtmG
         oLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774523866; x=1775128666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HGPKj/TRzPmN2Ik58tT9FnvetsUYhm2GXve+aIyOCI8=;
        b=EDXwAfV86i85b9wh6BYu7gDVjCTyXkEyxPtJKiVYQ23HmE0ud4TjhCS8EBNqy8Gexp
         kIM3MDiLJPCr8eGinTM7isb58qvue02AxiR0WwgWhiZ6UBFd8CiIlL+gcqn4V5s28vZh
         SDP6PWr/m+iMpGmuu/P8Q7b1te0osxxGZh0iao4RHS6ZGJBguWhCTNvVSbhW1FtZV1p2
         eeUST35FUimLB8NgZBgrEEc9lUabqHMcKCLCpciv/l6UwMmnWu0g7Jd21kZoPxVXY0E+
         uzJ5eSZA7Xl+eSOYwT3e1JDbfpGLCD/C+66AjBoWMypQ8QNihitc2bcuDn1AVoFPiO+V
         h4GA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ7HStOL8tNKGlw8uy6vcM4cepgKcW4TjZ0AuSg+lwlnsRBVU7O8cnhsruGXb7xzDzuJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFE9MKt4sdEfkYJcOn4yYZQmd824FXKQd8/d0yHe6PhwoQDzT9
	JMdRHgEdVtS0bDo3ozrX1Kk0FzfxMyRu8L0s6KQVHxqKE6WAyjaugW0AIRDlb+vZEm/EO+f1GWu
	E4jJ10wCyfyrNKkwYRqEQepKiC/ibi+4=
X-Gm-Gg: ATEYQzwspU0lROPmbog3QpvGvOGtnQqz6yxCW8PT1wYkXO0yrN0kPa+vF5xWYN7HCjV
	9rhaZVawf+7Ctinam8Pi6eWqxZPDq1ml4QhKgmd90EITu9EJpUvImQcL7JYj6/4O0qFRP0sPY8F
	4ILDT1gLgxBB3HfHvSZQHhCnhjnVS5cRyRHghwxMyTSYERS9iT3kmxFXuaIKbdMeqL9IiF6ZRrQ
	572P+1qm25h76zCRBEbW632ZjznvpsfOJsbuk7bKeqy7qaYB/QTTQUx43rXUGmCbvXVrvyAMjOR
	nEg1ckNqVzS+7BWjKhpmgWE=
X-Received: by 2002:a05:6402:3251:b0:66a:6c0b:938a with SMTP id
 4fb4d7f45d1cf-66a82618419mr4014232a12.2.1774523866080; Thu, 26 Mar 2026
 04:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326102608.1855088-1-puranjay@kernel.org> <acURahmSDqFYgcIz@willie-the-truck>
In-Reply-To: <acURahmSDqFYgcIz@willie-the-truck>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 26 Mar 2026 11:17:34 +0000
X-Gm-Features: AQROBzAZkkiGlI2jm6-OxaPdxKJ5ecrTm7aGYa4l0T4VkdM7mjPVBzubvkR7fc0
Message-ID: <CANk7y0hhSoegJD+D03bnHzCNzUKzvbbb1ivoVOWqBxZb0D3UUA@mail.gmail.com>
Subject: Re: [PATCH] srcu: Optimize SRCU-fast per-CPU counter increments on arm64
To: Will Deacon <will@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, rcu@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 10:58=E2=80=AFAM Will Deacon <will@kernel.org> wrot=
e:
>
> On Thu, Mar 26, 2026 at 03:26:07AM -0700, Puranjay Mohan wrote:
> > On architectures like arm64, this_cpu_inc() wraps the underlying atomic
> > instruction (ldadd) with preempt_disable/enable to prevent migration
> > between the per-CPU address calculation and the atomic operation.
> > However, SRCU does not need this protection because it sums counters
> > across all CPUs for grace-period detection, so operating on a "stale"
> > CPU's counter after migration is harmless.
> >
> > This commit therefore introduces srcu_percpu_counter_inc(), which
> > consolidates the SRCU-fast reader counter updates into a single helper,
> > replacing the if/else dispatch between this_cpu_inc() and
> > atomic_long_inc(raw_cpu_ptr(...)) that was previously open-coded at
> > each call site.
> >
> > On arm64, this helper uses atomic_long_fetch_add_relaxed(), which
> > compiles to the value-returning ldadd instruction.  This is preferred
> > over atomic_long_inc()'s non-value-returning stadd because ldadd is
> > resolved in L1 cache whereas stadd may be resolved further out in the
> > memory hierarchy [1].
> >
> > On x86, where this_cpu_inc() compiles to a single "incl %gs:offset"
> > instruction with no preempt wrappers, the helper falls through to
> > this_cpu_inc(), so there is no change.  Architectures with
> > NEED_SRCU_NMI_SAFE continue to use atomic_long_inc(raw_cpu_ptr(...)),
> > again with no change.  All remaining architectures also use the
> > this_cpu_inc() path, again with no change.
> >
> > refscale measurements on a 72-CPU arm64 Neoverse-V2 system show ~11%
> > improvement in SRCU-fast reader duration:
> >
> >   Unpatched: median 9.273 ns, avg 9.319 ns (min 9.219, max 9.853)
> >     Patched: median 8.275 ns, avg 8.411 ns (min 8.186, max 9.183)
> >
> >   Command: kvm.sh --torture refscale --duration 1 --cpus 72 \
> >            --configs NOPREEMPT --trust-make --bootargs \
> >            "refscale.scale_type=3Dsrcu-fast refscale.nreaders=3D72 \
> >            refscale.nruns=3D100"
> >
> > [1] https://lore.kernel.org/r/e7d539ed-ced0-4b96-8ecd-048a5b803b85@paul=
mck-laptop
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  include/linux/srcutree.h | 51 +++++++++++++++++++++++++++-------------
> >  1 file changed, 35 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index fd1a9270cb9a..4ff18de3edfd 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -286,15 +286,43 @@ static inline struct srcu_ctr __percpu *__srcu_ct=
r_to_ptr(struct srcu_struct *ss
> >   * on architectures that support NMIs but do not supply NMI-safe
> >   * implementations of this_cpu_inc().
> >   */
> > +
> > +/*
> > + * Atomically increment a per-CPU SRCU counter.
> > + *
> > + * On most architectures, this_cpu_inc() is optimal (e.g., on x86 it i=
s
> > + * a single "incl %gs:offset" instruction).  However, on architectures
> > + * like arm64, s390, and loongarch, this_cpu_inc() wraps the underlyin=
g
> > + * atomic instruction with preempt_disable/enable to prevent migration
> > + * between the per-CPU address calculation and the atomic operation.
> > + * SRCU does not need this protection because it sums counters across
> > + * all CPUs for grace-period detection, so operating on a "stale" CPU'=
s
> > + * counter after migration is harmless.
> > + *
> > + * On arm64, use atomic_long_fetch_add_relaxed() which compiles to the
> > + * value-returning ldadd instruction instead of atomic_long_inc()'s
> > + * non-value-returning stadd, because ldadd is resolved in L1 cache
> > + * whereas stadd may be resolved further out in the memory hierarchy.
> > + * https://lore.kernel.org/r/e7d539ed-ced0-4b96-8ecd-048a5b803b85@paul=
mck-laptop
> > + */
> > +static __always_inline void
> > +srcu_percpu_counter_inc(atomic_long_t __percpu *v)
> > +{
> > +#ifdef CONFIG_ARM64
> > +     (void)atomic_long_fetch_add_relaxed(1, raw_cpu_ptr(v));
> > +#elif IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE)
> > +     atomic_long_inc(raw_cpu_ptr(v));
> > +#else
> > +     this_cpu_inc(v->counter);
> > +#endif
> > +}
>
> No, this is a hack. arm64 shouldn't be treated specially here.
>
> The ldadd issue was already fixed properly in
> git.kernel.org/linus/535fdfc5a2285. If you want to improve our preempt
> disable/enable code or add helpers that don't require that, then patches
> are welcome, but bodging random callers with arch-specific code for a
> micro-benchmark is completely the wrong approach.

Thanks for the feedback.

I basically want to remove the overhead of preempt disable/enable that
comes with this_cpu_*(), because in SRCU (and maybe at other places
too) we don't need that safety. One way would be to define
raw_cpu_add_* helpers in arch/arm64/include/asm/percpu.h but that
wouldn't be good for existing callers of raw_cpu_add() as currently
raw_cpu_add() resolves to raw_cpu_generic_to_op(pcp, val, +=3D), which
is not atomic. Another way would be to add new helpers that do per-CPU
atomics without preempt enable/disable.

And do you think this optimization is worth doing? or should I just not do =
it?

Thanks,
Puranjay

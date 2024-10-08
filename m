Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52B1E0488
	for <rcu@vger.kernel.org>; Tue,  8 Oct 2024 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417097; cv=none; b=UftCQ2QG3qz3ZrZaA6uTHm06IgpZsM36+mkXQY0gnZil5Kes7DbKpTlpzRzHGBPhohCf8aH/ckYGp4XXChDdXbkU2fvVuVMixtuYl+F4BbnKfHHJrtqbtlzNVyq/K7adfDYiGLBTGRP6Q4Nci1o5Mfcn1Tt4CcF2T6+lkNwT368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417097; c=relaxed/simple;
	bh=VH7rZr0esPU0xI4PKHKzYYcpwg6WN43xykPQsQS9Ol0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evpP/qsHSL+4Pmfq4+o3zfgVHAH+cY5Yx51Yz/MvxgJpq4Mljux1cSD52Eex5+vm6WdLcp8Ng+ImX97JrMzZOeD/B6S5NcUdcNSOy4qaWVgp63fayQ726PQlOY9Amid5vVhhy5kQOCTe7i8M7A7Li7+pM4/g6ssX++r6x1lJteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Jzbif4pN; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Jzbif4pN"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e03caab48a2so149557276.1
        for <rcu@vger.kernel.org>; Tue, 08 Oct 2024 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1728417095; x=1729021895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ci765eh137PIwschjUYVXX8mCS3TMC1xVhlYWFrItI=;
        b=Jzbif4pNVbMKt7L70L/czfy6c35GnXU9+VTZYZmbEH590RL1nRRdcuFz0tJ5PUulxS
         byrkL3cvDlR+BQASbRBDvGDhg2489tuzxLhyK8rQSx8fwgdpcOL+ckAAuo79IbLPU0gZ
         LRcP1OLZ11gPR6gYOV86azqzfBifo5nLZFODo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728417095; x=1729021895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ci765eh137PIwschjUYVXX8mCS3TMC1xVhlYWFrItI=;
        b=j4SJTE84aBVrrPB93qMp0094RufJABrf989LL4R9YcuSBUePvXRpnfVzQpgEBNKBD5
         s/7boPmsdHFbb8weuXitizUhi6wB4dIltSWjzLcx43aaGigPlae0OskIA/iXu4c2qk3H
         k1TVFPDCGX12X8wIjX4dGNWour+B4bhyW6kiR97+9NUrdxsvoYsO6wcmlLC9tq/RiQyv
         +Gg+2HD7JxL4sOjg0YlGw1qQjstcsCFGkAjFrs0T3aTDIXMIqnvKPvmeA2GAzLsyZ6p3
         JTdqjrHEhmCQhR7bikDTl5atlKhh2yqf4wagvij0RsTgKYbmbmT9rfzCxZZA4/blHj53
         LiXA==
X-Forwarded-Encrypted: i=1; AJvYcCWwRy573gSHAtA+CeLG2KvjhYLkaeVkVQJCT5Vdb5P87j5g0nrvrgFZZ1lg6Zm0vcoljJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQRlJrqTzzGlhNXt9XNZTYtGSk5bWap0EO5uBXUcHIxaqj0LwY
	+2T4KguOxixMio1bODv7Y/YDMZ70xzHEHQoybAPBtxbBO9qLDCYori1Lb2JQp+vR4d/zX2fr927
	uZjXWtFsOWKygFLcCfe0N6Svyl1FqX2FQYDkrwA==
X-Google-Smtp-Source: AGHT+IG9DP1nwTVmYxTMmFI7BVV4DLB4FBMyoonYBQmzC+5HTaL0RTxVWS8uoRkvFMU6qF86uDGTHoIWkK/XNJ/usxc=
X-Received: by 2002:a5b:ac5:0:b0:e16:4ca7:7acf with SMTP id
 3f1490d57ef6-e28ea74e65emr4313926276.10.1728417095081; Tue, 08 Oct 2024
 12:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008135034.1982519-1-mathieu.desnoyers@efficios.com> <20241008135034.1982519-5-mathieu.desnoyers@efficios.com>
In-Reply-To: <20241008135034.1982519-5-mathieu.desnoyers@efficios.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 8 Oct 2024 15:51:23 -0400
Message-ID: <CAEXW_YQ5BumqU98+BnYF8wJ1iVJ8jaKa6u3STTt-mQruXu1vfA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/4] sched+mm: Use hazard pointers to track lazy
 active mm existence
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Will Deacon <will@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	John Stultz <jstultz@google.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, Mateusz Guzik <mjguzik@gmail.com>, 
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev, Vineeth Pillai <vineethrp@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 9:52=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Replace lazy active mm existence tracking with hazard pointers. This
> removes the following implementations and their associated config
> options:
>
> - MMU_LAZY_TLB_REFCOUNT
> - MMU_LAZY_TLB_SHOOTDOWN
> - This removes the call_rcu delayed mm drop for RT.
>
> It leverages the fact that each CPU only ever have at most one single
> lazy active mm. This makes it a very good fit for a hazard pointer
> domain implemented with one hazard pointer slot per CPU.
>
> -static void cleanup_lazy_tlbs(struct mm_struct *mm)
> +static void remove_lazy_mm_hp(int cpu, struct hazptr_slot *slot, void *a=
ddr)
>  {
> -       if (!IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN)) {
> -               /*
> -                * In this case, lazy tlb mms are refounted and would not=
 reach
> -                * __mmdrop until all CPUs have switched away and mmdrop(=
)ed.
> -                */
> -               return;
> -       }
> +       smp_call_function_single(cpu, do_shoot_lazy_tlb, addr, 1);
> +       smp_call_function_single(cpu, do_check_lazy_tlb, addr, 1);
> +}
>
> +static void cleanup_lazy_tlbs(struct mm_struct *mm)
> +{
[...]
> -       on_each_cpu_mask(mm_cpumask(mm), do_shoot_lazy_tlb, (void *)mm, 1=
);
> -       if (IS_ENABLED(CONFIG_DEBUG_VM_SHOOT_LAZIES))
> -               on_each_cpu(do_check_lazy_tlb, (void *)mm, 1);
> +       hazptr_scan(&hazptr_domain_sched_lazy_mm, mm, remove_lazy_mm_hp);

Hey Mathieu, Take comments with a grain of salt because I am digging
into active_mm after a while.
It seems to me IMO this seems a strange hazard pointer callback
usecase. Because "scan" here immediately retires even though the
reader has a "reference". Here it is more like, the callback is
forcing all other readers holding a "reference" to switch immediately
whether they like it or not and not wait until _they_ release the
reference. There is no such precedent in RCU for instance, where a
callback never runs before a reader even finishes.

That might work for active_mm, but it sounds like a fringe usecase to
me that it might probably be better to just force
CONFIG_MMU_LAZY_TLB_SHOOTDOWN=3Dy for everyone and use on_each_cpu()
instead. That will give the same code simplification for this patch
without requiring hazard pointers AFAICS? Or maybe start with that,
and _then_ convert to HP if it makes sense to? These are just some
thoughts and I am Ok with all the reviewer's consensus.

And if I understand correctly, for this usecase - we are not even
grabbing a "true reference" to the mm_struct object because direct
access to mm_struct should require a proper mmgrab(), not a lazy_tlb
flavored one? -- correct me if I'm wrong though.

Also, isn't it that on x86, now with this patch there will be more
IPIs, whereas previously the global refcount was not requiring that as
the last kthread switching out would no longer access the old mm?
Might it be worth checking the performance of fork/exit and if that
scales?

thanks,

- Joel

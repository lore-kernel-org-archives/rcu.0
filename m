Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C5C12C544
	for <rcu@vger.kernel.org>; Tue, 16 Apr 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276456; cv=none; b=V7Xxqm/k2BU/NG9FGZ7Z0NzqorsA9kxK2U0eOf8vK49FnrGn2xxANlH6bLiavE6iZfyPi3mpFNJ0dxhOQpr8XIdx3c/iFaMFejsj59M+J0gAmx+JGbsCWTvAAg6KIb7lfFJU59D0aq3yR1/UTYudSVvmnQY5NZE0eMnxh7NJ4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276456; c=relaxed/simple;
	bh=Pujm/r3xB6YlHkRLKYxgDrcLT8Z+/QffDjAZvYeDnX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RGIdAKPwl8TijVHEEzL0m4PS0Hqa5c7b3Xyp4DmRwwcClueTZS5Iel225ifj+bkOVUBdGTQKNJikmNxHDuP5BsBbGLH4SPGmSDOnz/7WJZr/RVn4xMaNtzReOCMcHH4ITT7+2aETCJuMyQZIXsME9kWXyn2KA/oPNG/BhJ3V7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YrVQfmJz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YrVQfmJz"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so3487483a12.1
        for <rcu@vger.kernel.org>; Tue, 16 Apr 2024 07:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713276454; x=1713881254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3HMGW99TX0Cqe3aYrj5LiSxtL+KydbJYyp90EN1U2HI=;
        b=YrVQfmJzyJVaQXvU58xrq3XdY0+gE8OO+M3CJeVtaC86Ki3fsDWRBiKpENeWyCzSMR
         bTe2xJigvkXGTAJDDlox6sD4VVAO+S42nTxvkIujiRRYwjtXX8SM2GeTw3fZFSZ2WIvS
         eGrldgepvtDEHtogynwU8ERcY+z+zYcmDDjyaIwZmQviOtKc09pTX4e3cGqa0dBttZg3
         jAOEZmsXX5O78DA6BmgevrzVSGNlvtykzfJwO0AS2uzTR2Q5rYh66YkgHelwVBQUUKUz
         dio09jg/f2ZwGllzJSx5oEM2lz5dI9FBpEYNyB0UFTxwE5C5gdDkOtt19P2tbCCCmbRP
         iWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713276454; x=1713881254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3HMGW99TX0Cqe3aYrj5LiSxtL+KydbJYyp90EN1U2HI=;
        b=EM/Jb18P/m9gLzqWZRvnE0opLqZIEBcXBBZDw9ONY/juzdI6W1+5oWMYys4JXG5ly0
         SeSQ0lMBGjC01YAE+ibqW/t1JmK9qwqRmPN9dj5pLYABGpyTYd4r6GKxLShU5urDJyeA
         cOMB2p1Fgi14ydtHliXVB+5W7z278l6OPsyZfqmGm4vSNqdCpna59jgNaKc6STfWbUdU
         tVnNbwt9biMiPKFgxEAwa6Uw5kC4CPAiNYY5tq76ETcBEd4v9sUSExlj7WdsMX66KXmL
         rq/V9orJc6ZMGvDLywRD+OHHY3pK4MwpD7khdmVoisvAnEN0IisVBR8AcY/BXWPBaGJf
         mLMg==
X-Forwarded-Encrypted: i=1; AJvYcCXEwByB5tGNbY7qxaxQ3OdWCdmcuDlUufYO7jrxz6CxZjbPBA6Dm7wHk5HY6H8A6AsxUq7dVWOlxDPkfQcZ+UAspsD7
X-Gm-Message-State: AOJu0YwYWjQmoKWU2k/zjwk1WgH8m4XIku8mGitngRsKUZyVZHHam8N6
	fCOIPqcgTqeSy0Njx7lncmbGadXddxfA2l8l8F8ISaMmxGATOL/mjosRgGdyoTv4uIMgAbJ3Swy
	s1Q==
X-Google-Smtp-Source: AGHT+IHY9YzbCwBFObbbVKUprvWZ1lVsqt1aqVyeCtv5WiwA+nKUa0M0YnEHgFtBrjfmqeer2cDphAZ9lOw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e74b:b0:1e2:3051:8194 with SMTP id
 p11-20020a170902e74b00b001e230518194mr60970plf.11.1713276453910; Tue, 16 Apr
 2024 07:07:33 -0700 (PDT)
Date: Tue, 16 Apr 2024 07:07:32 -0700
In-Reply-To: <Zh5w6rAWL+08a5lj@tpad>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328171949.743211-1-leobras@redhat.com> <ZgsXRUTj40LmXVS4@google.com>
 <ZhAAg8KNd8qHEGcO@tpad> <ZhAN28BcMsfl4gm-@google.com> <a7398da4-a72c-4933-bb8b-5bc8965d96d0@paulmck-laptop>
 <ZhQmaEXPCqmx1rTW@google.com> <Zh2EQVj5bC0z5R90@tpad> <Zh2cPJ-5xh72ojzu@google.com>
 <Zh5w6rAWL+08a5lj@tpad>
Message-ID: <Zh6GC0NRonCpzpV4@google.com>
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
From: Sean Christopherson <seanjc@google.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Leonardo Bras <leobras@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 16, 2024, Marcelo Tosatti wrote:
> On Mon, Apr 15, 2024 at 02:29:32PM -0700, Sean Christopherson wrote:
> > And snapshotting the VM-Exit time will get false negatives when the vCPU is about
> > to run, but for whatever reason has kvm_last_guest_exit=0, e.g. if a vCPU was
> > preempted and/or migrated to a different pCPU.
> 
> Right, for the use-case where waking up rcuc is a problem, the pCPU is
> isolated (there are no userspace processes and hopefully no kernel threads
> executing there), vCPU pinned to that pCPU.
> 
> So there should be no preemptions or migrations.

I understand that preemption/migration will not be problematic if the system is
configured "correctly", but we still need to play nice with other scenarios and/or
suboptimal setups.  While false positives aren't fatal, KVM still should do its
best to avoid them, especially when it's relatively easy to do so.

> > My understanding is that RCU already has a timeout to avoid stalling RCU.  I don't
> > see what is gained by effectively duplicating that timeout for KVM.
> 
> The point is not to avoid stalling RCU. The point is to not perform RCU
> core processing through rcuc thread (because that interrupts execution
> of the vCPU thread), if it is known that an extended quiescent state 
> will occur "soon" anyway (via VM-entry).

I know.  My point is that, as you note below, RCU will wake-up rcuc after 1 second
even if KVM is still reporting a VM-Enter is imminent, i.e. there's a 1 second
timeout to avoid an RCU stall to due to KVM never completing entry to the guest.

> If the extended quiescent state does not occur in 1 second, then rcuc
> will be woken up (the time_before call in rcu_nohz_full_cpu function 
> above).
> 
> > Why not have
> > KVM provide a "this task is in KVM_RUN" flag, and then let the existing timeout
> > handle the (hopefully rare) case where KVM doesn't "immediately" re-enter the guest?
> 
> Do you mean something like:
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d9642dd06c25..0ca5a6a45025 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3938,7 +3938,7 @@ static int rcu_pending(int user)
>                 return 1;
>  
>         /* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
> -       if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
> +       if ((user || rcu_is_cpu_rrupt_from_idle() || this_cpu->in_kvm_run) && rcu_nohz_full_cpu())
>                 return 0;

Yes.  This, https://lore.kernel.org/all/ZhAN28BcMsfl4gm-@google.com, plus logic
in kvm_sched_{in,out}().

>         /* Is the RCU core waiting for a quiescent state from this CPU? */
> 
> The problem is:
> 
> 1) You should only set that flag, in the VM-entry path, after the point
> where no use of RCU is made: close to guest_state_enter_irqoff call.

Why?  As established above, KVM essentially has 1 second to enter the guest after
setting in_guest_run_loop (or whatever we call it).  In the vast majority of cases,
the time before KVM enters the guest can probably be measured in microseconds.

Snapshotting the exit time has the exact same problem of depending on KVM to
re-enter the guest soon-ish, so I don't understand why this would be considered
a problem with a flag to note the CPU is in KVM's run loop, but not with a
snapshot to say the CPU recently exited a KVM guest.

> 2) While handling a VM-exit, a host timer interrupt can occur before that,
> or after the point where "this_cpu->in_kvm_run" is set to false.
>
> And a host timer interrupt calls rcu_sched_clock_irq which is going to
> wake up rcuc.

If in_kvm_run is false when the IRQ is handled, then either KVM exited to userspace
or the vCPU was scheduled out.  In the former case, rcuc won't be woken up if the
CPU is in userspace.  And in the latter case, waking up rcuc is absolutely the
correct thing to do as VM-Enter is not imminent.

For exits to userspace, there would be a small window where an IRQ could arrive
between KVM putting the vCPU and the CPU actually returning to userspace, but
unless that's problematic in practice, I think it's a reasonable tradeoff.

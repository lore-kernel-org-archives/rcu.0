Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09AE36B1C
	for <rcu@vger.kernel.org>; Fri,  3 May 2024 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761778; cv=none; b=NFjKdW/DooX6XlEUjEjSVpIWksaZgXakRxYV2VzgnK9/QI3BJ0Nv5rl87tDpchfOtWlWpOUTqmJyv9e8uEdx2w1ohIpHibKPnYMebbYbjCDywROlWtSDbKywsJiiJgPNLj8ADX52glnu95dtAMNv/vs1s57fggJttRaXueFSD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761778; c=relaxed/simple;
	bh=tU6G7JYGWRkG+2O/O2roQvpxabuBZJxtfMZ8Pdnsff0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=GAJ5T4lOeAiuHsMojuLDOBlBsX2e4Z4DfL/Khw6i2XXqD5NLg8hfUk+9AL98ulJvH/IlZcVDenz2/d+XajCZLtiso1l89d6m8JKRHKIo+8vTHs8HaQcxvfAv3bWCyNC7KXYRxYM24voRP514MRrMYSCcsRZeA//h30UYk14pvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JuLdIbmU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuLdIbmU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714761775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jg1F0r+Luam104Y7UVnMDpQtCctuiu4jLX0tf0Er1I=;
	b=JuLdIbmUOWthf/SfUfhZzbHmM8sbDv35ewFqCntRW8JzA5xdoFZXjhtGrrvceHccjfYqni
	Ww4u41V/TZI3ndQdNBQKmEWFUDuNAQFGPTsLeUqu5ER5W62z6KGH3egaXQN+v9d6t0D8eF
	htKso3kNlnZltOP4VhIYoR5/Ncki3Zg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-P8i1WP_uNnWSmlVUk_-rzg-1; Fri, 03 May 2024 14:42:54 -0400
X-MC-Unique: P8i1WP_uNnWSmlVUk_-rzg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e41c665b99so101054895ad.1
        for <rcu@vger.kernel.org>; Fri, 03 May 2024 11:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714761773; x=1715366573;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jg1F0r+Luam104Y7UVnMDpQtCctuiu4jLX0tf0Er1I=;
        b=BX+KKQjgZel46tV99Z2x4Sbhklj6VeYHkMpPe9/O2STCatEgmGyvXmYtF+fCCn+oBn
         iTB6K+RunwjaUKTyXKB0FReFptuuZHBasyIV1ass3XhC4UbyZlugEGjGwTNe67hQoP46
         K6Z3mEjzzRDvNldKJHDix08P5j5+bISvSPzTkW8aab0iToo+Z/3mxGyQeWqbqSjC0dZC
         dr2SO0HBN4WSoAlnG1w6N0v2ecG7P+zhn/X3NPJnlm9yEr3+WtufvIHCn3KHhLqkD4iU
         rLR7ZKBNeRJoeo1PTZNb6tIxL1vSUS3q92rV+Q6j9hQOjVEnH2JUCW4UKqK8pUWkQWIt
         abqw==
X-Forwarded-Encrypted: i=1; AJvYcCVTFg9++Tj8sjsMdzdJBJJsTp6WNrVpTlmzHfq4tT3Lesg1S6/DRvvp5gGkTUl/3hlf/wt7905PtZkbUVYDVWB2z7tf
X-Gm-Message-State: AOJu0YwRWL2lrYuzj2wgFRpEwaSPLujkDZV3XvqmoIOUjDnCI8GiMD/g
	Q0IFADB+WMioBUlneWr/S6fzIs4MEM9kgtylSKm9X6PWyX+p/sWp/Y1DxbRe3Ix+w9y5pka45bL
	h8hW7pP0gmB97INqXEl3eBUjy9DB25BGWcog6IwlWazVvhZWtmQ==
X-Received: by 2002:a17:902:f70f:b0:1dd:81a3:8dc3 with SMTP id h15-20020a170902f70f00b001dd81a38dc3mr4364032plo.46.1714761773122;
        Fri, 03 May 2024 11:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO/B7NcxkkrJOjUeyFPE3oTYjTTOUH1HEefTB3GxhO5X3BJw+May4aWchCVGJZGF1h0o9dfQ==
X-Received: by 2002:a17:902:f70f:b0:1dd:81a3:8dc3 with SMTP id h15-20020a170902f70f00b001dd81a38dc3mr4363995plo.46.1714761772691;
        Fri, 03 May 2024 11:42:52 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4b0a:b7a4:5eb9:b8a9:508d])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001eb6280cb42sm3590633pls.11.2024.05.03.11.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:42:52 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
Date: Fri,  3 May 2024 15:42:38 -0300
Message-ID: <ZjUwHvyvkM3lj80Q@LeoBras>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <ZgsXRUTj40LmXVS4@google.com>
References: <20240328171949.743211-1-leobras@redhat.com> <ZgsXRUTj40LmXVS4@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Sean, Marcelo and Paul,

Thank you for your comments on this thread!
I will try to reply some of the questions below:

(Sorry for the delay, I was OOO for a while.)


On Mon, Apr 01, 2024 at 01:21:25PM -0700, Sean Christopherson wrote:
> On Thu, Mar 28, 2024, Leonardo Bras wrote:
> > I am dealing with a latency issue inside a KVM guest, which is caused by
> > a sched_switch to rcuc[1].
> > 
> > During guest entry, kernel code will signal to RCU that current CPU was on
> > a quiescent state, making sure no other CPU is waiting for this one.
> > 
> > If a vcpu just stopped running (guest_exit), and a syncronize_rcu() was
> > issued somewhere since guest entry, there is a chance a timer interrupt
> > will happen in that CPU, which will cause rcu_sched_clock_irq() to run.
> > 
> > rcu_sched_clock_irq() will check rcu_pending() which will return true,
> > and cause invoke_rcu_core() to be called, which will (in current config)
> > cause rcuc/N to be scheduled into the current cpu.
> > 
> > On rcu_pending(), I noticed we can avoid returning true (and thus invoking
> > rcu_core()) if the current cpu is nohz_full, and the cpu came from either
> > idle or userspace, since both are considered quiescent states.
> > 
> > Since this is also true to guest context, my idea to solve this latency
> > issue by avoiding rcu_core() invocation if it was running a guest vcpu.
> > 
> > On the other hand, I could not find a way of reliably saying the current
> > cpu was running a guest vcpu, so patch #1 implements a per-cpu variable
> > for keeping the time (jiffies) of the last guest exit.
> > 
> > In patch #2 I compare current time to that time, and if less than a second
> > has past, we just skip rcu_core() invocation, since there is a high chance
> > it will just go back to the guest in a moment.
> 
> What's the downside if there's a false positive?

False positive being guest_exit without going back in this CPU, right?
If so in WSC, supposing no qs happens and there is a pending request, RCU 
will take a whole second to run again, possibly making other CPUs wait 
this long for a synchronize_rcu.

This value (1 second) could defined in .config or as a parameter if needed, 
but does not seem a big deal, 

> 
> > What I know it's weird with this patch:
> > 1 - Not sure if this is the best way of finding out if the cpu was
> >     running a guest recently.
> > 
> > 2 - This per-cpu variable needs to get set at each guest_exit(), so it's
> >     overhead, even though it's supposed to be in local cache. If that's
> >     an issue, I would suggest having this part compiled out on 
> >     !CONFIG_NO_HZ_FULL, but further checking each cpu for being nohz_full
> >     enabled seems more expensive than just setting this out.
> 
> A per-CPU write isn't problematic, but I suspect reading jiffies will be quite
> imprecise, e.g. it'll be a full tick "behind" on many exits.

That would not be a problem, as it would mean 1 tick less waiting in the 
false positive WSC, and the 1s amount is plenty.

> 
> > 3 - It checks if the guest exit happened over than 1 second ago. This 1
> >     second value was copied from rcu_nohz_full_cpu() which checks if the
> >     grace period started over than a second ago. If this value is bad,
> >     I have no issue changing it.
> 
> IMO, checking if a CPU "recently" ran a KVM vCPU is a suboptimal heuristic regardless
> of what magic time threshold is used.  IIUC, what you want is a way to detect if
> a CPU is likely to _run_ a KVM vCPU in the near future.

That's correct!

>  KVM can provide that
> information with much better precision, e.g. KVM knows when when it's in the core
> vCPU run loop.

That would not be enough.
I need to present the application/problem to make a point:

- There is multiple  isolated physical CPU (nohz_full) on which we want to 
  run KVM_RT vcpus, which will be running a real-time (low latency) task.
- This task should not miss deadlines (RT), so we test the VM to make sure 
  the maximum latency on a long run does not exceed the latency requirement
- This vcpu will run on SCHED_FIFO, but has to run on lower priority than
  rcuc, so we can avoid stalling other cpus.
- There may be some scenarios where the vcpu will go back to userspace
  (from KVM_RUN ioctl), and that does not mean it's good to interrupt the 
  this to run other stuff (like rcuc).

Now, I understand it will cover most of our issues if we have a context 
tracking around the vcpu_run loop, since we can use that to decide not to 
run rcuc on the cpu if the interruption hapenned inside the loop.

But IIUC we can have a thread that "just got out of the loop" getting 
interrupted by the timer, and asked to run rcu_core which will be bad for 
latency.

I understand that the chance may be statistically low, but happening once 
may be enough to crush the latency numbers.

Now, I can't think on a place to put this context trackers in kvm code that 
would avoid the chance of rcuc running improperly, that's why the suggested 
timeout, even though its ugly.

About the false-positive, IIUC we could reduce it if we reset the per-cpu 
last_guest_exit on kvm_put.

> 
> > 4 - Even though I could detect no issue, I included linux/kvm_host.h into 
> >     rcu/tree_plugin.h, which is the first time it's getting included
> >     outside of kvm or arch code, and can be weird.
> 
> Heh, kvm_host.h isn't included outside of KVM because several architectures can
> build KVM as a module, which means referencing global KVM varibles from the kernel
> proper won't work.
> 
> >     An alternative would be to create a new header for providing data for
> >     non-kvm code.
> 
> I doubt a new .h or .c file is needed just for this, there's gotta be a decent
> landing spot for a one-off variable.

You are probably right

>  E.g. I wouldn't be at all surprised if there
> is additional usefulness in knowing if a CPU is in KVM's core run loop and thus
> likely to do a VM-Enter in the near future, at which point you could probably make
> a good argument for adding a flag in "struct context_tracking".  Even without a
> separate use case, there's a good argument for adding that info to context_tracking.

For the tracking solution, makes sense :)
Not sure if the 'timeout' alternative will be that useful outside rcu.

Thanks!
Leo


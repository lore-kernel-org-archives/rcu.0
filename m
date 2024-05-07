Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1D078C76
	for <rcu@vger.kernel.org>; Tue,  7 May 2024 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715121406; cv=none; b=AiXnjmYfAwnkKLTAMgrm72mn35wNRtxGRP3Yj8EHW3Ue9FSxubUJQoAr7Ni3Fzi01XeO0/uIjBOno2uI+MwbC+53FblRITfzHsJ+DderqgNJW3MXG5ZwGFZ0f3WzRzyDKdrOhQkKMXSxzonIT4rm7mCXuDXvcPYgodx1PIw1R0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715121406; c=relaxed/simple;
	bh=qLh4FcW043Jw3x1x/N3WG1KkmF0fIC1AdFobuqPSh6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=tvpzLTDN8KOTTDJXeU349MnlFJYVv7wdYLTvV80PhiFNErtHrBVkWMStoPhHoKEAaF5KB5OL52rdwAP2qkF/4r/jBlqM0QskCtjgfJkE5lvVgZky498fFoadPrgijHsv6oNEo4Yk9hpz2eUMQIJWXzEG6d+UzPz8Zs3ilKa9P0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCyNzVAY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCyNzVAY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715121403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yft7MoXeXYqeDwiwLX/QmeJ5r//V2xxgF5dCCW5zxIU=;
	b=LCyNzVAY6naTF+F8mDOctYR1PpnxN+H4982GwV26Rkb8k3w2WVDU9/adg4yBRJSbtFIrRa
	xS6AhYBTaTJ9Ls94KwxAwU9DPCAZIhe+U2lZva7M1rS+Ze8weYg+fe+aB+xDPNu+R+QtgH
	p8OzmVGOMUrK9xUETXvCL0z5C88Hv44=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-1R-frbtAOKCPJnpPpRTM2A-1; Tue, 07 May 2024 18:36:42 -0400
X-MC-Unique: 1R-frbtAOKCPJnpPpRTM2A-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1ec48e36217so31368585ad.3
        for <rcu@vger.kernel.org>; Tue, 07 May 2024 15:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715121401; x=1715726201;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yft7MoXeXYqeDwiwLX/QmeJ5r//V2xxgF5dCCW5zxIU=;
        b=HaaPFdiq6j2877sw0rYbB67PXO/jelIuglF9mbikc3fqd8eWFlMXbEjerYfBUTjrJH
         SBcfYNB7LVGd5N9itNWCXTpONaH3heJT3Pa8AVENXnrNGQt+CvZhVLmlc0pknH1NAN3Q
         8lHGr5o4XEN3yAZ3U1u7wKtRtRnlkUEQQTLthIS7V8Lo2O/2uFEeci/InAFJoLb91trh
         uOm15SDdhj+oGw2rzidjQgl6bh3qF7MT1iL7eaB1K1siUDVGzYersUGkWTlk/7W3OtCY
         Smua2/eeYpFAVp2MZCpyZhLIWKcHEr1gTWVmy41TWER51T01lkHd4CE2W/HhmSZv0fSo
         LUWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmEJ4T8E/Ov4wN7K7ARFcorcLFW3HOoWm2aJGWTTOlxdXAe9KB59QHdLafDDuNmwfkbqSoSV+y8Le/X/P3MmdvDZIr
X-Gm-Message-State: AOJu0Ywa0Cmb/g7qJOiKJ2gtOIi6sDagubUuXoYP4T7R+DSvWdRTqeit
	NU4dwEOj83PQeATxXa33wIcllXH1P3bfie0cwGldeK0rSDcCF3qhx/LhjdAHu7VidzlQS57KK6q
	Rpq1/bqxFFseb9LU8+s1V2PuFTtblYMQJmePLCpXkaSKS8Qbe+Q==
X-Received: by 2002:a17:903:1108:b0:1eb:fe3:3436 with SMTP id d9443c01a7336-1eeb078f3aamr10167605ad.52.1715121400994;
        Tue, 07 May 2024 15:36:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsT0q+Ag+v8B4RKnqvWGzH2V6aKthhzvi7rusOJ89hjqpUoCdyGnZd9MOkYWdlIfwbIpCFyw==
X-Received: by 2002:a17:903:1108:b0:1eb:fe3:3436 with SMTP id d9443c01a7336-1eeb078f3aamr10167365ad.52.1715121400572;
        Tue, 07 May 2024 15:36:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:4b0a:b7a4:5eb9:b8a9:508d])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902650600b001e259719a5fsm10780512plk.103.2024.05.07.15.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 15:36:39 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
Date: Tue,  7 May 2024 19:36:20 -0300
Message-ID: <Zjqs5G_f2DCfhE62@LeoBras>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <Zjptg53OzzKwImH5@google.com>
References: <ZhQmaEXPCqmx1rTW@google.com> <Zh2EQVj5bC0z5R90@tpad> <Zh2cPJ-5xh72ojzu@google.com> <Zh5w6rAWL+08a5lj@tpad> <Zh6GC0NRonCpzpV4@google.com> <Zh/1U8MtPWQ/yN2T@tpad> <ZiAFSlZwxyKzOTRL@google.com> <ZjVMpj7zcSf-JYd_@LeoBras> <ZjkludR5wh0mKZ2H@tpad> <Zjptg53OzzKwImH5@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, May 07, 2024 at 11:05:55AM -0700, Sean Christopherson wrote:
> On Mon, May 06, 2024, Marcelo Tosatti wrote:
> > On Fri, May 03, 2024 at 05:44:22PM -0300, Leonardo Bras wrote:
> > > > And that race exists in general, i.e. any IRQ that arrives just as the idle task
> > > > is being scheduled in will unnecessarily wakeup rcuc.
> > > 
> > > That's a race could be solved with the timeout (snapshot) solution, if we 
> > > don't zero last_guest_exit on kvm_sched_out(), right?
> > 
> > Yes.
> 
> And if KVM doesn't zero last_guest_exit on kvm_sched_out(), then we're right back
> in the situation where RCU can get false positives (see below).
> 
> > > > > > >         /* Is the RCU core waiting for a quiescent state from this CPU? */
> > > > > > > 
> > > > > > > The problem is:
> > > > > > > 
> > > > > > > 1) You should only set that flag, in the VM-entry path, after the point
> > > > > > > where no use of RCU is made: close to guest_state_enter_irqoff call.
> > > > > > 
> > > > > > Why?  As established above, KVM essentially has 1 second to enter the guest after
> > > > > > setting in_guest_run_loop (or whatever we call it).  In the vast majority of cases,
> > > > > > the time before KVM enters the guest can probably be measured in microseconds.
> > > > > 
> > > > > OK.
> > > > > 
> > > > > > Snapshotting the exit time has the exact same problem of depending on KVM to
> > > > > > re-enter the guest soon-ish, so I don't understand why this would be considered
> > > > > > a problem with a flag to note the CPU is in KVM's run loop, but not with a
> > > > > > snapshot to say the CPU recently exited a KVM guest.
> > > > > 
> > > > > See the race above.
> > > > 
> > > > Ya, but if kvm_last_guest_exit is zeroed in kvm_sched_out(), then the snapshot
> > > > approach ends up with the same race.  And not zeroing kvm_last_guest_exit is
> > > > arguably much more problematic as encountering a false positive doesn't require
> > > > hitting a small window.
> > > 
> > > For the false positive (only on nohz_full) the maximum delay for the
> > > rcu_core() to be run would be 1s, and that would be in case we don't
> > > schedule out for some userspace task or idle thread, in which case we have
> > > a quiescent state without the need of rcu_core().
> > > 
> > > Now, for not being an userspace nor idle thread, it would need to be one or
> > > more kernel threads, which I suppose aren't usually many, nor usually take
> > > that long for completing, if we consider to be running on an isolated
> > > (nohz_full) cpu. 
> > > 
> > > So, for the kvm_sched_out() case, I don't actually think we are  
> > > statistically introducing that much of a delay in the RCU mechanism.
> > > 
> > > (I may be missing some point, though)
> 
> My point is that if kvm_last_guest_exit is left as-is on kvm_sched_out() and
> vcpu_put(), then from a kernel/RCU safety perspective there is no meaningful
> difference between KVM setting kvm_last_guest_exit and userspace being allowed
> to mark a task as being exempt from being preempted by rcuc.  Userspace can
> simply do KVM_RUN once to gain exemption from rcuc until the 1 second timeout
> expires.

Oh, I see. Your concern is that an user can explore this to purposely
explore/slowdown the RCU mechanism on nohz_full isolated CPUs. Is that 
it?

Even in this case, KVM_RUN would need to run every second, which would 
cause a quiescent state every second, and move other CPUs forward in RCU.

I don't get how this could be explored. I mean, running idle tasks and 
userspace tasks would already cause a quiescent state, making this useless 
for this purpose. So the user would need to be willing to run kernel 
threads in the meantime between KVM_RUNs, right?

Maybe this could be relevant on the scenario: 
"I want the other users of this machine to experience slowdown in their 
processes".
But this this is possible to reproduce by actually running a busy VM in the 
cpu anyway, even in the context_tracking solution, right?

I may have missed your point here. :/
Could you help me understand it, please?

Thanks!
Leo



> 
> And if KVM does zero kvm_last_guest_exit on kvm_sched_out()/vcpu_put(), then the
> approach has the exact same window as my in_guest_run_loop idea, i.e. rcuc can be
> unnecessarily awakened in the time between KVM puts the vCPU and the CPU exits to
> userspace.
> 


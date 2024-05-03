Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452903398A
	for <rcu@vger.kernel.org>; Fri,  3 May 2024 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714773620; cv=none; b=KWNuIN2Xo4ySTAK1iHkjtSzW91G7H9JUL5m5QTEPbS2hK1tw5OEZo1uAevMixCMhKfCuwSa/Cib4834rIegr7a3+BohIpruxUTR/0kW7mSdY6Z0uFqeiYUzGrbpAVojj40E8Nx/kQSrm947Zlocfu+IioO2q/9j5tPseWmuByVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714773620; c=relaxed/simple;
	bh=XQiU0er//ycreNecj07YnExhQLfQPkzMxtFyfmDgfLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=XaCA0CLsOQKuJ5S9TfqvzGgkDqvXN2KLL9cZc8k1zltZUBjg79hbRiZLGzIShfj3Iazk9Vlt5ZCMi4KFs2eH48kskpQOAfqnIpD1xkDr+7FqWsLFVOv3+j3OL7L5T+xZJ/kAJuSpqid2t6qg3fpmUFLv2Nj0QkBCMgrRldaD4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IKhS35f9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKhS35f9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714773618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkMTmfCnwe1TLRVSdXDuN09++cK3MORgect0bHY89+U=;
	b=IKhS35f9lLT/V5jFdR5FChRobjFU+npZ94m9ElDweFpHMUhJTCHlsiPJTgr8rXktNfAWsV
	xdZ2lmYQPzJ1J4URo7/8eLFT28AcpOZt5YsRDb6CGWuy/Isj899qS62lqIj7/4ruyatt5w
	4HfYQx3vHKUvrU5nei9KDrEnh7GbaE0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-6QCbUDLFM2C6RTrhNlC7VA-1; Fri, 03 May 2024 18:00:16 -0400
X-MC-Unique: 6QCbUDLFM2C6RTrhNlC7VA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-439fcfca0a7so1341111cf.3
        for <rcu@vger.kernel.org>; Fri, 03 May 2024 15:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714773615; x=1715378415;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkMTmfCnwe1TLRVSdXDuN09++cK3MORgect0bHY89+U=;
        b=McjRGhmSmEaFkjLnUOedId0YTyl+DKLXGA3DxPz1WlBKzF7bTGnewlxmZEvLxwbs4h
         uPymB/1An4Vvx337I7MLkm2PiR8w/LotbhmHO5lpWUPW3ZO1Q8E/LY9CWxVuz8Acw0Gf
         kMk4y40jZ26y5HyT+ibjrcMXkGQzb/AtvKlEXsJZr/rZ+ozgmNrEgbidMSwM46smua8i
         K15STBGtYRVGutER0iZQ4Vb5hCPSKo21MU3iymgnG30fZZ2il3tJgRa2lIH4I7KqK9Fn
         JXSA7A+mG0C9g9oUkhyc4hLS+uWY8XCsj25WzNrvZgGyrzUvSt82d4lpX5QZ9ZBWZPOJ
         VAcA==
X-Forwarded-Encrypted: i=1; AJvYcCU2J0UME6c+KDsOGp6/08ge/uLXQcZtv2AcQHZAzHnmwilz/EfUAlxlrJtEPyhARtL76aOJ8xrP4NG5OVgXg+8PeAgS
X-Gm-Message-State: AOJu0YxMG9Km0zCsqKLYEphY5nb7JVElMm5DnplMZe7J3F9CGkCoD5WA
	QEhX1lleRfGGodH4JqGYRWCV+LK7tLqCP6IR/Xfamq+231K9U3Alh0w1Puw7HPAPS4YMl3v/JoA
	Bk9kUbd7lzPgcQMIXnGmryjDs+/RbdNI/eigS90ejogHuJGKaJg==
X-Received: by 2002:a05:622a:64a:b0:43a:c04c:e3d3 with SMTP id a10-20020a05622a064a00b0043ac04ce3d3mr4760588qtb.34.1714773614904;
        Fri, 03 May 2024 15:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtvMvUlssNS/lZYNWfxREqByMmGZElBz+i7SUORBFfOFK20m+exUSKpKGv8DylZ/jEex73aw==
X-Received: by 2002:a05:622a:64a:b0:43a:c04c:e3d3 with SMTP id a10-20020a05622a064a00b0043ac04ce3d3mr4760547qtb.34.1714773614409;
        Fri, 03 May 2024 15:00:14 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4b0a:b7a4:5eb9:b8a9:508d])
        by smtp.gmail.com with ESMTPSA id cb6-20020a05622a1f8600b0043c7d293f9fsm1986488qtb.67.2024.05.03.15.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 15:00:11 -0700 (PDT)
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
Date: Fri,  3 May 2024 19:00:01 -0300
Message-ID: <ZjVeYVQm1iU-y7JF@LeoBras>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <ZjVXVc2e_V8NiMy3@google.com>
References: <20240328171949.743211-1-leobras@redhat.com> <ZgsXRUTj40LmXVS4@google.com> <ZjUwHvyvkM3lj80Q@LeoBras> <ZjVXVc2e_V8NiMy3@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, May 03, 2024 at 02:29:57PM -0700, Sean Christopherson wrote:
> On Fri, May 03, 2024, Leonardo Bras wrote:
> > > KVM can provide that information with much better precision, e.g. KVM
> > > knows when when it's in the core vCPU run loop.
> > 
> > That would not be enough.
> > I need to present the application/problem to make a point:
> > 
> > - There is multiple  isolated physical CPU (nohz_full) on which we want to 
> >   run KVM_RT vcpus, which will be running a real-time (low latency) task.
> > - This task should not miss deadlines (RT), so we test the VM to make sure 
> >   the maximum latency on a long run does not exceed the latency requirement
> > - This vcpu will run on SCHED_FIFO, but has to run on lower priority than
> >   rcuc, so we can avoid stalling other cpus.
> > - There may be some scenarios where the vcpu will go back to userspace
> >   (from KVM_RUN ioctl), and that does not mean it's good to interrupt the 
> >   this to run other stuff (like rcuc).
> >
> > Now, I understand it will cover most of our issues if we have a context 
> > tracking around the vcpu_run loop, since we can use that to decide not to 
> > run rcuc on the cpu if the interruption hapenned inside the loop.
> > 
> > But IIUC we can have a thread that "just got out of the loop" getting 
> > interrupted by the timer, and asked to run rcu_core which will be bad for 
> > latency.
> > 
> > I understand that the chance may be statistically low, but happening once 
> > may be enough to crush the latency numbers.
> > 
> > Now, I can't think on a place to put this context trackers in kvm code that 
> > would avoid the chance of rcuc running improperly, that's why the suggested 
> > timeout, even though its ugly.
> > 
> > About the false-positive, IIUC we could reduce it if we reset the per-cpu 
> > last_guest_exit on kvm_put.
> 
> Which then opens up the window that you're trying to avoid (IRQ arriving just
> after the vCPU is put, before the CPU exits to userspace).
> 
> If you want the "entry to guest is imminent" status to be preserved across an exit
> to userspace, then it seems liek the flag really should be a property of the task,
> not a property of the physical CPU.  Similar to how rcu_is_cpu_rrupt_from_idle()
> detects that an idle task was interrupted, that goal is to detect if a vCPU task
> was interrupted.
> 
> PF_VCPU is already "taken" for similar tracking, but if we want to track "this
> task will soon enter an extended quiescent state", I don't see any reason to make
> it specific to vCPU tasks.  Unless the kernel/KVM dynamically manages the flag,
> which as above will create windows for false negatives, the kernel needs to
> trust userspace to a certaine extent no matter what.  E.g. even if KVM sets a
> PF_xxx flag on the first KVM_RUN, nothing would prevent userspace from calling
> into KVM to get KVM to set the flag, and then doing something else entirely with
> the task.
> 
> So if we're comfortable relying on the 1 second timeout to guard against a
> misbehaving userspace, IMO we might as well fully rely on that guardrail.  I.e.
> add a generic PF_xxx flag (or whatever flag location is most appropriate) to let
> userspace communicate to the kernel that it's a real-time task that spends the
> overwhelming majority of its time in userspace or guest context, i.e. should be
> given extra leniency with respect to rcuc if the task happens to be interrupted
> while it's in kernel context.
> 


I think I understand what you propose here.

But I am not sure what would happen in this case:

- RT guest task calls short HLT
- Host schedule another kernel thread (other task)
- Timer interruption, rcu_pending will() check the task which is not set 
  with above flag.
- rcuc runs, introducing latency
- Goes back to previous kernel thread, finishes running with rcuc latency
- Goes back to vcpu thread

Isn't there any chance that, on an short guest HLT, the latency previously 
introduced by rcuc preempting another kernel thread gets to introduce a 
latency to the RT task running in the vcpu?

Thanks!
Leo



- 


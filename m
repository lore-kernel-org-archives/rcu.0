Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45C50A9D
	for <rcu@vger.kernel.org>; Fri,  3 May 2024 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771800; cv=none; b=SBChOnZzBI0W/zREGBtgRxcKS5bcjYQTAo+RpPEElHO8+KDn4CKXQHbZh6SFEoL1haPtPY0hhQagw4yQ0pxziTVwXVdoCRcr6PIgzyHsmTkSUslwuwYyabrZJrfSNGJvhLp+JFfT+W7btthmiZoy+VtXbApZszDgS07v1cALxtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771800; c=relaxed/simple;
	bh=EQL3IeOBP2Bu3dDlMxHDHIr3MtiCwMbPHUudi15G5QY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jUVrsgXbZPvzqD23SXQY2ij/1+wCw6aQ6ymUXH28dPWwaWdox4q2Dms/H5QzifMvDLPRGUvRZukLVlz+5XHmYO4kkaYUp1jGJAroi7H6tzi1C0h+pTpHhd0It1yiCQev7EHJKp0bW5DvwqsPYUHeiFjdn27itII6fr8kHjieeyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DdxW38AY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DdxW38AY"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b40ef83453so145004a91.2
        for <rcu@vger.kernel.org>; Fri, 03 May 2024 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714771799; x=1715376599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNr9lZmsjOzqzGs7i+GBj2/4wYllIMuY8anx349EdT0=;
        b=DdxW38AYZ4c9t5T6ft/zwfIdQQBEngxmtBJsZei+Ux8Y8kjJRgGUq46Wa7AbpuomB3
         aHveA0IQ+/ta5QwTefzZSjS6po6YK/Lcy6nrVRkbqbv5uD/acTYTKIEQrL9GhW+7YhVa
         GqRoXL3vSA+3NKPGEsAqKmMUdFr0Jj3u3DdO6RIpzOdcBBb3S0zy6hVq5pIgPANfObei
         TjoA1tFqNYRc/CZUfLHLZgWUlZoidlm0VWwzqN6qOeLmD9ZURZst7xr5pJ4+dKtK9a33
         omjMKM/hcWLU1C/uilp9BAP4Kg9u+FAX1e+3VwwAuZ9hv7wi/I4kEHNZnZrXCPjcMDwM
         NVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771799; x=1715376599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNr9lZmsjOzqzGs7i+GBj2/4wYllIMuY8anx349EdT0=;
        b=CwArMHZyL3FNvqAVwdn3GyaevuG/QBIhBuRmEjfsDLenud+yHAt7s1BgAOk681bvom
         8wgnCta41MK/VEgBRME23dP+W1fQnIbC4hl3nmJjs8Dm7M2d2jgNmovDWVu28mocvyY8
         YwNo99c1CjSKnfq3qlSb4TINhUbT8g1C4albcn4fOvwvPZnUoV3jotmyHOnQlzv7BmQJ
         POTRDN+MOIjXG5lLr0xJboBu4ESZ2Tgh1lDHT4u26lLFtoVR7GxKxGr9ckhWAeJyom3O
         9zZ1V5H21hN455MgFhaQ1tYdm+zUDCrDVjYVTlrokZtcQ6Sek8yvu3IQYBacCebERGv5
         W4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWywYBRm/6NJIZHaMxpjYoosu5/lGHvIrnqZRasbD7BfFUp7axvR3M30we8l8yt2Ih4a1UYHhbEHvdY8FDRmKRePqtB
X-Gm-Message-State: AOJu0Yy1KDQlUqFqKCxeJvbyE1NymfJwC23Y3mybj6Xuu36cDeimMsBj
	/CUgrFWl0Xpf9CGKLLT4gxweP8WVuIANlWmEm1kuOZW/9D+ZZThoMcLaEjNEFXIMki8pbEfyYVx
	Hsw==
X-Google-Smtp-Source: AGHT+IF9Vxd2NYDOkdG6bdDYRHr51xqBZdk7NhC734vEBMcRNr/FlI1t8PmITviB5QPPFCtj8eIQae1ddMg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:db55:b0:2b2:9773:edab with SMTP id
 u21-20020a17090adb5500b002b29773edabmr10552pjx.0.1714771798574; Fri, 03 May
 2024 14:29:58 -0700 (PDT)
Date: Fri, 3 May 2024 14:29:57 -0700
In-Reply-To: <ZjUwHvyvkM3lj80Q@LeoBras>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328171949.743211-1-leobras@redhat.com> <ZgsXRUTj40LmXVS4@google.com>
 <ZjUwHvyvkM3lj80Q@LeoBras>
Message-ID: <ZjVXVc2e_V8NiMy3@google.com>
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
From: Sean Christopherson <seanjc@google.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 03, 2024, Leonardo Bras wrote:
> > KVM can provide that information with much better precision, e.g. KVM
> > knows when when it's in the core vCPU run loop.
> 
> That would not be enough.
> I need to present the application/problem to make a point:
> 
> - There is multiple  isolated physical CPU (nohz_full) on which we want to 
>   run KVM_RT vcpus, which will be running a real-time (low latency) task.
> - This task should not miss deadlines (RT), so we test the VM to make sure 
>   the maximum latency on a long run does not exceed the latency requirement
> - This vcpu will run on SCHED_FIFO, but has to run on lower priority than
>   rcuc, so we can avoid stalling other cpus.
> - There may be some scenarios where the vcpu will go back to userspace
>   (from KVM_RUN ioctl), and that does not mean it's good to interrupt the 
>   this to run other stuff (like rcuc).
>
> Now, I understand it will cover most of our issues if we have a context 
> tracking around the vcpu_run loop, since we can use that to decide not to 
> run rcuc on the cpu if the interruption hapenned inside the loop.
> 
> But IIUC we can have a thread that "just got out of the loop" getting 
> interrupted by the timer, and asked to run rcu_core which will be bad for 
> latency.
> 
> I understand that the chance may be statistically low, but happening once 
> may be enough to crush the latency numbers.
> 
> Now, I can't think on a place to put this context trackers in kvm code that 
> would avoid the chance of rcuc running improperly, that's why the suggested 
> timeout, even though its ugly.
> 
> About the false-positive, IIUC we could reduce it if we reset the per-cpu 
> last_guest_exit on kvm_put.

Which then opens up the window that you're trying to avoid (IRQ arriving just
after the vCPU is put, before the CPU exits to userspace).

If you want the "entry to guest is imminent" status to be preserved across an exit
to userspace, then it seems liek the flag really should be a property of the task,
not a property of the physical CPU.  Similar to how rcu_is_cpu_rrupt_from_idle()
detects that an idle task was interrupted, that goal is to detect if a vCPU task
was interrupted.

PF_VCPU is already "taken" for similar tracking, but if we want to track "this
task will soon enter an extended quiescent state", I don't see any reason to make
it specific to vCPU tasks.  Unless the kernel/KVM dynamically manages the flag,
which as above will create windows for false negatives, the kernel needs to
trust userspace to a certaine extent no matter what.  E.g. even if KVM sets a
PF_xxx flag on the first KVM_RUN, nothing would prevent userspace from calling
into KVM to get KVM to set the flag, and then doing something else entirely with
the task.

So if we're comfortable relying on the 1 second timeout to guard against a
misbehaving userspace, IMO we might as well fully rely on that guardrail.  I.e.
add a generic PF_xxx flag (or whatever flag location is most appropriate) to let
userspace communicate to the kernel that it's a real-time task that spends the
overwhelming majority of its time in userspace or guest context, i.e. should be
given extra leniency with respect to rcuc if the task happens to be interrupted
while it's in kernel context.

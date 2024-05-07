Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424556B6F
	for <rcu@vger.kernel.org>; Tue,  7 May 2024 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115616; cv=none; b=jevGFt9VT/zT1W2hNbThapiP/kuv3Nzk0jCQMD66ojSlTTNiois7UE52ViomIsVmC5tjbmi5KIPXlEWphTGMnY6GQhPTz0r54h4kjJIxSZQtnJO8qnIGmZkGWy4RbvKh0/rDn880+KLLDlG1CUPHmAjfjeoOYsbgqiElnbdObhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115616; c=relaxed/simple;
	bh=KGaBxlKzHGddtI5cT3/iPp6MeXwNxT3uYaVqVaOo3wo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XNnCzGFwyTxQtlpXUUScBh5mGxUd90UiwFrLQKBY7E/j49U+g94v77L4J2okkRzGjmUzlrrb9ndgYq1scHsYz24pjVyWIf1Ilny2qlk1GNAk9wbygCdI/zRC4VI0IvZwRpFcS4PnP7xlaCd03TCx5aLvyVIF0oHJp7A8zFNjW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ttsqER34; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ttsqER34"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61d21cf3d3bso61802747b3.3
        for <rcu@vger.kernel.org>; Tue, 07 May 2024 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715115614; x=1715720414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gt0HQZF6AKIfqYkEueAoLR6ql6u8oX1eFDCyfBRdfyw=;
        b=ttsqER347XtN/ZjV87StpMgg2aEaU5QHpdBZuoSflbpKv7hpcR1L/FQ8YWu8ECMYfV
         aik4LcSgHZXQlA7YERfB9DpKjkSRWAUDoc2AIE3+pNTMrl7utHRgeJsmE+cGOEKxKaDz
         A7y9nuAfwDsC9ESPuNBkew9jrUyARqFRGu6zlKgCW2scr+RCoIlKI9ZDM/ANJWqyTjVq
         KIdEjnUQL05kiFdPLU9PdCDTsoBbaNRJJrTPL5y9SkB/phIeReLY3RtfJXe4aE5aGgMz
         f0ot2iJVgWo9VWAF9NpBFcIQs3TXijiaQjBs8VYmCevgf3gzwq02qVoP/wT5O9VYhuWe
         nlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715115614; x=1715720414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gt0HQZF6AKIfqYkEueAoLR6ql6u8oX1eFDCyfBRdfyw=;
        b=cHpUx1v644MswYwHirEFHj3lGJvyRyB2yaYx9ejaM/oWW3LyXutyz6fYE2v+Llp6of
         IuQ3bCexjH81L6qPD6FcroazhxY6eG8Z/+od/CM5EYbuz6/DlEZBe3vyXNHrDjm/taCZ
         q8K/ie1T6LVvX3dTnGxMOgNR2GGfATZWmN0bjFruVmWrnJhoNTSYBBjtBuht6ek66eeO
         WKFN0Poh6BrvoS7j8Rh1YtfHzN9rnUjJw3pDfj2gWudzHbUAsPujJKKjk0KSeaJdI/EF
         T8+6emAPjLR54IzezUa8EQXyGrnpBqM65TUlTIOejZ9jaQeJ1RRp5dFERDvc4dA5rtDV
         iC1w==
X-Forwarded-Encrypted: i=1; AJvYcCXqjaH5BroCDO4PJpg3LA3v9xp9Fgu0esteMphFKX1n9QfTF0GofJ4f/7DTzBMjKgfRPDcEYbLg9MpBmJnCseugdpRu
X-Gm-Message-State: AOJu0Yw6o7olvJsVHTVfh12SConEsBgwAQX4r5BhjUkp6w+ihdiD5w4C
	5ropNIC4eiFfZdeY/DfFkTAWTv1FpVIXXROxC0ClcBZA8J6UiQJyl5CdQCUouR1CDllOdleAV19
	8ag==
X-Google-Smtp-Source: AGHT+IGyXnV0t6LTC2+6Qm+s+jCXY/9iy23P8kf+tZ7wZU82m6+nn3Hh/XAbuULfL6Zy9qX11RYWuRk32vE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2b43:0:b0:de4:5eaa:4b67 with SMTP id
 3f1490d57ef6-debb9da3339mr78675276.11.1715115614194; Tue, 07 May 2024
 14:00:14 -0700 (PDT)
Date: Tue, 7 May 2024 14:00:12 -0700
In-Reply-To: <663a659d-3a6f-4bec-a84b-4dd5fd16c3c1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328171949.743211-1-leobras@redhat.com> <ZgsXRUTj40LmXVS4@google.com>
 <ZjUwHvyvkM3lj80Q@LeoBras> <ZjVXVc2e_V8NiMy3@google.com> <3b2c222b-9ef7-43e2-8ab3-653a5ee824d4@paulmck-laptop>
 <ZjprKm5jG3JYsgGB@google.com> <663a659d-3a6f-4bec-a84b-4dd5fd16c3c1@paulmck-laptop>
Message-ID: <ZjqWXPFuoYWWcxP3@google.com>
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
From: Sean Christopherson <seanjc@google.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 07, 2024, Paul E. McKenney wrote:
> On Tue, May 07, 2024 at 10:55:54AM -0700, Sean Christopherson wrote:
> > On Fri, May 03, 2024, Paul E. McKenney wrote:
> > > On Fri, May 03, 2024 at 02:29:57PM -0700, Sean Christopherson wrote:
> > > > So if we're comfortable relying on the 1 second timeout to guard against a
> > > > misbehaving userspace, IMO we might as well fully rely on that guardrail.  I.e.
> > > > add a generic PF_xxx flag (or whatever flag location is most appropriate) to let
> > > > userspace communicate to the kernel that it's a real-time task that spends the
> > > > overwhelming majority of its time in userspace or guest context, i.e. should be
> > > > given extra leniency with respect to rcuc if the task happens to be interrupted
> > > > while it's in kernel context.
> > > 
> > > But if the task is executing in host kernel context for quite some time,
> > > then the host kernel's RCU really does need to take evasive action.
> > 
> > Agreed, but what I'm saying is that RCU already has the mechanism to do so in the
> > form of the 1 second timeout.
> 
> Plus RCU will force-enable that CPU's scheduler-clock tick after about
> ten milliseconds of that CPU not being in a quiescent state, with
> the time varying depending on the value of HZ and the number of CPUs.
> After about ten seconds (halfway to the RCU CPU stall warning), it will
> resched_cpu() that CPU every few milliseconds.
> 
> > And while KVM does not guarantee that it will immediately resume the guest after
> > servicing the IRQ, neither does the existing userspace logic.  E.g. I don't see
> > anything that would prevent the kernel from preempting the interrupt task.
> 
> Similarly, the hypervisor could preempt a guest OS's RCU read-side
> critical section or its preempt_disable() code.
> 
> Or am I missing your point?

I think you're missing my point?  I'm talking specifically about host RCU, what
is or isn't happening in the guest is completely out of scope.

My overarching point is that the existing @user check in rcu_pending() is optimistic,
in the sense that the CPU is _likely_ to quickly enter a quiescent state if @user
is true, but it's not 100% guaranteed.  And because it's not guaranteed, RCU has
the aforementioned guardrails.

And I'm arguing that, since the @user check isn't bombproof, there's no reason to
try to harden against every possible edge case in an equivalent @guest check,
because it's unnecessary for kernel safety, thanks to the guardrails.

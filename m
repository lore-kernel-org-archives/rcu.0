Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFBE2836B5
	for <rcu@vger.kernel.org>; Tue, 17 Mar 2026 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754469; cv=none; b=D2A6vm+qkS9UkZ9qKUHmrjeCTBkdfND9U4mXPkSA5cYFnyBUGQXnVhmtrR0aywmNWEDDrXNd2RKb4fqzZNCRfcPS3tB/xAxwwYfzJsT4fLW85A9brsqLNUaCER+cRcwF1BMhGAMmuX8XVosJLE1F3CUmuJ3Uq3RsuyW2EKTTE2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754469; c=relaxed/simple;
	bh=HE5o7NvvcoTvNry8H/eHkvgYRRNwg+qejCpG/sn7S98=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bJ//axVDA5IiRE/kyoF+YmdJjMS4scleigW3VufpSVUWoClxY9/uJAqXzfAzxdgU+WqhrG2Q7i+v0wtL95PJnjmHO3ZUNgKEVVwmTDW4ZsTtnqOrEyHX5ltu+oBrecrbTDBajACZtIDOLmmA9fwHqY7u/YGeJwJujJ/bPEb3K5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYQo9ZgI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYQo9ZgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE297C19425;
	Tue, 17 Mar 2026 13:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773754469;
	bh=HE5o7NvvcoTvNry8H/eHkvgYRRNwg+qejCpG/sn7S98=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=TYQo9ZgIssYgS6Js/4Cl6mp3AV/tsUsmDhg/sTJiuz9oqGfLL8i6Le17U82jghpZk
	 KOOQtFzQULTnl2A/uaFEmXh+1rTW2YNcLGObqlqdIbohiETqFGVYoPNMrov9VB7EMF
	 4WaKRkOQ1PhOiiYy9YUJyc2oWc96d5pVNiUm69qK+xIJUNMf8eO9TADevqWKPwVgc2
	 gENyUV3E0HyyLQctxjwrC8kJ5oMQWVZz3i7PiqYmyMMDD+vIJ+kL1DQeslfKNeFd8C
	 207jNqUcdnNlJ0ogYeMrWu+RQasz4B/0G+l8+IqE23pHUQsM5++BpHwEIJ0ZkCDXub
	 0pbXzYiIiduhg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AB2AFCE0B07; Tue, 17 Mar 2026 06:34:26 -0700 (PDT)
Date: Tue, 17 Mar 2026 06:34:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, boqun.feng@gmail.com
Cc: rcu@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Next-level bug in SRCU implementation of RCU Tasks Trace + PREEMPT_RT
Message-ID: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

Kumar Kartikeya Dwivedi (CCed) privately reported a bug in
my implementation of the RCU Tasks Trace API in terms of SRCU-fast.
You see, I forgot to ask what contexts call_rcu_tasks_trace() is called
from, and it turns out that it can in fact be called with the scheduler
pi/rq locks held.  This results in a deadlock when SRCU-fast invokes the
scheduler in order to start the SRCU-fast grace period.  So RCU needs
a fix to my fix found here:

b540c63cf6e5 ("srcu: Use raw spinlocks so call_srcu() can be used under preempt_disable()")

Sebastian, the PREEMPT_RT aspect is that lockdep does not complain
about acquisition of non-raw spinlocks from preemption-disabled regions
of code.  This might be intentional, for example, there might be large
bodies of Linux-kernel code that frequently acquire non-raw spinlocks
from preemption-disabled regions of code, but which are never part of
PREEMPT_RT kernels.  Otherwise, it might be good for lockdep to diagnose
this sort of thing.

Back to the actual bug, that call_srcu() now needs to tolerate being called
with scheduler rq/pi locks held...

The straightforward (but perhaps broken) way to resolve this is to make
srcu_gp_start_if_needed() defer invoking the scheduler, similar to the
way that vanilla RCU's call_rcu_core() function takes an early exit if
interrupts are disabled.  Of course, vanilla RCU can rely on things like
the scheduling-clock interrupt to start any needed grace periods [1],
but SRCU will instead need to manually defer this work, perhaps using
workqueues or IRQ work.

In addition, rcutorture needs to be upgraded to sometimes invoke
->call() with the scheduler pi lock held, but this change is not fixing
a regression, so could be deferred.  (There is already code in rcutorture
that invokes the readers while holding a scheduler pi lock.)

Given that RCU for this week through the end of March belongs to you guys,
if one of you can get this done by end of day Thursday, London time,
very good!  Otherwise, I can put something together.

Please let me know!

						Thanx, Paul [2]

[1] The exceptions to this rule being handled by the call to
    invoke_rcu_core() when rcu_is_watching() returns false.

[2] Ah, and should vanilla RCU's call_rcu() be invokable from NMI
    handlers?  Or should there be a call_rcu_nmi() for this purpose?
    Or should we continue to have its callers check in_nmi() when needed?

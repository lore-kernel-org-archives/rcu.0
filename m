Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52112638B3;
	Mon,  3 Mar 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020872; cv=none; b=rr7j9epQ91Cj5Ff4/GnKAOXA7+Ra8y8STnl3vptUbfZvyGQ5pdtXJH5KdJhNnBbwg40y7x+xQGckKW4Qenu/tC4mQ6XTHcd4dCKIreJq6OyDdlm4YeY0BPT4fmN6FYtaEkANZx9mQAORZnj/KzI2A/sy2t7yPzptOhj53ug2Adc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020872; c=relaxed/simple;
	bh=HFWd221qYkwBkZK/Eltiz7x5I4KV8ixBTSuJsUJ8heg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwIXt/5V12ajR6ilhCmJIPqJSMGY01iKIcXDmP3pmOM02js3pyqSShaUqhs5QenlevjFNsZstIMbgVg8msqPScXqL1ODY6i1jL0bVX4o187QwMGFrb7RR+nmOy5zVfo1qTL9VRFst4yj2epM5+UTkvgw27opjrbAQHihVv0NOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5127EC4CED6;
	Mon,  3 Mar 2025 16:54:30 +0000 (UTC)
Date: Mon, 3 Mar 2025 11:55:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Strforexc yn <strforexc@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: KASAN: global-out-of-bounds Read in srcu_gp_start_if_needed
Message-ID: <20250303115522.437773d7@gandalf.local.home>
In-Reply-To: <20250303114711.12716d05@gandalf.local.home>
References: <CA+HokZrPb-oHcuZQsc=LZ6_aJfjKy9oMeCBd-tq4b_sX5EG7NQ@mail.gmail.com>
	<20250303114711.12716d05@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 11:47:11 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > [   92.322619][   T28]  ? srcu_gp_start_if_needed+0x1a9/0x5f0
> > [   92.322636][   T28]  srcu_gp_start_if_needed+0x1a9/0x5f0  
> 
> The lock taken is from the passed in rcu_pending pointer.
> 
> > [   92.322655][   T28]  rcu_pending_enqueue+0x686/0xd30

I figured out what likely triggered the lockdep warning too. I thought
rcu_pending_equeue() was an internal RCU function, but then when I looked
at what directory it was in (found it in emacs so I only saw the file name
and not the path), I see that function is internal to bcachefs.

That function also has:

	local_irq_save(flags);
	p = this_cpu_ptr(pending->p);
	spin_lock(&p->lock);

That is a sure sign of an RT disaster waiting to happen. As in PREEMPT_RT
that spin_lock turns into a mutex, and just before, you disable interrupts.

And yes, lockdep will report that as a bug.

-- Steve

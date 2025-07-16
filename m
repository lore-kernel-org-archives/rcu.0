Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A67199935;
	Wed, 16 Jul 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678577; cv=none; b=BSmCeNZkVM2qdG8tHM2T+8Z80CTGxElTdWu2b3INkx+uCcc5Oou/B3cnO1zAsdj/kB/TMuTBZ+fMdjV8dtiv93KLUHQONrEyBC7BM6vsJfQaCYTIbM0e3fnitWiA96gJbp/r+GbN4yIGV3xRPrXiErgVKpXEvQSJ6GxwPl4Z30U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678577; c=relaxed/simple;
	bh=udKVfp54jvTQVoUSNkCjh4UzprprEWcUqW5CgAHCeb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSHkc+uar7vZBkYwjJUHmMYI9tc2NiXgonR4XeAsFmd13+wKXVt69y0p9wSO7ki8r+nZxsMn8n3Wr/g8IkLtLetMOr5hsAH48C8PvhRBFMhzdO3+DfooZFCA5M0uJOwqQB/b2tiP1AGe1vJe4zSXeoqHDZ8EBPeLjPt0M0Pcj+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id E7A111403BE;
	Wed, 16 Jul 2025 15:09:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 8C5B73B;
	Wed, 16 Jul 2025 15:09:23 +0000 (UTC)
Date: Wed, 16 Jul 2025 11:09:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Frederic Weisbecker
 <frederic@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <20250716110922.0dadc4ec@batman.local.home>
In-Reply-To: <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
References: <20250620084334.Zb8O2SwS@linutronix.de>
	<34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>
	<20250623104941.WxOQtAmV@linutronix.de>
	<03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
	<fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
	<29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
	<acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
	<ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
	<512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
	<bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
	<16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 173rm1wg47g3dcjidadpyy4ajng1pjje
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 8C5B73B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19DAW/3/GdXtEluzb41g8XAo3DhAQN7QhU=
X-HE-Tag: 1752678563-58156
X-HE-Meta: U2FsdGVkX18tz3Yx0CoJowNA+6hIiLSDZdksIfMg0CZ4+eyfoZQQuQFv51+Q0ub/zvLQ1ffeGWjBNtGgHQIHS3e2pU0hhHxqFt4mWTMRUj+EPixtfJi2uzQ+lkxsOKR5GeOhU2Z5aPU9Nrhs7Xy+nWEMDEty77/PyYzLOsNgqAJTjdfLb/US0vhz8g1h9KAZaYP0b1i0ktiPe/7ostSmbC/WXMZx/Tr7od3EYMOnRPsHuA6T9N8WamIKgj1JxZsfijduyO1yhGmh+mkIVERkgO4Ka8W9JH66NBDHNY9Y4DFi5Y1ov0ten/T7No4UhX9uJ1fqokvEif3cQ94lYK7BuvjXa3g0ceRq

On Fri, 11 Jul 2025 10:05:26 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> This trace point will invoke rcu_read_unlock{,_notrace}(), which will
> note that preemption is disabled.  If rcutree.use_softirq is set and
> this task is blocking an expedited RCU grace period, it will directly
> invoke the non-notrace function raise_softirq_irqoff().  Otherwise,
> it will directly invoke the non-notrace function irq_work_queue_on().

Just to clarify some things; A function annotated by "notrace" simply
will not have the ftrace hook to that function, but that function may
very well have tracing triggered inside of it.

Functions with "_notrace" in its name (like preempt_disable_notrace())
should not have any tracing instrumentation (as Mathieu stated)
inside of it, so that it can be used in the tracing infrastructure.

raise_softirq_irqoff() has a tracepoint inside of it. If we have the
tracing infrastructure call that, and we happen to enable that
tracepoint, we will have:

  raise_softirq_irqoff()
     trace_softirq_raise()
       [..]
         raise_softirq_irqoff()
            trace_softirq_raise()
               [..]
                 Ad infinitum!

I'm not sure if that's what is being proposed or not, but I just wanted
to make sure everyone is aware of the above.

-- Steve
-

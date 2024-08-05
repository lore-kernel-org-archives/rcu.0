Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F3F1474D7;
	Mon,  5 Aug 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848493; cv=none; b=tkJBoxUSC+aFHvYFoY4QthXzy260Uevgfw9aybfn1rYBOM6gROfhljNbcpl2a526quvWB7z1Y4Rgr+2e4vtomTzdV8IMBwknWfm3lkmhdXJO4tF0rglgtiBNBzz0Ha0W/cHzJvZOXwmLAx3py7RDuL3yfcRc1R8eR7AuCfYEltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848493; c=relaxed/simple;
	bh=Q8cRiGdW/G37KQUA7mUq7lbhNpPWJj4xD/Ko0fT93TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnz+8lLKH6Gj3L9TxpnPaBYhf6TpQtRNJqIHmxcjTzAWhSWnbPYVABhilAnWMcAad7iVQFnEUuEK9TUTAKHvtqVmk/Il1nLDj9gAV8XeVjJI9hWborU1mHRj8GvdN2c6OM7nOcwY3V3+vbJiGLYYElfazXgMfGkRwmK57TeR6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pofpxnz2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pofpxnz2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kP2eEK55ZvFw4950+W9tiFY6USmBFEODBUznCrkG1Po=; b=pofpxnz2SF5o8WrgCS2bpYec/E
	/AqemK00vx1zl6vjLV/y1jcndpIdTzP/Pq/81XQOfDpvPYkNJfLe3v8NEhZb8n3xrh68cr3gpQN/O
	FtrLk2GniZOAecF8ZyuxS9uDWk8c2J55anT9zWSk6vXW7FNvL6e0CQpdVR8LwGwkmIqbdFP7eziSl
	gbHDxV6T1dGKztL0Isqf3ZsoqWVPOhDVFamsMkB0xmvn5A84c+AtUEkCNAUjhw+hGyb8SnQXxwTci
	4gGSsvrnpYdecdlHkeyOhVka2BqhG7VLP55B3yutdEJpGgENmvma1h+Tzs/1H3cl5+Cs7y4OJ0TLf
	r9J2mJbg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1satal-000000044mb-3vMu;
	Mon, 05 Aug 2024 09:01:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9317430049D; Mon,  5 Aug 2024 11:01:22 +0200 (CEST)
Date: Mon, 5 Aug 2024 11:01:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: RCU-Task[-Trace] VS EQS (was Re: [PATCH v3 13/25]
 context_tracking, rcu: Rename rcu_dynticks_task*() into rcu_task*())
Message-ID: <20240805090122.GH37996@noisy.programming.kicks-ass.net>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-14-vschneid@redhat.com>
 <ZqJiDlKtD4wvsv1j@localhost.localdomain>
 <31d78183-4526-41e8-90df-d03c95fdb9b2@paulmck-laptop>
 <ZqlmjVyWXIneklCm@pavilion.home>
 <30c6d4aa-7598-4dc1-8592-7533d64714c2@paulmck-laptop>
 <Zqot4NpepOORtNzv@localhost.localdomain>
 <6c915a8d-983a-4cbb-8d89-01e326a16876@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c915a8d-983a-4cbb-8d89-01e326a16876@paulmck-laptop>

On Fri, Aug 02, 2024 at 09:32:08PM -0700, Paul E. McKenney wrote:

> Huh.  One reason for the current smp_call_function_single() in
> cpuhp_report_idle_dead() was some ARM32 CPUs that shut down caching on
> their way out.  this made it impossible to use shared-variable-based
> CPU-dead notification.  I wonder if Arnd's deprecation schedule
> for ARM32-based platforms will allow us to go back to shared-memory
> notification, which might make this sort of thing easier.

All those idle paths should be doing ct_cpuidle_enter(), which includes
telling RCU the CPU is going idle, no?

I cleaned all that up a while back.

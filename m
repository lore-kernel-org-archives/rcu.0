Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F0F9FE;
	Sat,  5 Oct 2024 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728127160; cv=none; b=bjdaXz1sX+7IyVW5fXfCpGpN/51ZsWJA99g5XoW0HUE5cYQ+mlKAScsnSsiqSW6p932XHrU3wFYeaRzwATZzhZqR4Ens9dOZIQvafbSubWYHJ4sbXLiah12gOHeLHmRCx6A6HndxO7k/9dfLSWlaGJUPtDpb9bxFmD0ZVIDIE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728127160; c=relaxed/simple;
	bh=aX4KouelstMm4b///IUMcecatsDTjQFBqamgA+2W4BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgyEZ7lFnoDo0cCiZXTu0kCtraI4jvNvc/uxwG7ixGzUjzcVLqbblqb0b1KaaGIwmgSYTlbDGK1xBoFhN/mj0b5oCk60JMiR5R3m7alpC7unnkKU0Bve6WhdYog7Vh9DznFdmjxh3iXY5qiS3OOxbNakEDEju2A1vyiHCK42BmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDSveQsn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDSveQsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A72C4CEC2;
	Sat,  5 Oct 2024 11:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728127159;
	bh=aX4KouelstMm4b///IUMcecatsDTjQFBqamgA+2W4BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDSveQsnrY+jiyQrTiVjtyuirfXUCqn0eoNjaHl3SE8F7wzup99P2J6eDx9uldHpH
	 yVeBnjKAzP8rZf/Ma4q3yhKS3+I1HDE6tuUOvj5B2zn4drHlCyEE+tMFy7CIqW8Hph
	 agVB9DRDpbvKwhJ/dv2pHwrDtfEm6Njl0tWpi7NXzzHc8GWzpGOCkgDgscEWsEUzeE
	 BsIAZF6CfAtteUp1SxdCrsQhRTopwXkEZOWxrgTaTGkX7C7/DQzUoaim1fgJmP6FFL
	 2zIC67jn0NZC49ZnXPZgDxoGj2RBoPHZem9lwHyEAqjqtQZlQ9xPzwzSHFnvMZWSZA
	 GIZxQArAHwY1w==
Date: Sat, 5 Oct 2024 13:19:17 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH v2 3/4] hp: Implement Hazard Pointers
Message-ID: <ZwEgtU8MFPfGmEfA@pavilion.home>
References: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com>
 <20241004182734.1761555-4-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004182734.1761555-4-mathieu.desnoyers@efficios.com>

Le Fri, Oct 04, 2024 at 02:27:33PM -0400, Mathieu Desnoyers a écrit :
> +void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
> +	     void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr))
> +{
> +	int cpu;
> +
> +	/*
> +	 * Store A precedes hp_scan(): it unpublishes addr (sets it to
> +	 * NULL or to a different value), and thus hides it from hazard
> +	 * pointer readers.
> +	 */
> +
> +	if (!addr)
> +		return;
> +	/* Memory ordering: Store A before Load B. */
> +	smp_mb();
> +	/* Scan all CPUs slots. */
> +	for_each_possible_cpu(cpu) {
> +		struct hp_slot *slot = per_cpu_ptr(percpu_slots, cpu);
> +
> +		if (retire_cb && smp_load_acquire(&slot->addr) == addr)	/* Load B */
> +			retire_cb(cpu, slot, addr);
> +		/* Busy-wait if node is found. */
> +		while ((smp_load_acquire(&slot->addr)) == addr)	/* Load B */
> +			cpu_relax();

You agree that having a single possible per-cpu pointer per context and a busy
waiting update side pointer release can't be a general purpose hazard pointer
implementation, right? :-)

Thanks.

> +	}
> +}
> -- 
> 2.39.2
> 

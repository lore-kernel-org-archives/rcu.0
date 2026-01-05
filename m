Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D2230DEB2;
	Mon,  5 Jan 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628762; cv=none; b=ALD4D5jlx2g/n4vdO0uQVWaEqM3+aBJ21jQ9T6ijc7zvcERzZ5ZPYgqzyiVIMzwgjI2mk2xkIh7pWPoc/o5cJ3c5AqQTOpYySM/8HQJnnVppNKoBhNURRtRlCWi0JP5Hb+ujkvO99EyD/6OTQwztnRTV2sSA/CHOHsdY+ZCLqwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628762; c=relaxed/simple;
	bh=pXFL4t0RGtMPOBfsKIF3gef+42EspnJOjDSIdP9VCzo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCl5Gpzyr+gQpXevWENCa78jNA3yj3w6NUDcPgIK2JxF+l9j8BTrK7dzceb7tWF2YUVxs+j5o33jPt7YNeGfNbwqguo5dTySxfw8rd0g+L/ODgmo7vZCT5dTQ5xMXXiYwgAdFhG2uUPsBDy5fzoOcsVCfhHQNFpeefd0CJiQft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 4910E140177;
	Mon,  5 Jan 2026 15:59:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 9ECA33C;
	Mon,  5 Jan 2026 15:59:09 +0000 (UTC)
Date: Mon, 5 Jan 2026 10:59:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Uladzislau Rezki <urezki@gmail.com>,
 joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 04/14] rcu: Promote blocked tasks from per-CPU to
 rnp lists
Message-ID: <20260105105931.141eb6f0@gandalf.local.home>
In-Reply-To: <20260103002343.6599-5-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
	<20260103002343.6599-5-joelagnelf@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: r4b9fmtu1qb365bwhr5zgo7yhhpdw6yg
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 9ECA33C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/G4GO2Xjuc7QxU4HflpZpxbbLIHFKqwL8=
X-HE-Tag: 1767628749-82921
X-HE-Meta: U2FsdGVkX19PEdqqCJ03quJtIe9ghdV5el7//SR/wpcJi3BYpsUGcoSC6KwNlRiz46dsUiU0rBaeiRW1yLzRCn4D9lav+VuqVhqBN7oHRDgCXmicLiZogozbAe8KhllN/Z4S11wtClG7D3ztVNTdXsj0YhPOmplQ8/qHKnVTawhi8yVc+dwuAEEIJr03zQGedffPu5pi03svciOVkJMZlawLWmWlN7S/fx4AsjSpEsIiMGwX1ERgVDgMn2+czB0DEdQJMdpwMNgq7AdPiDM/jmzNUvk1KzuZPfrC4sHyABdEvtnt7uIpTZ/9UqLBuwpv05fplaGm6JwoTFjow5Lpmkjq7SDO61It

On Fri,  2 Jan 2026 19:23:33 -0500
Joel Fernandes <joelagnelf@nvidia.com> wrote:

> +#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
> +/*
> + * Promote blocked tasks from a single CPU's per-CPU list to the rnp list.
> + *
> + * If there are no tracked blockers (gp_tasks NULL) and this CPU
> + * is still blocking the corresponding GP (bit set in qsmask), set
> + * the pointer to ensure the GP machinery knows about the blocking task.
> + * This handles late promotion during QS reporting, where tasks may have
> + * blocked after rcu_gp_init() or sync_exp_reset_tree() ran their scans.
> + */
> +static void rcu_promote_blocked_tasks_rdp(struct rcu_data *rdp,
> +					  struct rcu_node *rnp)
> +{
> +	struct task_struct *t, *tmp;
> +
> +	raw_lockdep_assert_held_rcu_node(rnp);
> +
> +	raw_spin_lock(&rdp->blkd_lock);
> +	list_for_each_entry_safe(t, tmp, &rdp->blkd_list, rcu_rdp_entry) {

How big can this list be? This would be considered an unbounded latency for
PREEMPT_RT. If this is needed, then we need to disable this when PREEMPT_RT
is enabled.

-- Steve


> +		/*
> +		 * Skip tasks already on rnp list. A non-NULL
> +		 * rcu_blocked_node indicates the task was already
> +		 * promoted or added directly during blocking.
> +		 * TODO: Should be WARN_ON_ONCE() after the last patch?
> +		 */

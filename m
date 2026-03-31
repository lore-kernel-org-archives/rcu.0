Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB233CF034;
	Tue, 31 Mar 2026 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949509; cv=none; b=Ea+Hk7/Jt80C6+Dd+naeirbsKBGAt0Omf2zpPKmuyZ98TOyy5J1dCzxn5CwdHnIrcsrloNd2pLYxMj+q76P757xlhF68zHCvpVd6140FVB/mi7t0GBoW2/pXMKeUiv21To0aIz/VQ9BqHoZXPGF5GetaZ0KCS3psg3Nv/78zgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949509; c=relaxed/simple;
	bh=xEbwMXX5FwDKtE4Hwy0RcLBu0twcGDuQxIoulpWwrMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz5tVKfGXA3nDADKeIH+mDsALo9ICZAo3pErjD20yFGdv12gpbJCPKR7JjP7bSlLj0B8oO2jQHIXBJ+ADEebCaSyTYcWcY6l4salf0DP2zvPGuebseuf+IZV9fdETZlt9NQdo9GodxnbqnpaT05N5Jd1QSaZzv3gjGP8efatSKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLNqIU+H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLNqIU+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D8BC19423;
	Tue, 31 Mar 2026 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774949508;
	bh=xEbwMXX5FwDKtE4Hwy0RcLBu0twcGDuQxIoulpWwrMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLNqIU+HPX8HQGGsvhZ7yjZ3n5e7cXBnyU5LZXR45P/nOrHty29WbPCPqBGHGvOj4
	 31sHfS+yn+fQ0AkoIPif4J7sSmfXJCSovvEUhbkINEOe09L2zp8dx5xU3NPM+Iv8o9
	 e2mCohSVbds6ALcAGxRx7WZ8wpzpJ8M1JPk13QIEEqVIdf7aZq32lgtLd6wcLW7Q+X
	 R8MjFeZYpeGKhsMEt/r0HFSys4a/bVDdVJ2/SANVKbw8rbPt6hQ+468+gJzUWTEyza
	 3QuL3tsJ887pp5C40kONZ+bEPzKYbDf4KvzI8JSTFC53TUdwFBiCBAjAponfTiddVf
	 S9n8DUw1RK4sw==
Date: Tue, 31 Mar 2026 11:31:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/15] sched/isolation: Support dynamic allocation for
 housekeeping masks
Message-ID: <acuUgmG-Makv9mp6@pavilion.home>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
 <20260325-dhei-v12-final-v1-1-919cca23cadf@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325-dhei-v12-final-v1-1-919cca23cadf@gmail.com>

Hi,

Le Wed, Mar 25, 2026 at 05:09:32PM +0800, Qiliang Yuan a écrit :
> The existing housekeeping infrastructure uses a single static cpumask
> for all isolation types. This prevents independent runtime
> reconfiguration of different services (like RCU vs. timers).
> 
> Introduce dynamic allocation for housekeeping masks to support DHEI.
> 
> This allows subsequent patches to manage service-specific masks
> independently at runtime.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>

Have a look at housekeeping_update(), it should provide the basis
for what you want. But I think Waiman is already working on making
nohz_full dynamically configurable.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178B257843;
	Wed, 25 Mar 2026 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447116; cv=none; b=NkXqb1xBMMqVlWEvR4jgvEGLWfGeY2WmIfS4ilOKljB+vu8KZMGaysx1bXD8M0xPRTjjJDKwnBzQ/00xBbb42MoDYZQPakOPVRaTMXa69Dh49ekBzJ4ZFugTt0HT3fEAW3Vf/mkKedfreR/NTkEDB1V8Rk4IgWxpRl6arT47+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447116; c=relaxed/simple;
	bh=0Wh5nuRIVjmmR3h1DHbl/7y/dEHsy8Ic5tYZGLWZU9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWLhOLlprCUZ+921QthWwYvgalYfS7Gv64PWG4Lae/TgJQNccPBGiq73pp+k7h7wShew7av/vdCQLfeM+NJnzL8hE4wfRu3UtB8IzsnjpcYFWMNMosAWP9xUj5Wfm1uE81YgNOxuhvZ4c82bVD9TkIuY4PCUidcQNJrtjReM0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JR3OsthR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JR3OsthR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0Wh5nuRIVjmmR3h1DHbl/7y/dEHsy8Ic5tYZGLWZU9U=; b=JR3OsthRB0FWUAQKcRzH6GOUYD
	G0lJgZ6r49/3yIaaPiy0bfMepMP+55l5tq1iETprIi/AociiRYj0JfsoypiQx3Tg26VUcFGELYHHS
	ILSSQoxQaRwl9QkCPKJrSYPQp2ttw+Q+8kEyum2trVSUYWs5Pfu84pm4VP5Ab/EpNNEn+ikvsgomU
	CH/xmi7rSzUQyoaKTRDsIE7gYzYiu7XcOtLY1oAVwLv6fQO4vMmsOBNNQXyhPlKHMsx3rcyM74MWM
	7T3s03vGBYY1zVxVPvSjn9SpMc4jFxqbYa1g2+Klc7hHBqXO1uUB7CoeXfOUSrCx6cJ2wfHMk7S1j
	v8BKDhIQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5OkY-00000006Hv5-1bO9;
	Wed, 25 Mar 2026 13:58:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D1C15300400; Wed, 25 Mar 2026 14:58:21 +0100 (CET)
Date: Wed, 25 Mar 2026 14:58:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
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
Subject: Re: [PATCH 02/15] sched/isolation: Introduce housekeeping notifier
 infrastructure
Message-ID: <20260325135821.GA3738786@noisy.programming.kicks-ass.net>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
 <20260325-dhei-v12-final-v1-2-919cca23cadf@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-dhei-v12-final-v1-2-919cca23cadf@gmail.com>

On Wed, Mar 25, 2026 at 05:09:33PM +0800, Qiliang Yuan wrote:
> Subsystems currently rely on static housekeeping masks determined at
> boot. Supporting runtime reconfiguration (DHEI) requires a mechanism
> to broadcast mask changes to affected kernel components.

Can we eradicate the whole DHEI naming please? It makes no sense.

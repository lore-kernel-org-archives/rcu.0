Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA17A3822B5;
	Tue, 31 Mar 2026 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949973; cv=none; b=U9xCY+01FFjuwLqijaJD5uh/Zt2KSdSo1QCDLGyxyw7jF9PUtWPhYKMnRGFsBQui2vSwZ1autQTEStT8WTLbFeZT/9pN32UT6RCidN+8MK9eoHaY0HoOGRiNNK0ZJGJUF5VY363Iu5d6gI10rLuhJsXX09JnALC/b2XatrwXOXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949973; c=relaxed/simple;
	bh=BLhBqZ3dvy+/k+BE7sIj/+ih1uPmppiKzXtrrL8OQ7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKH+dNTfuHhEQoqMNiH/igpp74W0CLFjJZ5iTZCU2k7/tey32KlCEhRWo8CdvcHi+GKO8Fp4rLqw3vzlLNMC6RUxnMLJA9y7OBFGbIyGvmAy8budoEwdmKFmVfMeVD+xvU188qV6LVJhG1kzzSBvSPTYOvwkuU/6cAnn/MRBJgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBDGmWNN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBDGmWNN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7361C2BCB0;
	Tue, 31 Mar 2026 09:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774949973;
	bh=BLhBqZ3dvy+/k+BE7sIj/+ih1uPmppiKzXtrrL8OQ7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TBDGmWNNI0rjYGNQr3ld25h4CGuuCOPmh6/TFscaT5pT3nTJrNnALBiWYkkG9HhgX
	 Z8D+bRzXWuIiip6lEfhjIcY1UST5helZGtSt+gRnvJnCiYCgdGoqtsVTiJIhb66bcJ
	 dcu6f8xCOjaEcUE+pcU4ACxX4ZxdQbIaKsN5ziHCkNfv8OPcDHvgwv6dRgQifeNXbs
	 Z/ttuv3CfskP69Cr/+WfIcrbVJrbcNU8VV5329ditHYcS92mISwcO0Qqb2Lhgcs+rl
	 NvRGRTJK/3vcqZiXNghn1SR+KWSVodebBTL1Y4C6ZtXaKkaDgDsfpFoIaBqU/1oO3K
	 G126pJ2ggyx3Q==
Date: Tue, 31 Mar 2026 11:39:31 +0200
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
Subject: Re: [PATCH 08/15] workqueue: Support dynamic housekeeping mask
 updates
Message-ID: <acuWU9bMGGE4AMEz@pavilion.home>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
 <20260325-dhei-v12-final-v1-8-919cca23cadf@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325-dhei-v12-final-v1-8-919cca23cadf@gmail.com>

Le Wed, Mar 25, 2026 at 05:09:39PM +0800, Qiliang Yuan a écrit :
> Unbound workqueues use HK_TYPE_WQ and HK_TYPE_DOMAIN to determine
> their default CPU affinity. These boundaries are currently static and
> only enforced during early boot.
> 
> Implement a housekeeping notifier to update unbound workqueue affinity.
> 
> This enables unbound workqueue tasks to respect dynamic isolation
> boundaries at runtime.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>

This is already handled by HK_TYPE_DOMAIN with cgroup v2.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

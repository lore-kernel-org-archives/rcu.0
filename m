Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F08218845;
	Wed, 25 Mar 2026 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454572; cv=none; b=gwbZ5gSvFOs2aOKLwzZqRdYw1G9oldvsx4zB6klr2WMD8nSM0jHrkJfEEaOz4bQqOdaxFd+BEnMJJF60Yhf0UF0o2SwO7uXGda6ZKb4bDTSZgsTsM+x22XDCIIVW2t4Me33Lz6hyR3EvqDwVOUY6qdEUdGKNYFevK1h/vwVNA1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454572; c=relaxed/simple;
	bh=GITsNDMkclAIBjNKnyGg5xvX4405o6x9Qefz9+3Snn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5/EE2CqNAACVSRj3mKYblXxfd6zdA0RZO/l6Wv8Y+ZAsXyGWg5dd3bVGoKQB3nNcuAPaBaVM8285UXjUmyzGQOUto2kE8b2NY8qM2qukqiYPumF5Q/6EsstmPS7TOE8ZZi0E3rvT8If1y6/8Z73LlE9LKbsr5w1eyuXwn8qNrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVFbM5u4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVFbM5u4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0988EC4CEF7;
	Wed, 25 Mar 2026 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774454572;
	bh=GITsNDMkclAIBjNKnyGg5xvX4405o6x9Qefz9+3Snn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVFbM5u4OPn3HWPHYzho/hMZVIujEIkAyumg4ZmiBJU0EhVMhrHCltUKyfhNnKJOI
	 ZSx0apo6vy9FR+LCxy6+rF0rhDdKj3ADfENvRcV0lo2jiAZuCKcXK7YU7zPlUUHqz+
	 5J5paHJWH18ceQt+JTFhiLeMKpVHDynyVjE6eM3htcixlLso2yzwaYG8ULhyIv1Fl4
	 o75FuDAHxjm7gxDciwhVAxthJH+7yRxbQsoVMsx8OVCDhnkezBr09vVM2zu3Zdi433
	 Lx3YielnCJXfE2/bPY0vbMeu9vz360kPaJkO1S0aIV8Y8/XdPhTZ2sN9Y4FkyxIA1J
	 NRO6w/7tUFc3g==
Date: Wed, 25 Mar 2026 06:02:51 -1000
From: Tejun Heo <tj@kernel.org>
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
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
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
Subject: Re: [PATCH 00/15] Implementation of Dynamic Housekeeping & Enhanced
 Isolation (DHEI)
Message-ID: <acQHKwGhYrpoOH1P@slm.duckdns.org>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>

On Wed, Mar 25, 2026 at 05:09:31PM +0800, Qiliang Yuan wrote:
> The Linux kernel provides mechanisms like 'isolcpus' and 'nohz_full' to
> reduce interference for latency-sensitive workloads. However, these are
> locked behind the "Reboot Wall" - they can only be configured via boot
> parameters and require a system restart for changes to take effect.
> 
> In modern cloud-native environments, CPU resources often need to be
> dynamically re-partitioned to accommodate container scaling without
> the performance penalty and downtime of a full system reboot. Similarly,
> high-frequency trading (HFT) platforms require the ability to fine-tune
> CPU isolation at runtime to minimize jitter for critical execution threads
> based on shifting market demands.
> 
> This patch series introduces Dynamic Housekeeping & Enhanced Isolation
> (DHEI). DHEI allows administrators to reconfigure the kernel's
> housekeeping boundaries at runtime via a new sysfs interface at
> /sys/kernel/housekeeping/.

I think I asked for this in the previous thread but please coordinate with
existing cpuset and isolation mechanisms. You aren't even cc'ing Waiman for
cpuset.

Thanks.

-- 
tejun

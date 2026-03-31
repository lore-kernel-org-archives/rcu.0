Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFF137AA9E;
	Tue, 31 Mar 2026 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949764; cv=none; b=o3lm7zc4egzl4WvELzmmhV49kqCW9Juqk0pbZVvFlIs6jSGQuFWblcVgOY97+lF1HzjiTqFuMCkQDs2Mf4IBrccx5XU9aquOdQi6C47bdb0VPjP6OUpZB7cdoaC4BMNPv3T2BWUVjqm1iqjdEL/dl+s/pc6VSWFZ8rNo+pqtEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949764; c=relaxed/simple;
	bh=unm0mN5O/5fTupUJP5/43mpmznDqUzGRVDsTFh0CMvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzFpdbQqb3YYteOUrKT4o2ymCxadTKoTKyaRhLtVm4HtmIKjzGCicD3AUP3mKo/m5gvU0CcZ4whRkz+cdHw2hTV+Un8gWC4lf4hmu858a4D+9R2GyXwFDcP+0wUNGE4qISOwgRqva7BAiZ1IEJiacnr2NkfVtqHhtHc+S67QHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqSufg7e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqSufg7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC742C19423;
	Tue, 31 Mar 2026 09:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774949764;
	bh=unm0mN5O/5fTupUJP5/43mpmznDqUzGRVDsTFh0CMvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqSufg7ecQ+Wg2DuC+R/UR+odxiwJs2VYV4DwERoT3W8EmYBR8cHR6TV9nHDR5e9G
	 DNWyNLpMyravuJGr8qGJLEkqqPWPDc8WRrUyHwvheRgvLWa4hru/o7xiaH2SxVtDps
	 dGN9D1i8lfx9blhA+g66BOqVMoEHHohm+nM0nbCtS3gFune9sYQzK+SW9x38xKcc7b
	 UFhDxkaNzAD1LwVq3ZS1NC7PMvMiJ0g60mTFEjqrJvsubEgFftMSvPWZ35E7Esdruh
	 7Io7X37tGiqX5l5+4flhDHiTwOchYDFE58LQhMws4ARzYSrE01fZ537tQlBt/Xklt+
	 FPD7dVClbx4sQ==
Date: Tue, 31 Mar 2026 11:36:01 +0200
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
Subject: Re: [PATCH 03/15] sched/isolation: Separate housekeeping types in
 enum hk_type
Message-ID: <acuVgY5AC-bMNsZu@pavilion.home>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
 <20260325-dhei-v12-final-v1-3-919cca23cadf@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325-dhei-v12-final-v1-3-919cca23cadf@gmail.com>

Le Wed, Mar 25, 2026 at 05:09:34PM +0800, Qiliang Yuan a écrit :
> Most kernel noise types (TICK, TIMER, RCU, etc.) are currently
> aliased to a single HK_TYPE_KERNEL_NOISE enum value. This prevents
> fine-grained runtime isolation control as all masks are forced to be
> identical.

For now we don't need finegrained runtime isolation. Only domain,
nohz_full and managed_irq. If the need arise, we can make it more
finegrained in the future.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

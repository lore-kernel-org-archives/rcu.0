Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8D3320F;
	Tue,  8 Oct 2024 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384881; cv=none; b=b8pJiFYFMoekK1fPca5zs3mJlIfuRgoma2zeJkMgLMMRWwLmvTbc8fCT6tohOPuBwbGTjnrwLeb3NdFlXf5aSmDcYiwGVXWUUmU62ebvoQLMMd/Baz/sg4hUdLB0Tnq74TrJ+aXBszmD2waCl7pnSDqQ65Z68FT1p4EsLEv0VV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384881; c=relaxed/simple;
	bh=tMLwLbqSfjHfOw4e2UN9i2C4GUC3GQ+xO7cRITf7Dtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOTJMHLl0NDXk8x1uff6z8X+2aCZ9YxbsQLyx7j39438f/SB4lvll5PBjyqx9A20wAL94CZNUqbWdA7s6uYDeipDqmGHapT3TsfhDe/Yd+Ywvd+Uzmd6EaPT6fX+PkZyl3lrK2iNOeiJ+0t6HcVYgIGSgoFl5l7xcV5vxvCHgIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovbgNVzJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovbgNVzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6557DC4CEC7;
	Tue,  8 Oct 2024 10:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728384881;
	bh=tMLwLbqSfjHfOw4e2UN9i2C4GUC3GQ+xO7cRITf7Dtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovbgNVzJkmgwqhNXgMxucWth9ib2ZNZ6+KFUe3Jx7Xyld3/TxQ48FYFAUUNLlICTc
	 yFadogOuiCYTIGm+UsXdxL1o2OtGyT/PB3X4e2K+e2iGN0Inm7DUo3hPCZ9yKyvMjk
	 UCkMz7kYkiJeWmDg6VSfATI0zNPqrmcBOYRHAKN3S5yDu7ILX+HO298ngo7uT0ZCwQ
	 ykVBmjDBpX7VH1/p2o4V5KCpjt2r5OzRGtHldp6WZalqFYpJdegy3OrkRlZcwuiqsm
	 InKMMt+8ap7bWGNYZqTqe4AZZ3GjcU50a3AgX/RH5wAK5LjGoMh8WO/cNCO/BzmEDI
	 Vq9L+nSAWj39Q==
Date: Tue, 8 Oct 2024 11:54:35 +0100
From: Will Deacon <will@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 11/20] sched: Handle CPU isolation on last resort
 fallback rq selection
Message-ID: <20241008105434.GA9243@willie-the-truck>
References: <20240926224910.11106-1-frederic@kernel.org>
 <20240926224910.11106-12-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926224910.11106-12-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Sep 27, 2024 at 12:48:59AM +0200, Frederic Weisbecker wrote:
> When a kthread or any other task has an affinity mask that is fully
> offline or unallowed, the scheduler reaffines the task to all possible
> CPUs as a last resort.
> 
> This default decision doesn't mix up very well with nohz_full CPUs that
> are part of the possible cpumask but don't want to be disturbed by
> unbound kthreads or even detached pinned user tasks.
> 
> Make the fallback affinity setting aware of nohz_full. This applies to
> all architectures supporting nohz_full except arm32. However this
> architecture that overrides the task possible mask is unlikely to be
> willing to integrate new development.

I'm not sure I understand this last sentence. The possible mask is
overridden for 32-bit tasks on an *arm64* kernel when running on an SoC
featuring some CPUs that can execute only 64-bit tasks. Who is unwilling
to integrate what?

Will

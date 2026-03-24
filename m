Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F2393DD1;
	Tue, 24 Mar 2026 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351648; cv=none; b=CJWA1obX4bYB5JAlSDUABSyw8JCTp1rLG8qOt6sYef6b6KeQfBrQAh4e8n5HXtBgLivH9hmyIkp0dVnMW2jy27Xb84MuJFZIy9RrRdIUqG8IQNLg7PZrTs9zWbef/3oTN0eYAjhNGRqnfxjlzWriFCWjdeiypM6Q+MY8BJKg5fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351648; c=relaxed/simple;
	bh=I8azb9YL+U6tmlmFYi8bALQhQcq5JRRjQA8cLgQ42Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei+ea/2+vZ9TfLkNMf412p86djLkgU3Es7z2BbFFTe5Zb2TMRlXdj4XokKzXGHRW5U1VkKmyrzoxeDOXyQko7rUa6JWqeVC45Ypw3GCvGvPXb0cNz3SW568MGdKenX03wwDxbUDXcu2z1gshnZcxq6IHescoWjxXYwLWGcryWRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSGfSh2Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSGfSh2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10346C19424;
	Tue, 24 Mar 2026 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774351648;
	bh=I8azb9YL+U6tmlmFYi8bALQhQcq5JRRjQA8cLgQ42Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oSGfSh2ZWungMvFGVdRptl/ZSREaBK1N9U5lCMO09JRFQ2w5gzK066O79PcCgeDSQ
	 a9mW4HdHVkzKsfTakF2C+h17tOV2+HdoOViw8W+QmIQSwyjaLdxrN/VdEdHVu8MWi8
	 6fRJJGHJD+rWq4P9h+YILIzYeuYPbXvyQKTstQjIJocfOQ8icaKC4hnRvpBK1lSVXC
	 ilNFNukWhnRPQ9zMusjS2bYxWVTELBdLb1oWsggftQMKdyTRq2WRSxAaw7FtCQgFZB
	 R9OpapDeOFzK0/NDZXr+6dQ1gdk9W8XHcFnfKGb4BQJvVfmqv9kDq3F2UZ8lnEhu58
	 ju6o/VyxUhiDw==
Date: Tue, 24 Mar 2026 12:27:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com,
	rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrea Righi <arighi@nvidia.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start
 process_srcu()
Message-ID: <acJ1HRXomQhbTN4_@localhost.localdomain>
References: <ab2yd35rm6OgZUmb@gpd4>
 <20260320222916.19987-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320222916.19987-1-boqun@kernel.org>

Le Fri, Mar 20, 2026 at 03:29:16PM -0700, Boqun Feng a écrit :
> Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> happen basically everywhere (including where a scheduler lock is held),
> call_srcu() now needs to avoid acquiring scheduler lock because
> otherwise it could cause deadlock [1]. Fix this by following what the
> previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> the work to start process_srcu().
> 
> [boqun: Apply Joel's feedback]
> [boqun: Apply Andrea's test feedback]
> 
> Reported-by: Andrea Righi <arighi@nvidia.com>
> Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> Tested-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Boqun Feng <boqun@kernel.org>

I have the feeling that this problem should be solved at the BPF
level. Tracepoints can fire at any time, in that sense they are like NMIs,
and NMIs shouldn't acquire locks, let alone call call_rcu_*()

BPF should arrange for delaying such operations to more appropriate contexts.

I understand this is a regression trigerred by an RCU change but to me it
rather reveals a hidden design issue rather than an API breakage.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

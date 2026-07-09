Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704CB3FCB22;
	Thu,  9 Jul 2026 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597679; cv=none; b=iw3JxWvGkXYQsMwmKuDZBjAOJcoPKQlVPJg6mjDDIk2MkNoCdCfPkla3ehIGlCaiW4lyCqTHBcAiiCq8/JaeBZnjQpydtkL65cTPL5H1YuMNty/HqGMHOpY7E7HgEreD8QQfyzciJRBdyZ4cc7dBETIbOzGeyalWrgmTdhg4s3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597679; c=relaxed/simple;
	bh=7b9ubX4eJpSrKckxC665q6Rcq1ny5va7YFqVt9ztfDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUeUTZvxGqXMDazJlThdk50Ft/kDz6cluQ5MJmF//Tnd5lXeVhrQmfilG686XB0xc7G9kHqzsRltxKg8jTYvG5VWDTHOUd8YPsalGh57YANfnxuyF7qjf42dBh0IVx6KdLXKZ0FFtXq29xI++8JRJrT7SLCaSh4OKSJD7fPKD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rz9Uguzh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rz9Uguzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916F81F000E9;
	Thu,  9 Jul 2026 11:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783597678;
	bh=//bPCs/Fj5nQIbCrq3GNhoz3E7nl1LpSHZDhsIuiOrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rz9UguzhaXzVeulfRp/+ijY6avpCTyPTgkEKIo9UqmYvowKzWhOs0DfH/iPJCngcR
	 RDZryP++n4jwwvXj8bAvQqVCa1+WJU008QxCJl02SA32oXnq+k2hyddmyFcqoG9WRK
	 tFQeJGB4ycanyxptPdOQd7NRsUDTj7kF7tU2ix9pyvBps2qGUh5ftYIxPX7SPIU9OF
	 cRQaOFCibXAFqX4HurO76rT8x8JiHDRV5g7HNFJPPrXZyUODKBF9phuqqt9tlPeAPO
	 wRXMNkFkf83lBDYnfJSRkEtXQBv7dHvJBz0emiOC+VgVLP7zyh02FeVjgLBRMrrD5b
	 aeawLGEnRbhAg==
Date: Thu, 9 Jul 2026 13:47:55 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v1 01/11] rcu: Rename struct rcu_gp_oldstate to rcu_gp_seq
Message-ID: <ak-Ka-jUGH77WNeO@localhost.localdomain>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624132356.516959-2-puranjay@kernel.org>

Le Wed, Jun 24, 2026 at 06:23:43AM -0700, Puranjay Mohan a écrit :
> The polled grace-period state structure rcu_gp_oldstate holds a snapshot
> of the normal (and, on SMP, expedited) grace-period sequence numbers.
> Upcoming changes store this structure in the callback segment list, where
> the "oldstate" name reads poorly: there it represents the grace period a
> segment is waiting on and is also compared against the current
> grace-period state.
> 
> Rename struct rcu_gp_oldstate to the more neutral struct rcu_gp_seq, and
> shorten its members rgos_norm and rgos_exp to norm and exp.  Local
> variables and parameters of this type are renamed from rgosp/rgos to
> gsp/gs accordingly.
> 
> While at it, provide a single definition of the structure in rcupdate.h
> rather than separate Tiny-RCU and Tree-RCU definitions, and give it the
> ->exp field unconditionally.  Tiny RCU does not track expedited grace
> periods and leaves ->exp unused, but a single definition that always has
> ->exp lets the shared callback code in rcu_segcblist.c reference it
> without CONFIG_SMP guards, including on !SMP builds.
> 
> No functional change.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

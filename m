Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38503CCFBD;
	Tue, 12 May 2026 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572145; cv=none; b=nqrHol62uwzvGVrsPJkK6RrPUQymEPq9ziwKrUTNV5NG4vJsKx90XA9jF3mV/0R7sZSsXBuJoDi04JEEJ28AxdrecMIG+kPRhi91i20zi4awg9GIwtkEgL9KOB0OS3WsvCn3Xb7hhRClsBMKkuxJ4Wpif2X1mrr0I1aj9N062TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572145; c=relaxed/simple;
	bh=L9Je9p6iKz0LhJs2B2OBOVnKx7GVs/d3t4vLkYEhSok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fG2ydDhaGtCvI/FMOYmm1fGQM5xleHWHCre16uke3+dVmgmg8j4PcIHYSfapi+QmYkVBpjIoPBWIUaGqak2ceeC1Seho197K0BePEdCK52FKyng8JQC5RvYLQJu7GC0cG6x+f19yvYtloaYtxaJ8ZdUXTeEiX1fBa1GJx4Q7K8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=e76ZAj6c; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="e76ZAj6c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L9Je9p6iKz0LhJs2B2OBOVnKx7GVs/d3t4vLkYEhSok=; b=e76ZAj6cq9wK8LolMqLtOiipXB
	N0kHt9swwcOBhSpr0VVJrOWwxxqVm7oztBxdbf5Dyl2AFH547HkdGDAGZCPc3J30LVvCj08AZ7QBs
	KlqhGZwml1BBrGa/JaEsnm0D0MVsH+wh7W+kiW8E+O1mUQ1W1wwj40xAvCRQJTbQBF3QLKXxrpgym
	Mj3VB02DVvDanDw11w9pDBKvlqTCdeNlZ6T8KBTyrQST1YypIKh6zJA3g9DKZOsQMEUkSml0D7g/v
	0QKsdOFS3rwVMNXRnL3auGlrkBeSRarMwPSAb1CsgHW8eVZ12SYOIpo93dOFdDVrKGbjGuI6sJZ/i
	S0N3VYIg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMhrD-002E10-01;
	Tue, 12 May 2026 07:48:47 +0000
Date: Tue, 12 May 2026 00:48:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/2] rcu: Add debugfs interface for pending callback
 monitoring
Message-ID: <agLaaBslalzcWhhH@gmail.com>
References: <20260507-rcu-pending-cbs-stats-v1-0-8f4eb3553bc9@gmail.com>
 <fd8b4470-930b-4688-b423-2e349f8c883f@nvidia.com>
 <CAGSyskW6T4cbX53gSRZSGeiTct9zHLBo9vsE9OH3Yw_sB1Frfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGSyskW6T4cbX53gSRZSGeiTct9zHLBo9vsE9OH3Yw_sB1Frfg@mail.gmail.com>
X-Debian-User: leitao

On Mon, May 11, 2026 at 06:08:53PM +0100, Gustavo Luiz Duarte wrote:
> > You actually don't need debugfs for this. You can just use bpftrace and
> > instrument trace_rcu_ (with other RCU tracing Kconfig options enabled?). I had
> > something like that working sometime ago.
>
> My initial attempt to do this using tracepoints was probing
> trace_rcu_segcb_stats, but this would add significant overhead to
> every callback enqueue/dequeue event which is too expensive for a
> production environment

An additional benefit of this debugfs-based approach is that it eliminates
the dependency on bpftrace and custom scripts. While instrumenting tracepoints
with bpftrace is certainly feasible for a limited number of servers, deploying
it fleet-wide becomes problematic. It requires distributing and maintaining
additional binaries on every host, just to collect metrics that a few lines
of kernel code can expose more efficiently.

So while bpftrace can technically accomplish this, it may not be the
most appropriate solution for this particular use case.

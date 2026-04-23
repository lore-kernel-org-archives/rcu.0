Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A383BB9E3
	for <rcu@vger.kernel.org>; Thu, 23 Apr 2026 02:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776910486; cv=none; b=qNzuPSb8db6gysGjXmVMmrJuPtGgNyiGQZaReBM87UjZm1ooVNhcHyErwAPh1jrpGcUTraSsacBmrX8bQ64jZAq1Er1k5gun77QuiX79lGvSPEBhZmfhRvX8odJ09ugm1Fh+A3ru7SiZnuHfENXPLWJHDxg39X7qa45UD25NgaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776910486; c=relaxed/simple;
	bh=w+jgw7+Kepc9dYFzbTYrY6IcLLSgaQuTLOr35M233RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV2kYLs4w4EYlZirtTPzBxxlVjBJhaMdP6KnsXtcSijisQpumoGk5MVh1UDey4DeBJ36lseP2Wc5EOwWNtyHdwQDS4frlTY4HwCB10IjkDtUK3UlraoDgPGFXyBiwstB+9Ft3q7f2xVAljp5trsqj91xNC5QkIq75ZVMTDSIH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtohxZ96; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtohxZ96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E883EC2BCB4;
	Thu, 23 Apr 2026 02:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776910486;
	bh=w+jgw7+Kepc9dYFzbTYrY6IcLLSgaQuTLOr35M233RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtohxZ96b5cBJNzVWuN1KlMFfV8bzUz4S2Z3cc4VHRO92xjBes5Xd9TvclMKCyXqs
	 dACx334Bw1ZWDNoum4nQ6hCYEZtweXJOY6D/PPo6OO7s1eWDqYT+Gs8Pgc6bCijmX4
	 FHe7gBmrsiEcSoIkSkznshwyNLJ5F7WTwwBaW/5enxNvLFg+AHMNfagUcbbxdmIxlO
	 pAx5fAe3kRB1TJY6fLr9ZJwhkV+4DgZt6lJZkDNYNF1al6OtPMkB9sOxoW+t9jQ66g
	 xWhe90YqtmqZegKSnVh5ynbUEkgz6fiQvq/OZx3eiZDbOyrJdXbHbT7bE3zhhcN1In
	 6O397lYNVvYZA==
Date: Thu, 23 Apr 2026 11:14:44 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/slab: introduce kfree_rcu_nolock()
Message-ID: <aemAlO9rhFaDPmKH@hyeyoo>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org>
 <aejeVK0J_jHSfVhD@milan>
 <aelxH--hZkCahPv6@hyeyoo>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aelxH--hZkCahPv6@hyeyoo>

On Thu, Apr 23, 2026 at 10:08:49AM +0900, Harry Yoo (Oracle) wrote:
> On Wed, Apr 22, 2026 at 04:42:28PM +0200, Uladzislau Rezki wrote:
> > On Thu, Apr 16, 2026 at 06:10:18PM +0900, Harry Yoo (Oracle) wrote:
> > I think a better option is to add a separate kvfree_rcu_nmi() helper,
> > or similar, and avoid complicating the generic implementation. Otherwise,
> > the common path risks becoming harder to maintain.
> 
> It's unfortunate that I didn't provide performance data to justify
> adding complexity. I can try, but apparently you're not talking
> about that.
> 
> Rather, you seem to be arguing that you're against this pattern
> no matter what the benefits are?
> 
> I'm confused.

I was indeed confused, but before writing this, I should have thought
that you might be considering a simple but still efficient solution.

Apologies, my reply may have sounded a bit offensive.

-- 
Cheers,
Harry / Hyeonggon

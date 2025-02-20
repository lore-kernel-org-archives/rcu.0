Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954C2F852
	for <rcu@vger.kernel.org>; Thu, 20 Feb 2025 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740011544; cv=none; b=P+OsJB9fVQahRsw0Ph5Gu7Q+pebIhX+ZD03jbjdotHrAiMHox2CNqdrbc+h7ucdRltBaKjjM3YmsIJNifvi96bEXZguWeFTaI0UBOE32L4+wl/tF81Tixgm0uop7ts/z9sOgK4/k1/tl7YKlD/H1PtJaMX65NcF7YsN6yt4nQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740011544; c=relaxed/simple;
	bh=QOeqh91z5zLZAyRZWMv7By4/V2v2xtm3slmWLndTwIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXG72TCNaRjr8dIvV1GfcVZEuHMBN3I+KYE68IqHW3E9TqL8OQ7YBnDyxz7Mw6WUaPXPfWMqwN4VByZNE17T61TJMCj0rhJJVNsGeNZ3VEAkYYrW1KMyr/aUN/EBMJwWxqI0er+ApLg2U3dFK0BJKzdvxyk7rWhFFaTndVjB7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WKZ0oKBJ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WKZ0oKBJ"
Date: Wed, 19 Feb 2025 19:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740011540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zsS9Q4nUAeiYswHx612hH9JLLqbPF56ptABqnRioV+o=;
	b=WKZ0oKBJzq9d3LpJkPzOBNptXICN3Yx+U3b7Sx8U+t2T86SQPkxIvtCePUHmHQ3nTxTQP1
	zD31Vnage2t26k1oyc891MgV/n5sfdSsL6FM2HFpTZYeCbYzNlPRzPd1MDezs3lwOi4pq1
	H76+hvOlvx2OXLAh96pkBDqh7VNn0Q8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, rcu@vger.kernel.org
Subject: Re: [PATCH v2 -rcu] srcu: Use rcu_seq_done_exact() for polling API
Message-ID: <emn7ljwqan26qlafww3gzolh3ydxgl5obbpzkoa2tlj6bjazlk@jw2ilnkbawog>
References: <20250219124309.463702-1-joelagnelf@nvidia.com>
 <dde0f073-c3d9-44c9-bd85-cf0e8a0fd628@paulmck-laptop>
 <52320693-3247-454f-931f-d9e23592862a@nvidia.com>
 <dyzwqkaldmoi7qircj6plzp6wnghvkmrxjbaf4ejvv7xy6t4p2@ea7mpkosxju2>
 <a7d1297d-afea-4253-9139-8c44e953fd43@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7d1297d-afea-4253-9139-8c44e953fd43@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 19, 2025 at 06:45:07PM -0500, Joel Fernandes wrote:
> 
> 
> On 2/19/2025 4:07 PM, Kent Overstreet wrote:
> > On Wed, Feb 19, 2025 at 08:29:47AM -0500, Joel Fernandes wrote:
> >>
> >>
> >> On 2/19/2025 8:22 AM, Paul E. McKenney wrote:
> >>> On Wed, Feb 19, 2025 at 07:43:08AM -0500, Joel Fernandes wrote:
> >>>> poll_state_synchronize_srcu() uses rcu_seq_done() unlike
> >>>> poll_state_synchronize_rcu() which uses rcu_seq_done_exact().
> >>>>
> >>>> The  rcu_seq_done_exact() makes more sense for polling API, as with
> >>>> this API, there is a higher chance that there is a significant delay
> >>>> between the get_state..() and poll_state..() calls since a cookie
> >>>> can be stored and reused at a later time. During such a delay, if
> >>>> the gp_seq counter progresses more than ULONG_MAX/2 distance, then
> >>>> poll_state..() may return false for a long time unwantedly.
> >>>>
> >>>> Fix by using the more accurate rcu_seq_done_exact() API which is
> >>>> exactly what straight RCU's polling does.
> >>>>
> >>>> It may make sense, as future work, to add debug code here as well, where
> >>>> we compare a physical timestamp between get_state..() and poll_state()
> >>>> calls and yell if significant time has past but the grace period has
> >>>> still not progressed.
> >>>>
> >>>> Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> >>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> >>>
> >>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> >>>
> >>> But we should also run this by Kent Overstreet, given that bcachefs
> >>> uses this.  Should be OK, given that bcachefs uses this API in the same
> >>> way that it does poll_state_synchronize_rcu(), but still...
> >>
> >> Thanks Paul!  Adding Kent Overstreet to the email to raise any objections.
> > 
> > It sounds like rcu_done_exact() is indeed what we want - bcachefs uses
> > this for determining when objects may be reclaimed (as is typical with
> > rcu), so we don't want objects to be stranded a "significant time past
> > the grace period".
> 
> Thanks for confirming. May I add your Reviewed-by tag as well?

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>

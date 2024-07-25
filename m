Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205717557C;
	Thu, 25 Jul 2024 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911164; cv=none; b=tbvrdAwcyGpH5n8G3fNkdMRF3xL0N7jfR6dxRxt5z4/wF/YOfSds5X7mOBSHeeLAs3JhrXUnx7XL8gySrgi2ebV57cP58ZHgFqBthX1JBRbVsGT9U9+7A/29nWefg/96rG+CWcXhDiD6gfmKTvId2fet22gfAAVYtHBPyTVGX7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911164; c=relaxed/simple;
	bh=JQLCRaTjuF1Y5Tee5FwgNd12L/3NrtzgTxeyESICL+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTIAEEUJfv+cH6FEAjiWRBKsu4ErT8LNiM2z+8GDrS+W+Yizfng+eqgPkfdutdM5FnUI0eBySpuc8FAudA+FOz185n4rSoi2Y6w4AydAKPrOn7sAJe6GZBBEsdL/typXxsiWavg09A86tePAmlXLf5PuJUimmjaRk1cL5XOKyO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUjblg9q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUjblg9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A65C116B1;
	Thu, 25 Jul 2024 12:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721911164;
	bh=JQLCRaTjuF1Y5Tee5FwgNd12L/3NrtzgTxeyESICL+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUjblg9qtifz3rTtAbR1AfQIDUjhB7OUPlQHc4qTd+fig/e5jBsMGL5Rupt104gce
	 15vIu8u22Uq5tzTSWWscvq4VwJvoQMVRQ1FmCHSYAmPL6c2Q4RrXj41cdCFZy0eDsI
	 prIrGLQ3rwmapFrt9JG9bg5qb2bvkto/LHgummU78PgEwLoLjltdUuSxagknA+AdT0
	 YqWPAAit30NMKGf6NpkCvuB8695bI39mk0MwMzxKq5VuwbYu4Grt+J7mqa77EDU1VK
	 ainJ5xjg/zkwZH1JOLs+4QqfIFCHY73ZX0+iZBrmFBE/YX+pMZvNZ2ME8svORy9dL6
	 8MEWuPV95H3kw==
Date: Thu, 25 Jul 2024 14:39:21 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 25/25] context_tracking, rcu: Rename rcu_dyntick trace
 event into rcu_watching
Message-ID: <ZqJHeTE52cn1-4p4@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-26-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724144325.3307148-26-vschneid@redhat.com>

Le Wed, Jul 24, 2024 at 04:43:25PM +0200, Valentin Schneider a écrit :
> The "rcu_dyntick" naming convention has been turned into "rcu_watching" for
> all helpers now, align the trace event to that.
> 
> To add to the confusion, the strings passed to the trace event are now
> reversed: when RCU "starts" the dyntick / EQS state, it "stops" watching.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  include/trace/events/rcu.h | 16 ++++++++--------
>  kernel/context_tracking.c  | 10 +++++-----
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 4066b6d51e46a..e51ef658437f0 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -466,40 +466,40 @@ TRACE_EVENT(rcu_stall_warning,
>  /*
>   * Tracepoint for dyntick-idle entry/exit events.  These take 2 strings
>   * as argument:
> - * polarity: "Start", "End", "StillNonIdle" for entering, exiting or still not
> + * polarity: "Start", "End", "StillWatching" for entering, exiting or still not
>   *            being in dyntick-idle mode.
>   * context: "USER" or "IDLE" or "IRQ".

So that should be:

 * polarity: "Start", "End", "StillWatching" for exiting, entering or still not
             being in EQS mode.

Right?

Other than that:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

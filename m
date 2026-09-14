Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C625393E;
	Mon, 14 Sep 2026 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397692; cv=none; b=cwKjvfvRA/4s+SYVtvF8ezPD5xTxIIIzq9FoEvnycStc2qNKMm66/atvGKD7SRM+lAXHiXuoN02IGxWnV8ZEfDOU0GMK3zXWfqM6RjGbKkNWdkzNntmqjqzARvENX8FCmo9A6Kk9euCDCYchAgmY3khNYE4huObhheo0hDMQXSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397692; c=relaxed/simple;
	bh=5OQkUBHuNHD3N9BtVn6PA+sGb2DzSvh2zQx5xM/cDcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7vwLRn2ESCONqzxu6tuEw6Oa7pQIHeQ3kndrGOT8bPzf6T39vrTvnGIW1cnv7BfnDffEMZDe+opj7TrALbHgYda3PcAvdCQ9e7KYNcGNBlmjCxfwbNwQYrb9xZD9XX+0L4ijhw3XJooNuMxG0Sl8GsU70kngXkq7QBBZnnhqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLFDDq8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLFDDq8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C44E1F000FF;
	Mon, 14 Sep 2026 14:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397690;
	bh=LQ5u3XjbXGUOat0OEXM2JEEtjlYIog0XalGjmRtDp90=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=YLFDDq8pzq0E8qOhLD+73lyHt9fSy18KUzLd9ONrvaLIor4PhrLpqonRJSmT4in8E
	 hponM+h3lZLgTtvpQMMjmu64mem6yL/d5DWFMtBYE7m6TnXYkm8/PtC4f6B0PhMumX
	 ErQ6xoArqxfqtrXOWenubDisiaAWqoXBxFWO9fzznBFGx586sUhciTgPVSio2Tmif+
	 bmcsh23JQvwb27nsWpawk4aGjG075fn8HbrJ3LT+Q1/BpT+xCKv5NuFOv2RfMbenK8
	 Ln7z7+rLKTmlF9BFPWIMQZ4ZgsT2wi8bRtuPMBXGUx3TQWIUqR2B/RORVN5z17I230
	 fRieXOIXKmbkQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DFD12CE10F1; Mon, 14 Sep 2026 07:54:48 -0700 (PDT)
Date: Mon, 14 Sep 2026 07:54:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcuref: Fix the rcuread_is_dead reference in
 rcuref_read() kernel-doc
Message-ID: <e3221cec-1e4f-41bb-a48d-8012cdda1620@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911213643.3781-1-kmehltretter@gmail.com>
 <20260914071921.8NKpjb_K@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914071921.8NKpjb_K@linutronix.de>

On Mon, Sep 14, 2026 at 09:19:21AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-11 23:36:43 [+0200], Karl Mehltretter wrote:
> > The kernel-doc comment of rcuref_read() refers to rcuread_is_dead, which
> > does not exist. The name is rcuref_is_dead. Say rcuref_is_dead.
> > 
> > Fixes: 3efa66ce6ee1 ("rcuref: Provide rcuref_is_dead()")
> > Assisted-by: LLM
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> 
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Sebastian

Queued, thank you both!

							Thanx, Paul

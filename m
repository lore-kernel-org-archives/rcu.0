Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BA822AE59;
	Tue,  8 Apr 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129214; cv=none; b=porvBDBSfqS2QFwy/BklPa6mcRdGP83Lcp7cTRHmNRoNjbzHj68tS0lNCJSyucuON5S5tkAPB812Nu458Wm+AYibTNDTydqGqK+ftPLOEWgWjjqT4/k8idszA1UykF6x9sTA6O19luLfkdUwzN3WQyHzT2UetYMfxAUINU4IZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129214; c=relaxed/simple;
	bh=RPBbCIP5rW4MHGMXbX+epS66ZhO8ldB+hyxzxPFajYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Puh7xLRa1msoJue2glR7Em/sFvUaXqs0jKxAhvlR4js2whOIKu30eA0KKpmeWjxLTOGOP6iLJ2PuHvHvLHj2eJDzK+1Jb8E3IZOBVeZUelJnUXHFv1vothQGp00zk0ZfBOW0CiAG5bmt/eASubwoAiWgECSekHc+y+sLyOLBdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOwFFGuY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOwFFGuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43349C4CEE5;
	Tue,  8 Apr 2025 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744129214;
	bh=RPBbCIP5rW4MHGMXbX+epS66ZhO8ldB+hyxzxPFajYw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QOwFFGuYhfa5S+aLpUUfOULQnh4LBf2uY58fXM9v1ArvKLT+vvxizp8zlOWN1L61j
	 fYaPX26tYfMyZOQCOWwJGrpZMKclFxsSAzTX3k5LzeK9E9Sygpy73Ce3IzN+VBNRbV
	 yrK8MSkyVCPcnqoj8LhI5m0E4y3moxrX5jEzR+I/Vixw/VNUNQ4KGByNRBpvL80u5V
	 1IXIbhX8Gwqm1hjZ3T0SO1LhZQ3efbhwSbi5BbBd6gv5sa722h/X1besI667M6ArCo
	 DDjbJbOWEeYSmrBtvcJkT/m5ctLrjQdncoXzWFcqFjkBqZ/0uanU+1sj5D8RlkEHkz
	 35J2iLMhd5UCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DD69ACE0F64; Tue,  8 Apr 2025 09:20:13 -0700 (PDT)
Date: Tue, 8 Apr 2025 09:20:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu <rcu@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	kernel-team <kernel-team@meta.com>, rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v3,4/12] rcutorture: Make torture.sh --do-rt use
 CONFIG_PREEMPT_RT
Message-ID: <cbf9cc21-a2bc-41db-a115-328711639f4c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250407191221.28679-1-paulmck@kernel.org>
 <174412255922.117.3971687661268349880@patchwork.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174412255922.117.3971687661268349880@patchwork.local>

On Tue, Apr 08, 2025 at 02:29:19PM -0000, Joel Fernandes wrote:
> Hello, Paul,
> 
> On Tue, 8 Apr 2025 14:23:32 GMT, "Paul E. McKenney" wrote:
> > The torture.sh --do-rt command-line parameter is intended to mimic -rt
> > kernels.  Now that CONFIG_PREEMPT_RT is upstream, this commit makes this
> > mimicking more precise.
> > 
> > Note that testing of RCU priority boosting is disabled in favor
> > of forward-progress testing of RCU callbacks.  If it turns out to be
> > possible to make kernels built with CONFIG_PREEMPT_RT=y to tolerate
> > testing of both, both will be enabled.
> > 
> > [ paulmck: Apply Sebastian Siewior feedback. ]
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> I pulled this from your -dev branch for 6.16. I checked and this patch is the
> only one changed so feel free to not re-send the whole series (I will be
> resending it anyway once I have all the topic branches).

Works for me, thank you!

> Also, I added your sign off as it was missing:
> [PATCH 03/12] rcutorture: Split out beginning and end from
> rcu_torture_one_read()

I should have caught that!  Thank you for fixing it up.

							Thanx, Paul

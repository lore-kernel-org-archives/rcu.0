Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA6D1C3C08;
	Wed,  2 Apr 2025 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621455; cv=none; b=gRBjYtLsMplnNgrijEzff5V3CvIM7JrlhvRoMoHBjDLpusWbf/LK0vjAlUyJhTATX7rR6lhrcJgB5gNfV/St1u2WIAgRFDsiTT2IqY4Ajd+ihe8G2Awpwp2i56S4T7r0fDqTiXhsusABZmJ3iaMFCRYfNCWf0z73bNcZMfWDkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621455; c=relaxed/simple;
	bh=4naYzQQz2CbOEkIa0276QErW3JzhlVKXn72uLCiWoPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRpQ5uI5D+5ISAdVSFbFP2XXERqyRQu8+9OGJ1ghvU7L0d8iKHyzaZhjZZ/AyaCYJ4G89mf+1VhjTESmc6w8kQAHvS/IscpYM16ulYxaRDxMFuLQ/EwrixGgPeWZcyDefRjoccCHtjCu2HyZmZwx396gLC/VtirLY646feh0/Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJSAu0qC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJSAu0qC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E85BC4CEDD;
	Wed,  2 Apr 2025 19:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743621454;
	bh=4naYzQQz2CbOEkIa0276QErW3JzhlVKXn72uLCiWoPg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iJSAu0qCw3+DjVvOFRVpRgt7daF9AUuFeJJu/HsaV5G9AbjLKwG3zYiHJOn/NLLny
	 FxpghIeov8D9sDwbjg8unGy5shzwtxDBAi7s9joktuX+XmHpc2ds8il1jwKILCE6pY
	 vEHGYrnj1NoZv3vJXvUsUGZwyYjJB6h1kE5Q31PEHRisNpI8br3KyM1C2GLaT3b/39
	 ZYxBIdWUhU4OLbKD9ctOkwAemvEjho+q9w8c+OmERZTIncNBJqowE0+V/qU/BNdey/
	 3cCTMV7erkowxyQlO0poHafSpVmq6jn3KHHXhYzjZiIw8n6AKOLvPQw61JzVOo5Pn8
	 IFR/rqIvM/GJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 19F64CE079A; Wed,  2 Apr 2025 12:17:34 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:17:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	rcu <rcu@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kernel-team <kernel-team@meta.com>, rostedt <rostedt@goodmis.org>
Subject: Re: [v2,04/12] rcutorture: Make torture.sh --do-rt use
 CONFIG_PREEMPT_RT
Message-ID: <72693320-1863-4e47-941f-0e887f87a855@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5da8ff7a10670359647fc8135668be7c.joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5da8ff7a10670359647fc8135668be7c.joelagnelf@nvidia.com>

On Wed, Apr 02, 2025 at 12:19:13PM -0400, Joel Fernandes wrote:
> Hello,
> 
> On Wed, 2 Apr 2025 16:17:06 GMT, Sebastian Andrzej Siewior wrote:
> > On 2025-03-31 14:03:06 [-0700], Paul E. McKenney wrote:
> > > The torture.sh --do-rt command-line parameter is intended to mimic -rt
> > > kernels.  Now that CONFIG_PREEMPT_RT is upstream, this commit makes this
> > > mimicking more precise.
> > > 
> > > Note that testing of RCU priority boosting is disabled in favor
> > > of forward-progress testing of RCU callbacks.  If it turns out to be
> > > possible to make kernels built with CONFIG_PREEMPT_RT=y to tolerate
> > > testing of both, both will be enabled.
> > 
> > Not sure what you point at here: You can build a PREEMPT_RT kernel and
> > RCU boosting is enabled by default. You could disable it if needed.
> 
> Yeah, RCU_BOOST has default y if PREEMPT_RT.
> 
> Paul, should we be disabling it in the --do-rt script?

You should have a "rcutorture.test_boost=0" from f2ac55968df2
("rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT").

Plus I just now made additional adjustments based on Sebastian Siewior's
feedback.  He is likely to have additional feedback, so this is currently
a "squash!" commit in my tree.

							Thanx, Paul

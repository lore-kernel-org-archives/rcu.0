Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779930AD10;
	Wed, 17 Jun 2026 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781666312; cv=none; b=fZxrpYvypnP6vwPdQipUJsurAid3pAy7VrcscJ+iXukcSZIaXd81ipnOkDFv33GatONvk3psRMHx6tl7oY5oHfVG3AVg5bf58/psfigVy925lPKuQxUIIXz+bcgP0ct2bdyOWNJ35cXIIhjerCMeg4Jy/brN3bPXDF3ENiXz6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781666312; c=relaxed/simple;
	bh=JIkzse7IjheKBSu7+5JC/PG5G5u399xOIV5YrF3kqCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKF+3O6YJ/CmmUxfcEPMDSFagIf+UnbZHgvu79Csk1KPQ9YmpxzTxoTrEemSZJBbUuUzVJ4EigH1rPt9tJijq/03tSpZ/rx685gk/ZZ3BuJNbow63XE0ZK10xVHq5y6KBfp2JlEvgYG3Xshy8/wdcdt7R2IfFTi9515aWaPYBM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwmVt4tm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwmVt4tm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85521F000E9;
	Wed, 17 Jun 2026 03:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781666310;
	bh=Ugg8ZML0CGT2Ok9/50WZDenhl0k+p10I/30SXQr3KvQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=mwmVt4tmcFzYUakmO1PdakAcn7lkxLnP6ETXkUX3gJEOL7+OcUyLMzR/tO8wT4Xwg
	 dyJtvhdur80BE5BKuPT0Q2gZCOxqL8bMFiJOmWNS2Gt1jgsDUBhk6SAFhtqKVvM040
	 bBgx0Q4AEMWGeSd2l5r8oFHyOsYQ+uoT5OF4vdjg6Xj2GZtxTVlnptc5mCojQlrMia
	 FsGqy4db2dI3qTdOn8xrlLuz220ZjlRm3tpFoR/AdHlD4fI9HRf9kYsm4/SDxPkJfU
	 io2raTlWCFUoGJkYyR9rEJvxvZfC+wlHhKuqrdSMAoLWF5ff4t5iqlR/iXUZC4OM1V
	 Dh0coX9LCFJpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 81F84CE03CE; Tue, 16 Jun 2026 20:18:30 -0700 (PDT)
Date: Tue, 16 Jun 2026 20:18:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org
Subject: Re: [PATCH RFC v1 0/5] Reader end deboost testing
Message-ID: <9d22b32d-a7c3-492e-87b7-a1ad7fbf0ecc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260616222622.2981876-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616222622.2981876-1-joelagnelf@nvidia.com>

On Tue, Jun 16, 2026 at 06:26:17PM -0400, Joel Fernandes wrote:
> This series adds rcutorture coverage for the RCU priority-boosting "tardy
> deboost" issue. The first 3 patches are Paul's and the next 2 are fixes I had
> to make to the test, so that another patch series (I haven't posted yet) can
> correctly be tested. I am posting just the test patches first in advance, which
> can go in independently if we agree on the changes.

OK, I have recently gotten distracted with hazptrtorture, and am likely
to be more distracted with call_rcu*_nolock().

So if you are ready, then you should go first.

> Joel Fernandes (2):
>   rcutorture: tighten boost-WARN to exclude any implicit-reader context
>   rcutorture: give async deboost mechanisms up to 500us before WARN

You need these, but once I get the immediate-deboosting going, they
should become optional.  But that is OK, I can adjust later.

							Thanx, Paul

> Paul E. McKenney (3):
>   rcutorture: Abstract reader-segment dump into
>     rcu_torture_dump_read_segs()
>   rcutorture: Check for immediate deboosting at reader end
>   rcutorture: Test RCU readers from hardware interrupt handlers
> 
>  kernel/rcu/rcu.h         |   7 ++
>  kernel/rcu/rcutorture.c  | 257 +++++++++++++++++++++++++++------------
>  kernel/rcu/tree_plugin.h |  32 ++++-
>  3 files changed, 218 insertions(+), 78 deletions(-)
> 
> -- 
> 2.34.1
> 

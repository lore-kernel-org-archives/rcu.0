Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160CDCA57
	for <rcu@vger.kernel.org>; Tue,  5 Dec 2023 04:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CW8Sr/MJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B55C433C8;
	Tue,  5 Dec 2023 04:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701750056;
	bh=cYXfgEUnHpMfmOckZEUuZ8xDn9DXcjOAm8MCEgy+tNk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CW8Sr/MJ5RZoHCQ69JfRgub52iftgGV0NccVxjHMH1NdUJviX1oxsNV2rBy8vCfJF
	 BZdSvhZ3Iiu4V9RPdIZyJJT51QYBCdmtHd04F9U9PNwuOxecdFzGS5y9IXBPtjPac2
	 5be745ra4n/uiCk4pWM4iAeST+lZsg1WP/QvLPr3OxsySx3tqReE9IuwCA9J7PNTH8
	 NqmlvkgDexMz1PzM5jgV7dFTyDgdiX5YoaV2anBwxbU9qxRfBzNZB0DVN2PQXEQ6uF
	 FBOXAvrNXqxSXSYEq/W8b0PJgJ12bZ57AuXmu/QkvaUoO1tZg6mJktQE5xK1uC9f5P
	 U8GP4La+svnHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 12376CE1147; Mon,  4 Dec 2023 20:20:56 -0800 (PST)
Date: Mon, 4 Dec 2023 20:20:56 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/3] rcu/nocb updates v2
Message-ID: <08b4d5bf-800b-4696-8c4d-fc86af741849@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231115191128.15615-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115191128.15615-1-frederic@kernel.org>

On Wed, Nov 15, 2023 at 02:11:25PM -0500, Frederic Weisbecker wrote:
> Hi,
> 
> Here is a re-issue of some leftovers from a previous patchset.
> Changes since last time:
> 
> 1) Use rcu_get_jiffies_lazy_flush() instead of the raw variable (thanks Joel)
> 2) Further comment ordering expectations between grace period end and
>    callbacks execution.

Hearing no objections, I have queued these for further review and testing.

							Thanx, Paul

> Thanks.
> 
> Frederic Weisbecker (3):
>   rcu: Rename jiffies_till_flush to jiffies_lazy_flush
>   rcu/nocb: Remove needless LOAD-ACQUIRE
>   rcu/nocb: Remove needless full barrier after callback advancing
> 
>  kernel/rcu/rcu.h       |  8 ++++----
>  kernel/rcu/rcuscale.c  |  6 +++---
>  kernel/rcu/tree.c      |  6 ++++++
>  kernel/rcu/tree_nocb.h | 26 ++++++++++++--------------
>  4 files changed, 25 insertions(+), 21 deletions(-)
> 
> -- 
> 2.42.1
> 

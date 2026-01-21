Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C593876AE;
	Wed, 21 Jan 2026 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025512; cv=none; b=i0hgKXf4HVPOEyx785vzkT96Y9JEqaDl7s7OQg6dwZ7cH6XEgHrZ1isKuHzucGxqlKRFTtaw3aSeoTeOBQJ0h3GJ1eP9yruaQIEXnFkMRkesGCr8RrXo64nf5IFKscFBW9GEk8uOuGeBjCo5jLFfIeN/oXspB9+dt78/uBvxgG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025512; c=relaxed/simple;
	bh=u9hB4pLwe6JOFHSSDGj57dMWborYAw5noiN3Xu+JTOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M84n6qzoswi91zFhv+qx0iKs/lZhZS5J7WySGlhgdulhfKt8Ga33T3gK8a+J7Clo6fFuOxKKTHbLNQmaJs1RVMSC6xw/SGJFT82y9slHOfxT2pYxGfJIH9xAYbCfQMs2PrFdH2qk4y2qzfwl0FFsIvFAbFwabIu8xd7VV3cHSNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7sB6IZh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7sB6IZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619D7C4CEF1;
	Wed, 21 Jan 2026 19:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025512;
	bh=u9hB4pLwe6JOFHSSDGj57dMWborYAw5noiN3Xu+JTOg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=N7sB6IZhUHWc5akko4O9pcNu+4NTfQ/BJz7xwCeiVOAlMwN9t0otepE8ObQ+48jXq
	 b9fJB91VE6sBYxuDJIlBAWUxWY1Qwr8ssmORpfahbFy2l4eIMiDmm1nC+9QsYLP0ZN
	 CcOmEnM6//mwhpeOqlNSYGXIYBVfle+GEMI34qveqNqaC0K9ck6MRd9LdMAyufy2ol
	 8oJpgvrnO4JHBW8lRFW8HZG7X+VEkwiDi9LQtGlcqPNKtaY94DZveg0hgfxe7PCTFO
	 2puxDOxKYib5CoA0Pl4eawd4NU9CTpWZjP93yZ/crj2dMO5PJucXzrI4oha5Ex0gs6
	 SzFIfbpUrgeMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 03E5DCE0B79; Wed, 21 Jan 2026 11:58:32 -0800 (PST)
Date: Wed, 21 Jan 2026 11:58:31 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v3 0/3] rcu/nocb: Cleanup patches for next merge
 window
Message-ID: <d464331a-23dc-49d5-9fa4-be91d8ece84d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260119231223.989409-1-joelagnelf@nvidia.com>
 <f568bee5-9cda-40bb-977a-a9063bd2c611@paulmck-laptop>
 <be3df000-915d-4fa1-b7e4-231df1344815@nvidia.com>
 <78a11bfa-4613-450d-bc3c-238e0b44557b@paulmck-laptop>
 <cddea3f4-4041-491c-87f8-0ffba948a3b6@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cddea3f4-4041-491c-87f8-0ffba948a3b6@nvidia.com>

On Wed, Jan 21, 2026 at 02:50:54PM -0500, Joel Fernandes wrote:
> 
> 
> On 1/21/2026 2:41 PM, Paul E. McKenney wrote:
> > On Wed, Jan 21, 2026 at 02:13:56PM -0500, Joel Fernandes wrote:
> >>
> >>
> >> On 1/21/2026 2:09 PM, Paul E. McKenney wrote:
> >>> On Mon, Jan 19, 2026 at 06:12:20PM -0500, Joel Fernandes wrote:
> >>>> These are a few nocb related cleanup patches for the next merge window.
> >>>>
> >>>> Also Frederic please object to the second patch ("Remove dead callback overload
> >>>> handling") if you would like, but I think based on our discussion I have
> >>>> implemented your suggestion, so it should be good.
> >>>>
> >>>> Changes from v2:
> >>>> - Dropped patch 2 "Add warning if no rcuog wake up attempt happened during
> >>>>   overload" as it was not needed since we removed the dead CB overload handling.
> >>>> - Replaced "Add warning to detect if overload advancement is ever useful" with
> >>>>   "Remove dead callback overload handling" per Frederic's feedback - instead of
> >>>>   adding a warning, just remove the dead code path entirely.
> >>>>
> >>>> nocb rcutorture scenarios passed overnight testing on my system.
> >>>
> >>> I reverted three of your earlier patches in order to apply this, only
> >>> one of which I am really confident in.  Please check my -rcu tree to see
> >>> if any of the three should be added back in, and I am starting tests in
> >>> the meantime.Age	Commit message (Expand)	Author	Files	Lines
> >>
> >> Per your latest /dev branch
> >> (https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=dev),
> >> you have the latest 3 patches:
> >>
> >> Extract nocb_defer_wakeup_cancel() helperdev	Joel Fernandes	1	-8/+11
> >> rcu/nocb: Remove dead callback overload handling	Joel Fernandes	1	-12/+0
> >> rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path	Joel Fernandes	3	-36/+18
> > 
> > Thank you for checking!
> > 
> > And just to double-check, all of the patches that I reverted are obsolete,
> > correct?
> 
> Yes, those patches were from v2. You have correctly applied the latest v3 version.

Woo-hoo!!!  ;-)

							Thanx, Paul

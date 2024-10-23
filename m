Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0961C9DFD;
	Wed, 23 Oct 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701652; cv=none; b=NR7FyF81Mi18lRJSiCbm49o1vAynjV61N2/sPefo645Yu0jMbkEzrmfyX2ABoOEUPEq2iPU6/oHHWoYngrl5MyF4Jhbzwj4aZwJK+8yc2tZChflG+akEWKNVpa7Ny1CBXTtnFHuAhXYIZt5SENANCsJbLaFuOaXB48HznBpyMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701652; c=relaxed/simple;
	bh=VpXcdYhspcQug35V2yqd0UWMgk3PGnE3ESouosVt6dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6ANgJMzjNdaKFRw9s8oIXaTLQYniBEOxFRhcKH1eB5evNIbynfgyE4qzBnumCozTB+NVxaXkgv87QCL6L6l8RqZ5rwtlBeTnT0CNzEUL40T0clDfJeaybTh1FDGHAFsFWCZ8XqgrecxUmLObXOW0dbMFz0Ok+Ts5jaCB6cXbWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxRN2HpZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxRN2HpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A29C4CEC6;
	Wed, 23 Oct 2024 16:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729701652;
	bh=VpXcdYhspcQug35V2yqd0UWMgk3PGnE3ESouosVt6dg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uxRN2HpZWyMZ+TPIMyOkOslwb30h1/A42B5YB6b+aJq4nCWAxH9HF749hsJ49ko2R
	 P2oKPhCPKEYjEILuLDxDvmQz9W4Lpp/htuFglHC69IGUivBbn3F5P+9OVMTFlMZhue
	 oNN1aBp42i+gymkfs3ZR5YF88Cq1fsaEwOEW0NMHLJajMPpD/Tfp1uMoWctoeQGFmN
	 JykTSwUOIlhjnR5iEHpj/FfB0u7lJuWm1acVbZl2tFnqycLUqAt5EUznGLPj1GELPT
	 uJGJJGlIbzrqVCZeR34opDgeWcADq/yG0vzIKlB0UZKD9rC31JDrxYJMz1r/x3Nij/
	 YzHDMCcGfYe4A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E05A5CE0EE1; Wed, 23 Oct 2024 09:40:51 -0700 (PDT)
Date: Wed, 23 Oct 2024 09:40:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alan Huang <mmpgouride@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, kernel-team@meta.com,
	Steven Rostedt <rostedt@goodmis.org>, andrii@kernel.org
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
Message-ID: <e0bc0674-9309-4749-b74d-e0aa6b40a552@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <ZxdLfLWWrAEfRiXV@infradead.org>
 <20241022070635.GY16066@noisy.programming.kicks-ass.net>
 <ZxdPN6wT1LMyLaNL@infradead.org>
 <20241022071018.GA16066@noisy.programming.kicks-ass.net>
 <ZxdQiLhn16FtkOys@infradead.org>
 <8b2552d8-0453-476a-8606-e8b761934783@paulmck-laptop>
 <E068D091-F79C-4F56-974D-08ED95AD6F58@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E068D091-F79C-4F56-974D-08ED95AD6F58@gmail.com>

On Wed, Oct 23, 2024 at 02:58:07PM +0800, Alan Huang wrote:
> On Oct 22, 2024, at 22:26, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > On Tue, Oct 22, 2024 at 12:13:12AM -0700, Christoph Hellwig wrote:
> >> On Tue, Oct 22, 2024 at 09:10:18AM +0200, Peter Zijlstra wrote:
> >>> Ah, well, the thing that got us here is that we (Andrii and me) wanted
> >>> to use -1 as an 'invalid' value to indicate SRCU is not currently in
> >>> use.
> >>> 
> >>> So it all being int is really rather convenient :-)
> >> 
> >> Then please document that use.  Maybe even with a symolic name for
> >> -1 that clearly describes these uses.
> > 
> > Would this work?
> > 
> > #define SRCU_INVALID_INDEX -1
> 
> Is there any similar guarantee of the return value of get_state_synchronize_rcu
> or start_poll_synchronize_rcu, like invalid value?

Yes, there is a get_completed_synchronize_rcu() function that returns a
value that causes poll_state_synchronize_rcu() to always return true.
There is also a get_completed_synchronize_rcu_full() function that
returns a value that causes poll_state_synchronize_rcu_full() to always
return true.

There has been some discussion of another set of values that cause
poll_state_synchronize_rcu() and poll_state_synchronize_rcu_full() to
always return false, but there is not yet a use case for this.  Easy to
provide if required, but why further explode the RCU API unless it really
is required?

							Thanx, Paul

> > Whatever the name, maybe Peter and Andrii define this under #ifndef
> > right now, and we get it into include/linux/srcu.h over time.
> > 
> > Or is there a better way?  Or name, for that matter.
> > 
> > Thanx, Paul
> > 
> 

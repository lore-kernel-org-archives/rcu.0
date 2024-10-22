Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A010119DF77;
	Tue, 22 Oct 2024 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607187; cv=none; b=VuvCngf6OQACie3H0lTYPWe23qW95E6HjU1/SMWTQByMVwRFrRj6oJ3GMVtEPwBLJ1JxXdy4V/bROLDOBSgg91Kr62MINKGkeLsLi5B+uThkwg1iexCnf7PgQ/5NDk6bO85xZYNCIt3KPtG1qwEK5O6tCpK/r911WYpkQuOiR68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607187; c=relaxed/simple;
	bh=mgEvvRiG+U6EMONRswkpZR8uLmcEQW9eMyDyIkTvjxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjgVF7cpixxHdCMDcWeJW/sm71voFoaa6UaEXYP5JRLT8dBDAK/dxSux1nyOkJbbDNaedlgcPkk7NJaOML4Ijyv34nqK2qyNMpimIVwtaqpYJdOnNZQNrC5NJ6X/g6BTIvRUdCrrDl8Qh+7dgqFIDGIrXVaqvrlAQszBQhFr90A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odThPF++; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odThPF++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EC1C4CEC3;
	Tue, 22 Oct 2024 14:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729607186;
	bh=mgEvvRiG+U6EMONRswkpZR8uLmcEQW9eMyDyIkTvjxI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=odThPF++THq/f5boaIgR6g8hFmX8NNok26qWwgAHfjC72KYP6fm7/FNoGkX+/1aWq
	 OREZ66vFQ/XeX9NPj0VR3NxCo8OpFDG6hDF6V6OX0gSh1c1zA7NcPs59PgrqCzYDzV
	 g2VruTZIMiwVD3tCR2mIitBcCMSJSDzMwBTP50dz4B91PtNy/YTb/Up4pytV9Co/9T
	 IN9Vqtb73dKgFXcc0sn7JApJJDZ43bq+6Me4du8y9fXurKgox4vybGYTtja3j3KFaF
	 a8ptn3EiGLXUeGrk6A5YCL6jf8xIQadTBAeS5Sb4b8lZWVSRhdtP9nZSN8bqeG9rlk
	 7ZlGyNyN1IzWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C6A35CE0A48; Tue, 22 Oct 2024 07:26:25 -0700 (PDT)
Date: Tue, 22 Oct 2024 07:26:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, andrii@kernel.org
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
Message-ID: <8b2552d8-0453-476a-8606-e8b761934783@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <ZxdLfLWWrAEfRiXV@infradead.org>
 <20241022070635.GY16066@noisy.programming.kicks-ass.net>
 <ZxdPN6wT1LMyLaNL@infradead.org>
 <20241022071018.GA16066@noisy.programming.kicks-ass.net>
 <ZxdQiLhn16FtkOys@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxdQiLhn16FtkOys@infradead.org>

On Tue, Oct 22, 2024 at 12:13:12AM -0700, Christoph Hellwig wrote:
> On Tue, Oct 22, 2024 at 09:10:18AM +0200, Peter Zijlstra wrote:
> > Ah, well, the thing that got us here is that we (Andrii and me) wanted
> > to use -1 as an 'invalid' value to indicate SRCU is not currently in
> > use.
> > 
> > So it all being int is really rather convenient :-)
> 
> Then please document that use.  Maybe even with a symolic name for
> -1 that clearly describes these uses.

Would this work?

#define SRCU_INVALID_INDEX -1

Whatever the name, maybe Peter and Andrii define this under #ifndef
right now, and we get it into include/linux/srcu.h over time.

Or is there a better way?  Or name, for that matter.

							Thanx, Paul

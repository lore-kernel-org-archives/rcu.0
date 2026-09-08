Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555644E80AC;
	Tue,  8 Sep 2026 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788910451; cv=none; b=cn3TwTw7+L62+63qIqJZZa6Cqx3QdFA5JOIdjF6v59g1A4zk9d3lo8hLS1y3bXdFxgDbehlf8CEkd7p9VKYjnrBryec7bLiCx2QvhC86bc9h/yz+kyqfLaflFz8nJBJuXn210yh/Z/UnMMLdumheU8ZYYoodscc8snZmBUaJBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788910451; c=relaxed/simple;
	bh=liMYSsF1synMdx/HvUli+eOYfqG0cswkPGN03w8eXuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFDqMbVdoe0G6YjVHm7SksSzUNl1l3SZr/iScoOJlVBVD+tAGHj1KHM9UBoe5kUWZSeCpdbs+ilMVXArrsoJ5PvcCHXYHAz0JJ6f5ExVGHsPrFKd97uzz46ixi6UYTnk7rXcr/ayRirbXhmoLv77RZWQ35xEihwDsFIm3TAF1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldlXsWrK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldlXsWrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F141F00A3A;
	Tue,  8 Sep 2026 23:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788910450;
	bh=PZ/BCZF9t/w1zHXlXvOwvompaGwtJhPtPXXnDJts8y4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ldlXsWrKKYv07ergMDXyKnL3FT7Ga2U//LejPwZ8xzsnM8AZH9nf2uVJ6iS/zPCjx
	 fvaghbZW0U7cMj2F1Hc/W60FJhubFTqcaVl2RN+b4kvAZpvSeRKxjg+y7SNnwXw1kU
	 TDA2QdFPNRPixx+0+8qvw42HvCxzmOlbOJ3r5KNxChr2r8HdWA5ckOdQnP8Q8bNCil
	 ucp555315oIwVBKmobfBSO+W0gcPPDsf1gYAdgzCme9V0WTbhs7sf8od3I19EujLUn
	 caVcPLDSFpj9KCEFhWdQeXT4vMMLF4OsDdCusQWXpfml6pCbnoZiya+zXPN6JOBgAN
	 E6HzUR8+Yth1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DCE04CE18F4; Tue,  8 Sep 2026 16:34:09 -0700 (PDT)
Date: Tue, 8 Sep 2026 16:34:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>, jiangshanlai@gmail.com,
	josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] srcutree: Add reader-free fastpath to
 synchronize_srcu_atomic()
Message-ID: <c7bb8c11-0f35-4723-87d3-43c73a758b66@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-4-kunwu.chan@linux.dev>
 <b7bc58aa-4b8a-4eaa-a7e8-8d338f34d14a@paulmck-laptop>
 <0d4af6318ac67486858be1df8d436147b444a2d2.camel@infradead.org>
 <8889e3f6-4cba-4d6c-97f8-85cdff367b0a@paulmck-laptop>
 <6bee4e69860f3963d1889f6af7226531d9bb6146.camel@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bee4e69860f3963d1889f6af7226531d9bb6146.camel@infradead.org>

On Tue, Sep 08, 2026 at 11:56:41PM +0100, David Woodhouse wrote:
> On Tue, 2026-09-08 at 15:53 -0700, Paul E. McKenney wrote:
> > Thank you very much!!!
> > 
> > I am interpreting this to mean that Kunwu's current approach does what
> > you need, so that we can keep current get_state_synchronize_srcu()
> > and poll_state_synchronize_srcu() semantics.
> 
> Yes, thank you. I'll rebase the KVM parts on top when it lands.

Queued for testing and further review, thank you both!

							Thanx, Paul

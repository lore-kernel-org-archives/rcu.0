Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659A125484D;
	Thu, 11 Sep 2025 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619455; cv=none; b=CS0tkFlqTL3toFGF3eF9yUu7BpQDeSYSPQ2w8Doq36FPocPRJZEtgDgrIKum6HmbD7ej3pJJFAwmwf7ihevYFd0AiDq8emTrLUjGTwcmnx7cPlapWpK8uEQ433aKRgPMVGN0BAvdSG5qCmLY4ra2QENdgQKKwd6tkS2qf21op/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619455; c=relaxed/simple;
	bh=ZjwiPBAwKH7AwJgS56aj0Mt8Iz098FGr9ay8z757enQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHI8x5PUY3Ueu3xx4laqR7frKpKzw48feJF/6klS4YdNFZ3ZBUV75OIOnpGt786EMEeRvF0BpksONJFStmbxyrAdXfkintuXVdHw4Pbdt+L1BgX1n0qMSQezXyTSgnhf0OQa8sg7Rg1kJNZBLZm4iAtguIXKHdpaxtjqGA7cfNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX9+cqLB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX9+cqLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9BFC4CEF0;
	Thu, 11 Sep 2025 19:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757619455;
	bh=ZjwiPBAwKH7AwJgS56aj0Mt8Iz098FGr9ay8z757enQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XX9+cqLBMr76wKln6+ZslUVmujA3hk2EFkLM9+udoW+Nt9ycVpkfbjsD1NFEsa9O8
	 775YozyyYLaOJJ2O2pqOlM++90jAdKWW3jn9B+QDFRomkbBIqft6NjKtdT+Plvuz6R
	 Jqv4Dy8jT/NekCr/qGaGRGP4AiGEuPFtGUGyXMdJZOxBxd+VhYNu6MMr7aJd1w40oj
	 FN2OYSTtqARK6j+Lqb3SiGMkg7Z7cTrB8UaHdAWR6OaXbkGqAiQGsdXyBAt6uK4a4M
	 hfbGqIjHby2BxBsE4kJBiY0/3mnCLpu0D+8JU0gtEOkIGKQ5yy0mU7Y3A1dq9NF8iO
	 XMpk20L9ZGW/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 65ECFCE0C15; Thu, 11 Sep 2025 12:37:33 -0700 (PDT)
Date: Thu, 11 Sep 2025 12:37:33 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
Cc: "dave@stgolabs.net" <dave@stgolabs.net>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	"frederic@kernel.org" <frederic@kernel.org>,
	"neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH] rcu/segcblist: Use WRITE_ONCE() for rclp->len decrement
Message-ID: <f5d5811c-4908-45e8-9db7-c7cc00b45649@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250911051009.682429-1-kaushlendra.kumar@intel.com>
 <d1cee525-84c4-41f8-8594-0643d532e3ff@paulmck-laptop>
 <LV3PR11MB8768B531BD88260D26996285F509A@LV3PR11MB8768.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV3PR11MB8768B531BD88260D26996285F509A@LV3PR11MB8768.namprd11.prod.outlook.com>

On Thu, Sep 11, 2025 at 03:46:08PM +0000, Kumar, Kaushlendra wrote:
> On Thu, Sep 11, 2025 at 10:40:09AM +0530, Paul E. McKenney wrote:
> > On Thu, Sep 11, 2025 at 10:40:09AM +0530, Kaushlendra Kumar wrote:
> > > The rclp->len field is accessed concurrently by multiple contexts in 
> > > RCU operations. Using WRITE_ONCE() provides the necessary memory 
> > > ordering guarantees.
> > 
> > Could you please be specific here?  What calls to rcu_cblist_dequeue() are such that hte ->qlen field can be concurrently accessed?
> > 
> > (Full disclosure: I don't see any, and KCSAN hasn't found any.  Of course, that does not necessarily mean that there is no concurrent access.
> > But we need such concurrent access called out explicitly here, because it might well be that the concurrent access is itself the bug.)
> > 
> > 							Thanx, Paul
> 
> Hi Paul,
> 
> Thank you for the clarification. You are absolutely correct. After reviewing the 
> code more carefully, I cannot identify specific concurrent access patterns for 
> the rclp->len field during rcu_cblist_dequeue() operations.
> 
> The primary motivation for this patch was to maintain consistency with 
> rcu_cblist_enqueue(), which uses WRITE_ONCE() for the rclp->len increment. 
> 
> I will modify the message accordingly and send a patch.

Why exactly is a patch needed for this case?

							Thanx, Paul

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459F63F
	for <rcu@vger.kernel.org>; Tue, 28 Nov 2023 05:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1dMQ082"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BD8C433C8;
	Tue, 28 Nov 2023 05:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701147957;
	bh=ZG13VLtBikWYAuMXjxCGyIuIfO5LfJqKfZbdqISB90w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=R1dMQ0829mRuy2Ze0/JX5fDmJQmMJHt267zyNioq4ZUQx9+/en7LCcVJFMgIMujn8
	 0scqCQJazeMCCv9wDYEvmEJ+K+WvNBpeicU+XY620mr2jK18BJJyxXZ8J40te/gICC
	 vYFT/5MEXTv16B4TwbjlrJcfIrL150A/1lIwU7KmDsNA8a78ABg3nJGblBAIPkOps6
	 9pPkehOdKRUFvuh6x3D/HID+EnUywmTxgAxxJF/lSiXVDckh9wPFyerTAOtCKmNcb2
	 boEn50fkkYUQ0O4l2/3+JhBILEvdp0REpAOKN1FMvHtkp9suYoilVC7mEmUhJ1wvHa
	 4kJ1rSr6FRvYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A4EFACE1140; Mon, 27 Nov 2023 21:05:56 -0800 (PST)
Date: Mon, 27 Nov 2023 21:05:56 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: rcu@vger.kernel.org, frederic@kernel.org, neeraj.iitr10@gmail.com,
	urezki@gmail.com, joel@joelfernandes.org, boqun.feng@gmail.com
Subject: Re: Neeraj will be doing RCU PR for v6.8 merge window
Message-ID: <f54b3cbe-181e-48b1-bd68-3eae64940046@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <6a6d4007-e783-4dee-9f0d-6a1d2525a766@paulmck-laptop>
 <d9bab0d0-02a4-4220-88b0-3f9a86512bf8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9bab0d0-02a4-4220-88b0-3f9a86512bf8@paulmck-laptop>

And this time using Neeraj's new email address, apologies for my
having failed to update it.  (Neeraj changed jobs recently, hence
the old email no longer works.)

							Thanx, Paul

On Mon, Nov 27, 2023 at 09:03:43PM -0800, Paul E. McKenney wrote:
> Hello, Linus,
> 
> This time, Neeraj Upadhyay will be handling the RCU commits for the
> upcoming v6.8 merge window.  This is once again a practice exercise, and
> I will likely be returning for the v6.9 merge window.  (Yes, I suggested
> that I would be doing v6.8, but Neeraj was willing to give it a go,
> so why not?)
> 
> This yet again covers only RCU, so I will be sending pull requests as
> needed for the other topics.
> 
> And yet again, please let me know of any concerns or issues with this.
> 
> 							Thanx, Paul

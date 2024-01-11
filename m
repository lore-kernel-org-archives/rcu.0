Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0737414F89
	for <rcu@vger.kernel.org>; Thu, 11 Jan 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egBaLgJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B287C433C7;
	Thu, 11 Jan 2024 10:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704970364;
	bh=sQOYgQ7nLzDZrUR41WeQc/H1CB1vNUOGef7Ick5XtPk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=egBaLgJ+FBLz92KoEjhUffMR2Nl1Mxn+paMUgWGIXxc3O9EIX6ldvkKYWMcT4JwSB
	 MZ35j3B1n7rq7cg5V8DbCy6QNi3zQyoGneL3UwV+Ywc/CPDIF/PfcyChwqyWp+MTTj
	 R6AWpxWPuCCvYpvkA4aXLB+mW1QjhRN7KvCxOnnB64pq9bxu9gwcv8Un8UbfC7SrNR
	 10H2wHH+zX3kMYVlAwwbEDfZI4pCHQLAHB9JlcP413Sn9rHYsgcCjmWGaNtHrq//b8
	 4kNe1lQsTjGOyNQROxEc6mRrsHRMoBFg9/a7P3K5u7pywzFIB73tTVDfdQjLvr3f86
	 9gyLND92ZXL3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0BA37CE045D; Thu, 11 Jan 2024 02:52:44 -0800 (PST)
Date: Thu, 11 Jan 2024 02:52:44 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: rcu@vger.kernel.org, frederic@kernel.org, neeraj.iitr10@gmail.com,
	urezki@gmail.com, joel@joelfernandes.org, boqun.feng@gmail.com
Subject: Re: Neeraj will be doing RCU PR for v6.8 merge window
Message-ID: <bebc98c1-286c-4196-8f41-50d41b30f031@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <6a6d4007-e783-4dee-9f0d-6a1d2525a766@paulmck-laptop>
 <d9bab0d0-02a4-4220-88b0-3f9a86512bf8@paulmck-laptop>
 <f54b3cbe-181e-48b1-bd68-3eae64940046@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f54b3cbe-181e-48b1-bd68-3eae64940046@paulmck-laptop>

Hello, Linux,

Just following up on Neeraj's RCU pull request from December 23rd:

https://lore.kernel.org/all/20231223021434.GA2714@neeraj.linux/

If there is something wrong with this pull request, could you please let
us know so that we can fix it?  (It looks good to me, for whatever that
is worth.)

							Thanx, Paul

On Mon, Nov 27, 2023 at 09:05:56PM -0800, Paul E. McKenney wrote:
> And this time using Neeraj's new email address, apologies for my
> having failed to update it.  (Neeraj changed jobs recently, hence
> the old email no longer works.)
> 
> 							Thanx, Paul
> 
> On Mon, Nov 27, 2023 at 09:03:43PM -0800, Paul E. McKenney wrote:
> > Hello, Linus,
> > 
> > This time, Neeraj Upadhyay will be handling the RCU commits for the
> > upcoming v6.8 merge window.  This is once again a practice exercise, and
> > I will likely be returning for the v6.9 merge window.  (Yes, I suggested
> > that I would be doing v6.8, but Neeraj was willing to give it a go,
> > so why not?)
> > 
> > This yet again covers only RCU, so I will be sending pull requests as
> > needed for the other topics.
> > 
> > And yet again, please let me know of any concerns or issues with this.
> > 
> > 							Thanx, Paul

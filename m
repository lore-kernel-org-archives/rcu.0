Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69141CA89;
	Mon, 13 May 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618807; cv=none; b=nI4BNRiCmZ5Ziewxg4M/+lWInvTJpz3uTyghoMrd4sYC8sIFEN2mpVKMYkrye5ZcCBQ7MphECqqZi5jLNpXZ6U0rwp5mcXG6JlK1u8ZE13cRctk1e5gOO8d8jydPx54vNs7DBiBOcYa8VPKmiSDv8FZIJUhjfykoJW1A4gR4UGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618807; c=relaxed/simple;
	bh=MkWI0eSVp+S5LEhfZiAhhvdMwAvSY+rnKHO51GHLaDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmCwHYrR33rL2vRyps4H74WhLYBqrn+qSQHFmWsJLMzfYqY0GNUBhsOpXoYdxhVLnHyxew4N9tclUYY7EenlOmNyF3x1A2X48UQCv6+YIJOiQDaw30L06A+QB4Gj7vuDSEtqbu3crcgb5D3v83XWsaNlRf+wXYDomnOyDVMKH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbAhzog5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbAhzog5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449A7C113CC;
	Mon, 13 May 2024 16:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715618807;
	bh=MkWI0eSVp+S5LEhfZiAhhvdMwAvSY+rnKHO51GHLaDs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LbAhzog5jaflLHu4HNwazc1VclE3Tv/XMW70rUi15/HyQf0RCFv8uTnnHQPOPw1ye
	 HHchU9WY1h7qBwDJypMB90uNAAbIQrjRyjCwKp+/CI+lIHB/fa/map64Yh5z8gKXkL
	 PCCCKv6WbMG1QSWGUcQ/nSsV7OVKZ+guEoRyz/UB49D9AWGGwSyrTOrRUHy9KVwOy7
	 Y883rhR5lHaS2E9MH/tzfbm0FfmvGVEYuym9pupC+PKx8fcqb1p+eU5ZiRRHg4IsJ0
	 d3esvv17JzNgLhq48kEtrRBKUl6xpRnCUWBW5wg2G9qc9KMMZxv46jVuaYnAb8llvk
	 kxIJ4VICPxOyQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3F7BFCE098A; Mon, 13 May 2024 09:46:45 -0700 (PDT)
Date: Mon, 13 May 2024 09:46:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Nikita Kiryushin <kiryushin@ancud.ru>, linke li <lilinke99@qq.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Zenghui Yu <zenghui.yu@linux.dev>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [GIT PULL] RCU changes for v6.10
Message-ID: <e35bf672-88d9-4a00-8237-99298392e55f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240510183049.312477-1-urezki@gmail.com>
 <CAHk-=wh=HgEeyKVKGXTKiLdhvs-5t9pFxUkK6ED+zsby=quBdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=HgEeyKVKGXTKiLdhvs-5t9pFxUkK6ED+zsby=quBdA@mail.gmail.com>

On Mon, May 13, 2024 at 09:38:11AM -0700, Linus Torvalds wrote:
> [ I should have reacted to this earlier, but I just put all the "for
> 6.10" pull requests in the queue without looking closer ]
> 
> On Fri, 10 May 2024 at 11:30, Uladzislau Rezki (Sony) <urezki@gmail.com> wrote:
> >
> > Please pull the latest RCU git tree from:
> >
> > https://github.com/urezki/linux.git tags/rcu.next.v6.10
> 
> Hmm. I don't have your pgp key to check, but I do see that it's in the
> kernel.org repo of pgp keys so I know where to get it.
> 
> HOWEVER - importantly - I also don't find any handoff emails from Paul
> or Boqun giving a heads up that I should expect pull requests from
> others.
> 
> Put another way: I really want to see proper heads-up and "yes, this
> was all intentional, nothing odd going on" when seeing pull requests
> from new people to core areas.

My bad, and apologies!

Yes, this is intentional, nothing odd is going on, and Uladzislau's pull
request is legitimate.

							Thanx, Paul

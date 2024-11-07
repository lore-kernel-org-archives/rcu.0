Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57501E25ED;
	Thu,  7 Nov 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973884; cv=none; b=lUa/nu0sGcvBFG0SyDPkGyZ9hewNMEvv3NSJdQQniJsRBD37bQNiMK2wMHrMVd5V4q6RwxrRom5QW1QsGIjM+DGWDD3tzSUAwvfXovOZCCDYam0sA4y47jj4L5rpuHqD1DAU4FP6pBqhnmZo92lm81T+HbTcr7HtVMvWh/pjCN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973884; c=relaxed/simple;
	bh=Rom/ildpqgeytyPHNoc4quEJo8BKKLGv+Rp6ums0tbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kv+Yp5RAgrTsEHLSM3n3CNQYmJL9tSPcqgyO8qw12z3/y17qdQ0EvsfxtMHU7K/tbofx7aQDMWvwngEdZko/AMUMIudCHC4bYDFZVlsHvXUWeYEp1oue4IMOXAPOmYlG0fW9tSiFikmqbQ6rzaos94vYYER1amNqLZkt/j2P7L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEKIQ+yq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEKIQ+yq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297C0C4CECC;
	Thu,  7 Nov 2024 10:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730973884;
	bh=Rom/ildpqgeytyPHNoc4quEJo8BKKLGv+Rp6ums0tbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HEKIQ+yqI9QMuv4yqVU66dgAJphJNk9zLN2lNSA9fHcssHOr55Km0WlJ+C/HIhxrA
	 s0yFaKWieaaeafLFD1Hd1hzNyiOa7xL9MWJDWmx0HoeJCyUT7TIydTb7IQWNmmIRpu
	 9ztub1bBcNXe28qUCI24yr52GNb8Sna+j0ry+7br66+b6EUkca0229wIfoioLw9Ngo
	 Uhv/isv2vUSsvDfLwOyGymDNhtCbRXak/UXWDLCDaOdpI/FFgrK8CGwOmpT85B7PHt
	 hnCOEYLKR+qXOP+bAl9aJvUW6FJBM/1cRvu6GqwxxO20EaDQKb4xYp2LT9DOYYfWyQ
	 BS0AvIACfKiyg==
Date: Thu, 7 Nov 2024 11:04:41 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Mingcong Bai <jeffbai@aosc.io>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
	sakiiily@aosc.io
Subject: Re: [Regression] wifi problems since tg3 started throwing rcu stall
 warnings
Message-ID: <ZyyQuTfMMSLwStf_@pavilion.home>
References: <b8da4aec-4cca-4eb0-ba87-5f8641aa2ca9@leemhuis.info>
 <ZxjLQzHKuR-w16hF@pavilion.home>
 <2b25a988-6965-48e4-a788-58dd8a776e06@leemhuis.info>
 <e2ffd3d06fad236ea900d4fb439b2240@aosc.io>
 <937c258b-f34c-4f63-949d-a5e7c8db714d@leemhuis.info>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <937c258b-f34c-4f63-949d-a5e7c8db714d@leemhuis.info>

Le Thu, Nov 07, 2024 at 10:10:37AM +0100, Thorsten Leemhuis a écrit :
> On 05.11.24 08:17, Mingcong Bai wrote:
> > (CC-ing the laptop's owner so that she might help with further testing...)
> > 在 2024-10-23 18:22，Linux regression tracking (Thorsten Leemhuis) 写道：
> >> On 23.10.24 12:09, Frederic Weisbecker wrote:
> >>> Le Wed, Oct 23, 2024 at 10:27:18AM +0200, Linux regression tracking
> >>> (Thorsten Leemhuis) a écrit :
> >>>>
> >>>> Frederic, I noticed a report about a regression in bugzilla.kernel.org
> >>>> that appears to be caused by the following change of yours:
> >>>> 55d4669ef1b768 ("rcu: Fix rcu_barrier() VS post CPUHP_TEARDOWN_CPU
> >>>> invocation")
> >>> Are you sure about the commit? Below it says:
> >> Not totally, but...
> >>
> >>>> As many (most?) kernel developers don't keep an eye on the bug tracker,
> >>>> I decided to write this mail. To quote from
> >>>> https://bugzilla.kernel.org/show_bug.cgi?id=219390:
> >>>>
> >>>>>  Mingcong Bai 2024-10-15 13:32:35 UTC
> >>>>> Since aa162aa4aa383a0a714b1c36e8fcc77612ddd1a2 between v6.10.4 and
> >>> Now that's aa162aa4aa383a0a714b1c36e8fcc77612ddd1a2 which I can't
> >>> find in vanilla
> >>> tree.
> >> ...quite, as that is the commit-id of the backport to v6.10.5; and the
> >> reporter reverted it there. Ideally of course that would have happened
> >> on recent mainline. If you doubt, ask Mingcong Bai to check if a revert
> >> there helps, too.
> > Do we need any further information/testing on this issue? Please let me
> > know if there's anything we can do as the issue still persists in 6.12.
> 
> Hmm, no reply from Frederic. Not sure why, maybe he is just away from
> the keyboard for a few days. But if the reporter has a minute, it might
> be wise to check if reverting that commit on top of 6.12-rc6 or newer
> also fixes the problem, to rule out any interference from changes
> specific to the stable series.
> 
> Ciao, Thorsten

Sorry for the lag, I still don't understand how this specific commit
can produce this issue. Can you please retry with and without this commit
reverted?

Thanks.

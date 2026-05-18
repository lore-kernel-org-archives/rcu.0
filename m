Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A07148AE02;
	Mon, 18 May 2026 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120830; cv=none; b=gnXWwk2E7MyoESQxS6ZtvOFdUaSBWmSOPBxxTXlIdaaKj9H4nBAfon0gbDt/OMLcWJqW68Mj93DA0Fy09GndVoEBWexD2VmwKGsz23cXYzaEt45OySoXQ96mZNlB/avxr7qpCkG7Qb3c8OX2q/G6Any4KMIjlq969VEh+je49sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120830; c=relaxed/simple;
	bh=1aPTzS8AxZw6WiwbV8gLyRuVvCej87lMpx6XhMRA5KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiAvwNm9mVafsN7xzLlodbx26Q2CzoFGHzREVnWVBUkhLPqlnDaV4GmLEpCZxAgjaVSyZWQEm4EPkJS3Tia6Q63EkfhSCiI2O4nWpZpwBh2IJ4aI2ooHQFFRFKS3nT3CJIH6A2K1i56jCIgEONjHoV+d0GXnwVUmUGynTPBtaGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3GQxRXu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3GQxRXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC23C4AF09;
	Mon, 18 May 2026 16:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779120829;
	bh=1aPTzS8AxZw6WiwbV8gLyRuVvCej87lMpx6XhMRA5KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3GQxRXufEXYYUsy8a3Lk4kijg2TASegSHnSLIsWqxYpyCbuPcvISXcwXyJcRoddT
	 G2EfYWpk0g0prJ1IK++pokWCdSEHgYBHA4vk5R19zmgK0/8N6JkV4yqH21FO0Ivef8
	 Tg4QMx35lmT2UkU5+4LXA9hNzWJN7VQxE/SYvN1gkJ58+/sT0wDNU7VIS0Fk4eVULT
	 6guoWh5QybDcBC+tqIeS8nik6fDKPLDqaTJW41QBJCJ35E1YpZsIDxomGByy0vzlYO
	 wKpBh0KJkxYZST+n6pn3ViUkuW6J0Lz+DkNzFb4yrjf269Wtyw6Ik5M5FTrlSSWVLT
	 atZpPk0W6H3ig==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 42AD9F40089;
	Mon, 18 May 2026 12:13:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 18 May 2026 12:13:48 -0400
X-ME-Sender: <xms:vDoLaqizI8W9NnB50EGjBnXBS-I5AJ_pkgwwdkZK-qNdb0Is5lfrpg>
    <xme:vDoLagnOLwYQTHy3lOJM7LKqI080g4b28TJ7fDkHVYwlKU5p9es2N7kkO9hI0oGKu
    OkMiCJ0MKPgvNNpdzWHP1iOyHBkPy-cZc5oIYkKy2YuODWeDj7DcA>
X-ME-Received: <xmr:vDoLarpXFGgiFkBOFaAwxZcx5CQNgkZCMBJhYCvl0mT5XjkAaSofwN-qZ-NYintZyHg0MDT6wVZsS9p5X0pAejuVLS6ywplc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elueehtefhtddtgfejvdejueehhfekteevueeuueekgeetieeggeehvdffhefhhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlvggvmhhhuh
    hishdrihhnfhhopdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunh
    drfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehn
    vhhiughirgdrtghomhdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhorheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhope
    hfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vDoLakK0eKK8cnzulGAMq1qXs7tDZYpqLlpVrh6rDzXDXmjqhGnKXA>
    <xmx:vDoLavAnLH44uRVUjQ5UG_YIjPldutzQO1UGGvZzLa3a0sdN6ZE4Lg>
    <xmx:vDoLau7sVCceWR3sTJL9BslY77NU2qgZabVoAEFD3iRwhWPaHWsW3g>
    <xmx:vDoLajHzbatfTLFdiDQkOdqTYYxC51bL82_JLq3OeNtrWhFNPnSq9Q>
    <xmx:vDoLahQQs7EQD6sJxMUOSFE0rGTWZLsAwmpH7yTDm2NUhGmBYGct_reL>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 12:13:47 -0400 (EDT)
Date: Mon, 18 May 2026 09:13:46 -0700
From: Boqun Feng <boqun@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Samir <samir@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH -next v1 05/12] srcu: Don't queue workqueue handlers to
 never-online CPUs
Message-ID: <ags6ug97zNR6Fiiw@tardis.local>
References: <20260511175448.153326-1-urezki@gmail.com>
 <20260511175448.153326-6-urezki@gmail.com>
 <f669fbc9-c068-489f-bd91-4e81561a6e58@leemhuis.info>
 <agm4-6f-6rOgQPFB@pc636>
 <3dd5cce0-51f9-4cf1-81b8-246e6c6a633a@paulmck-laptop>
 <53d546e4-8db0-4e14-a79d-270212081be7@leemhuis.info>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53d546e4-8db0-4e14-a79d-270212081be7@leemhuis.info>

On Sun, May 17, 2026 at 09:11:10PM +0200, Thorsten Leemhuis wrote:
> On 5/17/26 20:03, Paul E. McKenney wrote:
> > On Sun, May 17, 2026 at 02:47:55PM +0200, Uladzislau Rezki wrote:
> >> On Wed, May 13, 2026 at 12:38:01PM +0200, Thorsten Leemhuis wrote:
> >>> On 5/11/26 19:54, Uladzislau Rezki (Sony) wrote:
> >>>> From: "Paul E. McKenney" <paulmck@kernel.org>
> >>>>
> >>>> While an srcu_struct structure is in the midst of switching from CPU-0
> >>>> to all-CPUs state, it can attempt to invoke callbacks for CPUs that
> >>>> have never been online.  Worse yet, it can attempt in invoke callbacks
> >>>> for CPUs that never will be online, even including imaginary CPUs not in
> >>>> cpu_possible_mask.  This can cause hangs on s390,
> >>>
> >>> Uladzislau, Paul, according to the fixes tag below this change fixes a
> >>> change that went into 7.0-rc6 -- and apparently causes a "hang" on some
> >>> architectures. So shouldn't this be heading to mainline instead of
> >>> -next? Ideally with a stable tag to ensure backporting to 7.0.y, but
> >>> that is a separate decision?
> >>>

FWIW, I'm happy to create an urgent PR to Linus with this fix. Since it
fixes a commit in the previous urgent fix PR from me. Ulad, let me know
if you want me to do it.

Regards,
Boqun

> >> I assume it will be picked to stable
> 
> Thx for the reply. This answered the second aspect I raised. What about
> the first: shouldn't this be heading to mainline this cycle, ideally
> quite soon? Or is this the plan and I misinterpreted the "-next" in the
> subject?
> 
> Sadly Jiri (now CCed) afaics didn't yet report if this fix helped to fix
> the issues they were seeing, but it sounded a lot like it was likely:
> https://lore.kernel.org/all/f0351414-41af-4f74-899c-87fb5bb45621@kernel.org/
> 
> >> since there is a "Fixes:" tag. From
> >> the other hand i can explicitly update commit message with Cc: stable@vger.kernel.org
> >>
> >> Paul, any thoughts?
> > 
> > The "Fixes" tag should cover it.
> 
> Often it does, yes, but it might be silently dropped for one reason or
> another. So in the end only a stable tag will guarantee backporting
> attempt by the stable team.
> 
> Site note: I recently also tried to persuade Greg to also take those
> with a stable tag first in case there is a huge backlog.
> 
> Ciao, Thorsten

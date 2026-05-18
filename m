Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5020B390205;
	Mon, 18 May 2026 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132620; cv=none; b=nF6oUovWBW4DdLrCkZMRzqVnXDpWl6pXHlSudlKzLKCfOWM8JTFGnoRPBU+sVz0FOdIDEpfp2xNfrzHxczEUYXRwA3GxjTcdpgctfavmCk1ViI4aAWqqmXRFbulBqdemPlt4XemRT+WMOl37GRU4P/i1m0v0sY7Kk8s8NSOcBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132620; c=relaxed/simple;
	bh=DdX2iIFCSalYqzjtTrWney+Z5bj6ec5weDXdJolRS5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJD1RkdQSYbRya34fl6iGvmqBjNAWVySRBqJSAIXV0SVHRzu9GrEvEga6cjVLl5zyYlzDaYxRRv6q87t+phv8/rK64aMHEmmP+LPZ5+OEjxGw2t0FJsKQKMe1aizraZq4rg3VXFVrGCN6oaJZz637aavAoycANZabeEcc1GjOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g43ZjO+c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g43ZjO+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97102C2BCC9;
	Mon, 18 May 2026 19:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132620;
	bh=DdX2iIFCSalYqzjtTrWney+Z5bj6ec5weDXdJolRS5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g43ZjO+cFxhBTiOyzS+xdgNNPxwvST7r5fxpxqCH941vKep9c6n6es1+r3/ih/EwK
	 5ZKd2pZLQQnMNPblSna228xD5Yg0xxRmwHC0ymOMW+2P1ALQeN1uWOC5UVCewRSbBo
	 /xpaPpT+nfQsKCSJa3ndrRo4Kr70KfbGQUvMmyUmbQJg6yjCkCxlgtbolXY6Wa2qxo
	 Fik5lnlf36mEvpp0UyfQ57grA+1yOnNVuBK1VtL/ClPOU5aOpxpMqzo4Y96MdCM65D
	 i+d/49aTt/HG1s+M+DA/fhj3zfxLghm2MZhKy0NqfZJBxyLbCaTF6lZR/1KS0w4JI2
	 XaxpqZphPl1/g==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id E31BBF40086;
	Mon, 18 May 2026 15:30:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 18 May 2026 15:30:18 -0400
X-ME-Sender: <xms:ymgLaq_nNafjvpbSCxiZGAdSCii3Tuii5ZBx2u0Gpi2xST2fXqDoWg>
    <xme:ymgLagQ_IqvXp2AMqaDCt9twwVtlzFph9PgZPsQayVZm9_v8yrDa2dvqP2FIz56VV
    sjyZUwZ2OjZ-8FEnYmcbjTbjhu8WNlu8OoFpoh2Ywq1ghIkqHj7hA>
X-ME-Received: <xmr:ymgLapn0M0bsTt3Wktsc6RDXKzxthf3Df-6FNw4mkklAEWCxXzq6ePbA6tx2FJxOmPoZKpfQnnKeAH4t6IjC-sXVrIciRVQD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elueehtefhtddtgfejvdejueehhfekteevueeuueekgeetieeggeehvdffhefhhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprh
    gtphhtthhopehrvghgrhgvshhsihhonhhssehlvggvmhhhuhhishdrihhnfhhopdhrtghp
    thhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunh
    drfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehn
    vhhiughirgdrtghomhdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhorheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhope
    hfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ymgLajXZcpy1qga9ciHrGV8cHNrKxEL4aeyN981UGnk5bMW7PvxE9Q>
    <xmx:ymgLamc15HSbTErQMD7Aj0sI14Q8pJatpKc2KGxMT56vcpbEf1jL-g>
    <xmx:ymgLapmSfytH15wX8d4BsHtMnUV-YFXqHqEBZBrAX8GkuMRwA2GfJQ>
    <xmx:ymgLagAfEsbN9FOtZ_aBKqxIWuoIWqlxqqgahSPLcRJXKoknf1v-wg>
    <xmx:ymgLajexyW3LxC6yHJpJWJmHm1iFjlrO1CkurDanVFwLCC5cLWoDgfK2>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 15:30:17 -0400 (EDT)
Date: Mon, 18 May 2026 12:30:08 -0700
From: Boqun Feng <boqun@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, paulmck@kernel.org,
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
Message-ID: <agtowPsNCB2LioTN@tardis.local>
References: <20260511175448.153326-1-urezki@gmail.com>
 <20260511175448.153326-6-urezki@gmail.com>
 <f669fbc9-c068-489f-bd91-4e81561a6e58@leemhuis.info>
 <agm4-6f-6rOgQPFB@pc636>
 <3dd5cce0-51f9-4cf1-81b8-246e6c6a633a@paulmck-laptop>
 <53d546e4-8db0-4e14-a79d-270212081be7@leemhuis.info>
 <ags6ug97zNR6Fiiw@tardis.local>
 <agtG4JmmyH1ycg16@milan>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agtG4JmmyH1ycg16@milan>

On Mon, May 18, 2026 at 07:05:36PM +0200, Uladzislau Rezki wrote:
> On Mon, May 18, 2026 at 09:13:46AM -0700, Boqun Feng wrote:
> > On Sun, May 17, 2026 at 09:11:10PM +0200, Thorsten Leemhuis wrote:
> > > On 5/17/26 20:03, Paul E. McKenney wrote:
> > > > On Sun, May 17, 2026 at 02:47:55PM +0200, Uladzislau Rezki wrote:
> > > >> On Wed, May 13, 2026 at 12:38:01PM +0200, Thorsten Leemhuis wrote:
> > > >>> On 5/11/26 19:54, Uladzislau Rezki (Sony) wrote:
> > > >>>> From: "Paul E. McKenney" <paulmck@kernel.org>
> > > >>>>
> > > >>>> While an srcu_struct structure is in the midst of switching from CPU-0
> > > >>>> to all-CPUs state, it can attempt to invoke callbacks for CPUs that
> > > >>>> have never been online.  Worse yet, it can attempt in invoke callbacks
> > > >>>> for CPUs that never will be online, even including imaginary CPUs not in
> > > >>>> cpu_possible_mask.  This can cause hangs on s390,
> > > >>>
> > > >>> Uladzislau, Paul, according to the fixes tag below this change fixes a
> > > >>> change that went into 7.0-rc6 -- and apparently causes a "hang" on some
> > > >>> architectures. So shouldn't this be heading to mainline instead of
> > > >>> -next? Ideally with a stable tag to ensure backporting to 7.0.y, but
> > > >>> that is a separate decision?
> > > >>>
> > 
> > FWIW, I'm happy to create an urgent PR to Linus with this fix. Since it
> > fixes a commit in the previous urgent fix PR from me. Ulad, let me know
> > if you want me to do it.
> > 
> I do not mind :) So i can drop this patch!
> 

Alright, I created the fix branch at:

	https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/log/?h=fixes.v7.1

And I'm going to throw some tests on it. Will send the pull request
tomorrow.

Regards,
Boqun

> --
> Uladzislau Rezki

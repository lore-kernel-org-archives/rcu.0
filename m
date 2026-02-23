Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EE63191BA
	for <rcu@vger.kernel.org>; Mon, 23 Feb 2026 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865654; cv=none; b=EvvDeYYKRZZNEcRNg1cx2Wz/Kf7mGZrP9RMeYvdxLyqJTktyw6S6CSvk+vZm49q2SFlBuQf2b3poiwd+e1yrF9KH884LqG2ZrfA3UIJx0Jcq5atbvqlkLheh7EO5tWVoUx1lGpJiFOxY6B9szcRtOBGOpFtWZKsvs4Zk/D0RiGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865654; c=relaxed/simple;
	bh=YodYJnZuKSlNBlkEnj7GRn/UmmZhwjmLQMUg4OcMz2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSLaRqr9YbYGAQGJAyRhsgiqZl1ALbklqCfd6yO5+ZZJIEfzU7bZv43zptWkCLZxPsV77T4Q5pmFypexYJBAyYMOY+1VvY9a/HtXgPzKrypSXn7cH6mtzKw5IoWtA0lPrI0PdKMRjJaqptLK/HAvbSH+RwNJ7YDzlg80NmfqB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDElEk2t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDElEk2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46245C116D0;
	Mon, 23 Feb 2026 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771865654;
	bh=YodYJnZuKSlNBlkEnj7GRn/UmmZhwjmLQMUg4OcMz2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDElEk2tgBble4V5qOG+eLKPjopDoG4X+CBVoR8V9XhR8/HLyxKZQty0THX36Ut42
	 jzmhdIxEFGFx6DzpFQyt0fyAeL5U7MkYTL1aeMS5s74jb/e3WuByeANvvRyditqAoj
	 FfdPY1t10cRvRLIiRO/1LaJqJUd0tByErLU4z38zg96JCBGLIG26bXLnKVwtaZdbsP
	 E+pvk00UzTthSf4/iHoupYKd3mGg8X4FRm8u2OsLn3ABGWNc3Pw1+GfNpFkGh9uKH+
	 6D1twEY9OOTfE/7NBlQAmQqh42KmloYHrPBcmHL9c88XuLBJLt7Zv3nA8aeJDDuGhg
	 q5G/gCjcK8ySw==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4A523F4006C;
	Mon, 23 Feb 2026 11:54:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 23 Feb 2026 11:54:12 -0500
X-ME-Sender: <xms:NIacaW-0c_GL8CxtGfoiTvMtllLSmxRvaBl_uhNP7cKRzYaVaM8q2A>
    <xme:NIacaa9Z2yyIPRd8b5rQk3mKa673utXlRCxEg_QuEt44CkhcF8fRohy5wu56GaumI
    RxBCTfpE6O0uniO40fX10eqQAaYlUrTmjnY94s2jtdBY1Fw6mTNfg>
X-ME-Received: <xmr:NIacaY8hNKUE-pozWwlhzpGzMy9J_Mzwn-YRtmkhKwWiA184p1Rl-6Vf_Ogsvt83-bPVIQ-5BrK4ooeu1kDFGQIcHwfqsJkr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    etvdevfeffgfffhfeuvdehveffudeivdehgfehhedvvdefhfefkeehjedukeeuhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdgvfhhfihgtihhoshdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeejkeehhe
    ehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeefgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrthhhih
    gvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpdhrtghpthhtohepsgho
    qhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhovghlsehjohgvlh
    hfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepnhhpihhgghhinhesghhmrghilhdrtghomhdprhgtphht
    thhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehgrhgvghhkhh
    eslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegsihhgvggrshih
    sehlihhnuhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:NIacadJEvAILUhzzKaws0NcoCWso-5Uwot8IHehp5Ikkj4MSide9sQ>
    <xmx:NIacaVREdOgjBP5kDk-jxqHqdrwceEoLMijswym8B09p55OUCxg4lA>
    <xmx:NIacae-rqQHO55EVn2jo-qXbrk0AsKq_ROVRRQ6uS2xSkb8bjW0CqQ>
    <xmx:NIacaddT7jvmL1F32UIWqjcnsgi8KuT5KzHq1UiAfOzH4qQztKuGaw>
    <xmx:NIacaYnTgLbvGZhudsjL7qN9ONhXPFqntFdQH9MKK09qiWxJcmfXG91S>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 11:54:11 -0500 (EST)
Date: Mon, 23 Feb 2026 08:54:10 -0800
From: Boqun Feng <boqun@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,	linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,	rcu@vger.kernel.org,
 linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH v4 4/4] hazptr: Migrate per-CPU slots to backup slot
 on context switch
Message-ID: <aZyGMp7JbXPfp8Kd@tardis.local>
References: <20251218014531.3793471-1-mathieu.desnoyers@efficios.com>
 <20251218014531.3793471-5-mathieu.desnoyers@efficios.com>
 <aUR9RfVChdcDncwX@tardis-2.local>
 <bd86f598-97f9-4fc7-b426-01f08974b945@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd86f598-97f9-4fc7-b426-01f08974b945@efficios.com>

Hi Mathieu,

On Thu, Dec 18, 2025 at 07:21:28PM -0500, Mathieu Desnoyers wrote:
> On 2025-12-18 17:16, Boqun Feng wrote:
> [...]
> > 
> > I would suggest we make CONFIG_PREEMPT_HAZPTR always enabled hence no
> > need for a config, do we have the measurement of the additional cost?
> 
> Removing the PREEMPT_HAZPTR brings read-side performance
> from 13.1 down to 5.1 ns. So there is a surprising amount
> of work that goes into list_add/list_del.
> 
> I just noticed that I was running a kernel with CONFIG_LIST_HARDENED=y.
> Reruning refscale for PREEMPT_HAZPTR=y with list hardening disabled
> goes from 13.1 ns to 12.4ns, so not a huge win.
> 
> I did not notice much difference in terms of scheduler
> performance with a quick hackbench run, but I cannot
> claim it is an extensive benchmark in any way.
> 
> > 
> > I think you need to add interrupt disabling for chain/unchain because of
> > the potential readers in interrupt and then you can avoid the preempt
> > disabling in hazptr_release() I think. Let's aim for supporting readers
> > in interrupt handler, because at least lockdep needs that.
> 
> OK, I'll look into it!
> 

Gentle ping on this. I want to make some forward progress on this ;-)

I suggest we make PREEMPT_HAZPTR enabled by default and support readers
in interrupt handler. The rest missing part is an async thread, we could
utilize some code in my previous patchset [1]. Let me know whether you
think you have the cycle for this, otherwise I could add this into your
series ;-) Thanks!

[1]: https://lore.kernel.org/lkml/20250414060055.341516-1-boqun.feng@gmail.com/

Regards,
Boqun

> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

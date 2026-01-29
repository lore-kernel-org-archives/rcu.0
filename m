Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C785C30B50F;
	Thu, 29 Jan 2026 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700529; cv=none; b=EsOVlhsLYz5exoY7De9hu+eM9le8TNuboarnzWhwf9qzU/C3RwNqDtUK0B8IrrghK9ysR/lmQCK40BCNxbcVDUtio/rrXzNf30tFINht4jVTS6Q8znvZsKHbaG++SJT8vVbeEBUwNSCYrxP0WoMMrl+LIkVkqr0mq3mStJuIfiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700529; c=relaxed/simple;
	bh=N3lQmcQvjkYcHfDYb2g9UzctjgJ00wHSg6Rc5NuB8ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBhoVye5U0fFuClerNY/nFwE4f2IeybJnVIc+D+daHJeu3VeYmeqMUswlhPnoFcc8BzU65mSnJkaL31F8dzLmKZCm5lN8MkdiQ30EHZo4fjGYN4PXMiv7c1o5SeUP0TtExNiuRKtdz6yBlGUzaSxoFGaJVityOS9IzYERKZNQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3O2+Jif; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3O2+Jif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72722C4AF09;
	Thu, 29 Jan 2026 15:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769700529;
	bh=N3lQmcQvjkYcHfDYb2g9UzctjgJ00wHSg6Rc5NuB8ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q3O2+Jif9qFZ/32nid2+i7mmWCJh9i5Za/4hMISGfyJZzD7A2VZb8/GpUFm7GTub5
	 fnAn6O5YwpqhQI3tnBsMZZyYBqYf/Acmi0tWthYGoy6kdnzjKSb2XWhFYEa7saNBgG
	 aRwBlfUBC+6zU1tf5x8IPWPTWgCGm8IJEKUF0hVE9HMLh/EdQd8o7fF441B34VYgCj
	 HoNtokP/QCIKqiwMeUFwmnhPUVgzf9XFDUMAPBG7hreO8ZgNdFNLKUPielTbGNf1C/
	 Ixl8HyuxXokV3XmZuc1EAl+xPc7oh6PWdiVopjddNpZgcBlVU6+ElNWW+h6jOLBbBX
	 76CPIyL1AJwRQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 79CFBF40090;
	Thu, 29 Jan 2026 10:28:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 29 Jan 2026 10:28:47 -0500
X-ME-Sender: <xms:r3x7addvFwGxtTKGW8nrJgrpX-m54fqG8s2WYt8WyUr4vv5rdVF3UQ>
    <xme:r3x7aW4WraYxs-pNnm8coMEmOoplkC6-_P1d0ZKBtI7MVquNNIgjojmiBxb_PddZt
    3TllvaoskwL9fKHfFIgQYL24xBsUbds2TxRNAy9xcdTGG8qQbinew>
X-ME-Received: <xmr:r3x7aaL-fEVJxtpNu3z-LMa8TcTPYTONV90LCg8Icd-KUaRpqtc9p6Cl8x2IiQyq1QTam6HcchtoDsHRn15Ic_f2ATG0ZEkd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeiheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgfdvtdefieetieefueetudehffevieffkeejvdetleffledvveetgfeufeethfeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunh
    domhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeijedtleekgeejuddqudej
    jeekheehhedvqdgsohhquhhnpeepkhgvrhhnvghlrdhorhhgsehfihigmhgvrdhnrghmvg
    dpnhgspghrtghpthhtohepgedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehm
    ihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    khhmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopeifihhllheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoh
    epghgrrhihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:r3x7aXPFVwkZWFqc4e4mcAxvTLvAo5irRafig6zLnC0uYNyMWtqUQQ>
    <xmx:r3x7aXup7oAguf94O8pM_Hy16vvdzGHkH7tkVpYEE3q2VN092OuXIQ>
    <xmx:r3x7adFMda4QXLLjp2HYFFBeFZDrUHTvS3tx2MVUJLpqzbak5dBmWQ>
    <xmx:r3x7aS4SMnVUrG46vHScs6ooVRE9Ne3UJKZfeN6XborAkSSNDO2Ujw>
    <xmx:r3x7aQUg7NyV9V_x8SrlR8xIpXRUJVX2QX7yN7fFOXljvEosxvNE5jR3>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 10:28:46 -0500 (EST)
Date: Thu, 29 Jan 2026 07:28:45 -0800
From: Boqun Feng <boqun@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org, lkmm@lists.linux.dev,	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,	Lyude Paul <lyude@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,	John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,	Daniel Lustig <dlustig@nvidia.com>,
 Ingo Molnar <mingo@redhat.com>,	Waiman Long <longman@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
 Miguel Ojeda <ojeda@kernel.org>,	Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: Update my email address to @kernel.org
Message-ID: <aXt8rRabQVTei7y2@tardis.local>
References: <20260129004520.62697-1-boqun@kernel.org>
 <CANiq72=p9ZY2GWgnu=wYbNUQE3mxRsa3KMfkEnJV++X=mhTcXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=p9ZY2GWgnu=wYbNUQE3mxRsa3KMfkEnJV++X=mhTcXw@mail.gmail.com>

On Thu, Jan 29, 2026 at 12:26:32PM +0100, Miguel Ojeda wrote:
> On Thu, Jan 29, 2026 at 1:45 AM Boqun Feng <boqun@kernel.org> wrote:
> >
> > I had issues using my gmail account multiple times this week, hence
> > switch to @kernel.org.
> 
> I will apply the patch unless you or someone else wants to route it differently.
> 

Please do! Thanks for the offering ;-)

> Gmail is definitely giving pain to a few people this January...
> 

Yeah, but maybe in their defense, probably that's the best service I
could get for free ;-)

Regards,
Boqun

> Cheers,
> Miguel

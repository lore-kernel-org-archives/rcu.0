Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3273D1EB5E1;
	Thu, 25 Dec 2025 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766688217; cv=none; b=oYs/OzERpxBu0HDmUURyuHmd5qyq4Sbk383YLiFA4ZyjzbDrWAqOVTYBEOow6nRgISbUVJFOOIql/pB8qt13OBFzhxuGtlgQPo9a7qo5C6IkSxZj4t4+vGt+u/ORDoJzg3rLVEXwVonkc5RIXi2bx61kjiyNZFQ/aVmx824CR0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766688217; c=relaxed/simple;
	bh=l6NyDJxFdwzzsWCthL7bQTxYgaDejW4PTFo9MkFg0jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akSc/dEdOAtfBh/B8QOQXBhegYxXQWaJJ3YfeHYvXynbBbqrcXveMZv02L3g6kMr2smOc4A9EwY769Aw27F/95YGbM+80UbiLwQahax7z7Oxs/PtV3GzLEeDlFb4YPuRMA04bbW+P+u+zJtCp4Y4HSv3bLeKc+gHPw+F4J0MlXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8wDEsWI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8wDEsWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A443DC4CEF1;
	Thu, 25 Dec 2025 18:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766688216;
	bh=l6NyDJxFdwzzsWCthL7bQTxYgaDejW4PTFo9MkFg0jk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=J8wDEsWIY7swhuUbouJleTLeRFPRHyT73K3H28llQSXgIC6R291CXy5Cca2o7JSf3
	 B/guUbuM4QN6eOwVmczHN83l4yGuzOTE0iU9Di2S93/rCNDe9G/UGN317AbsN/XHE+
	 w32/0lluOSKxkFUUfMNoFY5Q0cHofAFANehiHv6Eas5j61g0AmCCpAudzv4w4KZ68e
	 oYu6d7tkndMOHuVb54UGr3ioOHvO6Yh49vD39+5043J6r05D2zQ6FTJF/iFG9h/inq
	 DNqJ6VelbIZtjWtD/Gqy1hqP3vqDwGMLOlSA6YpwSAZAfR2OUD+qRLV9YAF8PzmbaP
	 bZeSjL9nu0A+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 264E5CE0D19; Thu, 25 Dec 2025 10:43:36 -0800 (PST)
Date: Thu, 25 Dec 2025 10:43:36 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org, clm@meta.com
Subject: Re: [PATCH] rcutorture: Fix operator precedence bug in exp_current()
 invocation
Message-ID: <fc23d447-51c1-4916-bab6-ebd547bbfd2c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251223004407.61147-1-joelagnelf@nvidia.com>
 <4bbae00e-f078-4f1e-a1e0-b1cdc72981de@paulmck-laptop>
 <20251223113758.2c6bb15d@gandalf.local.home>
 <f99bbb2e-62bd-47fb-8cee-07716766c087@nvidia.com>
 <52bda0a7-5311-4e62-89c5-287c731548e4@paulmck-laptop>
 <086174f6-8bc9-4417-a878-ef665c0b0f10@nvidia.com>
 <fa889e55-19f6-417b-9a25-676ecfcd39a7@paulmck-laptop>
 <20251223155443.7165adf9@gandalf.local.home>
 <511ba78b-06f9-4f4e-b27b-e83428d81217@paulmck-laptop>
 <20251224091450.6ef76142@gandalf.local.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224091450.6ef76142@gandalf.local.home>

On Wed, Dec 24, 2025 at 09:14:50AM -0500, Steven Rostedt wrote:
> On Tue, 23 Dec 2025 15:50:18 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Does that mean that my intelligence is artificial?
> > 
> > Choose your answer carefully.  But don't worry about my reaction to it.
> > After all, more than six decades of being incessantly targeted by
> > advertising has made me quite good at ignoring things.  ;-)
> 
> Paul, I don't think your intelligence is artificial. Heck I usually tell
> people the two most intelligent kernel developers are you and Al Viro.

Thank you for that high praise, but I fear that you might be selling
Al short.  His ability to dive into random code and find issues is
truly impressive.  Maybe we need him to teach the LLMs a thing or two?

> Although, maybe all intelligence is artificial? Who knows?

We each can choose our definitions to get whatever answer we want.
What could go wrong?  ;-)

							Thanx, Paul

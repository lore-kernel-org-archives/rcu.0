Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171632C030E;
	Tue, 23 Dec 2025 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766533819; cv=none; b=aXgzA7t2I4qJpkm7dcifjae/rpTjeP/Ss6fcfFdo5XkdxX9veHMfjh0OXZL3p//kA0lqMrOjmsK9iwti+tnCgW/eOHj8GWqhkzRC118SfZFD0mswllvFuiEYYZGKMrdKryFXRZhmNpRZejoFMISaWf5KBab7vJWsy4HWWwTngKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766533819; c=relaxed/simple;
	bh=yWcYvdxmeMRmO1jWjXM7GqpeKQaP4/SaGEd4WPo+NnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBqtztoM83yAGATbpl8sqR0FTLS8pMErQBXO4WH3OOqC0QQt/YOXFO/lVlBZ9JR/P7aUnwvlotqHIAcxP+PXFepdSlczeFXJLTS2bslFvRwT34Xg4hwoWI71yAsKU4ZEKN4aok+/300prlUIv35SpJoKzuOg2hbYAyZReP/Gw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBHrRrx5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBHrRrx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C11C113D0;
	Tue, 23 Dec 2025 23:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766533818;
	bh=yWcYvdxmeMRmO1jWjXM7GqpeKQaP4/SaGEd4WPo+NnU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CBHrRrx5AF+u2TdiiB8lbs8plumD8IIwG0SrYGpjVTMyZ6aPtdsC4CQURF/bjAcPt
	 JRc4YfRkaW+zHWhtcqflm3GaZdun6bM6RJVZIvx5DW9aKLnD2uEQFnmfURmmdB01kh
	 d+jYVQVhx6miYZjxLt5A6XqZH6F+CuR8rASqvpDj3Qd29GoVuloWfb9fFQcyJHjY/J
	 +WAutTxUmFGHYxXYg89nHeZKcJcF0PSQu07jmQp0mUY3RGGSfQ0M9mLBqk39A6PZOW
	 cgVrVzldnzk1IINchObKW2OEPaOMoXcwkg+WpibOOkmEKoELz056JMDQDjsAxqBbJ6
	 3uTmGjG4Wa5NA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 391F9CE0D1C; Tue, 23 Dec 2025 15:50:18 -0800 (PST)
Date: Tue, 23 Dec 2025 15:50:18 -0800
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
Message-ID: <511ba78b-06f9-4f4e-b27b-e83428d81217@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251223004407.61147-1-joelagnelf@nvidia.com>
 <4bbae00e-f078-4f1e-a1e0-b1cdc72981de@paulmck-laptop>
 <20251223113758.2c6bb15d@gandalf.local.home>
 <f99bbb2e-62bd-47fb-8cee-07716766c087@nvidia.com>
 <52bda0a7-5311-4e62-89c5-287c731548e4@paulmck-laptop>
 <086174f6-8bc9-4417-a878-ef665c0b0f10@nvidia.com>
 <fa889e55-19f6-417b-9a25-676ecfcd39a7@paulmck-laptop>
 <20251223155443.7165adf9@gandalf.local.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223155443.7165adf9@gandalf.local.home>

On Tue, Dec 23, 2025 at 03:54:43PM -0500, Steven Rostedt wrote:
> On Tue, 23 Dec 2025 09:51:19 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > On Tue, Dec 23, 2025 at 12:30:01PM -0500, Joel Fernandes wrote:
> > > On 12/23/2025 12:28 PM, Paul E. McKenney wrote:  
> > > > On Tue, Dec 23, 2025 at 12:22:51PM -0500, Joel Fernandes wrote:  
> > > >> On 12/23/2025 11:37 AM, Steven Rostedt wrote:  
> > > >>> On Mon, 22 Dec 2025 17:12:18 -0800
> > > >>> "Paul E. McKenney" <paulmck@kernel.org> wrote:

[ . . . ]

> > > > Adding Chris on CC for his thoughts on whether it was him or his AI and
> > > > whether or not this matters.  Should he choose to share any thoughts on
> > > > either topic.  ;-)  
> > > 
> > > "Was it Paul replying here, or was it his email client?" ;-)  
> > 
> > "Yes!!!"  ;-)
> > 
> > > Sorry I couldn't help. :-) What is a Christmas holiday if not for poking some fun?  
> > 
> > No problem!
> > 
> > I was half expecting something along the lines of "Is Paul an AI?" ;-)
> 
> I guess that begs the question. Is your intelligence artificial? ;-)

My many teachers and mentors along the way would likely argue that
they made a difference.  That would suggest that at least some of my
intelligence is created by the efforts of human beings.

Does that mean that my intelligence is artificial?

Choose your answer carefully.  But don't worry about my reaction to it.
After all, more than six decades of being incessantly targeted by
advertising has made me quite good at ignoring things.  ;-)

							Thanx, Paul

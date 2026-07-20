Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC243B3EE;
	Mon, 20 Jul 2026 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566544; cv=none; b=S7SxESHjwTr83LOcWExjDfchCE+9UQRU9zTExTj4l8Poavuo5JMGaADIDQb4Fk2VEJhkmEzoOh1PK2pxnymCaBYsia5MK9qKKhn3ubzBCKjbaSbpFmxE86KQVi+yypbNg3z+2O49TO22V5V8/5hgpazTRzW9prSil943dhr/zhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566544; c=relaxed/simple;
	bh=AubKSU3dLsPzm3qNcyZZd+4XouIFlKAGmaeIvVSyLaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIiq/6VZIy5d/6ATvSp3IaS2zpf/op8o6GKDF8zq9K2T/q5H5DdXmubpsZo85Mi2b3gy7m+slPOCXl9F/cMB5PaIERqu1YzWoXOYAvW99RMIZ7bFwsWN/4sYLoWtIIJcL5sGui4NK78Vtx0w4D9GnbkIvwECxeNCyHSttyisXQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2aIIh9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2aIIh9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E357B1F000E9;
	Mon, 20 Jul 2026 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784566542;
	bh=+4VUlVgc7+EubpcqvcLFxntuQI31LVXsFkyms9nAtdE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=P2aIIh9cNQ89sgbFowQNjn4BY7RSrgY6FySizmJ6s8FNihNCEu27OQGTbsss0vDZO
	 QB3EAPi7AiA71M0NWTrrVRWTVsnTBuUAGstRyI6w7ze9x3OW9b53T4WpfQEhKbTa5O
	 KGofX0yVNH4eOfQJEzaglHn9IlN2pxTw1RJ13K9922xczUTSU2kwd3+4C45Zm1tIdu
	 LD7eNqTIyc8Cyt8qT4f0vwwy1mktl48jXtJ5pVOhPM6X6QZ4WMkwIlmhHehjTwHJdW
	 wFdNB6GbMLTQ35fYVBlEibk3BKSmYXcbz7F9FUMJznfb5GeGpWi7jD963GWbnje+fy
	 FFkOYkVIKzEDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AE9ACCE0C57; Mon, 20 Jul 2026 09:55:42 -0700 (PDT)
Date: Mon, 20 Jul 2026 09:55:42 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v1 06/11] rcu: Enable RCU callbacks to benefit from
 expedited grace periods
Message-ID: <cf1a3ffc-ed2a-41f4-bfd2-cbeab9d06861@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-7-puranjay@kernel.org>
 <alD6o01ukyliCS37@localhost.localdomain>
 <6c683413-8e8b-4888-ba01-9d79c3867432@paulmck-laptop>
 <al4vKQ02tBYyYANk@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <al4vKQ02tBYyYANk@localhost.localdomain>

On Mon, Jul 20, 2026 at 04:22:33PM +0200, Frederic Weisbecker wrote:
> Le Tue, Jul 14, 2026 at 11:48:08AM -0700, Paul E. McKenney a écrit :
> > > I have similar concerns about the three smp_mb() in
> > > get_state_synchronize_rcu_full(). It could be just two (rcu_seq_snap()
> > > has a barrier that could be just one). Not sure if that matters but,
> > > just wanted to point that.
> > 
> > We need the one at the beginning of get_state_synchronize_rcu_full(),
> > but from what I can see, not the ones in the calls to rcu_seq_snap().
> > I blame laziness.  We could make an rcu_seq_snap_no_ordering() that
> > didn't have the smp_mb(), but I didn't believe that the overhead would
> > be visible at the system level.
> 
> It isn't so much about performance than being clear about ordering
> expectations. Though we could argue that grace period polling can be
> about performance.
> 
> But in general rcu_seq_snap() advertizes:
> 
>    READ seq
>    smp_mb() /* Above access must not bleed into critical section. */
> 
> This doesn't tell much. Which critical section? That's not used on
> read side.

Fair question!

And the answer is "any critical section that might later be executed by
the current task."

Would it help if I made that comment read as follows, separately from
Puranjay's series?

	// The above access must not bleed into any later RCU read-side
	// critical section executed by the current task.

							Thanx, Paul

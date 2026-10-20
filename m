Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521408;
	b=bxnE/wK84YkVHGsnDiBas7l21qOSS1UaqlP9SK52HdO5CnmMDW/r3nZI00vv6RX/MfyW
	 O7IpapylTH6Py6ZeUtJTKIvCZcOlof+gNvb5qZ36lCATuJMpkphI60O9sQaXZxLrb2RG6
	 iY9UGaL01DNHUlGLf4UA7pz5S0Nc7oPIwqO1Gfnem+TnFvGF9moH+xILGMJOfEzqxcnk6
	 bpfSCU6hRoo5mZHzooZ4JIE4stzOyV/e3vlrAIlAZvq0HB9/IhtpfljQ6qhW0csZ5sJAI
	 A5OLSh1h7WZ8lxDkhtiqjoYR0wxYARR6KHewU/U/WJY/4qe90tqsg92JcQ+LZQdKfUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521408;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ouWjU4tQYCPGaaITYf8Wcp+WRi1h9s1tRN92zBpbxMo=;
	b=dQpjR1XP3PuhsafLZ5Db5WcY11G7kHmKZ/+WNwVhX6rwLetpCXcMdYdnL7ojoBZsUy9q
	 3/wKnt9fdC3hnUPow6/SqI5NhWLvOIkMZWJ5I1vrEwqmBHAPP1CWrU9LkwB7JYk5NMqCf
	 +cWZ0TeJDu+xuorON/7Z9UygNH3KpPi9g+Wu0hCuseNTshHgGWvvpd0ezBS2MfR+BvRfb
	 WLiZTt4H4MthPqNCkZZ67NKbPVRY1J9h0Pg/WC/pFp/D3dCky3z361w0FkUs2IdAHdfw9
	 j4RMub9SRNPOyY50nfJE62UXtAAyn84QPn/aJu/vHGaBg6e1q1qu3OQJ5jDuAXiprSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeJ87ine;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104E606A319;
	Tue, 20 Oct 2026 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeJ87ine
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A011F000C9;
	Tue, 20 Oct 2026 18:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521408;
	bh=ouWjU4tQYCPGaaITYf8Wcp+WRi1h9s1tRN92zBpbxMo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=YeJ87ineRpDBRmOg34ZDDeb3tvaGFxcbkw+4K3Q0Z5tK0ozhKcEHyP90wJps8Monc
	 zw/PtMX2sdkSAY6tVQwUgE9XlwzAeMBL5hTxtMEoi2QLvw2Dz3dXpN3rKSB2PQ0UC/
	 vQABkdK0PxHvDFjYJ72muumP5ixYMxoLec1slb/Fr3ypTzXEt9BPWuHk/Wd+Zlx5D6
	 2dUd7Jh8PSDVlZ3XzTBeokGSY9eBnrU5ywn/8cj+JSY63WopfpWAcB2GopV1HNr7KJ
	 W9svEMAsDU4R2SRTsWcQBpSOXERzUfgZa+w3K8gMwJ4jKTUACDMZh/RFBljgl21NGs
	 VfRbDJbLqGPIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C7352CE09E8; Tue, 20 Oct 2026 11:36:47 -0700 (PDT)
Date: Tue, 20 Oct 2026 11:36:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Bradley Morgan <brads@mainlining.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Kunwu Chan <kunwu.chan@gmail.com>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC -rcu/dev] hazptrtorture: Release all deferred hazard
 pointers before stopping
Message-ID: <c0540cf0-32ba-46e8-8648-23b70936fde7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261019162005.12888-1-parri.andrea@gmail.com>
 <AFA8DFD1-7D1C-49FD-BE53-95747FE4302C@mainlining.org>
 <20261019173230.73558-1-parri.andrea@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019173230.73558-1-parri.andrea@gmail.com>

On Mon, Oct 19, 2026 at 07:32:28PM +0200, Andrea Parri wrote:
> On Mon, Oct 19, 2026 at 05:22:54PM +0100, Bradley Morgan wrote:
> > On 19 October 2026 17:20:03 BST, Andrea Parri <parri.andrea@gmail.com>
> > wrote:
> 
> [...]
> 
> > >Fixes: f23d7b47ced9 ("hazptrtorture: Add kthread to release deferred hazard pointers")
> > >Assisted-by: LLM
> >
> > Why not put this into a series?
> 
> The two patches fix unrelated bugs, touch different files, and apply in
> either order, so I posted them separately.  But both are for -rcu/dev,
> and the test notes in the hazptr patch rely on this one.  I'll send the
> next version as a two-patch series with this patch first, unless Paul
> prefers separate submissions.

I am fine either way.  But whatever you do, please do *not* put them
into the same patch.  ;-)

> [...]
> 
> > >+	/*
> > >+	 * Run until hazptr_torture_cleanup() stops this kthread, not just
> > >+	 * until torture_must_stop(): the writer can be waiting in ->sync()
> > >+	 * for a deferred hazard pointer while it is being stopped.
> > >+	 */
> >
> > Could this be shorter?
> 
> Yes.  The comment in hazptr_torture_cleanup() already says why, so this
> one can just point there:
> 
> 	/* Keep going until hazptr_torture_cleanup() stops us, see there. */
> 
> [...]

The longer one is better.

> > >+	/* The readers have stopped, so nothing new can be deferred. */
> > >+	for_each_possible_cpu(cpu)
> >
> > Is the comment needed? I don't know if it's nessesary.
> 
> I'd keep it.  A reader can defer after the last pass in the loop, and
> kthread_stop() can then end the loop without another pass, so this
> pass is needed; the comment says why one pass is enough.
> 
> > >+	/*
> > >+	 * Stop do_pending only after the writer and the readers: the writer
> > >+	 * may be waiting on hazard pointers that readers deferred.
> > >+	 */
> >
> > May we shorten this? Feel free to bikeshed that one.
> 
> Sure:
> 
> 	/* The writer may wait on hazard pointers that readers deferred. */

And same here.

I am sure that it is possible to create shorter versions that keep all
to the information, but I am OK with Andrea's original versions.

Bradley, Andrea is not a native English speaker and I believe that
you are, so if you want better wording here, please provide it to him.
Perhaps someday he will return the favor should you ever be required to
write in Italian (or German or Ladin, for that matter).  ;-)

							Thanx, Paul

> Thanks for the review,
>   Andrea

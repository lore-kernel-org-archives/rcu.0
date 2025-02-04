Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03F62054EE;
	Tue,  4 Feb 2025 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738700575; cv=none; b=dNcIR4X5oLf6vnU+ICFKaQejmswEXHGNdvPPa1PVgQ7VglQFHDA8aC6ktJb9b+yxhV/5PbDXf7qE5aH0DExWZJTCCtWYKYwU4hbZP3QxxAGv4S/IWV2hNLZTCHDM05isxjLBqZk2W/cfMLPmMpniptzdTknCSuvpkmmJ4dtU4Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738700575; c=relaxed/simple;
	bh=6pDWVXlpf3owYG4nrbk030+L2zdJkaTJsYmKtyvi0n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmBSF+q+3sDwWF2EZEa340mAuT5/EKiVrxLpcB1GDaVkGlXF12WaB4xUXYjFEyHCWhp9JdtxoOKVF/qqzJ759s114K3DCgxPWz4D+jpGrow3K3qdMb723lyoHBwo+JDf2t9VOP3cMvvV0Me/wmkwauZ3Na36H2iZ01W90U0ze5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq+gDRdi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq+gDRdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389BFC4CEDF;
	Tue,  4 Feb 2025 20:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738700574;
	bh=6pDWVXlpf3owYG4nrbk030+L2zdJkaTJsYmKtyvi0n4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Yq+gDRdiTyzt9y1UrRVJCl9AMSHhq+EeWtbqaNyyv87Brzx20mnbJVtedBcGECjs6
	 RYwPbtlz7e/2scXrVBAeTJhyxtQli4uoMAu5issTexgpU9EzQ5yuRbBUE5i6VgEXMO
	 MnixCSxbZo8VjT7bT7wze2jBxNmyxIkiQhKUKepIr0YUqWjo1+W+eveD26tD2xzWB8
	 d4oeLmOSWw47G3LlKsGY1XYCpfL3YPIltf5rWS+PnuUv7Qr7Nq9kNdadsWEmI0EkFy
	 af67y+/BVd0lo0w2Bv/HK83xniM859HUbzjstLXVDHN8XsGmGobKIKQAwcbgDyx2HB
	 YyQkpB3BrgiMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CA170CE028A; Tue,  4 Feb 2025 12:22:53 -0800 (PST)
Date: Tue, 4 Feb 2025 12:22:53 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Merge rcu_seq_done_exact() logic into rcu_seq_done()
Message-ID: <999751de-b891-424d-a7b5-80bfa98793ff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ecce7241-4238-4d86-8e4c-5080937129ce@paulmck-laptop>
 <15D1150A-9B7B-4EB7-91C6-2D881D6F48DA@joelfernandes.org>
 <861f1dc3-bfc0-4a81-9b78-c8e9995db4cd@paulmck-laptop>
 <CAEXW_YQ4W=upWV_x1woSgq-DJPFXmBjH2pVmUnBVb_n_UKrw7A@mail.gmail.com>
 <ec293223-2a33-4d2f-b3ca-c011c3d987f3@paulmck-laptop>
 <CAEXW_YQXgZANSjo835VfHMqY=z8gaSWQ2bgaWtVd4-3KX0hX8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQXgZANSjo835VfHMqY=z8gaSWQ2bgaWtVd4-3KX0hX8w@mail.gmail.com>

On Tue, Feb 04, 2025 at 10:44:45AM -0500, Joel Fernandes wrote:
> On Thu, Jan 30, 2025 at 12:56 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > By "where we were initially", one might reasonably guess that you meant
> > that the initial value and the target are one and the same.  But I suspect
> > that you are thinking of a third value, the value of the underlying
> > grace-period sequence number at the time of the call to rcu_seq_snap().
> > But you might be thinking of something else entirely.
> >
> > > Now we move rcu_seq_done_exact. It has the exact same behavior except
> > > that instead of ULONG_MAX/2, the above situations are shrunk to about
> > > 10 counts from the target. So if target is 28, then the initial
> > > sequence should have been at least 18 to avoid false-positive, but
> > > again it is possible and I certain see in the code that it cannot be
> > > used this way.. (at least so far).. So all we are left with is the
> > > false-negative band of ~2.5 GPs..
> >
> > Here, I have the same questions.  As you no doubt guessed.
> >
> > > About "what are the consequences of failing to get this right".  I
> > > believe false-positive is unacceptable unless it is maybe debug code -
> > > that can break functionality in code, too short GPs and all that.
> > > However false-negative is OK as long as the usecase can retry later
> > > and can afford to wait. Did I get that much correct?
> >
> > Maybe?
> >
> > Please look at this on a per-use-case basis.
> 
> Sure. FWIW, I started a world-editable document here. I am planning to
> work on this a bit more before our meeting this week. If others
> knowledgeable like Frederic and others could make edits/comments,
> that'd be welcomed. But I basically summarized this whole thread here:
> https://docs.google.com/document/d/1sFNuGH4U6DFCE8sunbdWMjFhJhb1aG4goOJAnS6c6gQ/edit?usp=sharing
> 
> My thought is (AFAICS), this patch is still valid and
> rcu_seq_done_exact is a potentially better replacement to
> rcu_seq_done. But famous last words...

Let's start with the use case where the sequence number is being used
by rcu_barrier().  What happens?

							Thanx, Paul

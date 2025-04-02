Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86AB221DB2;
	Wed,  2 Apr 2025 04:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743567882; cv=none; b=U6SMsaha2ZWYkkAXe9wGz+ZfBZklliCrh77gqpZP7n53umDC69vHUBT2QiziHoXDo2SSl8qcJgoCNlvasIEW/s0GblpmQ0RXGQcjHBCnJ26ZJ7CY2+QHVQyEpZFoCZZM2svp1te84k/FqenqzaJhC8albJWahYcO2GasGKIAbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743567882; c=relaxed/simple;
	bh=iPerpFKBLSUX7o746DNeTHUueumGD/t3jLh+gLiQEoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es0kTD3v2P5TAVW4cq0Xpdst1HcHMGNxAmucBAcCvKB1X4rFoinqdPW3M4e/xyns3d8UaY0wp/FNLTOgRhgXuEd2gMoIyF3xMAfNbzWEgW+YifaXFpXv4fSqM3BAz1ELxwVGvC4LiyMKb/hNyKJU1XXLLYyNZHal98swxdcjlJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+qQFvLG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+qQFvLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573A1C4CEDD;
	Wed,  2 Apr 2025 04:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743567881;
	bh=iPerpFKBLSUX7o746DNeTHUueumGD/t3jLh+gLiQEoY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=L+qQFvLGRKQi2C8vUF5KHsY9EJ4oNfZ9cVRrZ4LoKJnhpINUmg2+tXEsNWnbK31xO
	 lvKaNu38SwTbvEQJLZ4yM1i6wPLVPbfhgYpEjOi34aSMVHGfF4Ti/0dyjcYMPzMwXI
	 be9sMv5z3lcgD6kD6fcbXSVWFQ5fiDRPJKzaB7Kooxm+iIEqYMjmsbaLXLcVqexxGe
	 3RnJkCF9jLXZ0a7uRs4JjCVdFaIMA+SId+FEG/OGwhoCvdkWp0Z7DXPxPuKZ/3kI4n
	 pZOZZ4Nus9W/lsvS4/34ioYqFhm+FF00ni+0/4s6Ixvmt+tp4+HnJAUOBpUGy+OSBA
	 sSheyM4301BCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 09129CE160D; Tue,  1 Apr 2025 21:24:41 -0700 (PDT)
Date: Tue, 1 Apr 2025 21:24:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/3] rcu: Replace magic number with meaningful constant
 in rcu_seq_done_exact()
Message-ID: <aaa33a2c-099f-490a-8054-02dcf4f88ef2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
 <20250324170156.469763-2-joelagnelf@nvidia.com>
 <eeda52c2-5397-4aad-ad01-ca04e5b0b80f@paulmck-laptop>
 <DDDD275D-1017-4189-9A8A-578021A33B4A@nvidia.com>
 <e47e5611-36de-4d12-9c07-57aa2a885299@paulmck-laptop>
 <Z-nBcg9FJqu5RzME@pavilion.home>
 <71fc9642-5fc7-45ec-8196-8fc89ed8e765@paulmck-laptop>
 <Z-sFonl2NrppdGQS@pavilion.home>
 <bc4d930e-60c2-4ff8-8995-d463b6365b00@paulmck-laptop>
 <Z-vsTRydjIAK-4-d@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-vsTRydjIAK-4-d@localhost.localdomain>

On Tue, Apr 01, 2025 at 03:38:21PM +0200, Frederic Weisbecker wrote:
> Le Mon, Mar 31, 2025 at 02:29:52PM -0700, Paul E. McKenney a écrit :
> > The disagreement is a feature, at least up to a point.  That feature
> > allows CPUs to go idle for long periods without RCU having to bother
> > them or to mess with their per-CPU data (give or take ->gpwrap).  It also
> > allows per-rcu_node-leaf locking, which is important on large systems.
> > 
> > Trying to make precisely globally agreed-on beginnings and ends of
> > RCU grace periods will not end well from performance, scalability,
> > or real-time-response viewpoints.  ;-)
> 
> The distributed disagreement is definetly a feature. The duplicate root
> is more debatable.
> 
> > But simplifications that don't hurt performance, scalability, and
> > real-time-response are of course welcome.
> 
> I'm not even sure my proposal is a simplification. Perhaps it is. Another
> hope is that it could avoid future accidents.
> 
> > Indeed, this probably needs actual performance results showing that
> > it is needed.  My guess is that only systems with a single rcu_node
> > structure that is both leaf and root would have any chance of noticing.
> > And those tend to have few CPUs, so they might not care.
> 
> Do you have any idea for a benchmark to test here?

The best that I can come up with is hammering with a combination of
expedited grace periods and polled grace periods.

							Thanx, Paul

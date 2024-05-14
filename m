Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA1320F;
	Tue, 14 May 2024 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688568; cv=none; b=nSIvXk2WDPFW9ns2KfKMQjwfvT+KsiXtZDIjRm1v1aF7fY+4x+EXJP6p224LyF8HEJ0f5z2yXDJPqVIUfSTSgGObGAIBGFrfRIUUvBPb0oKfubQLLXIj3SsL6xDBWtEUdASmSouTE9ou6ylxMU0XmpVDY8pASfvpEMIk8QpxFRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688568; c=relaxed/simple;
	bh=iXjrw2SdjuQ3DLboGS0Vp8JyExJQR3Gg2I+FL4ICjZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEHxHXyC+mZAown/6Ii30x8wGsFMgQmvXFjSOwD8g76+IBiZu8l/0GfHo5jxzqsYAq/ybPSFPht4yuaiXpSa/MEx/i6/9Uv8k2YyvgV1s+1d8ULsjH+iwxPrlCsmrC/oJUpQ5zyqM3w0w5QFQ102y5kdoc1s0aGGz3QWlF/qg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eivisrfS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eivisrfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575CDC2BD10;
	Tue, 14 May 2024 12:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715688567;
	bh=iXjrw2SdjuQ3DLboGS0Vp8JyExJQR3Gg2I+FL4ICjZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eivisrfShAh0GBBOLjm2tGNzmKyE15omAS09heBkU2y8ELEp2QGdrtis7yKHrmr6b
	 y7aH9XkMGAVzI0QP+34bZRPgVqb9lph+U1GyQwiMp5E6hWVIQgmFGd/0Nq/NiDBfMC
	 9NIrp4PUNfJrNUNh6JpEzgj3Q0b2r8lQdomB8QhWI+IGQLXcJL+fMKla5WRJws1qXl
	 tn5+MGBZKFROpz8dSloGP+UyNWQ/9/Ry4YFA+3uPlshIISMIPy2/F13iarsH/Rgi0Q
	 xX9n1/nvRcrl/ud2Ze/cHEOL5vX1JCJhBKcDkuePbUAtT1gbW1JYW70hPHlKkxR2ca
	 s9hSIvbAH/l2g==
Date: Tue, 14 May 2024 14:09:25 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 27/27] context_tracking, rcu: Rename rcu_dyntick trace
 event into rcu_watching
Message-ID: <ZkNUdSZ6s0mJpV91@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-28-vschneid@redhat.com>
 <ZjuFUZXk4rYO4L2v@localhost.localdomain>
 <xhsmhr0e5h7x1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhr0e5h7x1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Mon, May 13, 2024 at 08:40:42PM +0200, Valentin Schneider a écrit :
> On 08/05/24 15:59, Frederic Weisbecker wrote:
> > Le Tue, Apr 30, 2024 at 11:17:31AM +0200, Valentin Schneider a écrit :
> >> @@ -228,7 +228,7 @@ void noinstr ct_nmi_exit(void)
> >>      }
> >>
> >>      /* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> >> -	trace_rcu_dyntick(TPS("Startirq"), ct_nmi_nesting(), 0, ct_rcu_watching());
> >> +	trace_rcu_watching(TPS("Endirq"), ct_nmi_nesting(), 0, ct_rcu_watching());
> >
> > Ah the initial string was wrong and you're fixing it, right?
> >
> > Should be a seperate patch?
> >
> 
> No, I'm just creating confusion for everyone involved (including myself) :(
> Dynticks start when RCU stops watching, so the naming logic gets flipped on
> its head.
> 
> If I take the original comment from
> bd2b879a1ca5 ("rcu: Add tracing to irq/NMI dyntick-idle transitions")
> """
> as argument: "Start" for entering dyntick-idle mode, "Startirq" for
> entering it from irq/NMI
> """

Oh my!

> 
> So here "Startirq" means "start dyntick mode from IRQ". With the name
> change, it should be "Endirq", since RCU stops watching, from IRQ...
> 
> I know, a lot of confusion for 0 functional change :(

Ok your change looks good then.

Thanks.


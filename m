Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425758;
	b=bNtEx8+dbWGRhGuK/TkInZ8FXyZ7q9AzWlhXhoxHGOss31aLKDTKXqLBhaLLt+A/McRT
	 yzXq2kH0R9R3mfcRSxTHkvYNjdnCTOZnapRtcS7zohWtAN34eHKLK9wqEei6yKnqPEVsI
	 3AWQTZLXmqndT4Xq0B1YrIzwStdmSG2Bj0BYywLNu+A1V9aLum+bkGVwxMYPmp7JGJiNE
	 beMozezXZLepv+svVqTFM2FPsASqpIfjjqwQe0bBy/4eI8uGMyd6Bl1bk3txDVi5g5gDX
	 fsdOrFRyVf26oXHPGTWlZPl9mE/W2CfWJEzCsbUp7iwgP4f3cnKvdG8/tKoRSION5Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425758;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=z8cbzXrIWEk900tpqfaN9UC9CWFZqvU+Ez1faa3vOsI=;
	b=vlSQo+F7g3NpP7XFbkkg/MCUzi3pUD9Usc1HcFb2BNbQcaAA1Rg4xzEjkGW/Wqm1WBKt
	 bfImryn7PsqlYe0emhlVqJz7ZzvY29fvc6K2Y0cQxbHqov3olof4zb7HvBoimZNV7KUfl
	 56sAuKbsNJwrCPamRkuQI3G3eqdSfoV/AnFzMiUaLAnG5umRpiVdzyOhHWk4h28qq2fNq
	 IXyIHTOBBVvxShey4XspaEhtiGe4WxPvHr9/NZI0ap8W9LO2OJf6WKe3zHHNjekGCv8p2
	 ShC/fcK3mer7qmKT08UXvIXK2gZbevl5lwDKrrWz8I1Gh+zDpzX1F1qLOVeoEnAFZPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnR2KInV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5020F606A324;
	Wed, 11 Nov 2026 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnR2KInV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D993C1F00A05;
	Wed, 11 Nov 2026 19:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425757;
	bh=z8cbzXrIWEk900tpqfaN9UC9CWFZqvU+Ez1faa3vOsI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=AnR2KInVdsFrGhjTEqGwyNDITpg0kivZxi2abKWAn7q6AJTGizUlxmPQjXelyh8GS
	 uYJIhf0/wiHfpDSxS4UOCOlPeTFfVaRnrY80Bin+mBzw+tywUip2r9A6Ey34FvxXmi
	 ePtS8Qqi6GuF6W0JYtsWowOk9UwITig3nyT68dr4fZuuQT79FEDqnNMp754/qdFaup
	 dfb2mNBvPbaB0BYD7ikvut3ARjA83zMo0d82nviDBCCLJ46NeJIw1gWbL7BZ75fNG0
	 oaeyRBqnCPG9kcoI44d4/rBr9ngwHe2cIc8b+5gdi9YjV0dIwUpHg8BTILynnNCd3B
	 p2aCOCCLOo1mg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A3F7DCE08D1; Wed, 11 Nov 2026 11:35:57 -0800 (PST)
Date: Wed, 11 Nov 2026 11:35:57 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2 0/7] srcu: NMI-safe atomic SRCU readers, and their
 irqsave forms
Message-ID: <5f8ba6c7-28b5-4a7b-b366-1476d0b460b0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <50d177ddb1de4b84e9fd2cbd2ec5bdb7e32845d4.camel@infradead.org>
 <0782c3e7-9766-440c-b21e-e89b822927ee@efficios.com>
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
In-Reply-To: <0782c3e7-9766-440c-b21e-e89b822927ee@efficios.com>

On Wed, Nov 11, 2026 at 02:33:18PM -0500, Mathieu Desnoyers wrote:
> On 2026-11-11 14:02, David Woodhouse wrote:
> > The latter claim is only true in __srcu_read_lock_fast()/_fast_updown()
> > isn't it? Not in the atomic-SRCU. Unless we do something like this on
> > top?
> 
> It is true for the atomic readers as well.  Without
> CONFIG_NEED_SRCU_NMI_SAFE, include/linux/srcu.h defines
> __srcu_read_lock_nmisafe() as an inline that calls __srcu_read_lock(),
> and the same for unlock.  So x86 keeps this_cpu_inc() and smp_mb().
> Your diff selects the same functions by hand.
> 
> Only the architectures that select NEED_SRCU_NMI_SAFE get the atomic
> increments.

Even better!  ;-)

							Thanx, Paul

> > I set a test running (*without* the above).
> 
> Thanks!
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

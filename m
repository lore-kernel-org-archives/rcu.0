Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858501;
	b=e6ddhIDlO4jydGiT7bK4Ck1VaLjG0ijcRAP9ju8jc15LVGWUN3uRaedpkhwia0wp6N32
	 WCW8eu52qBDdTw3eXRNe/kk7LNQGRsIyjerKqQCRdhgq0xG1QvA67fFLFMprCA2cdknIt
	 SC0TLv418S/PL9JqG3yo/n57skwfpbLYuSUTlipe40BZxsGquKhFvsu5lOH8oC0jD0+hH
	 Gtd8YWAUCKHlLR7P+bcyEsVamL7myGglpBe1f0QY/mWYORONUnJV7+YXRWkCLgc345osq
	 RzXZ4pC7pPpjUcYs+Qgvmml3X0k0XumlAMIda3Pn2FLnSeuEiPfB6HhXcrLSE0AXf0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858501;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=NTJxvN6eVCRH9bYjo5+5T3IwZyMatLdqQn+ZAt89TIc=;
	b=FlmBNG1Z1QGKPILZvRi5TR19ziHpizdWS2k7b5nP0/TERCnmps+I8UCIHRoeCW3vdkN6
	 gmDT4iBqVAS9kEDCesJpsCXlrFoL8mqe/WJgCmk/JL0hIkLcGHkVj1xL86FT/DuH2W9xR
	 KI4Xl0cqDkZOTWGxtgJGdcqqa9ukQd75TF7BIg9gUD9BA7tK1sKXM7uF//RIOGOZ707ge
	 B3oC2HY50xKpJY2I/wT058Zn9HuWVNx0JzvErDi9aeKpB20Jj1LeOAZvCkLOoUV2guXm5
	 CMBrO407KFpF2oXHlJpRsqInv3zgCFoY+xKZm00gWvOxkly+pSKODjpPmKBS/Tz5m+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkdAc24K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD81606A322;
	Mon, 16 Nov 2026 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkdAc24K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F3C1F000C4;
	Mon, 16 Nov 2026 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858501;
	bh=NTJxvN6eVCRH9bYjo5+5T3IwZyMatLdqQn+ZAt89TIc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=hkdAc24KoXrS9Wo07IgWag2ZQQSuPPvp1/gwGqKqn4jrtCrHSG1wv9HC8UWnVkTBO
	 iwgidp9zMDxWT8RqAVAR2j1Fw6pigvbxW3SrnSphNOlYAo3QaWeS96lukZAAOqXq1T
	 zmC6/koKylG8mFSyee4UQP8rfrsjU9FJs9UPc9/RhYZW9Ych2+Wff62dBcojSh/2Se
	 P5oNC8N5imW9rsUT/IpWUSXLzRlL/INTlbwxPNCIkhoXAdwRjf+JZ5W/cGlCirinIg
	 POczF+rc5rS6pS8Op7Wgw3H8NW7TjZ70MObfxMLUI2iGaXXgE2DFNADD3FpN8DSZbx
	 0lcen3Y4tiu9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6C128CE097D; Mon, 16 Nov 2026 11:48:21 -0800 (PST)
Date: Mon, 16 Nov 2026 11:48:21 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <jfern@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/6] Additional miscellaneous RCU updates for v7.5
Message-ID: <e173f3b7-de3b-4b3d-b0dc-c12a091c9723@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bf761cab-7423-464b-ba8e-bd39ad0eb089@paulmck-laptop>
 <20261116190040.GA946893@joelbox>
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
In-Reply-To: <20261116190040.GA946893@joelbox>

On Mon, Nov 16, 2026 at 02:00:40PM -0500, Joel Fernandes wrote:
> On 11/16, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > Hello!
> > 
> > This series provides additional miscellaneous updates for v7.5:
> > 
> > 1.	MAINTAINERS: Add Puranjay Mohan and RCU reviewer.
> > 
> > 2.	Make torture.sh test NMIs for atomic SRCU on x86.
> > 
> > 3.	Avoid duplicate identify_qemu_vcpus calls in torture.sh.
> > 
> > 4.	Make torture.sh test NMIs for RCU on x86.
> > 
> > 5.	Make kvm.sh ignore empty-string arguments.
> > 
> > 6.	Use ${:+} to save a few lines in torture.sh's torture_one().
> 
> Thanks, I will apply all except 2. and 4. as they depend on Mathieu's series
> which is not going in for 7.4:
> https://lore.kernel.org/all/20261112133731.127221-1-mathieu.desnoyers@efficios.com/
> 
> For the others, I have replaced patches which were already there (in 7.4 next
> tree) with the new ones you sent, with updated tags.

Thank you, and apologies for missing that dependency.  Distractions this
morning.  ;-)

							Thanx, Paul

> thanks,
> 
> Joel Fernandes
> 
> 
> 
> 
> > 
> > 						Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> >  b/MAINTAINERS                                       |    1 
> >  b/tools/testing/selftests/rcutorture/bin/kvm.sh     |    3 ++
> >  b/tools/testing/selftests/rcutorture/bin/torture.sh |   11 ++++++---
> >  tools/testing/selftests/rcutorture/bin/torture.sh   |   23 +++++++++-----------
> >  4 files changed, 22 insertions(+), 16 deletions(-)

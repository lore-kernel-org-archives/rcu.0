Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0213C3FA;
	Tue,  7 May 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089701; cv=none; b=PHK54a8vTKe4rGCV6IwDAmeXb6OyXtgg+1vjQGVQN0dUIn1tyV/YQSJ5pEtP+IFNHtXyJF+ATmgFW+A1Kmwx9TGElvywGFW6UsWC7HETVFnlxvlPhW3je0rJ5htSpB6suxhXfNOoPvmD37ty4awlCIHXApCvrJVtUnRdhvGWfAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089701; c=relaxed/simple;
	bh=+JnVkJ/DcmtF++oBXep2XfQOhJAgJTlRFNVTNBDM/Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUadxnJ638Mm+kIcM49Z8G1FYkCXb9YtBRp7Q7lRSfaFZyjhkHpGhHMno7dd2DgUvn+PB4APva/A+/j+1HDy19A1pdu7psY4buzHSRRKynzb0VDGCpvtAl3DV026gDa9q3FG/n84TACOG/TpOvSA0y9aR+h/sO29r1fvMHnZ1bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAjqF1d9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAjqF1d9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EC5C2BBFC;
	Tue,  7 May 2024 13:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715089700;
	bh=+JnVkJ/DcmtF++oBXep2XfQOhJAgJTlRFNVTNBDM/Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uAjqF1d9EG9EYBgOPPCxw2xFDVNjHOr1ObHDHvILc1AkJJVvpNT7pwmazxkUmtlzR
	 CpXw2Bekil7em9ppS4Od7qTonPrs0GQtxAzzM/rcvi5XpX6lb+r5jyA1UikMHbJBOU
	 LaKbBArTAOtVAofLOVh0q2nFGOmsdk7eRPPSRSkVU2exICz5La/12Ye4328Ew2zIbB
	 DzW5hlfPeapryWv2dkWxF/KHQhpoLsuym8OOgCaeNRABA7O1sVOm0eTuCzGIORLMda
	 RbLiqAq62gtb6tU8GNk+7qWFieSm98tGBtK8gbMYT/wX5q/s5c2Yux7Zut7cI5iyag
	 uDUdeVahFkNrg==
Date: Tue, 7 May 2024 15:48:18 +0200
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
Subject: Re: [PATCH v2 18/27] rcu: Rename rcu_dynticks_in_eqs_since() into
 rcu_watching_changed_since()
Message-ID: <ZjoxIhtCw4Pov0VH@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-19-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-19-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:22AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, the dynticks prefix can go.
> 
> Furthermore, the "in_eqs_since" part confuses me, as IIUC this only checks
> for a change in watching/eqs state, not that RCU transitionned *into* a
> EQS after the snapshot was taken.
> 
> e.g. if
>   snap = 0b1000 (EQS)
> and the following rcu_watching_snap(CPU) is:
> 	 0b1100 (watching)
> then
>   rcu_watching_in_eqs_since(rdp, snap) -> true
> 
> but because RCU was already in EQS at the time of the
> snap - it hasn't entered EQS "since" the snap was taken.
> 
> Update the name to reflect that we're only looking at watching/EQS
> transitions, not specifically transitions into EQS.

Indeed in practice the function only checks a change. But semantically it really
checks a trip to eqs because this function is only ever called after a failing
call to rcu_dynticks_in_eqs().

So not sure about that one rename. Paul?

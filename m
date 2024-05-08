Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6320777658;
	Wed,  8 May 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175045; cv=none; b=aX7CU3hvmN1JG3jjMBflypuAXYKqC2GZKR2tMTYeqagC1UEiNE1sb2InNMlrhB2EV96DogFiwc70aTKfJ/FNoD1EDEzdGF40nIGwYC41OBwMQQFvOSMIsO2aaFJ4IvHLLHBngLglz+n7lclDPpKhnb7vMgn/jVSlBU/kiV2Aan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175045; c=relaxed/simple;
	bh=WM/R+O0N2WssVLD5UK0w8D7Basb8oqDH86NZVRpGGaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pen/pmUZdPnmRVZGH2ZeqMJ2AzIXVmseR4mjfAMenwgWm+TzLZNNChFYhj9gS7cEsmsxsPgy+SJG4fLKGiNRXrcgmBk9Ztnr4iltiJR5q/oAibvlXDy6ggFDc2VYYZFTzdxwAyFRlW+cLpPnKnSBRAdm4RhB2f6B7IZVWmR7gy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNDdzO+x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNDdzO+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E442C113CC;
	Wed,  8 May 2024 13:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715175045;
	bh=WM/R+O0N2WssVLD5UK0w8D7Basb8oqDH86NZVRpGGaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNDdzO+xkSk5lHWB74f6QAD1/w7MQ7VvGVaMOMRLpaT1KN0A3xRJ8grQR3GD2Xm2O
	 EXdidSpehADSPcQXu4QFx34pPbLSKPvUGLPO/1SDHt5MhEVOBvHp1dDOWeiJiznzuN
	 mkEx7V4ej+hvCgt9LdBnyVhbUWVa4qqu5M2R1Rokf6yRG5f+Yc0nFm+ncpgobGOEjO
	 9CeSf3nGUO7NAXHOTDAY9e1mH4NBin8CPtc1U+POmfOE82cyinYbNBXY2c3oOxVbPw
	 ROWW79oVc60hCX/xLIqv/ncyaFeIsSRMiUVT+062MwC/YqtM3tozSgbdu+IcABe43z
	 ERDqlFBNMh4GQ==
Date: Wed, 8 May 2024 15:30:42 +0200
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
Subject: Re: [PATCH v2 24/27] rcu: Rename rcu_momentary_dyntick_idle() into
 rcu_momentary_eqs()
Message-ID: <Zjt-gqSq2RDBC9Jp@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-25-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-25-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:28AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, replace "dyntick_idle" into "eqs" to drop the dyntick
> reference.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E4922089;
	Thu, 25 Jul 2024 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909444; cv=none; b=DM/m8PCavao24Qsd3FS4wtu40AFM92h9WRKNJQX2vY2o+SJGD0UK6bOONUU3Ao5UTC1ABjlSMSgbrOpXQya8T6DdMphS7f8PQ2mNXMyhPNtnxsjm7GTEWoRcMErxzdthD/e97FDJHOnEJSoQsHtl1YAr/mCJrqT29NFXY0No1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909444; c=relaxed/simple;
	bh=hs5vrEkAEk3NjkXphJzsI+2vLNWna1xyaHQdMmDvbtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTxJ0QanvCNeRSFGPsMc4WzEYLZG8wKrBoJcyeEg79GMGaca3iFtcFs/I8HRvrLmLtkxOB1CTx7qs7ujrbBFu2cidiDges4CigG6A0G5aj0Cv/xGDqVjrzup03saPhEfHdbyi/2+lnqlGTE3QM2no2a3iosORMtkSURIOor2xWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqROKyon; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqROKyon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7107C116B1;
	Thu, 25 Jul 2024 12:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721909444;
	bh=hs5vrEkAEk3NjkXphJzsI+2vLNWna1xyaHQdMmDvbtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QqROKyongAeKeNcyGx3cOsxk4IAC0Ie2eaIoWX9MVbc5qkTPavQo7pj6iFeE3bYa9
	 HhkxY3WxTxZrY5RZYpITe24L/brGBKeRl7IgkPWXvXO5YLG0SxLA8XjxkbD/ZsNhJ1
	 R31RPsqwSpoeCyuE/zcdnbCvEJ79rdUq1KithAG76q7X3436uDGtflj3rAT63g3QrD
	 3P1yuOzkhc5PNebA1zWLoqI5mg7zZxjHN1jsH95C8zhSObWzV+Sct3uEGe47gwmDE5
	 QllkzoFmC8IVZ+BTkxtRzoVREuTtCnuAoAPFjbvU809mPJ49biuxYJ0G4OMTfzetyn
	 VLDmCJhGGTp8Q==
Date: Thu, 25 Jul 2024 14:10:41 +0200
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
Subject: Re: [PATCH v3 14/25] context_tracking, rcu: Rename
 rcu_dynticks_curr_cpu_in_eqs() into rcu_watching_curr_cpu()
Message-ID: <ZqJAwZiJ3oC-Kr36@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-15-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724144325.3307148-15-vschneid@redhat.com>

Le Wed, Jul 24, 2024 at 04:43:14PM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, reflect that change in the related helpers.
> 
> Note that "watching" is the opposite of "in EQS", so the negation is lifted
> out of the helper and into the callsites.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

You may need to update the patch title on this one.

Thanks.

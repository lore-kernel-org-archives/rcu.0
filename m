Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1A75815;
	Mon,  6 May 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714993284; cv=none; b=sHnlBtfClCq7YF6OrDS9ZzeSOzNOIEza/TplueizrgbfBvHu1zd+ErgbG32wcrUqVzPqX0FfNglJHLtluc2SkkdTViDR+SSFq1a0yF3kWW53r7yegqix7dc4lVW+eyWSmbpQDqoixb/nTjTL2iln+h0IAaIpfGB9ZPbD/9Ctjzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714993284; c=relaxed/simple;
	bh=Xuss9Xm00J++0coXdMYhy2tC5vJmSIbccfKL7M8w924=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RO2TnpyyuX3PVYA9fvg/s2Wpie5gbBuNKgkZ/8QLVwhkGhjDyxNfrFX5SRkB4TsVJLWjrbLwQpWpqHd225ZNskwRPfLqjA1UWRK1DXhzYxZwOSKkb0w/cA19jSJXM8F05WrIYQf8Ot8SjKwIJodl0IVMv2E7BtPL1FkyJJGYTaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kdg6oIJL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kdg6oIJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19D4C116B1;
	Mon,  6 May 2024 11:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714993283;
	bh=Xuss9Xm00J++0coXdMYhy2tC5vJmSIbccfKL7M8w924=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kdg6oIJL4LzyMx7FVDQNHS4NEtlQXYZc7oYh1gdrolEMIUOyhW3BeE1aNMCAp89nx
	 wil1/MXtu6dNUJse3hKBW8NzPwyRkoN7av6hIF6Hq5YcukV4pSbLIIBotS61t7eM0X
	 Xt16QOBB8APdL5VDejp8iY+7CC25ZK37IgZUqEH3mZUvGIieM0QvgPdnOL3Hqpg2Fk
	 LPwSnPyGr6uQCmyor1qyttpPYQ04kdVz8iy4PImd0IZ3fB4JWtmjRgHD2ZlwJv27Od
	 N/uyyXArqT2KJLD2FNc0XjfzuOpy9H79A+o9d2ugFwkm1oD/598BLiOnJtywMGxjCr
	 f02RcYy3/AmMg==
Date: Mon, 6 May 2024 13:01:20 +0200
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
Subject: Re: [PATCH v2 07/27] context_tracking, rcu: Rename
 ct_dynticks_nesting() into ct_nesting()
Message-ID: <Zji4gCgDswcV53dC@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-8-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-8-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:11AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, reflect that change in the related helpers.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

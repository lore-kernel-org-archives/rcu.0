Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EA07D3E3;
	Wed,  8 May 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175591; cv=none; b=NdUSYD8NSQjZQXovYrKtvXDPJGACRQKNiuRwnfyJghh4+bO1OG/oLQ6PPAaweQhn4vvUngAfdU9vWihSB0Pb3gETaC9H6Ls7QRkRCUxXgbXNrpT5g456O4zr/AQpErmi9PG8CroWmGYPtrNzwTdX3j8TUIQG/eI1NrMFSurpeqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175591; c=relaxed/simple;
	bh=0vLEDB1vtDUAGEF1w8FrBQkyFhMxAQDUCmxDflIvCag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J38Do0xyXqD+Slm4+nnzdRSz4Bss+SzrvQSiw6ugjL1YjItujI/gTY54KvLJtWVwVh9wXUWMJI8RUTZRkijWOP5qLv/D2ag76QQe8p8yBsHzxsgOij4WMpis/j6mevbp3BGIIkonuEPjQFDJHdL2mc7fUMqSyc4WCOak5C+Xl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiS9jUb3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiS9jUb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D0FC113CC;
	Wed,  8 May 2024 13:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715175590;
	bh=0vLEDB1vtDUAGEF1w8FrBQkyFhMxAQDUCmxDflIvCag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fiS9jUb3NxUxP8XOgM2HtDBSABc70QjRUZPC7V+aYPihPMHJ5Hrgvu4iJvYyePh/g
	 RupFsq6OlrESFxleSIlsmEBQab5CDzplltQiP//Fb/EUBCY5SJKNCNZT9oFbysuW3w
	 FEymwUAIjYLkMlMjPdJhneQUFl7sWKU6JOMobQ16ZCynuELLLQJBxdGWE5VF1K+k2G
	 wdUN2bVe0RiS3SYPfFVbNkGYxdofz3ZaudTH3R+9wpvNhuiDORlNot7t3+7EKvAA3A
	 keoFCFr6tMLGnACGbvOmR/gOkaQy2pmZ10otPCiMOOrh7kCyUus0gk0+xYOcOT6pqI
	 rSEB9UZgwTt8A==
Date: Wed, 8 May 2024 15:39:48 +0200
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
Subject: Re: [PATCH v2 25/27] context_tracking, rcu: Rename stray ->dynticks
 comments
Message-ID: <ZjuApFLf1efFDEqp@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-26-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-26-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:29AM +0200, Valentin Schneider a écrit :
> A few comments still mention a context_tracking .dynticks field, but that
> has been merged into the .state field as of:
> 
> 171476775d32 ("context_tracking: Convert state to atomic_t")
> 
> Update these loose references.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

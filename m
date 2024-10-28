Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A28EDE;
	Mon, 28 Oct 2024 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121084; cv=none; b=dyNg8CYmT/7m3caafCEVT7d1PfcDPNm3qmRUXqq5uXwwg25kMBoYDTwIWRkHF96Bp/iwH4rHeEtzKOCr8sQgtjm3HUduChcOouhD4zrEHwUD1jbMiuQJIn38W4fzcKgd4P6b5+U2d7aeT16WavCyDkqp5j2hmiwYuyVndZMWKP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121084; c=relaxed/simple;
	bh=53ulgl2L6YVILmp/0t8Yz2mrHhjsp+6XVmz1KvpwTew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRQc1xnVkXKanHP0f5kRzo3TBEQBlQlGAZdakzK/YH3SaE6kjXpQ4z6IDZBtQpzJvUxaoKOObbTIglR7k6gYeFcp0/wRF8F5FOrKtmDkC2NtULgn742FY/N7plouqg0ot+UfMFMd1EE5BrIJJ2Q9lFoCRn5VoOnCEGGTLuCLzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y187vtra; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y187vtra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D14C4CEC3;
	Mon, 28 Oct 2024 13:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730121083;
	bh=53ulgl2L6YVILmp/0t8Yz2mrHhjsp+6XVmz1KvpwTew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y187vtraRi+Owyni8cOpxz0cH+DEoHaSjkqt+DZpHV+yLESw9x+n5zhS9gHHvGtPv
	 e4GCdBAAS9vN1ZBX/hC3+UBleBZ8eTkCLFygEEOEzkFeUzaCXQn0nr489fAi+r4TYm
	 lovAteL60/UFMRTjrLEsEvoqMEzI/nLlf5dIXa6WpA1gfqSnBSrIgxDe4v5Y1lEb9k
	 QQLcgw6GUB6/awkcDKzznwt0oa/VF2RX/rdIApmhJvMFVMJ/5ntKEOkGBkboO49lpe
	 tdBcQc1yVWbHoxfCyK5ufzTMKiyq+BkruVmh9gx+1kWH2VDjrKxZoRp6B6fcxy3Nwf
	 W2KjcxkAy8Pqw==
Date: Mon, 28 Oct 2024 14:11:20 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/3] hrtimer: Use __raise_softirq_irqoff() to raise
 the softirq.
Message-ID: <Zx-NeHWC0LX-75s0@localhost.localdomain>
References: <20241024150413.518862-1-bigeasy@linutronix.de>
 <20241024150413.518862-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024150413.518862-2-bigeasy@linutronix.de>

Le Thu, Oct 24, 2024 at 04:55:49PM +0200, Sebastian Andrzej Siewior a écrit :
> As an optimisation use __raise_softirq_irqoff() to raise the softirq.
> This is always called from an interrupt handler so it can be reduced to
> just or set softirq flag and let softirq be invoked on return from
> interrupt.
> 
> Use __raise_softirq_irqoff() to raise the softirq.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

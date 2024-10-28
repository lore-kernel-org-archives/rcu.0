Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7A1E48A;
	Mon, 28 Oct 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121233; cv=none; b=VBjouISz96jXuW5hoAncmQgDBLFG4ckwsLjoFrsLJfykvwNPRn44UY9lS45eanvpQLNEoAz8BzfnuRvNOKS1VCmjfUNzdXLNQYXVBq39RmJAqF4VbUud5L1RH06euk/d1ue2+0vNjQgYNjP7tKegcmlUWFve70LqWFARFS4LhME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121233; c=relaxed/simple;
	bh=oakMzO7Cn0cA3jBZvy82va2r/vv8HzUeFj/p9lV6Mb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2KKmEx2hI1Mx2/1Hpu7h3utkKoWkGGu41ayeRxM1FTpaCgqwNoXyQiNKqDh6bNe1l1Du7q59LFtUiO9sZdeQeOqQ2yet768ma2AW+a9sUfzdKj0rIbCqhaXnBUU+A15WXazuKPC7oMavKwiODM4cXc9Ce4EqRzWUAdhSMlyXQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcoFZ3Sb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcoFZ3Sb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552DDC4CEC3;
	Mon, 28 Oct 2024 13:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730121233;
	bh=oakMzO7Cn0cA3jBZvy82va2r/vv8HzUeFj/p9lV6Mb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CcoFZ3SbHQmKt0HKeyFXNomW/+VGn1JtXzzrDCLw+eH4tJn6ZdaPc4SR7UR2CyMbM
	 lo7NTGFVv316wMdiQkIdb1rovC+s7ABGNn49GBqryhdNLtJ+DdYpAGPjy8VDatNsJP
	 eeFvN35SE7chB10bB3BPoqcoNJ4g8qK5CSf6FJtIMXVYI1omCZhQ9zMD3tgPNWMKTn
	 0qIwUU9Lfe2TeshkwlllhSCR/s9uxYC3ECFvqHNbL6JMAUOQ/NP2cdMX6lH1e+BVIV
	 5KcEAv2co5dVvk7tRYtQfws9OSzaSPHnCCuZTvJGFM93iNS++qI6DAJYiQrBEeWnUH
	 juGzxODPr1zXw==
Date: Mon, 28 Oct 2024 14:13:49 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/3] timers: Use __raise_softirq_irqoff() to raise the
 softirq.
Message-ID: <Zx-ODfHKAEkXfLHD@localhost.localdomain>
References: <20241024150413.518862-1-bigeasy@linutronix.de>
 <20241024150413.518862-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024150413.518862-3-bigeasy@linutronix.de>

Le Thu, Oct 24, 2024 at 04:55:50PM +0200, Sebastian Andrzej Siewior a écrit :
> As an optimisation use __raise_softirq_irqoff() to raise the softirq.
> This is always called from an interrupt handler, interrupts are already
> disabled so it can be reduced to just or set softirq flag and let
> softirq be invoked on return from interrupt.
> 
> Use __raise_softirq_irqoff() to raise the softirq.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF118C031;
	Thu,  6 Nov 2025 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393397; cv=none; b=WmO0/mXzTTUnowtxYcvktP5TcCB5D9x3tnsG6SaI/Id/77+aPmFFclc+UpBlK64JqjndKDUvw5yOdunl7/QZQ07t2EVj+GFToqLBL9rp/gKBQeJ7uL1SHb3cnhKwk2ZJ76gwXri84VUhAdoIsYjPBraAoblk8KcxzFV7BhPxd1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393397; c=relaxed/simple;
	bh=zWyEcnA4cB+brnZbkCkr4GECTZm5bOmqltkvlbLoRmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvX9el6zqEVY/Dar+c6wv3g2oX4UDtBPMI7usDK7pC7hZKHxHeY2suYPaH+zP8VUXjLxH3Nl3Xh+DvS8mcnq9aTZIs1gdgeebuiXUe99L+MmASEuuBXYXZ/pGYhOYMfVDFoynNQh13KUypw+CaSnjGK3Sda4vMDqloYEpy5Sd4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EST7YQ8X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EST7YQ8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F776C4CEF8;
	Thu,  6 Nov 2025 01:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762393397;
	bh=zWyEcnA4cB+brnZbkCkr4GECTZm5bOmqltkvlbLoRmM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EST7YQ8XxA8vZC+sLWpQcJJQFuR/mIUjqsdTY3WzOgGh3FXnrelz6ydF1IJn/Hiyk
	 ZE0b01P2alKjurPQcfNwUmdQyMXdOOftOu7PiYxQuBfPG9booCoZutqo/me1DRorRa
	 tuYVgDacCnSQMKv+dOHc2nGox97ozNLEJ6EmN9Cw2wlURDs5p5EduuD6Dq6qJx+Gok
	 Ex73TWF9HWXbjaYERq5m1uNqiyCd3NLjlkXkr9FLiEba++6LrWrOZ2fJPgviggNt1m
	 +AaXiczn/ooAI2A3336leajlMUOAYH2zLljZI0gKtuSClEwZanLrwu3v9+ZlrPBg5x
	 7HKQZ7P4uUJyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B85CDCE0B94; Wed,  5 Nov 2025 17:43:15 -0800 (PST)
Date: Wed, 5 Nov 2025 17:43:15 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/8] refscale updates for v6.19
Message-ID: <d9df7e45-66cc-4ca3-953b-50d2eb5a574a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
 <aQvWCaUWTDvfIUiE@pavilion.home>
 <aQvXVrsgE-Xz_aRB@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQvXVrsgE-Xz_aRB@pavilion.home>

On Thu, Nov 06, 2025 at 12:01:42AM +0100, Frederic Weisbecker wrote:
> Le Wed, Nov 05, 2025 at 11:56:09PM +0100, Frederic Weisbecker a écrit :
> > Hi Paul,
> > 
> > Le Sun, Nov 02, 2025 at 02:49:34PM -0800, Paul E. McKenney a écrit :
> > > Hello!
> > > 
> > > This series contains additions of microbenchmarks to the refscale suite,
> > > and depends on the SRCU series.
> > > 
> > > 1.	Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast().
> > > 
> > > 2.	Add local_irq_disable() and local_irq_save() readers.
> > > 
> > > 3.	Add local_bh_disable() readers.
> > > 
> > > 4.	Add preempt_disable() readers.
> > > 
> > > 5.	Add this_cpu_inc() readers.
> > > 
> > > 6.	Add non-atomic per-CPU increment readers.
> > > 
> > > 7.	Do not diable interrupts for tests involving local_bh_enable().
> > > 
> > > 8.	Add SRCU-fast-updown readers.
> > 
> > But this series depends on the "RCU Tasks Trace in terms of SRCU-fast"
> > patchset which isn't for 6.19, right?
> 
> Ah it depends on the latest srcu posting, nevermind, got confused in my
> inbox :-)

I confess that my redistribution of that series was a bit abrupt,
apologies!

							Thanx, Paul

> Thanks.
> 
> > 
> > -- 
> > Frederic Weisbecker
> > SUSE Labs
> > 
> 
> -- 
> Frederic Weisbecker
> SUSE Labs

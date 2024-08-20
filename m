Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8E1CAB8
	for <rcu@vger.kernel.org>; Tue, 20 Aug 2024 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179643; cv=none; b=AsVa2jjB1ihn8ilNFotryP9TAMHfyAnVUWP4KY65PnFx6Ose34A0AoWDnPIzPp3PuOqWQm24Bvc/qWu1u8/sX71yAtNssAC0A0xj/lLIPpt30LA0zOJYc3+0mVrhQ2KH6m5U7L5POr+Td4CaW4CLRKTSxRWA9fMlJW+XN4NOmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179643; c=relaxed/simple;
	bh=xpNbck+mVnibwssYzrkPNoD+U458KWOF3BZS/dDv6bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8Gc5fm0U/tVtjfKtDWFEldnwcWR50ih6HVUbil4PepA1X4ceAP4hQ3vOY9Zg+JexDQD1Vv3RMDsU38beLuP9yGyQysgGanpwGFpfQ32d5ZD1PxaHrNwe+0hEQQbkTqulPErV0Zl703ygOKEQmLsnXEW2QjowqE33akm2pi2ERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kz37GigS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kz37GigS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DABC4AF13;
	Tue, 20 Aug 2024 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724179643;
	bh=xpNbck+mVnibwssYzrkPNoD+U458KWOF3BZS/dDv6bk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Kz37GigSV9W3lIyc8fwdhSg8CTjdJa5pUy1dY6zixYXs3R1lgE6fj+8sGLoS8iNzA
	 LIJe1MQ025hJpZsQtmtRk0QGJrWD6g4+CVPdPr47c68qDb+ueAhdKbA0oORg0d1U/L
	 A8/OW28A/qJxm7B+L7DAN/Fb5X+dqN9dcbWTgSZptMpW4ZPThnYD/uRle9TXnRiUxA
	 Fnrs+h8ee4uQMau6LCfT03fTYXqtTjfJz80L1o0x4uE3XUJoxtD35zH6CCAPZjOQzz
	 Ty9e9A15iliBkBJOXhooWHLcbFIW67OWufTHQlWt0au0X9efrKxbdOQcdT3xIUZ/rU
	 17+IprSctzu/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EC0DDCE0DE1; Tue, 20 Aug 2024 11:47:22 -0700 (PDT)
Date: Tue, 20 Aug 2024 11:47:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] doc: rcu: update printed dynticks counter bits
Message-ID: <e1af4a94-577a-4fe4-be4f-e4c7b835aab7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5dd8782f70c3b2367ae3c7d9016eb8fb32c76b49.1723969097.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd8782f70c3b2367ae3c7d9016eb8fb32c76b49.1723969097.git.baruch@tkos.co.il>

On Sun, Aug 18, 2024 at 11:18:17AM +0300, Baruch Siach wrote:
> The stall warning prints 16 bits since commit 171476775d32
> ("context_tracking: Convert state to atomic_t").
> 
> Fixes: 171476775d32 ("context_tracking: Convert state to atomic_t")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Good eyes!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  Documentation/RCU/stallwarn.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> index ca7b7cd806a1..30080ff6f406 100644
> --- a/Documentation/RCU/stallwarn.rst
> +++ b/Documentation/RCU/stallwarn.rst
> @@ -249,7 +249,7 @@ ticks this GP)" indicates that this CPU has not taken any scheduling-clock
>  interrupts during the current stalled grace period.
>  
>  The "idle=" portion of the message prints the dyntick-idle state.
> -The hex number before the first "/" is the low-order 12 bits of the
> +The hex number before the first "/" is the low-order 16 bits of the
>  dynticks counter, which will have an even-numbered value if the CPU
>  is in dyntick-idle mode and an odd-numbered value otherwise.  The hex
>  number between the two "/"s is the value of the nesting, which will be
> -- 
> 2.43.0
> 

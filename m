Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0226F28D;
	Wed, 20 May 2026 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280011; cv=none; b=Rl7NSqvryr1T9lOhabewaZccZ+yly4kXEroxkK6boGQHe0YFG5+ASrPQrd0qFS/UP5z+WNtRcgxHdwbm2ylMernZml+sL9gW6F7C3h/+aK4ecbYXFg7Ym0YZfsxh1ZDJQC5iKiHjAbRBExOPRhhJvTBkrXkO53s6I/sJeaSu1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280011; c=relaxed/simple;
	bh=hElv4jlf+VyfC9PiRkCcYpP76uoQlesfjuznhLOACSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8HVrzwtfy+1zzulTeCX4BwMHYmvqVEjlPJo/q0JOy/EWOJJtSc05l/TR4a/YLlyDiwCl3jSL4PsewH4cuoqYT8iVLbKO3C4QKPHxa+UxN0RV3dYCZ6aNaSeNYkIv0t5Nth58JmqNEHlXrkucKahkDBexPhKifSe+PGt1ADuNGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7R2h7fA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7R2h7fA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C0E1F000E9;
	Wed, 20 May 2026 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779280010;
	bh=ZtdGhoXGn9qULrrX8sCJlcSw7bHynPmqT3dAbF9DrAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P7R2h7fA6JXZ3iXH/wt74befZDgvEFCcW6pa24MREvnM1PMhnAdpGSMy7j45yD20w
	 w+/KN38nuq72EGeqC1bFqmM6SfFPaIl53yf1RyVmC1KMoqBGfNAueUPKeOS13Riavc
	 VFK06BTC+Ye6M0tcsFglot5vfivHysdDQAhwd5VCisfHlZE2vQn+LY3Qgo5Wr1Q6FI
	 19K6iuvph9sY8EPFHtGMoESmgWXf7XtuFCGnnsTBY6r/roi/CufTBdx1o4ZseNNH0n
	 VhrCmRQ5a/ibj9yEAo9JJJSpH+4CtvCbag7TWOMKsRrcDj5DIHSAPJXUpIvuchvutb
	 gQKcQ3ZTXWTag==
Date: Wed, 20 May 2026 14:26:47 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2 07/11] rcu: Simplify rcu_do_batch() by applying
 clamp()
Message-ID: <ag2oh3MNOm-GTWLs@localhost.localdomain>
References: <20260519194524.158515-1-urezki@gmail.com>
 <20260519194524.158515-8-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519194524.158515-8-urezki@gmail.com>

Le Tue, May 19, 2026 at 09:45:20PM +0200, Uladzislau Rezki (Sony) a écrit :
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit replaces a nested ?: sequence with clamp().  This does not
> reduce the number of lines of code, but it does simplify the line that
> it modifies.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 55df6d37145e..e46a5124c3eb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2584,7 +2584,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  		const long npj = NSEC_PER_SEC / HZ;
>  		long rrn = READ_ONCE(rcu_resched_ns);
>  
> -		rrn = rrn < NSEC_PER_MSEC ? NSEC_PER_MSEC : rrn > NSEC_PER_SEC ? NSEC_PER_SEC : rrn;
> +		rrn = clamp(rrn, NSEC_PER_MSEC, NSEC_PER_SEC);
>  		tlimit = local_clock() + rrn;
>  		jlimit = jiffies + (rrn + npj + 1) / npj;
>  		jlimit_check = true;
> -- 
> 2.47.3
> 
> 

-- 
Frederic Weisbecker
SUSE Labs

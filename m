Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFD813A26D;
	Tue, 22 Apr 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344564; cv=none; b=rKI+Kc1PZ8/qBJGLO4hMpLoyVBEiozuA126wFB4E8kE5XwDafsslrKrTWhTCphq+pRnEy/3+kERKhkIHBoyfTDsuLdbDQJLtNZ6kiIUa05LOEhFGPJrv/BiwEtnSrsHFANzOlWUr8+cSM2PxyqIqyBqIFbopNZXtrZKOrfCK4y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344564; c=relaxed/simple;
	bh=zXBEWG0uJ7e4VYgyCowIr0NkWKI1P2H66tweTx+3XR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEf6m5YTJAVVIfhzsM1uNIaZnN7pwNlW24MPBkY4F+QQ7xsR7akQRJtEaFuLQt7WuXZAF7PMoP2GMaMR2j0Rv6ufSxHKj6ZcpH6gPngP+qiJyqezfwRkOKEVC1lctWVcCWoMvvs015gbthpcxnZQRCpugHVtzBvDa5pHOgslqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rON4TYpT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rON4TYpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948B2C4CEE9;
	Tue, 22 Apr 2025 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745344563;
	bh=zXBEWG0uJ7e4VYgyCowIr0NkWKI1P2H66tweTx+3XR4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rON4TYpT0usaMLfYUrgK9pGw/EUYVyF2Gm3QgD5ReBpAlD/5YBhdsiNDmYeER1bnh
	 4OtD+mHcuChqj1F5dvjgrJw1omSV/gS3kke4IaI4R2UCycJCA2HLw/9XpYYeFSNJ1d
	 5a3Q+VQu7FE8g+oOkq7HO6fbY41iqiqJoPaMzEs23Sm0aW2eRfQIkNGbbsXmxbMRlI
	 xjJrnS3DmlHnocz3FJp/cMUVlEgaiBnOTiL1AIXyj/p19GV52AlCGXmG0RaNTythaK
	 mAQauILu8apjN/PmOk2VSXelKX6oT7MlRnr3ML0Si6XslbDIu8m+yXcsaoyRFajsO0
	 GB2mnZNtOZHKg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 08AB8CE0875; Tue, 22 Apr 2025 10:56:03 -0700 (PDT)
Date: Tue, 22 Apr 2025 10:56:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] tools/memory-model/Documentation: Fix SRCU section in
 explanation.txt
Message-ID: <1497ef3c-b1fc-4723-949b-28d92a3afb6b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250422173830.90647-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422173830.90647-1-urezki@gmail.com>

On Tue, Apr 22, 2025 at 07:38:30PM +0200, Uladzislau Rezki (Sony) wrote:
> The SRCU read-side critical sections describes the difference between
> srcu_down_read()/srcu_up_read() and srcu_read_lock()/srcu_read_unlock()
> in a way that a last pair must occur on the same CPU.
> 
> This is not true, the srcu_read_unlock() can happen on any CPU, but it
> must be performed by the same task that invoked srcu_read_lock().
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Good catch!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  tools/memory-model/Documentation/explanation.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index 6dc8b3642458..34aa3172071b 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -1896,7 +1896,7 @@ following respects:
>  
>  3.	The srcu_down_read() and srcu_up_read() primitives work
>  	exactly like srcu_read_lock() and srcu_read_unlock(), except
> -	that matching calls don't have to execute on the same CPU.
> +	that matching calls don't have to execute within the same context.
>  	(The names are meant to be suggestive of operations on
>  	semaphores.)  Since the matching is determined by the domain
>  	pointer and index value, these primitives make it possible for
> -- 
> 2.39.5
> 

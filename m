Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0841DF963;
	Wed,  8 Jan 2025 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736366519; cv=none; b=ggVDI9MP80SUFkE/6T+oXi+u7uPHVvmiYaYiN8CwnHsnIxkbzw0mCL0Y+ee60JACjTygxjDp+EaWXyXsurmiBWMx+CR4sDQcLcT7ZXLyU3qxa5XLtGxD6CRLa/RObqOaC6K0A1VucnUXDC33O3K6y5K9vTxhZZ7J71l5dfYbZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736366519; c=relaxed/simple;
	bh=UCT2noZpV9Q0Nyfu307D4UyYqC9laSpfQxDtj1KLilc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FknrzZTtKtxEedLcE6VMltMhUpzjG7CxFRc8Y8y7F1jvrUoxJAX8y4mXYrtqleNfVcopbC6VyIq5fX3A20ENhWgaOigyX0E1+5zI6lCBGIhU0ydDmElzONZDcOXd/zyUlnEaHsF3e6DNRvsXahqRW4GBahsfVleY+Iibb1LEffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDIrHOYf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDIrHOYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCD8C4CED3;
	Wed,  8 Jan 2025 20:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736366518;
	bh=UCT2noZpV9Q0Nyfu307D4UyYqC9laSpfQxDtj1KLilc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iDIrHOYfoocqpuq/IAlEw0wStCTvDVhvpJf3cJrOCwUWbO6TmKhNvHEvZANapffU2
	 EINt3WYty+ZtBIqmc/PsLLkmq5WboX7AVK9HblM+x/wt4pjSKr1Eg/KfmOyUpg87Or
	 unXGP3qQEOXan++f1hT73JyUtM0oAUKNEWo5NnJN1EY5L7c1Q9Lts+8RQNJBuUXYCY
	 fxaVFd1cSXL0cT8PAwefe5YHlFGwi5PfFAZyzD4MhbFryUwLvPDWSR/NvcfscJmz/L
	 UGw6a42SLiNlG58ALljJA/KpHWOQgrpfH4MziVLt6QY1vyG8lYLSpLtMccuVNvVAgH
	 D4HY94nwlae1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 458CACE0DC7; Wed,  8 Jan 2025 12:01:58 -0800 (PST)
Date: Wed, 8 Jan 2025 12:01:58 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Reaver <me@davidreaver.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krister Johansen <kjlx@templeofstupid.com>
Subject: Re: [PATCH] checkpatch: Remove migrated RCU APIs from deprecated_apis
Message-ID: <dea6be36-0462-4076-b6ae-56886b495b01@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250108192456.47871-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108192456.47871-1-me@davidreaver.com>

On Wed, Jan 08, 2025 at 11:24:54AM -0800, David Reaver wrote:
> The deprecated_apis map was created in [1] so checkpatch would flag
> deprecated RCU APIs. These deprecated APIs have since been removed from the
> kernel. This patch removes them from this map so checkpatch doesn't waste
> time looking for them, and so readers of checkpatch looking for deprecated
> APIs don't waste time searching for them.
> 
> Link: https://lore.kernel.org/all/20181111192904.3199-13-paulmck@linux.ibm.com/ [1]
> 
> Signed-off-by: David Reaver <me@davidreaver.com>

I guess it has been more than five years now.  ;-)

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  scripts/checkpatch.pl | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9eed3683ad76..842a39a01af1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -834,1 +834,1 @@ foreach my $entry (@mode_permission_funcs) {
>  $mode_perms_search = "(?:${mode_perms_search})";
> 
>  our %deprecated_apis = (
> -	"synchronize_rcu_bh"			=> "synchronize_rcu",
> -	"synchronize_rcu_bh_expedited"		=> "synchronize_rcu_expedited",
> -	"call_rcu_bh"				=> "call_rcu",
> -	"rcu_barrier_bh"			=> "rcu_barrier",
> -	"synchronize_sched"			=> "synchronize_rcu",
> -	"synchronize_sched_expedited"		=> "synchronize_rcu_expedited",
> -	"call_rcu_sched"			=> "call_rcu",
> -	"rcu_barrier_sched"			=> "rcu_barrier",
> -	"get_state_synchronize_sched"		=> "get_state_synchronize_rcu",
> -	"cond_synchronize_sched"		=> "cond_synchronize_rcu",
>  	"kmap"					=> "kmap_local_page",
>  	"kunmap"				=> "kunmap_local",
>  	"kmap_atomic"				=> "kmap_local_page",
> 

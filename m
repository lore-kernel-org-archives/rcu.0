Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F721553A3;
	Thu, 11 Sep 2025 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619973; cv=none; b=lbGK6LzoUavvVUH1k0Tb8d2J9i7UdnenVoH6rWDC8CTAOXxhV0qh2hX80qgBK4IPcXSwi++7oWATRNMdRngntJZ4EdDbA8/psrZwcdFSgMIHE5iJKN6cpFJYkz3CGcy0s0meRNgvSZZeQzy2h6rTfvVBkdr9YBadUUeWoCDkgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619973; c=relaxed/simple;
	bh=3VRUkWlxIjH7lJghzSxYxKoEqymH+umEOlZRHG/+qXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0m65AUt370BfaAC+W+Q2KyktcdXjPl2HvXEBdub5y+wHPWaLVaCFhHN+G/yFb8TWhq/MBJxm4DhmTXyZsHxdipOJ4SyozP0rUEPk9QFjSdVsxuKlqqA3EVm+A8UAaddVggYdt51gQ2sdhbvXUYkIBcpasa2DrHvSShohl4y4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUQGO6Yj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUQGO6Yj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4DBC4CEF0;
	Thu, 11 Sep 2025 19:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757619972;
	bh=3VRUkWlxIjH7lJghzSxYxKoEqymH+umEOlZRHG/+qXI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iUQGO6Yjc+BgT0WScz9sYoXvjUA0pcIS+f0pY5CHrhidb+7DRkVmRBj8ApcXqOmIN
	 jzB4SeNLH12UHLz5H0nxkegKTf9EhrtggjjHxpbveDiMpHPlmv+6mQHrjfnhRreG7v
	 1ZM+I8txQ5jR7CbSrMr8dYs6Jf2jsZx9K8ur59PM50Y6uPK1x9g6FIpU1M+bF18Cl3
	 B+CWpKl+HKD7tWbfMVPaV1C0Fv65WkBoY8TlKbtaDqSzJMh7PyTw3fE2Z41SfZovle
	 pR0s1xXOolpp2ADRvQ8cCSpPusryHRJlf3MHcuR5XVQfSRNCYWXRreSYzWIn9gXPWi
	 2XTmG15uMv19g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 38085CE0C15; Thu, 11 Sep 2025 12:46:11 -0700 (PDT)
Date: Thu, 11 Sep 2025 12:46:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] refperf: Set reader_tasks to NULL after kfree()
Message-ID: <cf66d322-ff98-4f50-a27c-52fad11c40e9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250911031811.681694-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911031811.681694-1-kaushlendra.kumar@intel.com>

On Thu, Sep 11, 2025 at 08:48:11AM +0530, Kaushlendra Kumar wrote:
> Set reader_tasks to NULL after kfree() in ref_scale_cleanup() to
> improve debugging experience with kernel debugging tools. This
> follows the common pattern of NULLing pointers after freeing to
> avoid dangling pointer issues during debugging sessions.
> 
> Setting pointers to NULL after freeing helps debugging tools like
> kdgb,drgn, and other kernel debuggers by providing clear indication
> that the memory has been freed and the pointer is no longer valid.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Queued for further review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/refscale.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index 2bfa987f4ba9..47486dff43ca 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -1048,6 +1048,7 @@ ref_scale_cleanup(void)
>  					     reader_tasks[i].task);
>  	}
>  	kfree(reader_tasks);
> +	reader_tasks = NULL;
>  
>  	torture_stop_kthread("main_task", main_task);
>  
> -- 
> 2.34.1
> 

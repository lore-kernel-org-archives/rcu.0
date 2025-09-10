Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2037526B75C;
	Wed, 10 Sep 2025 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520311; cv=none; b=s+ujwRbmoJ8RbARMCAzhFrrJbqU66kZ49ginhjYm5v+nvioTyrYA2meSktQ5ermGOmZ2AlRb7vpf2gJDjsqUAAImMT22zPz93sMDon+pbGcOtMZ7hLZFKjMSxWEpCMcUX6MTFDYb1kcvR0fZ0pim4iHRL0bVXKwZRgV1MLA2+yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520311; c=relaxed/simple;
	bh=YS/3/gjBRXnURwH/ahYtatm80YUoGD0xJzFvxzflZZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvXtY3vUk5i0c9tPg196gc2Ma8SZHLF9DQKViaIMMdS6gAa6ajk1bCch80u+C4HAnJsf3DUqYwa5QmcpnZJ3BadhEpQTkOvgfpKsuP9eknul7Je5qhSr4y0SD1QNVi1ojBl8mK3f7uPvjO5HsxqLAPeOO9ky3jK8Fob9XP2i+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN2txi/j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN2txi/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92673C4CEEB;
	Wed, 10 Sep 2025 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757520310;
	bh=YS/3/gjBRXnURwH/ahYtatm80YUoGD0xJzFvxzflZZo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UN2txi/jzH/f9tb0AcfQmbJ++5rtI0LNK7YTRzKR50Ubgs/7omuGh/4VqdtdASwnW
	 AkNHdsaP4/aSqbSgq2un7HIoht1RB39ud3wrDuwFQsRMjkhgYW8TiteHAMwb0b1h+e
	 JKoLV+GXjvQIs2Y5tiS0il7tQaa5J/SL43RAA3RMKSvsi/V8gXp/FDM1fASJkvUGrE
	 7Sl82j9/3NUAOGGVrCjvV1rsR0qCRD8jOF/KrbgXRF3a2Wh1Bi+txlkxDIVxU7sn8j
	 tLCV47eSuG5o40AcBhPqj9K3tRg9V1cIGZ3pNpENk7jfCUKDV2PcUAqbaVCrwvrtJe
	 Eu3zqZ8ovDheg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 505C1CE0B24; Wed, 10 Sep 2025 09:05:09 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:05:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] refperf: Remove redundant kfree() after
 torture_stop_kthread()
Message-ID: <1d46403b-50cc-410a-aa7d-ffaabc9fdda2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250910151419.3762048-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910151419.3762048-1-kaushlendra.kumar@intel.com>

On Wed, Sep 10, 2025 at 08:44:19PM +0530, Kaushlendra Kumar wrote:
> Remove unnecessary kfree(main_task) call in ref_scale_cleanup() as
> torture_stop_kthread() already handles the memory cleanup for the
> task structure internally.
> 
> The additional kfree(main_task) call after torture_stop_kthread()
> is redundant and confusing since torture_stop_kthread() sets the
> pointer to NULL, making this a no-op.
> 
> This pattern is consistent with other torture test modules where
> torture_stop_kthread() is called without explicit kfree() of the
> task pointer, as the torture framework manages the task lifecycle
> internally.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Queued for further review and testing, thank you!

							Thanx, Paul

> ---
> Changes in v2:
> - Corrected commit message based on review feedback
> 
>  kernel/rcu/refscale.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index 2c2648a3ad30..2bfa987f4ba9 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -1050,7 +1050,6 @@ ref_scale_cleanup(void)
>  	kfree(reader_tasks);
>  
>  	torture_stop_kthread("main_task", main_task);
> -	kfree(main_task);
>  
>  	// Do scale-type-specific cleanup operations.
>  	if (cur_ops->cleanup != NULL)
> -- 
> 2.34.1
> 

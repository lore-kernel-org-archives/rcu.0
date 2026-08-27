Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B7447803;
	Thu, 27 Aug 2026 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853359; cv=none; b=TnmTn86PAmbEl+GihG8RrqzSr+sfVSosmrRtfN4rIRp6t9AOlIZ28XAnO3JjicFj23DU3EABgcAYXKEzXDiie6VYvzLTHGnt0z5Zj5fnbauTTuTeKwZ5GqNtbnDTqLruQSQtdZQJ7K3c4NwV9ldQIh8dsGAmgC6JRYv9hIcziQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853359; c=relaxed/simple;
	bh=L8KCDHot62Y6Ew7k3XqT9pvexPdRxmDuCVaqn6m/f0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj7mRYTX/D7VqrWVprH2xyugSbe/Sq/Tlorsji7rNtClklEa/ceoO/nzPV3hkuZRQdRP6/RFNmLCb99OCHbH7iPgbZkZlKRryOLTtSgcvIHzKLfash3uOcuS/Z6LY3Jq6BsJQIwhgjrfqCmQNvwemEgakcCnRkIbGOK8KyWEP9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMBtxnHa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMBtxnHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4624D1F000E9;
	Thu, 27 Aug 2026 17:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787853358;
	bh=vZ7C2/CTlac1zgMJppc2AjQ/Uy0zQfoKz02KlYqLtHw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=aMBtxnHaexduBS9V6dJUQv1F5BkzFuYq0SUx4IUVcGroR9Nhs5pcSlcdmAt15kjO3
	 rYEuGP4aED58t9++sVmmNklA2A/aXXE7cK1rC7zARxE07LeIKJQfqYymkSLyBLCvSd
	 l24gGHOS4VCgU/NosATsUSySC9oYJW3eZIE1AxudZv6TLAfmctBl5rsCiUBqaOg7Yh
	 AFVzLQMwIJwn2T9kV8HCK8GcD+qgLTkXJ4HlnieIFSW1GlpwGfcbVc6ylzrmH71Bnh
	 0zQMhZSzQldSiz7l0iTeW3TGh3P+8WKKcf9egiEHrm0Qxnrq7VM+Xc8OU6mEKcEw+K
	 tgvcs3PXvFA+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 03112CE1496; Thu, 27 Aug 2026 10:55:58 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:55:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Longlong Xia <xialonglong2025@163.com>, frederic@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang@linux.dev,
	vineeth@bitbyteword.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: Re: [PATCH 1/1] rcu: fix shrink budget underflow in
 lazy_rcu_shrink_scan
Message-ID: <2dfd3f5c-0a06-4353-a9bf-ea9f9100a4ca@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260824133142.2293426-1-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824133142.2293426-1-xialonglong2025@163.com>

On Mon, Aug 24, 2026 at 09:31:42PM +0800, Longlong Xia wrote:
> From: Longlong Xia <xialonglong@kylinos.cn>
> 
> The lazy RCU shrinker decremented sc->nr_to_scan (unsigned long)
> and then tested the result with <= 0.  When a single CPU's lazy
> callback count exceeds the remaining budget, the subtraction wraps
> to a large positive value and the <= 0 comparison, which is
> equivalent to == 0 for an unsigned type, never fires again.  The
> scan loop then iterates through every nocb CPU instead of honouring
> the reclaim budget.
> 
> Reorder the logic to compare _count against nr_to_scan before
> subtracting, so the loop exits as soon as the budget is met.
> 
> Fixes: c945b4da7a448 ("rcu: Shrinker for lazy rcu")
> Assisted-by: Zcode:GLM-5.2
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>

Good catch, and plausible fix.  Queued for further review and testing.

Frederic, thoughts?

							Thanx, Paul

> ---
>  kernel/rcu/tree_nocb.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 19bb42672baf..afc3ab84cc47 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1332,10 +1332,11 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		rcu_nocb_try_flush_bypass(rdp, jiffies);
>  		rcu_nocb_unlock_irqrestore(rdp, flags);
>  		wake_nocb_gp(rdp);
> -		sc->nr_to_scan -= _count;
>  		count += _count;
> -		if (sc->nr_to_scan <= 0)
> +
> +		if (_count >= sc->nr_to_scan)
>  			break;
> +		sc->nr_to_scan -= _count;
>  	}
>  
>  	mutex_unlock(&rcu_state.nocb_mutex);
> -- 
> 2.43.0
> 

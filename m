Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FCC21E086;
	Wed, 26 Feb 2025 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584095; cv=none; b=bkAHhQz76KoaaKA0ICvtczgU9LXJh+KQxqSL2wV7/4Ok8VkqkvGD6euXxRsbQ1ktBASQYQpgSYfjFnKfgH4ZkbDgi0imf6BAvjVSbsEf/qHNt16AFjfa3bi/lX4DQa32MVPX0Rh3Aq4Z+pNaPBLMXXaGvZCUZW/X2m1KKmatKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584095; c=relaxed/simple;
	bh=dvpCdknSbJRBihARcmk+j1D9QLD2fLv6ZklkUW1Vi+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBZFd24oKzQK8q5Qq1IlR0I482g8MinMn3Q5z46v719u+MfknnSl2VE9sHUxaqTFJwnLfnGuYnJN3jdAQd1xNlcddTKyhh0qLP3Q45nNmWwGdCQyFBapGUb2gdSSbR+BBVXn769Q3fa4AYItdHkfmOrt/i0n8lLyPXMK+oBiEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST/AwY2K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST/AwY2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2E3C4CED6;
	Wed, 26 Feb 2025 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740584095;
	bh=dvpCdknSbJRBihARcmk+j1D9QLD2fLv6ZklkUW1Vi+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ST/AwY2KIDewjzv2ggIQoFpEQq7LWxbSEjkyin70X2yx5ugBH1SbNA16sWg10n0mU
	 s6Tgi8JM4lzt0rohG+ZP7mK0wesbeu1o0kJwnssGh2YD3NHS17mUCtrLqfmsk0bT4g
	 2I5D0lMu/Ij/XVeWFsHTaRvEyVhOPGBbfz5dhO11NXwL+lEXJcxrSxhpcRgcA/J8AF
	 vbia9ePMvhpeqvCXJ3RMSI90/MlrUBt8hpnjBwrWVSe+xwuYUfqYa2abZlRRke+f/u
	 hR7VTT/g0JxSN+labsxlUr3SXTaVN4vxRjw5WCinaboo3bcmWeoXAvhw1XtUHCM9A7
	 SKUOwRGdQcZOQ==
Date: Wed, 26 Feb 2025 16:34:52 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/3] rcu/exp: Remove confusing needless full barrier on
 task unblock
Message-ID: <Z780nGXxjiVMSvXa@localhost.localdomain>
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-3-frederic@kernel.org>
 <20250225215908.GA1812344@joelnvbox>
 <Z78OeeyarjDB63Dj@localhost.localdomain>
 <63cbab19-a7d4-4daa-8b54-58665e159e23@paulmck-laptop>
 <c0c0f393-fa50-4437-80b2-f38d65b43fab@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0c0f393-fa50-4437-80b2-f38d65b43fab@nvidia.com>

Le Wed, Feb 26, 2025 at 10:26:34AM -0500, Joel Fernandes a écrit :
> 
> 
> On 2/26/2025 10:04 AM, Paul E. McKenney wrote:
> >>> I was wondering if you could also point to the fastpath that this is racing
> >>> with, it is not immediately clear (to me) what this smp_mb() is pairing with
> >>> 🙁
> >> It is supposed to pair with the barrier in sync_exp_work_done() but then again
> >> this is already enforced by the smp_mb__after_unlock_lock() chained through
> >> rnp locking.
> > You could interpret that "Order GP completion with preceding accesses"
> > to include preceding readers, which to your point sounds plausible.
> > And in that case, again as you say, the raw_spin_lock_irqsave_rcu_node()
> > in rcu_report_exp_rnp() provides the needed ordering.
> > 
> > I think.  😉
> 
> This is for the case where readers are blocked. For the case where readers were
> not blocked, and we exited the RSCS, we just expect the regular QS reporting
> paths to call into rcu_report_exp_rnp() and similarly provide the full memory
> barrier (smp_mb) on the now-reader-unlocked-CPU right?

Right, again through rnp locking and smp_mb__after_unlock_lock().

> 
> Just wanted to check my understanding was correct :)
> 
> Also if I may paraphrase the ordering requirement here, we do not want RCU
> readers to observe any modifications happening to data after the GP has ended
> (i.e. synchronize_rcu_expedited() has returned). Similarly, we do not want
> updates in the pre-existing readers to not be visible to accesses after the GP
> has ended. Right?

Exactly!

Thanks.

> 
> thanks,
> 
>  - Joel

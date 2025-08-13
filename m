Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C8322E;
	Wed, 13 Aug 2025 04:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060103; cv=none; b=ACova7XXacSRHcHeHSkjNqHGPvIQnw2NG8mvTLZvzGO4GSiOJBjdi1Vp+mdtQ2vrbdpkFl7EdDWqgxUslPubGkhpc9FeFVX1qzLyh6cdH84jljMSWgD5Bw813iqBU7XYku1Ly2HhwlAwqhbEHyub7SmsUa+4WxNwJqZCnJvwdlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060103; c=relaxed/simple;
	bh=v2d764f2ep5EHkqA3NAse77cvCy3e/Ewnulm5smU8fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+FODy8mMk+xR/TQu+qbesAoQlb/QIwGVD4mRukAGDDBhEhp9g/mevxSR+ItH17mnsfI5VGN2CjKXF+fxZ0w1C0+hOoU2YmddmO4fJNLF3CPpnMVMWfXuRuV30HYH9ewjUvZkOSRysCBWlAfQIVjbb7TCuwdUXWfxo0GF74yTIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrIzbobI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrIzbobI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D0DC4CEEB;
	Wed, 13 Aug 2025 04:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755060103;
	bh=v2d764f2ep5EHkqA3NAse77cvCy3e/Ewnulm5smU8fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrIzbobI7/iWRr7TUYEjc8/cS662o0No7nQ+qiQxgJwACUex6dwWWL6pA5JAG4cuc
	 JekVnAeLsihOc92MG2PLvmqtia4q3WMeKWbR+Re5piWUanG0Fs14AmPa46ovfeNS86
	 nIxnLWhxLD9hLQpbaZK0OBvwR+8RVpLK+ky4np88RPzKUehsFD8SulFE/W07hLyyyx
	 IvrWAYCdHmVuoGrwhOZE/AprUejn/FGisXLywH5O2x3ZIDt4+uI19OZ2SUptnFMiDD
	 OqbGybsowpArfn+p7A4GcckoAgOYAxTeCYHKszQxOemPDbTmCYc4F820VKMvOMCP2K
	 4Rzt9BBQGUj0w==
Date: Wed, 13 Aug 2025 10:10:24 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Qi Xi <xiqi2@huawei.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	rcu@vger.kernel.org
Subject: Re: [linus:master] [rcu]  b41642c877: BUG:kernel_hang_in_boot_stage
Message-ID: <20250813044024.GA2872@neeraj.linux>
References: <202508071303.c1134cce-lkp@intel.com>
 <aJY1DsIUQxzq1U1Q@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJY1DsIUQxzq1U1Q@localhost.localdomain>

Hi kernel test robot,

> #syz test
> 
> >From a3cc7624264743996d2ad1295741933103a8d63b Mon Sep 17 00:00:00 2001
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Fri, 8 Aug 2025 19:03:22 +0200
> Subject: [PATCH] rcu: Fix racy re-initialization of irq_work causing hangs
> 
> RCU re-initializes the deferred QS irq work everytime before attempting
> to queue it. However there are situations where the irq work is
> attempted to be queued even though it is already queued. In that case
> re-initializing messes-up with the irq work queue that is about to be
> handled.
> 
> The chances for that to happen are higher when the architecture doesn't
> support self-IPIs and irq work are then all lazy, such as with the
> following sequence:
> 
> 1) rcu_read_unlock() is called when IRQs are disabled and there is a
>    grace period involving blocked tasks on the node. The irq work
>    is then initialized and queued.
> 
> 2) The related tasks are unblocked and the CPU quiescent state
>    is reported. rdp->defer_qs_iw_pending is reset to DEFER_QS_IDLE,
>    allowing the irq work to be requeued in the future (note the previous
>    one hasn't fired yet).
> 
> 3) A new grace period starts and the node has blocked tasks.
> 
> 4) rcu_read_unlock() is called when IRQs are disabled again. The irq work
>    is re-initialized (but it's queued! and its node is cleared) and
>    requeued. Which means it's requeued to itself.
> 
> 5) The irq work finally fires with the tick. But since it was requeued
>    to itself, it loops and hangs.
> 
> Fix this with initializing the irq work only once before the CPU boots.
> 
> Fixes: b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508071303.c1134cce-lkp@intel.com
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---

Can you please update testing results with the proposed fix?


- Neeraj


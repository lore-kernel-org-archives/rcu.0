Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE5B30C17B;
	Sun, 17 May 2026 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040991; cv=none; b=oDo4NfC41eUh31+z6Q1mXMnQDsHYiQCOoKiu+aFu/YfEIulMRYmPLj/VkNRH6m33HifZsontMKK8Qveuce2e+uOCNKpHVZSQ1Cr+UY1hyj1ho4Z6mzqD2Ulsmt/kW7JGwFhTGBDPQR3P+0+tsQsnxwMYV3bSn09vY2pwk19whiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040991; c=relaxed/simple;
	bh=eKYZ5Zd25SHKyCY6FwF2U4AnbvuHzFzmQuoXM1yYuWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjvoOb1fvAxMUGz0uHKQztFLviCoLGZIr7Fsou93EcgIw5nB/O+Oir4KGhFjJvAMcszpQKnx1OZGfkCB+P0OnnAqvielsK4leSTPPg168c4BJi1ZniZJbOqloIf5Vps0FCuEQ+UMhGC1fKV6/x4qDl3sDBE3GtTMPXHvpL2dMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwdiJrY+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwdiJrY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E23EC2BCB0;
	Sun, 17 May 2026 18:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779040991;
	bh=eKYZ5Zd25SHKyCY6FwF2U4AnbvuHzFzmQuoXM1yYuWA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SwdiJrY+6cMNNbD7KZ48x+jSYsObPVRT9LrTHIxEGQqg3jNGKOogW3II3mynY07+D
	 G+dSQbN1qhMRC39l2hnaEYv5nuvec/DTPWCn44CaXjTbedLgHL0Z1Ut1VHlfBl8rN9
	 gi0ajJAgPUMW91uraHq8mIQ/PJp87KOQ+IS3GGHzVPVqJ4QdShALUMDj2k/Qlt8aUZ
	 NvtXC/CDAmhXwYv5sG4xqlFGYVW+GIKhKxqMH9QoVA8UupH5ohNY9m+zwTL1AzR9Fo
	 15LKvQ8iMw6eRIdQ29UVVYz7ky0x+/s9cZ5gnqjnDsGxYKm/6eh6OGL7qbOPVAeBUY
	 FTu+UPVLohpKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1F826CE08BA; Sun, 17 May 2026 11:03:11 -0700 (PDT)
Date: Sun, 17 May 2026 11:03:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Samir <samir@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH -next v1 05/12] srcu: Don't queue workqueue handlers to
 never-online CPUs
Message-ID: <3dd5cce0-51f9-4cf1-81b8-246e6c6a633a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260511175448.153326-1-urezki@gmail.com>
 <20260511175448.153326-6-urezki@gmail.com>
 <f669fbc9-c068-489f-bd91-4e81561a6e58@leemhuis.info>
 <agm4-6f-6rOgQPFB@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agm4-6f-6rOgQPFB@pc636>

On Sun, May 17, 2026 at 02:47:55PM +0200, Uladzislau Rezki wrote:
> On Wed, May 13, 2026 at 12:38:01PM +0200, Thorsten Leemhuis wrote:
> > On 5/11/26 19:54, Uladzislau Rezki (Sony) wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > 
> > > While an srcu_struct structure is in the midst of switching from CPU-0
> > > to all-CPUs state, it can attempt to invoke callbacks for CPUs that
> > > have never been online.  Worse yet, it can attempt in invoke callbacks
> > > for CPUs that never will be online, even including imaginary CPUs not in
> > > cpu_possible_mask.  This can cause hangs on s390,
> > 
> > Uladzislau, Paul, according to the fixes tag below this change fixes a
> > change that went into 7.0-rc6 -- and apparently causes a "hang" on some
> > architectures. So shouldn't this be heading to mainline instead of
> > -next? Ideally with a stable tag to ensure backporting to 7.0.y, but
> > that is a separate decision?
> > 
> I assume it will be picked to stable since there is a "Fixes:" tag. From
> the other hand i can explicitly update commit message with Cc: stable@vger.kernel.org
> 
> Paul, any thoughts?

The "Fixes" tag should cover it.  But maybe Thorsten knows something that
I do not?

							Thanx, Paul

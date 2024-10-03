Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6579684D2C
	for <rcu@vger.kernel.org>; Thu,  3 Oct 2024 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999413; cv=none; b=MPaU2HCHewvykXYoGrJuFfNKBx8bT+npZpj1KEOId/kI9poB9j24kNDr3CzdeCGrtySkN+K6SPtagVG2fVSdWy837E5Vv6DKUelRgqpyE656dstB+fzFkfidUeJPNfsGWLBD1mu5M5koifMSnXK3m63Q7iaL5kHmEYAiKkpRRfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999413; c=relaxed/simple;
	bh=P4LWAW2BuFWicMI3nETfSqQILrG3rvRQdtJX9isTTm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/K9zc/SlTHXsYOrfgHfZ5qs7Ji50YRGobvXWGzs3GRONbO//99GpcjgeI8NFxkbmU8IhC/mXFOi3c7++k7zEIv0ISv38bjl2qpjJBBw88LydpxIkwoYwhrY6vNl0Bxust5H9xamz6K90gkRqON5Q63jz6gL3nfQykT9HjiLpww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oggh95Pv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oggh95Pv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804F3C4CEC5;
	Thu,  3 Oct 2024 23:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727999413;
	bh=P4LWAW2BuFWicMI3nETfSqQILrG3rvRQdtJX9isTTm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oggh95Pv5xS/dCu8mfGNmwpNCVJoFUf28Q0HUfE6SXx2z02Jw3b6FESZmuL+VB+CN
	 T8UkfSmSzsXR2/DscS1Xg914Fdxh/3fpQnUx3HaZCKOH544qcDXJ53XMBamHky1LEl
	 x5n+/gfWRmL5CxXLZSOYfJZZ8AtaP2+Jrwg3mtCU6HGtKOSAUXf+BqjAuPYGPPTcil
	 eIhXYbIJNQMyaHKMFew9u8LQnyMolt+Qye/QedvRn5mrPkPAcpr8dVXr319posYxAb
	 3KBpl+PgSnwva7DLiOo4Z8Erwv5ccQe9vihXmJlwtrovHebJNcxumv2ns9Na6aYhnl
	 MgIr7CsNuLPVg==
Date: Fri, 4 Oct 2024 01:50:09 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, rcu@vger.kernel.org
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
Message-ID: <Zv8tsbnYDgFNfSPq@pavilion.home>
References: <2747e596-5359-4f32-b3e0-0b2368d37017@paulmck-laptop>
 <CALm+0cV0GwT5umPRZrZWg4oqXwdjcWz-NkxkhgxQkv=NypQthA@mail.gmail.com>
 <CAFTL4hzY09QEGE+sTqc02d2LkuH_ObYKiuVTfGnrtwjtYiwt4A@mail.gmail.com>
 <d31bdc50-a61b-446b-926d-b3ddde832a91@paulmck-laptop>
 <236a1f66-f128-44e4-9272-7ae4dbad7485@paulmck-laptop>
 <ZthlEg2njJwXMk32@localhost.localdomain>
 <5bb81db1-bf62-4edc-8d71-dfa192dda39f@paulmck-laptop>
 <Ztn5MOwk4nIfTWv-@localhost.localdomain>
 <Ztn7PpfFiYDRBjWX@localhost.localdomain>
 <CALm+0cXA8LJM7RWO5uqowkN3-gZYidPuyXZoHOJi10cJja1qPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALm+0cXA8LJM7RWO5uqowkN3-gZYidPuyXZoHOJi10cJja1qPQ@mail.gmail.com>

Le Thu, Oct 03, 2024 at 10:01:57PM +0800, Z qiang a écrit :
> When the rcuoc kthreads process rcu callback, before invoke
> rcu_segcblist_add_len(&rdp->cblist, -count),
> the rcu_barrier() can insert rcu_barrier_callback() func to offline
> cpu rdp's->list.

Excellent analysis! Indeed we can have:

CPU 0                         CPU 1                          CPU 2
-----                         -----                          -------

// deoffload                  // nocb_cb_wait                // rcutorture
rcu_barrier()
    rcu_segcblist_entrain()
        rcu_segcblist_add_len(1);
                             rcu_do_batch()
                                 rcu_barrier_callback()
                                                             rcu_barrier()
                                                                 // still see len == 1
                                                                 rcu_segcblist_entrain()
                                                                      rcu_segcblist_add_len(1);
                                 // decrement len
                                 rcu_segcblist_add_len(-1);
                             kthread_parkme()
// Warn because there is
// still a pending barrier
WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));


And the worst is that the second rcu_barrier() is ignored.

> 
> 6,5408,150692937,-,caller=T453;rcu: rcu_callback func: rcu_barrier_callback
> 
> Maybe we can wait until rcu_segcblist_n_cbs(&rdp->cblist) return zero
> and then invoke kthread_parkme() in rcuoc kthreads.

> Any thoughts ?

Sounds good, or simply make sure that rdp->nocb_cb_sleep == false before
parking? Since kthread_park() should only be called after rcu_barrier() and
then rdp->nocb_cb_sleep shouldn't be set to true as long as there is a pending
one? Well we can also add a WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist))
before calling kthread_park().

Would you like to send the fix?

Thanks.

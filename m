Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CBA2773CC;
	Thu, 30 Apr 2026 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561221; cv=none; b=pxaWcQxf1ruKGb+3hU1XomGS+/mKFKwkL8kj6qp9JD02syNC3YJ0UyIcnP+2z0Lti9eBGnDTtVkPnXOQfC/9Ilh2HNzKfLyjZ+4Z/J/9zqGnga8yfWazDgC1CYhmqLzD1Xv6rpf83zZ5Com2HZyr2efjzB+1M8X5DpKdjLPyq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561221; c=relaxed/simple;
	bh=NIpBbsTVJAPA1LbGLLmEMRWHJX+8fdw+OfgAkskpcEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ysktbyk1UNflSwU9wRCFqxtFbFnZJ9LmUYQQyefVjabd6xMI4bLaAnS6sKMfmST5nNien82bHW36dI9VS6S85aSZ/I6/DgxQWAzdKVWcih7oA2Uo7AzMq+y6nGnP12VkT1KEeVmrcZ5zQm1HR16rqUxi2max3kc82dQJyuLBJcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t55mjbee; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t55mjbee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56644C2BCB3;
	Thu, 30 Apr 2026 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777561220;
	bh=NIpBbsTVJAPA1LbGLLmEMRWHJX+8fdw+OfgAkskpcEQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=t55mjbee1vXMVJyHEeEn0P8FI8bsYPXfabVw7eCjPFiizXuDUdAK/L+jI9fQK9KS7
	 qvG9ZEwKvSc1VWEGNWZC4tFLsGO6/CSezgvxys2Vjxm1G9BCqC8ftD1SUdpZUjv2sS
	 O0xlD15qrjow9JwOs5diImGaL8cq7hyzFtgo7ocohp1gkXIAOlDXqtyuc+cYjfJKuS
	 xDoeFDB3chbtG5AtdvfOui0E7Pe5vBlgQYBWWP6k5cacldnVikQobM16nG3lcB4wtQ
	 KMk5vRqwaUXQsYN/gOZwPJgrOtCg03D2Vk0AkdqvQEWcLDuZl48VXtEImepCQYumks
	 Bs5cgZ4Kab1Pg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D31DCCE04A5; Thu, 30 Apr 2026 08:00:19 -0700 (PDT)
Date: Thu, 30 Apr 2026 08:00:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Samir M <samir@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
	linuxppc-dev@lists.ozlabs.org, Boqun Feng <boqun@kernel.org>
Subject: Re: [mainline][BUG] Observed Workqueue lockups on offline CPUs.
Message-ID: <16676927-5a4a-4007-9ece-593a4699adb0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <97a7d011-d573-4754-9e5d-68b562c64089@linux.ibm.com>
 <688280dc-78a2-4796-9eaf-e1c058836012@linux.ibm.com>
 <ae-EP1BpXgnEWCt4@tardis.local>
 <1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com>
 <5ab8d72e-1a93-4d50-b097-0dde35d81f25@linux.ibm.com>
 <6c51cebc-3b98-439d-adcd-a0f382b98f40@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c51cebc-3b98-439d-adcd-a0f382b98f40@linux.ibm.com>

On Thu, Apr 30, 2026 at 11:49:02AM +0530, Samir M wrote:
> 
> On 29/04/26 11:21 pm, Shrikanth Hegde wrote:
> > Hi Samir.
> > 
> > On 4/29/26 3:46 PM, Samir M wrote:
> > > 
> > > Hi Boqun,
> > > 
> > > Thank you for pointing me to the existing patches. I have tested
> > > both Paul's patch [1] and TJ's workqueue patch [2] on my PowerPC
> > > system (80 CPUs), and can confirm that the workqueue lockup issue is
> > > not observed.
> > > 
> > 
> > Can you try only paul's patch and confirm if the issue is fixed?
> > 
> 
> Hi Shrikanth,
> 
> I have verified Paul’s “alone” patch, and it resolves the issue no workqueue
> lockups are observed.

Thank you, Samir!  May I add your Tested-by?

							Thanx, Paul

> Regards,
> Samir.
> 
> 
> > > Test Environment:
> > > - System: PowerPC with 80 CPUs ( e.g. PowerPC LPARs with 80 online
> > > and 384 possible CPUs)
> > > - Kernel version: Latest upstream (7.1-rc1)
> > > 
> > > Regression Testing Results:
> > > All tests completed successfully with no issues observed:
> > > - Hackbench
> > > - Kernel selftests
> > > - LTP scheduler tests
> > > 
> > > The workqueue lockup that was previously occurring is no longer
> > > present with the patches applied.
> > > 
> > > References:
> > > [1]: https://lore.kernel.org/rcu/ed1fa6cd-7343-4ca3-8b9d-
> > > d699ca496f83@paulmck-laptop/
> > > [2]: https://lore.kernel.org/rcu/adlHKowvhn8AGXCc@slm.duckdns.org/
> > > 
> > > Best regards,
> > > Samir
> > 

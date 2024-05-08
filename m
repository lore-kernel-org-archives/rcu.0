Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7151E89A
	for <rcu@vger.kernel.org>; Wed,  8 May 2024 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715212247; cv=none; b=gv4YnDXjEpNIUH321s7NqqdfltltQZqX7xWkWE+Yd2nY0pUsMh1vsSQmrUEzFUU+YV44akLvqcV8YNSZ105l3FEzsLCDNgWIk8/PyaJe3qJICj6Yc8JpDJ5TfqIp2IW6nBS+JkmbC8jTsmL+uKlYWs3n2KHZWYNx/JBigFFcwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715212247; c=relaxed/simple;
	bh=RsuFMqDrLETJ6CHiIIVaA3b20KjWmlH6Wsw6FKjwp10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzQGoPw8aC+PkSsqrlejeJvsJePKlV7Ov4XH13eHJsyyddEC1RoQY3aIb3AvbeZ5B6EWiS2aRAsWqlCx1b3EOw1l+Sd4VdQTj/VUh/Rg6zycg3HmeNZS3FpQZROzA4UiHg81g/+49rvfuvFqOpIS39KwGl1ztJr1YSbM6QTp7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stBEDMB+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stBEDMB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144A3C113CC;
	Wed,  8 May 2024 23:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715212247;
	bh=RsuFMqDrLETJ6CHiIIVaA3b20KjWmlH6Wsw6FKjwp10=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=stBEDMB+XGBqELdbbm3MSBl+dbLYUs1EcWdnrBdIJLOA6BI12O2dvQVEWvCNN9KIV
	 RzpY1mhgUxGn6NwVNZVVnlaXqhL5LhVEb0cBRgy5md7+eb6DhXbHRgPM1s1YyFSMA5
	 LfVesreBziCCvixF5f1t89bAisfogh+iPVi0KM5zMRY09gVrobHTTT3YQZ5iHCrv71
	 Q49dvYgiN95G24HSETsS7pPwg7XfETkqWIr4bAVytP/NU0doCIv3LzTw5S4lWcJB+g
	 zpT16zGwvqHsEJADLrb1b0OhBKSN9CAOR4O8oSyPlrhw8t+WyaMS0IEZZl5mxksyWB
	 Xg6W2XwGIiNXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A675CCE0A6A; Wed,  8 May 2024 16:50:46 -0700 (PDT)
Date: Wed, 8 May 2024 16:50:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: dwmw@amazon.co.uk, rcu@vger.kernel.org
Subject: Re: [bug report] rcu: Kill rnp->ofl_seq and use only
 rcu_state.ofl_lock for exclusion
Message-ID: <c18678f2-dff9-4d2b-9079-d77ab276ccf2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <febb13ab-a4bb-48b4-8e97-7e9f7749e6da@moroto.mountain>
 <cef46486-ac26-495d-bd2d-1e998a73a421@paulmck-laptop>
 <edfea2ff-d73e-48aa-83db-96daba77c500@moroto.mountain>
 <e775bd83-dfa3-4f09-9539-e0e655feda08@paulmck-laptop>
 <2a5bc6d1-c45e-4cf2-81bd-49b55caa1478@moroto.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a5bc6d1-c45e-4cf2-81bd-49b55caa1478@moroto.mountain>

On Wed, May 08, 2024 at 08:38:06PM +0300, Dan Carpenter wrote:
> On Wed, May 08, 2024 at 10:32:43AM -0700, Paul E. McKenney wrote:
> > 
> > Agreed, and please see below for the proposed cleanup in this case.
> > 
> > 							Thanx, Paul
> 
> Thanks!  Did you see the other warning I mentioned?
> 
>     kernel/rcu/srcutree.c:910 srcu_gp_end()
>     warn: mixing irq and irqsave

I did, but then I promptly forgot about it.  Thank you for the reminder.

> Btw, I'm mostly sending you these because I know you're interested in
> these sorts of cleanups.  I didn't bother sending one to aacraid people,
> for example.  :P

Maintainer's choice!  ;-)

How about the following?

							Thanx, Paul

------------------------------------------------------------------------

commit 75a3b18f319a1f06df94cfeef81d7dd6a38cd59b
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed May 8 16:47:16 2024 -0700

    srcu: Disable interrupts directly in srcu_gp_end()
    
    Interrupts are enabled in srcu_gp_end(), so this commit switches from
    spin_lock_irqsave_rcu_node() and spin_unlock_irqrestore_rcu_node()
    to spin_lock_irq_rcu_node() and spin_unlock_irq_rcu_node().
    
    Link: https://lore.kernel.org/all/febb13ab-a4bb-48b4-8e97-7e9f7749e6da@moroto.mountain/
    
    Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 98f79ba01b0af..9a8b7ecd2ff45 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -846,7 +846,6 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	bool cbs;
 	bool last_lvl;
 	int cpu;
-	unsigned long flags;
 	unsigned long gpseq;
 	int idx;
 	unsigned long mask;
@@ -908,12 +907,12 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	if (!(gpseq & counter_wrap_check))
 		for_each_possible_cpu(cpu) {
 			sdp = per_cpu_ptr(ssp->sda, cpu);
-			spin_lock_irqsave_rcu_node(sdp, flags);
+			spin_lock_irq_rcu_node(sdp);
 			if (ULONG_CMP_GE(gpseq, sdp->srcu_gp_seq_needed + 100))
 				sdp->srcu_gp_seq_needed = gpseq;
 			if (ULONG_CMP_GE(gpseq, sdp->srcu_gp_seq_needed_exp + 100))
 				sdp->srcu_gp_seq_needed_exp = gpseq;
-			spin_unlock_irqrestore_rcu_node(sdp, flags);
+			spin_unlock_irq_rcu_node(sdp);
 		}
 
 	/* Callback initiation done, allow grace periods after next. */

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21DD2F90DE;
	Tue, 11 Nov 2025 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888864; cv=none; b=KWcWLjgBiugkjvHCPl2v6lsU4Q2d/cY/M5nAUaWh1PEJuS6q5VfEsZDtiJoabyxiZHKJ3MAOyPS39M4B110yiguynef8q9toigouZZI5nzzaEPUZ7aj36t6+8vcM3d2wU8Houfo23Fpt73OX3W70Li3s7+3zMApo8Yh0m72RhgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888864; c=relaxed/simple;
	bh=GvVQcbzeSRPenNYF+ChAuxP72S7rTyZwy6STU2ucxQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXQcLExXSjj8zMXUcPTuPV92ZCpllVFrSrAK5pjrQYyfAyYu2YaTUW353ogNlUgq4b8YgPNdkMWgjOX62Ooziz/KRc8ELGUauODIoCd3yW8c+O1KMbVUfwwBpPMMbR3ijPnM0xBCpc5PVwhdq1b6gVNk62XHgnOYH8Vyurzl82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWPTzyu1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWPTzyu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B846C113D0;
	Tue, 11 Nov 2025 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888864;
	bh=GvVQcbzeSRPenNYF+ChAuxP72S7rTyZwy6STU2ucxQ4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qWPTzyu1XGG/wQJZKFreoATHmurvkU5giDswYjfkh3GuY1r2/2iem9hXOerzKmWPM
	 Zy/GBBbyejKDG7uXWjk1m3/T2nWKQxdZ6H/xjEcibdgizFwcftUpu8R1aVZ8vnlTot
	 Hu72Qv5z0y/xu8QmIc5gAOeU5WqXnP4lj6VkFEMeut/hbxAWCoD1hcCUadljhplmp1
	 Gu9xk1tAeFWi93mFuggK8OyI1m4KxNvaLiWND+AKLHb+CFDAzmH5NehKTsdbizbEPW
	 eVZ2Bu1BAEskk9rQCKlMSvamJCNEFWGfw8f7hEsmJJhqdpYxCqQ1TP6UzhA4DsXKzt
	 wQMEYbAJfVgPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2089BCE0CFD; Tue, 11 Nov 2025 11:21:04 -0800 (PST)
Date: Tue, 11 Nov 2025 11:21:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 3/8] refscale: Add local_bh_disable() readers
Message-ID: <5b1fa8a6-0f47-4ab8-af7a-74916bc520e2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
 <20251102224948.3906224-3-paulmck@kernel.org>
 <20251111153803.5_08_ro2@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111153803.5_08_ro2@linutronix.de>

On Tue, Nov 11, 2025 at 04:38:03PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-02 14:49:43 [-0800], Paul E. McKenney wrote:
> > --- a/kernel/rcu/refscale.c
> > +++ b/kernel/rcu/refscale.c
> > @@ -636,6 +636,37 @@ static const struct ref_scale_ops jiffies_ops = {
> >  	.name		= "jiffies"
> >  };
> >  
> > +static void ref_bh_section(const int nloops)
> > +{
> > +	int i;
> > +
> > +	preempt_disable();
> > +	for (i = nloops; i >= 0; i--) {
> > +		local_bh_disable();
> 
> This (preempt off followed by bh off) may cause warnings. That would be
> bh is disabled on the CPU, it gets preempted by _this_ which disables
> first preemption and then bh. 
> I hid the code under CONFIG_PREEMPT_RT_NEEDS_BH_LOCK so it shouldn't be
> a problem in the long term I think. So just if you see a warning here
> under RT you know why :)

Huh.  Would migrate_disable() be appropriate?  Or I suppose I could just
let it migrate on RT.  So how about the fix shown below?

							Thanx, Paul

> > +		local_bh_enable();
> > +	}
> > +	preempt_enable();
> > +}
> 
> Sebastian

------------------------------------------------------------------------

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 07a313782dfd..5a692a3b93fa 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -887,25 +887,29 @@ static void ref_bh_section(const int nloops)
 {
 	int i;
 
-	preempt_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 	for (i = nloops; i >= 0; i--) {
 		local_bh_disable();
 		local_bh_enable();
 	}
-	preempt_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 static void ref_bh_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 
-	preempt_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 	for (i = nloops; i >= 0; i--) {
 		local_bh_disable();
 		un_delay(udl, ndl);
 		local_bh_enable();
 	}
-	preempt_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 static const struct ref_scale_ops bh_ops = {

Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559853C4540
	for <rcu@vger.kernel.org>; Tue, 10 Mar 2026 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160107; cv=none; b=YN7lEsOSJdooWD95U21E05mQLps6JLMZ1Tg2VdVgxoDonm4rpUm0tc2Fqt4bUFfqNS9eXnKSmvHQJvOF1B0vOQr5l3VBYxGUqGSiRHhijsdHsGcJ8HzN+PI+AfpdVrFwl4ybGpct9+9lbl3CqvTFFu7/l2MupC5GObsFc/oJDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160107; c=relaxed/simple;
	bh=FL0Y++PniJCdiK4Zsc0SzSepgLO+RuZnWfvxdkNFQZM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i84UcaQ8cXTJWh4esKFgCt1myXl5QvtbzJnU+5kjIIGiptcmM4rlQeLQEqToP0ea/074XYU9fL9aRm6FDGWN6kwKJ4R80t2dPMlBIrIyKalWVwktQOWH9bBxiq9ghhU0wJZpfjTU2dZv9v1H+6154Dazp0RQyttyooaF4ZdHxXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8C+MO8W; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8C+MO8W"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a1322af04fso6295921e87.2
        for <rcu@vger.kernel.org>; Tue, 10 Mar 2026 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773160104; x=1773764904; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EGb5UTMxHHTw3aW+XSO8JqH10dAgX3Vgne2skjLFpxo=;
        b=T8C+MO8WYRQcY+FBr3AZ7mpF2tOQHQm94k5dm3tYQuMpAJjRodQ4UI5chnEAOFmSiG
         fqrrwIPpYgRIKUpx7mxb7bxNbZw64vvzLTMhgz9LOcWCfNsr3YtHW4Q+AA6NNMezQ8al
         WWBOwiHtJ0jZit7ylrjdymu3wGxaLXAX6gG6iBI6QZ0hRbU7lsdFv2ACcESpB3G3UT/9
         zBivxqBdj3vL82GL3q9HaWVnZtmNZ6d/b7qcyJxy3etRGkDK6dJsblGeR6qa8REfyNbh
         beYngATFSKVu8YgEUp4DQncyP7be5Qvr88pjMseAImAsaTccYue4UqAYt4tiGIMfMh7+
         JSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773160104; x=1773764904;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGb5UTMxHHTw3aW+XSO8JqH10dAgX3Vgne2skjLFpxo=;
        b=R4ES74HuKwJqQVy1SuGj75as23hFa36c06ksoGuIpTLHzh/1j1wtqmHGdcIkn/DHS7
         Vmg5Pyfrypd3vMJJyr7I8wdoudhIoi2Oc3Ms0L8iCFX0+87W+sHUMDBas4iaZYBUXraD
         Hw44zpUL69or220nfnKCDcoF88TLMOK1r7yEis8K1OS54n2ktxwa3EhWejs6aZmlr+0y
         TS35vrW5hJsPFWuCBR9KbNyOqWJXP54U0DRhJrlaTnSGhR26wmdirhDqr1MU1anrrJn2
         9nyG8s5Ww2opfYR8etS86J14GLWHtdKzJ+nvG/fNUQsdUY629zhmPBS2MxjnVWPDQglf
         gAxw==
X-Forwarded-Encrypted: i=1; AJvYcCUXKZuTZ8+T/uARoVOcmkpkuBTcY6ELulUg8mpITX2AvUq/Q7wLJatmDWtAVeYyBwjC03g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyte3fLkWjxFP+sQgU51fPz/vco2X9FzyswDYfrW/MX0aMw0NBt
	Fh8JiW1EBs71B21QW50rnv1QC/pbKtpf5+3nEFGUxD97QUf3HtNmSr7p
X-Gm-Gg: ATEYQzwo4UTEl3qJ9ooW2+nObLtc6b8duGj5uA70irryY+/8sdyXixmn3HKXeLx+QmB
	XUMf8XqgzXVpDpMmH+FgqEA6J3ReomtcTBMQ6c4It+UCUDnGAeg9XcRK2aDXUCgKGXZiX748kI6
	esn2TyhgVGhXxucEzM52nLDV6xaROOOmNBlaqn2TMwZ+BmjioNVAzP+VFTmBL7vPwIN+xAcg08j
	o+kKATq61+VHPssyMIK5egj6AQ29ndjbxoBusRaiECV8mgEjnriQ69IJuvrkDWXFCD8apZTt6Q1
	cDqNzKGp1opf+N2zWI/qj9AiFbPT0ZvRrl36drVqnBauVaet+lV8gd6qSXxuT8yFwOsNUmFVx0Z
	KNyOaKEbSleW3i7MPOgmg85QkkUVdLq+kzyjPnaLM+K0lHShMzPhyWLiVVsK+TZmAEux82nfuLR
	k=
X-Received: by 2002:a05:6512:a85:b0:5a1:3b80:8c28 with SMTP id 2adb3069b0e04-5a13cabaea4mr4476235e87.10.1773160104220;
        Tue, 10 Mar 2026 09:28:24 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a5d04627dsm6229531fa.25.2026.03.10.09.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 09:28:23 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 10 Mar 2026 17:28:22 +0100
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E.McKenney" <paulmck@kernel.org>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Samir M <samir@linux.ibm.com>
Subject: Re: [PATCH v2] rcu: Latch normal synchronize_rcu() path on flood
Message-ID: <abBGpuDHlAlPmH4g@milan>
References: <20260302100404.2624503-1-urezki@gmail.com>
 <14e954e4-cfa6-4069-a25f-ccb444d17535@nvidia.com>
 <aaliA7sc4Nnu_i_C@milan>
 <abAmiX85PFNq2Ua-@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abAmiX85PFNq2Ua-@localhost.localdomain>

Hello, Frederic!

> Le Thu, Mar 05, 2026 at 11:59:15AM +0100, Uladzislau Rezki a écrit :
> > On Tue, Mar 03, 2026 at 03:45:58PM -0500, Joel Fernandes wrote:
> > > On Mon, 02 Mar 2026 11:04:04 +0100, Uladzislau Rezki (Sony) wrote:
> > > 
> > > >  * The latch is cleared only when the pending requests are fully
> > > >    drained(nr == 0);
> > > 
> > > > +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > > > +{
> > > > +	long nr;
> > > > +
> > > > +	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> > > > +	nr = atomic_long_inc_return(&rcu_sr_normal_count);
> > > > +
> > > > +	/* Latch: only when flooded and if unlatched. */
> > > > +	if (nr >= RCU_SR_NORMAL_LATCH_THR)
> > > > +		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
> > > > +}
> > > 
> > > I think there is a stuck-latch race here. Once llist_add() places the
> > > entry in srs_next, the GP kthread can pick it up and fire
> > > rcu_sr_normal_complete() before the latching cmpxchg runs. If the last
> > > in-flight completion drains count to zero in that window, the unlatch
> > > cmpxchg(latched, 1, 0) fails (latched is still 0 at that moment), and
> > > then the latching cmpxchg(latched, 0, 1) fires anyway — with count=0:
> > > 
> > >   CPU 0 (add_req, count just hit 64)       GP kthread
> > >   ----------------------------------       ----------
> > >   llist_add()    <-- entry now in srs_next
> > >   inc_return()   --> nr = 64
> > >   [preempted]
> > >                                             rcu_sr_normal_complete() x64:
> > >                                               dec_return -> count: 64..1..0
> > >                                               count==0:
> > >                                               cmpxchg(latched, 1, 0)
> > >                                                 --> FAILS (latched still 0)
> > >   [resumes]
> > >   cmpxchg(latched, 0, 1) --> latched = 1
> > > 
> > >   Final state: count=0, latched=1  -->  STUCK LATCH
> > > 
> > > All subsequent synchronize_rcu() callers see latched==1 and take the
> > > fallback path (not counted). With no new SR-normal callers,
> > > rcu_sr_normal_complete() is never reached again, so the unlatch
> > > cmpxchg(latched, 1, 0) never fires. The latch is permanently stuck.
> > > 
> > > This requires preemption for a full GP duration between llist_add() and
> > > the cmpxchg, which is probably more likely on PREEMPT_RT or heavily loaded
> > > systems.
> > > 
> > > The fix: move the cmpxchg *before* llist_add(), so the entry is not
> > > visible to the GP kthread until after the latch is already set.
> > > 
> > > That should fix it, thoughts?
> > > 
> > Yes and thank you!
> > 
> > We can improve it even more by removing atomic_cmpxchg() in
> > the rcu_sr_normal_add_req() function, because only one context
> > sees the (nr == RCU_SR_NORMAL_LATCH_THR) condition:
> > 
> > <snip>
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 86dc88a70fd0..72b340940e11 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1640,7 +1640,7 @@ static struct workqueue_struct *sync_wq;
> >  
> >  /* Number of in-flight synchronize_rcu() calls queued on srs_next. */
> >  static atomic_long_t rcu_sr_normal_count;
> > -static atomic_t rcu_sr_normal_latched;
> > +static int rcu_sr_normal_latched; /* 0/1 */
> >  
> >  static void rcu_sr_normal_complete(struct llist_node *node)
> >  {
> > @@ -1662,7 +1662,7 @@ static void rcu_sr_normal_complete(struct llist_node *node)
> >  	 * drained and if it has been latched.
> >  	 */
> >  	if (nr == 0)
> > -		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 1, 0);
> > +		(void)cmpxchg(&rcu_sr_normal_latched, 1, 0);
> >  }
> >  
> >  static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > @@ -1808,14 +1808,22 @@ static bool rcu_sr_normal_gp_init(void)
> >  
> >  static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> >  {
> > -	long nr;
> > +	/*
> > +	 * Increment before publish to avoid a complete
> > +	 * vs enqueue race on latch.
> > +	 */
> > +	long nr = atomic_long_inc_return(&rcu_sr_normal_count);
> >  
> > -	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> > -	nr = atomic_long_inc_return(&rcu_sr_normal_count);
> > +	/*
> > +	 * Latch on threshold crossing. (nr == RCU_SR_NORMAL_LATCH_THR)
> > +	 * can be true only for one context, avoiding contention on the
> > +	 * write path.
> > +	 */
> > +	if (nr == RCU_SR_NORMAL_LATCH_THR)
> > +		WRITE_ONCE(rcu_sr_normal_latched, 1);
> 
> Isn't it still racy?
> 
> rcu_sr_normal_add_req                                   rcu_sr_normal_complete
> ---------------------                                   ----------------------
>                                                         nr = atomic_long_dec_return(&rcu_sr_normal_count);
>                                                         // nr == 0
>                                                         ======= PREEMPTION =======
> // 64 tasks doing synchronize_rcu()
> rcu_sr_normal_add_req()
>    WRITE_ONCE(rcu_sr_normal_latched, 1);
>                                                         cmpxchg(&rcu_sr_normal_latched, 1, 0);
> 
> 
> Also more generally there is nothing that orders the WRITE_ONCE() with the
> cmpxchg.
>
Yep that i know. This is rather "relaxed" mechanism rather than
a strictly ordered. The race you described can happen but i do not
find it as a problem because as noted it is relaxed policy flag.

But WRITE_ONCE() i can replace by:

if (nr == RCU_SR_NORMAL_LATCH_THR)
    cmpxchg(&rcu_sr_normal_latched, 0, 1);

>
> Is it possible to remove rcu_sr_normal_latched and simply deal with comparisons
> between rcu_sr_normal_count and RCU_SR_NORMAL_LATCH_THR?
> 
It is. But the idea with latch is a bit different then just checking
threshold. The main goal is to detect flood and lath the path until
__all__ users are flushed. I.e. it implements hysteresis to prevent
repeated switches around the threshold.

With your proposal behaviour becomes different.

Thoughts?

--
Uladzislau Rezki

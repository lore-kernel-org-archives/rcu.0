Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B018368947
	for <rcu@vger.kernel.org>; Wed, 11 Mar 2026 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218719; cv=none; b=Rv0O1r19ODptSeKKkgY7a8JA/0PTqohiQcihhKxUpX0q0yZatWtpiSi1Yak9vLQvGxbQGGb3wbenSHijlpRKyo3e9E3oXBgl49coOoSDgwmnAVDNa8QVEsHIIOB26Qz3bOwsDCNyM1RsV1eiHY56X9GmiuRomxMLizmIbMlOw/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218719; c=relaxed/simple;
	bh=oOT9yiLaConydp2X9aibOi/2mvZ6/SlN8Kib2TRX8rs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ6y+RoG+95ocQOoSviGGca5cC2G+haNW9A+Dc/iDaVSK8KhrcIkuzt18hpc5oWqNu0fFwin+LbMcgnJ2U7E5l+woVc2ysN/hb8kh4+kXhMmgUBOWzSFJt0S/d2vKpwaj99Zcwnxxhnsn4nnJrsPwEBJfbbRIA87jsHloUePCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V77nBBe8; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V77nBBe8"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38a3990e87fso34517631fa.3
        for <rcu@vger.kernel.org>; Wed, 11 Mar 2026 01:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773218715; x=1773823515; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F5Zw0kiAgkQZP/2xYGJJZKe3e37OXmx1+McOOFoII7o=;
        b=V77nBBe8Wb7vjvZN8lu/NtBcM6oHnA9GvARgwonIW0NdgUP0uDE5FP9QWEoqAtFk3k
         aHhivNIQxzQJ9g7TRlhAAIWA25XhlW0dSG/2SkFBq2ok2cyncNEwdC1gPsQwTrSMsm9j
         S6rxtTHuHBRiXZcz0e8vmUvcPM2ZLfDF/wWBlFozhAbRoi9uPKyzr+lpNLQeu9xCa4hI
         f6VTfJc9EnG6EaVlKJQZqsCim/HxdidyyM1rzCTALPhiwlWCccYYN5yz79OCARdbeFw+
         UL/9YNc16Ex0e/GAeIczV62UdGNrEyNOwh+eNIN6Z9j/atFzYW+Q6qmcAB0jamEs4sRo
         4P9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218715; x=1773823515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5Zw0kiAgkQZP/2xYGJJZKe3e37OXmx1+McOOFoII7o=;
        b=cAn0onOiVncwslaJjUmO2Qkv7fIGZJ6S0a3uFIeoanq5uQSQbhPuxCGS7p+foSJMbQ
         p+9u4ZWFxzeu7ozXGTIw0NlFUCFrZuFmMlJ3GAmNNxVLruX83mII0tbFdTsQu2rY7pGh
         a7mOS/C+jj/KLSZKa5GoleUah+sBolwwo9UccYbHxfO1e4GBjs+/zzM//cNGkA8FCyNL
         NzOhcrhqa3FxQ3j2LLyZLOEUOJm14QIAazyq+fzONV7WYuNy1vxLsWeEsC/sOc6daSQy
         7XmHvL6t2+sV/eqkGhmb6eslRkAWa9pqdR07oeg9VhwyuesspB6yQZx7jKPGLW71faof
         MWVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv1MWwCjeCCn4AKqh2HHz2MTQ9LjkdtXsbkEdHfKLiyUhIx+XWcD/PUW3cXHaPPOVph+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN3EFXnVOcwvsWvF6sWHN50+p0zQwrKE/cG7+Zut8RtgErudtZ
	X7xbnu095WVfyCJjjNS7Wovj6aNGpIVdKe9wvnveHQsLIE7lFZPtRt8l
X-Gm-Gg: ATEYQzwGMLg5SPTR4PXnraHYiZe1Cr/PNByi1OkrJTejK4LqkkxdGa1uegI3zftXumQ
	ZzwIRqFdk3AwspvzdVBJeo/MYcYG5BvW0IpVZoADvxe9I2clrf1w4EcffzIBx1kBgpQQDAlIAoA
	+/J00HpNX2V9QSDw1Tw/rtE//0hgSOg3hUibiSQrFGzXNF606UxxtDQOTgQxTby8tZ//oymhy7F
	Ub9nEhvkH18mD7nLbcy0meURFCap492qL+0B3OtF7ImRdsSAUXtlyk2GKhaj5TbzgIA/VUcQPdB
	OiQTkODg+fupZ0350Vf5v9AKP+ZblWspbcTYoplrHSPtKTeFvIPShi7JRWFGIxNY44D1Xg5I7/B
	uPDrcqlGJCH0zZLg57E6NwUXk2Gz49qPgySf29JvACcJHgyXQqUo9my60fxZHyDiuxtnxFTXkgG
	1YJUZ38ZNzXvQKAZUu/XYE1YWAXjS7Tq3k9zF3EtMmNbYnGMuBMg==
X-Received: by 2002:a05:651c:2118:b0:38a:4197:862c with SMTP id 38308e7fff4ca-38a67dc32aamr6258101fa.9.1773218714787;
        Wed, 11 Mar 2026 01:45:14 -0700 (PDT)
Received: from pc636 (host-95-203-16-219.mobileonline.telia.com. [95.203.16.219])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67d61f1asm2293781fa.2.2026.03.11.01.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:45:14 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 11 Mar 2026 09:45:12 +0100
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
Message-ID: <abErmN5ywlEhGFAv@pc636>
References: <20260302100404.2624503-1-urezki@gmail.com>
 <14e954e4-cfa6-4069-a25f-ccb444d17535@nvidia.com>
 <aaliA7sc4Nnu_i_C@milan>
 <abAmiX85PFNq2Ua-@localhost.localdomain>
 <abBGpuDHlAlPmH4g@milan>
 <abCaAHBZSwqXJzuy@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abCaAHBZSwqXJzuy@pavilion.home>

On Tue, Mar 10, 2026 at 11:24:00PM +0100, Frederic Weisbecker wrote:
> Le Tue, Mar 10, 2026 at 05:28:22PM +0100, Uladzislau Rezki a écrit :
> > Hello, Frederic!
> > 
> > > Le Thu, Mar 05, 2026 at 11:59:15AM +0100, Uladzislau Rezki a écrit :
> > > > On Tue, Mar 03, 2026 at 03:45:58PM -0500, Joel Fernandes wrote:
> > > > > On Mon, 02 Mar 2026 11:04:04 +0100, Uladzislau Rezki (Sony) wrote:
> > > > > 
> > > > > >  * The latch is cleared only when the pending requests are fully
> > > > > >    drained(nr == 0);
> > > > > 
> > > > > > +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > > > > > +{
> > > > > > +	long nr;
> > > > > > +
> > > > > > +	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> > > > > > +	nr = atomic_long_inc_return(&rcu_sr_normal_count);
> > > > > > +
> > > > > > +	/* Latch: only when flooded and if unlatched. */
> > > > > > +	if (nr >= RCU_SR_NORMAL_LATCH_THR)
> > > > > > +		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
> > > > > > +}
> > > > > 
> > > > > I think there is a stuck-latch race here. Once llist_add() places the
> > > > > entry in srs_next, the GP kthread can pick it up and fire
> > > > > rcu_sr_normal_complete() before the latching cmpxchg runs. If the last
> > > > > in-flight completion drains count to zero in that window, the unlatch
> > > > > cmpxchg(latched, 1, 0) fails (latched is still 0 at that moment), and
> > > > > then the latching cmpxchg(latched, 0, 1) fires anyway — with count=0:
> > > > > 
> > > > >   CPU 0 (add_req, count just hit 64)       GP kthread
> > > > >   ----------------------------------       ----------
> > > > >   llist_add()    <-- entry now in srs_next
> > > > >   inc_return()   --> nr = 64
> > > > >   [preempted]
> > > > >                                             rcu_sr_normal_complete() x64:
> > > > >                                               dec_return -> count: 64..1..0
> > > > >                                               count==0:
> > > > >                                               cmpxchg(latched, 1, 0)
> > > > >                                                 --> FAILS (latched still 0)
> > > > >   [resumes]
> > > > >   cmpxchg(latched, 0, 1) --> latched = 1
> > > > > 
> > > > >   Final state: count=0, latched=1  -->  STUCK LATCH
> > > > > 
> > > > > All subsequent synchronize_rcu() callers see latched==1 and take the
> > > > > fallback path (not counted). With no new SR-normal callers,
> > > > > rcu_sr_normal_complete() is never reached again, so the unlatch
> > > > > cmpxchg(latched, 1, 0) never fires. The latch is permanently stuck.
> > > > > 
> > > > > This requires preemption for a full GP duration between llist_add() and
> > > > > the cmpxchg, which is probably more likely on PREEMPT_RT or heavily loaded
> > > > > systems.
> > > > > 
> > > > > The fix: move the cmpxchg *before* llist_add(), so the entry is not
> > > > > visible to the GP kthread until after the latch is already set.
> > > > > 
> > > > > That should fix it, thoughts?
> > > > > 
> > > > Yes and thank you!
> > > > 
> > > > We can improve it even more by removing atomic_cmpxchg() in
> > > > the rcu_sr_normal_add_req() function, because only one context
> > > > sees the (nr == RCU_SR_NORMAL_LATCH_THR) condition:
> > > > 
> > > > <snip>
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 86dc88a70fd0..72b340940e11 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -1640,7 +1640,7 @@ static struct workqueue_struct *sync_wq;
> > > >  
> > > >  /* Number of in-flight synchronize_rcu() calls queued on srs_next. */
> > > >  static atomic_long_t rcu_sr_normal_count;
> > > > -static atomic_t rcu_sr_normal_latched;
> > > > +static int rcu_sr_normal_latched; /* 0/1 */
> > > >  
> > > >  static void rcu_sr_normal_complete(struct llist_node *node)
> > > >  {
> > > > @@ -1662,7 +1662,7 @@ static void rcu_sr_normal_complete(struct llist_node *node)
> > > >  	 * drained and if it has been latched.
> > > >  	 */
> > > >  	if (nr == 0)
> > > > -		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 1, 0);
> > > > +		(void)cmpxchg(&rcu_sr_normal_latched, 1, 0);
> > > >  }
> > > >  
> > > >  static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > > @@ -1808,14 +1808,22 @@ static bool rcu_sr_normal_gp_init(void)
> > > >  
> > > >  static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > > >  {
> > > > -	long nr;
> > > > +	/*
> > > > +	 * Increment before publish to avoid a complete
> > > > +	 * vs enqueue race on latch.
> > > > +	 */
> > > > +	long nr = atomic_long_inc_return(&rcu_sr_normal_count);
> > > >  
> > > > -	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> > > > -	nr = atomic_long_inc_return(&rcu_sr_normal_count);
> > > > +	/*
> > > > +	 * Latch on threshold crossing. (nr == RCU_SR_NORMAL_LATCH_THR)
> > > > +	 * can be true only for one context, avoiding contention on the
> > > > +	 * write path.
> > > > +	 */
> > > > +	if (nr == RCU_SR_NORMAL_LATCH_THR)
> > > > +		WRITE_ONCE(rcu_sr_normal_latched, 1);
> > > 
> > > Isn't it still racy?
> > > 
> > > rcu_sr_normal_add_req                                   rcu_sr_normal_complete
> > > ---------------------                                   ----------------------
> > >                                                         nr = atomic_long_dec_return(&rcu_sr_normal_count);
> > >                                                         // nr == 0
> > >                                                         ======= PREEMPTION =======
> > > // 64 tasks doing synchronize_rcu()
> > > rcu_sr_normal_add_req()
> > >    WRITE_ONCE(rcu_sr_normal_latched, 1);
> > >                                                         cmpxchg(&rcu_sr_normal_latched, 1, 0);
> > > 
> > > 
> > > Also more generally there is nothing that orders the WRITE_ONCE() with the
> > > cmpxchg.
> > >
> > Yep that i know. This is rather "relaxed" mechanism rather than
> > a strictly ordered. The race you described can happen but i do not
> > find it as a problem because as noted it is relaxed policy flag.
> 
> Ok, that will need a comment explaining how and why we tolerate missed
> latches then.
> 
Makes sense!

> > 
> > But WRITE_ONCE() i can replace by:
> > 
> > if (nr == RCU_SR_NORMAL_LATCH_THR)
> >     cmpxchg(&rcu_sr_normal_latched, 0, 1);
> 
> Possibly yes, though I'm not sure that would help.
> 
Just to align with second place where we drop rcu_sr_normal_latched.

> > > Is it possible to remove rcu_sr_normal_latched and simply deal with comparisons
> > > between rcu_sr_normal_count and RCU_SR_NORMAL_LATCH_THR?
> > > 
> > It is. But the idea with latch is a bit different then just checking
> > threshold. The main goal is to detect flood and lath the path until
> > __all__ users are flushed. I.e. it implements hysteresis to prevent
> > repeated switches around the threshold.
> 
> Good point!
> 
> > With your proposal behaviour becomes different.
> > 
> > Thoughts?
> 
> Good thoughts! :-)
> 
Thank you Frederic :)

--
Uladzislau Rezki

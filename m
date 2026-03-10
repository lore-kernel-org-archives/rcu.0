Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB213D9DC2
	for <rcu@vger.kernel.org>; Tue, 10 Mar 2026 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146260; cv=none; b=ctJJB3xncyKgk0YA/HWNzBfp/3WN+0KXeKaXZ6fInTNFR1f8Bx/SzoFMSOiPWIiVG+oYPtbJtzYbUBt2e/+CO3oe8BwXmc2TbJKJH1b7ZdjOL1lXRpY9UODLDfQnhYl0REFuDp0lplB6gJTLTqueWLPZihd+6xdobeux4++noZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146260; c=relaxed/simple;
	bh=0bAhRDyvGa4cS+4K0qhSHzgqCGxW2jh+MxKRm5W2UU0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGAq6zgHhLecLdUS8S8KWvcKlj0zbqRaxZHeB8YzDPRTjHXupJwuVnNSzbVHCKnewvmsrUBc/vKU48m2s2eU/KTuDOK5JeCRzd6Kn4bGDsitSiLZoIao1rW9MOnxiYjUAaw/+jbZEqBVOyZ2SgB6XGiQdQS+HfD1/3/IOVFbULc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHS+Fdvd; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHS+Fdvd"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38a3fd333eeso33636371fa.1
        for <rcu@vger.kernel.org>; Tue, 10 Mar 2026 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773146257; x=1773751057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dE4ZSs01YcC6EqrF1gb9FT1sy8HSTnoh20t3NFf4UnI=;
        b=IHS+Fdvdcm2PdcstnztFQh5JifAIjgdk2tIhgg94bKP/IyS5hV1xkZvbwMDRaBG3U2
         VO6alPVf9qhzSK7nKrnSANDPo2pW+X5TOlT1aTIO3u5jx06ENjs+iIAzSfSnqrEf4zWn
         93jSh2vPe/WxZlfPAps+8G+7JWYzCnGj5OqfX5EnrlAGualpyddpqhwpqnrO0c23L3Vx
         +wBAPc2g8FAmrKATOmzjRrMhFLd4nfT9byabSocanTWFbGZjEcDp4VRo4rdzznz8YUZ+
         3khkJwVH8z1XfIBuA0vxRk6q5QZQoVZUujY1/U5Ukyhj2LZV7MLiqIZUpigFTwlYARoF
         iR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773146257; x=1773751057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dE4ZSs01YcC6EqrF1gb9FT1sy8HSTnoh20t3NFf4UnI=;
        b=WeJGIm8qeIVJ6J3v/0ra+mR6XyQfa2kg7SVNsipovyKh67yBEFl8IzRW5YImEA/7Wz
         TIZyVyP69NUaBIhTldc4HLv9SBr0SCNsBC2E7H76l+lGhFZdQ5Et7+7WW3noID0E5KrW
         CK1aKuld836k0tEzEEEsyaq6BSBbUfUdzrOghCssZjTgfRwSrJ43AAFUENB4a+xnJ7xt
         1n/7kDP3Et/V34ChKVx3Z4rRlZkhlNAGmVAy/461o5ZxLwl8qOKSttL6lIp3fBMNJZS2
         laTCU1cs9C+O99bOMKYD6cSDvvvRv46U2hT40A8w5Au6CD08oKyq3I9z7b/3XAGTZDUz
         f8Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXXSLeawuOjafvWCji4w1PwgYsIvwyTdeRxLAN9YGh6dcOsUM4CYnlLno+1ttKcV7YVEZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLjeB4iElu92suhV4luKkwhxzKIP/eYeY7ni0nkrU5BqPYy5k9
	0eA4DS7QCulkw2wPDCGbQANT4EqVE1SMv7C37/KJ37O1lg4Fs4ucmlzh
X-Gm-Gg: ATEYQzxT24HHRoeZlpqmLVqRbaLtquGmBMcDuUBA58ncqW9QzzUEGmoao/+XdrquYIz
	FEZI+7lh3Ui+IF47xJtr84HGgZNFyel8/iHyE2YQ3UvnpYkuNLkz02jt0La33YD/qvFN5r9Ekj/
	JsUFtyrcEtUvRwNvzNxPphQOduUw5bCCszHhm36QpE0G4lyqyHfOtH8/2N/6cFQ0PXbl3dZAbnD
	lESiT+iWoIbxzzA8Wt011KFxfKJuN++4Bcwz3kZPDCZotBBu0Gmr+EmOFX2fr7ctAShBLqQzBLq
	gFKl7v9InxgxDqEorsfqgMSIzOHrOp4oUcFX6/p1Kp/TvmMriJ1CnRrtZCQlrLQoHtxea/2+N4I
	qHYSmPhJLqMKOJ00wXNheYo+su2kZGXD5nWdKP/Inzsvd44NyTTxlPp1zxcjbqhCvDQ5K78K0C8
	1nUByv9l0fvo9G8VqsdtdD08NV0yPV0YxfLr9XQemEkSGi5U1sog==
X-Received: by 2002:a2e:b1cb:0:b0:389:e6e4:3c7d with SMTP id 38308e7fff4ca-38a5d049f5dmr9094331fa.19.1773146256916;
        Tue, 10 Mar 2026 05:37:36 -0700 (PDT)
Received: from pc636 (host-95-203-16-219.mobileonline.telia.com. [95.203.16.219])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a5cfa1144sm5157871fa.6.2026.03.10.05.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:37:36 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 10 Mar 2026 13:37:34 +0100
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Paul E.McKenney" <paulmck@kernel.org>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Samir M <samir@linux.ibm.com>
Subject: Re: [PATCH v2] rcu: Latch normal synchronize_rcu() path on flood
Message-ID: <abAQjtW_F7E6mKrS@pc636>
References: <20260302100404.2624503-1-urezki@gmail.com>
 <14e954e4-cfa6-4069-a25f-ccb444d17535@nvidia.com>
 <aaliA7sc4Nnu_i_C@milan>
 <b900330f-0c77-4eb8-bb11-c3083571ae77@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b900330f-0c77-4eb8-bb11-c3083571ae77@nvidia.com>

On Mon, Mar 09, 2026 at 04:32:46PM -0400, Joel Fernandes wrote:
> 
> 
> On 3/5/2026 5:59 AM, Uladzislau Rezki wrote:
> > On Tue, Mar 03, 2026 at 03:45:58PM -0500, Joel Fernandes wrote:
> >> On Mon, 02 Mar 2026 11:04:04 +0100, Uladzislau Rezki (Sony) wrote:
> >>
> >>>  * The latch is cleared only when the pending requests are fully
> >>>    drained(nr == 0);
> >>
> >>> +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> >>> +{
> >>> +	long nr;
> >>> +
> >>> +	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> >>> +	nr = atomic_long_inc_return(&rcu_sr_normal_count);
> >>> +
> >>> +	/* Latch: only when flooded and if unlatched. */
> >>> +	if (nr >= RCU_SR_NORMAL_LATCH_THR)
> >>> +		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
> >>> +}
> >>
> >> I think there is a stuck-latch race here. Once llist_add() places the
> >> entry in srs_next, the GP kthread can pick it up and fire
> >> rcu_sr_normal_complete() before the latching cmpxchg runs. If the last
> >> in-flight completion drains count to zero in that window, the unlatch
> >> cmpxchg(latched, 1, 0) fails (latched is still 0 at that moment), and
> >> then the latching cmpxchg(latched, 0, 1) fires anyway — with count=0:
> >>
> >>   CPU 0 (add_req, count just hit 64)       GP kthread
> >>   ----------------------------------       ----------
> >>   llist_add()    <-- entry now in srs_next
> >>   inc_return()   --> nr = 64
> >>   [preempted]
> >>                                             rcu_sr_normal_complete() x64:
> >>                                               dec_return -> count: 64..1..0
> >>                                               count==0:
> >>                                               cmpxchg(latched, 1, 0)
> >>                                                 --> FAILS (latched still 0)
> >>   [resumes]
> >>   cmpxchg(latched, 0, 1) --> latched = 1
> >>
> >>   Final state: count=0, latched=1  -->  STUCK LATCH
> >>
> >> All subsequent synchronize_rcu() callers see latched==1 and take the
> >> fallback path (not counted). With no new SR-normal callers,
> >> rcu_sr_normal_complete() is never reached again, so the unlatch
> >> cmpxchg(latched, 1, 0) never fires. The latch is permanently stuck.
> >>
> >> This requires preemption for a full GP duration between llist_add() and
> >> the cmpxchg, which is probably more likely on PREEMPT_RT or heavily loaded
> >> systems.
> >>
> >> The fix: move the cmpxchg *before* llist_add(), so the entry is not
> >> visible to the GP kthread until after the latch is already set.
> >>
> >> That should fix it, thoughts?
> >>
> > Yes and thank you!
> > 
> > We can improve it even more by removing atomic_cmpxchg() in
> > the rcu_sr_normal_add_req() function, because only one context
> > sees the (nr == RCU_SR_NORMAL_LATCH_THR) condition:
> Sure, though you still need the atomic_long_inc_return.
> 
Yes :)

>
> But yes, the approach looks good. :-) Do you think we can have v3 ready for 7.1?
> I would like to shoot for that if possible.
> 
I will post v3 today.

--
Uladzislau Rezki

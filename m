Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD0BA2E;
	Tue,  4 Mar 2025 03:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741058639; cv=none; b=l0GIdfNGTCqPqyrW3ONYyRhS+HN3Rn/Cr3N9Mp8OLhzI/5HdNa+07VO93c3e9AdHO6ruRwFcyKveUmhM3LwIQDKdqk+IeWVlMX9GbNK6FuHG3Cl3BujpgCQzFujOYy/wLldwrNGSf7p2qpcQQbprM/Lhu5qcu0inZMRPIfSNQC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741058639; c=relaxed/simple;
	bh=LbWf2RbKFirwUyZdYNDUIyxbyF6JRTILZiEnb4AI69s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKGg6tpxvMfEwgaFJaiXTJ9CVP9YGu0VLdKmC+4wi0WdJ4BSuSTHWogvE/W6XDYTktoHcMSjwuYHFlxDVDflLcF/SQ+lhFyaAQXLF3JY8z+uWkX3fAfSXMgwED76JgT3hyFeCMFyHyjG1rUUwTrgmw0DcIhTMf7s+xH1wiXIxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOk9AKvI; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOk9AKvI"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-474f0fa7ab0so11975411cf.2;
        Mon, 03 Mar 2025 19:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741058636; x=1741663436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yHv01cpiNheinxXz1yrKQULp6f7bHddwHJ6U3E3GJdw=;
        b=YOk9AKvIfO10knFPNlVK/54fCdgNK9TVHAZTvj/g1FAVlgOW/AoTJIzUvhCNaCZC6t
         sI4e9l8MOtvNSsZ/i5LBd8yw/g+RqEGT+joBGS6fnlT3u8EXzOFljnMLSsqo+zWHvCxT
         QAet0KAeUp5uVrDtFzUnF7dIoAwTVGe8HyE3PZJtWwS8NlEExjtCYizW2mLqC4wQyuCa
         6c1KDzNX6BGBcMJB2c5TCqlH+FoVbKOrSovGHZ3nlt5sK0V1Odq89W7BoVOKHdZ875hc
         n9eYPH/rYxbkoMJbzaNWTcxvUNGRqmqFWz+B+FlC9fvZqnb9P4qlWyJ6JVQKEAVkm8FU
         pB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741058636; x=1741663436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHv01cpiNheinxXz1yrKQULp6f7bHddwHJ6U3E3GJdw=;
        b=MgwZwN5dZDZP4qaegJfWhVPA+ZzEvAuWk7dpL0Wt47hQuAnqyQVaQEXtkqe9n8Cgt/
         gsQoCm/RMKBGYGWdeMykXxpNwNOKNB6OmhJF+K8tQBHjJZsuiM2L3cYmaIP5n3QPhl0k
         ilZuwUiQVYMai9iFZ/+FT2DgkCp3kGapTb6OwHCqn2YlVsDi1jE7ABgi3fRNX8dvfBYG
         wyEqg4rtQCJYgOWItH88szKMqJG9StKxs+LgH81uLCF9RrHn1Y15MniOK66af9TKWAlM
         c+S2E2/dS0PBdFHlKd5UWqCjgcOnqzDaeFlYjq4qDPG8Ynqsrssm9oHMa4EM4DBbo7a1
         AL6A==
X-Forwarded-Encrypted: i=1; AJvYcCUnqCb/vbp1YDQ4oiIdvHzwi9mMVEOgNIUMjNw1gvT2s24hFKwdNs+c9lBBedtMa4fjS0AG@vger.kernel.org, AJvYcCWUOPm7Ormb92+Yom1Q86meIfUbivBeVnx+7b6Hq2hkO+ry46uE3GfhWo9xne98+A0SsgRKhsCp7ARP8GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytqpQMSkJQn7QJUC1Bm5nE+OJZrd2v84a9e9a+bU6VmkpZU7Ub
	yDtci03vJ7g1YBzkLeL+iX1noBop2HFshYcIfN/fsnVFouoa4CIJ
X-Gm-Gg: ASbGncs0wmHQlxecSFsFIYeEF+paTz8W5C+ctmM0+KINTDJdBWEUacRywOWDPKXDQwQ
	xTthbKEgQq9YRokn1RI8s6hniydC88Zodfv1Qr0Sa42EiMCBPv8Q4kdq8ggFLEOAVIOfBQtX0Hc
	jQ8LbyjydTO6N66kI1JPbdGA6yljoGG9pQVzU57ncLdVDSjTbLR5MSV8iK5dSjryLiQ852bB2sL
	cMXZwHtqeSUc0782d7Xz/bK4dKTlqpt8jNf7DMap/Aj7pm65SkfiS8KSSK46rgQQldzBq1Eu6eU
	1cJ98Bxp0Onlf+3WzoDxXjovGN0+dydlALKUzQrnjeZ2+MOp6uC9YGnurR8PdNU9WexJA4MU7y1
	oHwhlO/VsPOgIKa4ZNgw5cEDHtiYf6sishmc=
X-Google-Smtp-Source: AGHT+IFPVcurCGfvd7Y0KbZa5xVOXqHvwuJWMLZe83MrHJnoAvhwu0jAoHnwP61/wNiDi2LyHhJcoA==
X-Received: by 2002:a05:622a:1b28:b0:471:bd14:a77c with SMTP id d75a77b69052e-474bc0fc34cmr260555911cf.44.1741058636106;
        Mon, 03 Mar 2025 19:23:56 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474721bf582sm67161801cf.37.2025.03.03.19.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 19:23:55 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id F170D120007A;
	Mon,  3 Mar 2025 22:23:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Mar 2025 22:23:54 -0500
X-ME-Sender: <xms:SnLGZ-uwtf3uTIYFsTD08-Iive6otE4tYXTbCQovPXR65Mo863_Rtw>
    <xme:SnLGZzeS6W02ypVimTzK6bKL7bh1diUHY8gL0qvY_Lvqb5rz9nHElJYYUIOqlyiSn
    pID5BCmjOOQthki3w>
X-ME-Received: <xmr:SnLGZ5wD5RkBrlpHpQgKZRgTXmj9B44pMsfNycUemjZXyIy1Ry53DfMX_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddt
    tddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvdefgffgieejleetueettdeiieegledt
    vedvgedvjeefieevgeethedtveelueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduuddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehrtghusehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopeiiiihqqhdtuddtfedrhhgvhiesghhmrghilhdrtgho
    mhdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsegrmhgurdgtohhmpdhrtg
    hpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:SnLGZ5MddKj_8f7sIz6kA0bmU1e96r2I1SkC7Rb-pFRBrxJavBYLLg>
    <xmx:SnLGZ-9tygXGiJQ2owftJbGMrnYvtHSK5fh3iKkAJbniV8dQnV-QhQ>
    <xmx:SnLGZxUlMHG5ssgyHVAOPB5QlTtDWZU5KWy25656X6iXZjOIRmUAlA>
    <xmx:SnLGZ3c5ykpXgaXzmNXYMM8aBFCFV5sb1QrsU9AaZZ7Xm_R6mfMy2Q>
    <xmx:SnLGZ4cuILxgRThkoY0v8-wKReEAe8CJADQ3GeNqGesmQjW8wt3QUxTo>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 22:23:54 -0500 (EST)
Date: Mon, 3 Mar 2025 19:23:29 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8ZyMaUhXMIxX7WE@tardis>
References: <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <20250303001507.GA3994772@joelnvbox>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250303001507.GA3994772@joelnvbox>

On Sun, Mar 02, 2025 at 07:15:07PM -0500, Joel Fernandes wrote:
> On Fri, Feb 28, 2025 at 05:08:49PM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 28, 2025 at 11:59:55AM -0800, Paul E. McKenney wrote:
> > > On Fri, Feb 28, 2025 at 08:12:51PM +0100, Uladzislau Rezki wrote:
> > > > Hello, Paul!
> > > >=20
> > > > > > > > >=20
> > > > > > > > > Except that I got this from overnight testing of rcu/dev =
on the shared
> > > > > > > > > RCU tree:
> > > > > > > > >=20
> > > > > > > > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_=
normal_complete+0x5c/0x80
> > > > > > > > >=20
> > > > > > > > > I see this only on TREE05.  Which should not be too surpr=
ising, given
> > > > > > > > > that this is the scenario that tests it.  It happened wit=
hin five minutes
> > > > > > > > > on all 14 of the TREE05 runs.
> > > > > > > > >=20
> > > > > > > > Hm.. This is not fun. I tested this on my system and i did =
not manage to
> > > > > > > > trigger this whereas you do. Something is wrong.
> > > > > > >=20
> > > > > > > If you have a debug patch, I would be happy to give it a go.
> > > > > > >=20
> > > > > > I can trigger it. But.
> > > > > >=20
> > > > > > Some background. I tested those patches during many hours on th=
e stable
> > > > > > kernel which is 6.13. On that kernel i was not able to trigger =
it. Running
> > > > > > the rcutorture on the our shared "dev" tree, which i did now, t=
riggers this
> > > > > > right away.
> > > > >=20
> > > > > Bisection?  (Hey, you knew that was coming!)
> > > > >=20
> > > > Looks like this: rcu: Fix get_state_synchronize_rcu_full() GP-start=
 detection
> > > >=20
> > > > After revert in the dev, rcutorture passes TREE05, 16 instances.
> > >=20
> > > Huh.  We sure don't get to revert that one...
> > >=20
> > > Do we have a problem with the ordering in rcu_gp_init() between the c=
alls
> > > to rcu_seq_start() and portions of rcu_sr_normal_gp_init()?  For exam=
ple,
> > > do we need to capture the relevant portion of the list before the call
> > > to rcu_seq_start(), and do the grace-period-start work afterwards?
> >=20
> > I tried moving the call to rcu_sr_normal_gp_init() before the call to
> > rcu_seq_start() and got no failures in a one-hour run of 200*TREE05.
> > Which does not necessarily mean that this is the correct fix, but I
> > figured that it might at least provide food for thought.
> >=20
> >                                           Thanx, Paul
> >=20
> > ------------------------------------------------------------------------
> >=20
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 48384fa2eaeb8..d3efeff7740e7 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1819,10 +1819,10 @@ static noinline_for_stack bool rcu_gp_init(void)
> > =20
> >        /* Advance to a new grace period and initialize state. */
> >        record_gp_stall_check_time();
> > +      start_new_poll =3D rcu_sr_normal_gp_init();
> >        /* Record GP times before starting GP, hence rcu_seq_start(). */
> >        rcu_seq_start(&rcu_state.gp_seq);
> >        ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > -      start_new_poll =3D rcu_sr_normal_gp_init();
> >        trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("st=
art"));
>=20
> Oh... so the bug is this? Good catch...
>=20
>=20
> CPU 0                                           CPU 1
>=20
>                                                 rcu_gp_init()
>                                                       rcu_seq_start(rcu_s=
tate.gp_seq)
> sychronize_rcu_normal()
>       rs.head.func
>       	=3D (void *) get_state_synchronize_rcu();
>                    // save rcu_state.gp_seq
>       rcu_sr_normal_add_req() ->
>             llist_add(rcu_state.srs_next)
>       (void) start_poll_synchronize_rcu();
>=20
>=20

This means synchronize_rcu_normal() got the new state of gp_seq, but
its wait request was inserted before the new wait_head, therefore..

>                                                       sr_normal_gp_init()
>                                                             llist_add(wai=
t_head, &rcu_state.srs_next);
> 							    // pick up the
> 							    // injected WH
>                                                             rcu_state.srs=
_wait_tail =3D wait_head;
>=20
>                                                 rcu_gp_cleanup()
>                                                       rcu_seq_end(&rcu_st=
ate.gp_seq);
>                                                       sr_normal_complete()

at rcu_gp_cleanup() time, rcu_sr_normal_complete() complete the
corresponding wait request, however, the sychronize_rcu_normal()
observed the new gp_seq, its poll state will expect the next gp, hence
the WARN_ONCE().

Yes, I believe this is the scenario for the bug.

>                                                             WARN_ONCE(IS_=
ENABLED(CONFIG_PROVE_RCU) &&
>                                                             !poll_state_s=
ynchronize_rcu(oldstate),
>=20
> Where as reordering sr_normal_gp_init() prevents this:
>=20
>                                                 rcu_gp_init()
>=20
>                                                       sr_normal_gp_init()
> 							    // WH has not
> 							    // been injected
> 							    // so nothing to
> 							    // wait on
>=20

I don't quite get the comment above, the fix I believe is that wait_head
was inserted with a llist_add() which is a fully ordered cmpxchg(), so
we have:

							  llist_add(wait_head, ..)
							  // ^ provding the ordering againt
							  // the seq change below

, which means if...

>                                                       rcu_seq_start(rcu_s=
tate.gp_seq)
> sychronize_rcu_normal()
>       rs.head.func
>       	=3D (void *) get_state_synchronize_rcu();
>                    // save rcu_state.gp_seq

=2E.. the synchronize_rcu_normal() observes the new gp_seq, then...

>       rcu_sr_normal_add_req() ->
>             llist_add(rcu_state.srs_next)

=2E.. when its corresponding wait request gets queued, the above wait_head
must be already in the llist...

>       (void) start_poll_synchronize_rcu();
>=20
>                                                 rcu_gp_cleanup()
>                                                       rcu_seq_end(&rcu_st=
ate.gp_seq);

=2E.. hence, as the comment below said, won't do anything.

>                                                       // sr_normal_comple=
te()
> 						      // wont do anything so
> 						      // no warning
>=20
> Did I get that right?
>=20

Other than I'm unable to follow what do you mean "WH has not been
injected, so nothing to wait on", maybe because I am missing some
terminology from you ;-) I think it's a good analysis, thank you!

> I think this is a real bug AFAICS, hoping all the memory barriers are in
> place to make sure the code reordering also correctly orders the accesses.
> I'll double check that.
>=20
> I also feel its 'theoretical', because as long as rcu_gp_init() and
> rcu_gp_cleanup() are properly ordered WRT pre-existing readers, then
> synchronize_rcu_normal() still waits for pre-existing readers even though=
 its
> a bit confused about the value of the cookies.
>=20
> For the fix,
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>=20
> (If possible, include a Link: to my (this) post so that the sequence of
> events is further clarified.)
>=20

Will add the tag (with the email you really want ;-)) and a link to this
email to the patch. Thanks!

Regards,
Boqun

> thanks,
>=20
>  - Joel
>=20

Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06C0C4332F
	for <rcu@archiver.kernel.org>; Tue, 13 Dec 2022 19:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiLMTvx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Dec 2022 14:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiLMTvv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Dec 2022 14:51:51 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F83B2124F
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 11:51:49 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h16so787152qtu.2
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 11:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpRpLw4ovkUnAdHKvukhw694LdDvnG3Qr4ym1x67X+Q=;
        b=Dz4RypEjEYeKhohcQrBzcHjsgAonpyjETm9g0Va4FeQFIEypJm+Fd5//n2Y3l7o6Bk
         ULLqkWJrNwq2/6MsvQdaQqy4Zw9eBwbxEuA3rZMw7Mv8dLWIKHFE8Bol20MxrVpN1asi
         mmBSfdg450BhIfuewc9Z15GA/mdj/AQwajOVQGE9eGBW7qx+KmMIUW569UwL0nxFdzn6
         RAqhW6SM1hHF9GRtWc0ZcO4x1shKlPkCCiwK1Zd/YufsolqInQIxQa35KKoq4bHI+fE3
         0u5X+e8fSh/hq4JWKtNcxUvl74jYe28XCPQHtMJuEH2NC/5eNznR5fU/3xTl9/wlWiue
         dk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpRpLw4ovkUnAdHKvukhw694LdDvnG3Qr4ym1x67X+Q=;
        b=Y6mp83qIWYUDrDfHCV0Eqx3SRKA2hCcxtLA9fbbZ+JX6fJpy++7+f78w4gD4umAO1D
         MbwQFakI1wKVwIo6NOCbag6zLfN2Uy+i0U8/npoDVdHLyjO8JFqkhGFjsfqO1vQWY8y8
         68ZXX0zQDXfIGnjbMEwQ+8T/yROEXoe9bCKwqusbMQ3u16WfScPBRPhwbJKuK9cAbMp6
         9rMj/qcoQKzTJm8Xc/KegnUdOIF/rkj1MN5RKgIlCz3UFFcBF2LHG3zQnq2n6doOd0lu
         4EZcNyPNsWYuvhp/d/bKqX5HZLH7KUdrPVvBH7zTvzFJYyLMfEdhsh4ufjGew52JokFI
         q1bw==
X-Gm-Message-State: ANoB5plTw5gMaZ9v/TKHMijLI7F7IhZ/iq3MJLT/gUYa6W35NN2Wl+6V
        v6QUvox23r1YLWmYLr7iPAY=
X-Google-Smtp-Source: AA0mqf72JU1fVfGFpQ1IgalBZUcEGwPQU2Jz3K6DnSfkdJ36FiD0jsmr7V4usdwMa/2HOhrCefA5Rw==
X-Received: by 2002:a05:622a:411b:b0:3a6:93d7:873f with SMTP id cc27-20020a05622a411b00b003a693d7873fmr6403202qtb.49.1670961108734;
        Tue, 13 Dec 2022 11:51:48 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b22-20020ac87fd6000000b003a6a4744432sm415591qtk.87.2022.12.13.11.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:51:48 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9954527C0054;
        Tue, 13 Dec 2022 14:51:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 13 Dec 2022 14:51:47 -0500
X-ME-Sender: <xms:0teYY1YQYDuymgoKOtCxoHYz2xH0M5QnGC4uj2JtTrISQjhUxqWgTg>
    <xme:0teYY8ZU0oET7V0BFXtJ8oBzK-NMiKzyjten7CkFNCuPNAVOdjUTQOhC-C_3251QU
    vXdyidICeRc0BPdrQ>
X-ME-Received: <xmr:0teYY39UoBDA8QWNsgx_jnXtcFYRl9SetQL0EgD0-G1r35IrlgzsvKLjkfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedugdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:0teYYzqAJWxx3acR7WYScNyGxOS5RZ14XzbobRbHHnWW6zUdWeQj3Q>
    <xmx:0teYYwp553o5sZ_CPZHNnJaU8girzDF-Lr2T8SDwkvzQMDc5zVtj2Q>
    <xmx:0teYY5QhbA0toNqop4U_RuLxDoHcBLiEVMtFIVyexZVsMhP7mX2Ewg>
    <xmx:09eYY8damZo55lNpyr_Sx_h8IaYH6Lh5FpOiqjUH_ROmrOfyUqLT8w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Dec 2022 14:51:46 -0500 (EST)
Date:   Tue, 13 Dec 2022 11:51:21 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: Re: [PATCH] srcu: switch work func to allow concurrent gp
Message-ID: <Y5jXuVHKippIZ24j@boqun-archlinux>
References: <20221130083902.31577-1-kernelfans@gmail.com>
 <Y4eKl2fCNDX2ka1g@boqun-archlinux>
 <Y4ix4BWZvTrk9WkJ@piliu.users.ipa.redhat.com>
 <Y5h3bmckCkJQ6cmg@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5h3bmckCkJQ6cmg@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 13, 2022 at 09:00:30PM +0800, Pingfan Liu wrote:
> On Thu, Dec 01, 2022 at 09:53:36PM +0800, Pingfan Liu wrote:
> > On Wed, Nov 30, 2022 at 08:53:43AM -0800, Boqun Feng wrote:
> > > On Wed, Nov 30, 2022 at 04:39:02PM +0800, Pingfan Liu wrote:
> > > > ssp->srcu_cb_mutex is introduced to allow the other srcu state machine
> > > > to advance as soon as possible. But according to the implement of
> > > > workqueue, the same work_struct is serialized and can not run
> > > > concurrently in fact.
> > > > 
> > > > Quoting from Documentation/core-api/workqueue.rst
> > > > "
> > > > Non-reentrance Conditions
> > > > =========================
> > > > 
> > > > Workqueue guarantees that a work item cannot be re-entrant if the following
> > > > conditions hold after a work item gets queued:
> > > > 
> > > >         1. The work function hasn't been changed.
> > > >         2. No one queues the work item to another workqueue.
> > > >         3. The work item hasn't been reinitiated.
> > > > "
> > > > 
> > > > To allow the concurrence to some extent, it can be achieved by changing
> > > > the work function to break the conditions. As a result, when
> > > > srcu_gp_end() releases srcu_gp_mutex, a new state machine can begin.
> > > > 
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> > > > To: rcu@vger.kernel.org
> > > > ---
> > > >  kernel/rcu/srcutree.c | 19 +++++++++++++++++++
> > > >  1 file changed, 19 insertions(+)
> > > > 
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 1c304fec89c0..56dd9bb2c8b8 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -75,6 +75,7 @@ static bool __read_mostly srcu_init_done;
> > > >  static void srcu_invoke_callbacks(struct work_struct *work);
> > > >  static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
> > > >  static void process_srcu(struct work_struct *work);
> > > > +static void process_srcu_wrap(struct work_struct *work);
> > > >  static void srcu_delay_timer(struct timer_list *t);
> > > >  
> > > >  /* Wrappers for lock acquisition and release, see raw_spin_lock_rcu_node(). */
> > > > @@ -763,6 +764,11 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> > > >  		cbdelay = 0;
> > > >  
> > > >  	WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
> > > > +	/* Change work func so work can be concurrent */
> > > > +	if (ssp->work.work.func == process_srcu_wrap)
> > > > +		ssp->work.work.func = process_srcu;
> > > > +	else
> > > > +		ssp->work.work.func = process_srcu_wrap;
> > > 
> > > This looks really hacky ;-) It would be good that workqueue has an API
> > > to allow "resetting" a work.
> > > 
> > 
> > Indeed, it is hacky and it can be done by using alternative work_struct
> > so that from the workqueue API, it is intact.
> > 
> > > Do you have any number of the potential performance improvement?
> > > 
> > 
> > I will try to bring out one. But the result may heavily depend on the
> > test case.
> > 
> 
> Sorry to update late, I was interrupted by something else.

No worries, thanks for looking into it.

> 
> I used two machine to test
> 
> -1. on 144 cpus hpe-dl560gen10
> 
> modprobe rcutorture   torture_type=srcud  fwd_progress=144 fwd_progress_holdoff=1 shutdown_secs=36000 stat_interval=60 verbose=1
> 
> # no patch
> [37587.632155] srcud:  End-test grace-period state: g28287244 f0x0 total-gps=28287244
> #my patch
> [36443.468017] srcud:  End-test grace-period state: g29026056 f0x0 total-gps=29026056
> 
> 
> -2. on 256 cpus amd-milan
> modprobe rcutorture   torture_type=srcud  fwd_progress=256 fwd_progress_holdoff=1 shutdown_secs=36000 stat_interval=60 verbose=1
> 
> # no patch
> [36093.605732] srcud:  End-test grace-period state: g10850284 f0x0 total-gps=10850284
> #my patch
> [36093.856713] srcud:  End-test grace-period state: g10672632 f0x0 total-gps=10672632
> 
> 
> The first test shows that it has about 2.6% improvement, while the
> second test shows it has no significant effect.
> 
> 
> I wonder if any test case can be in flavour of my patch. Any suggestion?
> 

I actually wait you to tell me that ;-) Your trick clearly can improve
the degree of parallel a bit, but IIUC you need that srcu_end_gp() runs
at the same time with the srcu work function (i.e. pending bit is
cleared) to archieve that. And that's really a small time window ;-)

And there's always the Amdahl's law: do we know whether the state
machine processing of SRCU is the bottleneck in any workload?

And are we willing to give CPU time to SRCU state machine processing
instead of anything else?

My suggestion is to keep this patch somewhere, and whenever you see a
related problem, try the patch and see whether it helps ;-)

Regards,
Boqun

> 
> Thanks,
> 
> 	Pingfan
> 
> > Thanks,
> > 
> > 	Pingfan
> > 
> > > Regards,
> > > Boqun
> > > 
> > > >  	rcu_seq_end(&ssp->srcu_gp_seq);
> > > >  	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
> > > >  	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
> > > > @@ -1637,6 +1643,19 @@ static void process_srcu(struct work_struct *work)
> > > >  	srcu_reschedule(ssp, curdelay);
> > > >  }
> > > >  
> > > > +/*
> > > > + * The ssp->work is expected to be concurrent to some extent, but the current
> > > > + * workqueue does not support the concurrence on the same work. (Refer to the
> > > > + * section "Non-reentrance Conditions" in the file workqueue.rst)
> > > > + * Resolving it by changing the work func.
> > > > + *
> > > > + * Prevent compilering from optimizing out it.
> > > > + */
> > > > +static __used void process_srcu_wrap(struct work_struct *work)
> > > > +{
> > > > +	process_srcu(work);
> > > > +}
> > > > +
> > > >  void srcutorture_get_gp_data(enum rcutorture_type test_type,
> > > >  			     struct srcu_struct *ssp, int *flags,
> > > >  			     unsigned long *gp_seq)
> > > > -- 
> > > > 2.31.1
> > > > 

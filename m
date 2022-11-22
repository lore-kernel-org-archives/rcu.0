Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61421C4332F
	for <rcu@archiver.kernel.org>; Tue, 22 Nov 2022 09:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiKVJ7W (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Nov 2022 04:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiKVJ7U (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Nov 2022 04:59:20 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD52B186E8
        for <rcu@vger.kernel.org>; Tue, 22 Nov 2022 01:59:19 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so11611015pjh.2
        for <rcu@vger.kernel.org>; Tue, 22 Nov 2022 01:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRT500nO9ut4XtpCQ2OHPe2qt4yHY5HiNR4FKG/d4os=;
        b=hyoL40tafRzbtWrPoP9VtQ3cXMfnzazvbhlXwkYwHithTXr7NWBSgQSB4lTBqIAku6
         nJsy9c7pqKS4M/tYHjzVDVjsdKyAhmgnshJ9sxPOTZBnqhLqEoFVa4+kQGwBSD1mGhj6
         U0cziOxkzpZZBrGls4N39uwQbLhV9m3cU8cXnK7hJd2Yv4IyDMcd+ZRydSgDUq6cNaCV
         Trua9D6USdi2NrqHne6bZJNnWWuCJRjpjEEk12kJj7+sIXdsErwllNYEgYzc//zVFEbj
         avldoLZyM72QpXzBbV6dyQE/Enewr77igMifxfkak0utYMJmtWPG6rnsbFVnUuROf3HQ
         Bw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRT500nO9ut4XtpCQ2OHPe2qt4yHY5HiNR4FKG/d4os=;
        b=vNps4TooF64DeP+wyi1zsWQIMf3QVXaOrHnWRGrWQtJm6s5NY9Ue6w/xBHFyAjH68U
         VnMGeA2BCWHpzDgxX5TCnd/DlbdOzdPbE46Dv7Hd/Ow9wWIuQ9TsAn/si309rnCcbWsG
         nQzOy9Y1Tlvl2sUHZ7GizV7OXhX9nOwgldevfqi//xol825LRQbuOiJUP07jZ2dUfGTS
         9HXECK3+cBKStBQhQEtETFxxRoTTWBejjgz3zcpsPcXbxxR0SJTkOM+6HpivAkokFXkI
         ugl71cy7jVY3Cmg5XJF3TofPDg0j/wKxda2UmX4Lf7I4GnCjkL99607oOXAibX5k79P2
         W7lg==
X-Gm-Message-State: ANoB5pn0SwGE5STvFZGpxX7uAE41CJbFy7n0TS9ZPME4aJ0PoN5a6bKG
        fKo4GB3d5Okm2/O3ZW3J7w==
X-Google-Smtp-Source: AA0mqf6Jn1Q7Wa/X2eJgGjzTKB4Two54212ZqzsZTsglxv/z7mUFU5/bRBKmXQykZYLxJz4y+P9wLQ==
X-Received: by 2002:a17:902:708c:b0:189:33cd:64b with SMTP id z12-20020a170902708c00b0018933cd064bmr2342896plk.81.1669111159341;
        Tue, 22 Nov 2022 01:59:19 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902e84200b00185507b5ef8sm11625751plg.50.2022.11.22.01.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 01:59:18 -0800 (PST)
Date:   Tue, 22 Nov 2022 17:59:12 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] srcu: Remove needless updating of srcu_have_cbs in
 srcu_gp_end()
Message-ID: <Y3ydcMAkqpCGNosw@piliu.users.ipa.redhat.com>
References: <20221120034014.7390-1-kernelfans@gmail.com>
 <20221120034014.7390-3-kernelfans@gmail.com>
 <20221122011916.GT4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122011916.GT4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 21, 2022 at 05:19:16PM -0800, Paul E. McKenney wrote:
> On Sun, Nov 20, 2022 at 11:40:14AM +0800, Pingfan Liu wrote:
> > At present, snp->srcu_have_cbs[idx] is updated by either
> > srcu_funnel_gp_start() or srcu_gp_end().
> > 
> > But as the code changes, now, srcu_funnel_gp_start() is called with srcu
> > read lock held. And its input parameter s, s = rcu_seq_snap(&ssp->srcu_gp_seq),
> > whose counter field always proceeds that of the srcu_gp_seq by one or two.
> > 
> > If the seq snap only proceeds by one, the state machine should be in
> > state SRCU_STATE_IDLE, the held srcu read lock will prevent the state
> > machine from moving ahead. So when srcu_gp_end() updates
> > snp->srcu_have_cbs[idx], the idx must be the past idx for
> > srcu_funnel_gp_start() that is cared by nobody.
> > 
> > So removing the unnecessary updating in srcu_gp_end().
> 
> This looks plausible, good eyes!
> 
> But is there a debug check that could verify that this is unnecessary?
> Logical reasoning is all well and good, but the actual system always
> wins arguments.  ;-)
> 

Agree. Reasoning may miss some ground and render a wrong result.

But it is a little hard to demonstrate the past idx is not accessed. I
will go on to figure a way out.


Thanks,

	Pingfan

> 							Thanx, Paul
> 
> > Test info:
> >   Running "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --configs 18*SRCU-P"
> > without any failure.
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > To: rcu@vger.kernel.org
> > ---
> >  kernel/rcu/srcutree.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 7df59fc8073e..c54d6c04751f 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -783,8 +783,6 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> >  			last_lvl = snp >= ssp->level[rcu_num_lvls - 1];
> >  			if (last_lvl)
> >  				cbs = ss_state < SRCU_SIZE_BIG || snp->srcu_have_cbs[idx] == gpseq;
> > -			snp->srcu_have_cbs[idx] = gpseq;
> > -			rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
> >  			sgsne = snp->srcu_gp_seq_needed_exp;
> >  			if (srcu_invl_snp_seq(sgsne) || ULONG_CMP_LT(sgsne, gpseq))
> >  				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
> > -- 
> > 2.31.1
> > 

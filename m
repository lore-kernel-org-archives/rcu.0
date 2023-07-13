Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15359EB64DA
	for <rcu@archiver.kernel.org>; Thu, 13 Jul 2023 01:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjGMBfc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Jul 2023 21:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjGMBfb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Jul 2023 21:35:31 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDCF1FC8
        for <rcu@vger.kernel.org>; Wed, 12 Jul 2023 18:35:30 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-345d6dc271dso714285ab.0
        for <rcu@vger.kernel.org>; Wed, 12 Jul 2023 18:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689212130; x=1691804130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qaRxxdr7002yjY9Sb9rO/hl+wvbOVuHe+f71rQQmNs8=;
        b=ZMHAvknOnwQhd7hwVntmR134VIf/xa8j7HZiHjXQ9avrdkys1ATjg4U+6vtSQiEsvf
         GhRM6CAI2OjvDFIornwXuZ348pIlr8Y+MbRK0iFbTN3mULWh7l5Wo6vG2kDv1f1xKnde
         +1VhH8VNCIxNdnXEyC9Uhgl1/ul6MJ6kfbsvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689212130; x=1691804130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaRxxdr7002yjY9Sb9rO/hl+wvbOVuHe+f71rQQmNs8=;
        b=WYcj9eYOSXg6Po/lhwgYWZO56PCJMNw2qoQoZrq2lMm2boywiNvCtEuCbCn+mR2LoV
         sS+MU4nL3fXWbPgvAdhppXBRQ549NHObWxjzY3iwZD/AY8Xc+Ocu2PAJQRk2Amwgmjqs
         HyKx3xlkp52e/YK0KnSiRFINUpQwkp11/m700zd0xsw1W3+6QBMLrV4SpqbsiANEkUP5
         DQXRz3G8NRuR13RjhtNns3MVFCY9CqHvfGzmFn8CR/0ckN/x5rIYdhJTXZ8FGUyt+OJ2
         R0AB6UtpwfkPDGksU1cv1AgRiaxW83rbbVivewD+ovdeQFlvCdQOVSLGv/b2I1ifA3RS
         0RLg==
X-Gm-Message-State: ABy/qLbhL/0dAUalOGDLJg+8vbjwBa9j380Ub6eYT/8rt0vzCR9tw+C0
        XVOSuSvHcaygTZBrQ7AwDrxb1w==
X-Google-Smtp-Source: APBJJlEreT5I7mhbY3CrgO4nPjdHks9kWfD2/wzw3a1D2fzQTpHAli4eHhivkahHLSwBjGrsEf0UHQ==
X-Received: by 2002:a92:de0e:0:b0:347:70a8:1749 with SMTP id x14-20020a92de0e000000b0034770a81749mr71357ilm.24.1689212130076;
        Wed, 12 Jul 2023 18:35:30 -0700 (PDT)
Received: from localhost (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id k1-20020a02a701000000b0042b2df337ccsm1483077jam.76.2023.07.12.18.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 18:35:29 -0700 (PDT)
Date:   Thu, 13 Jul 2023 00:32:01 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sandeep Dhavale <dhavale@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <20230713003201.GA469376@google.com>
References: <20230711233816.2187577-1-dhavale@google.com>
 <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
 <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 12, 2023 at 02:20:56PM -0700, Sandeep Dhavale wrote:
[..]
> > As such this patch looks correct to me, one thing I noticed is that
> > you can check rcu_is_watching() like the lockdep-enabled code does.
> > That will tell you also if a reader-section is possible because in
> > extended-quiescent-states, RCU readers should be non-existent or
> > that's a bug.
> >
> Please correct me if I am wrong, reading from the comment in
> kernel/rcu/update.c rcu_read_lock_held_common()
> ..
>   * The reason for this is that RCU ignores CPUs that are
>  * in such a section, considering these as in extended quiescent state,
>  * so such a CPU is effectively never in an RCU read-side critical section
>  * regardless of what RCU primitives it invokes.
> 
> It seems rcu will treat this as lock not held rather than a fact that
> lock is not held. Is my understanding correct?

If RCU treats it as a lock not held, that is a fact for RCU ;-). Maybe you
mean it is not a fact for erofs?

> The reason I chose not to consult rcu_is_watching() in this version
> is because check "sleeping function called from invalid context"
> will still get triggered (please see kernel/sched/core.c __might_resched())
> as it does not consult rcu_is_watching() instead looks at
> rcu_preempt_depth() which will be non-zero if rcu_read_lock()
> was called (only when CONFIG_PREEMPT_RCU is enabled).

I am assuming you mean you would grab the mutex accidentally when in an RCU
reader, and might_sleep() presumably in the mutex internal code will scream?

I would expect in the erofs code that rcu_is_watching() should always return
true, so it should not effect the decision of whether to block or not. I am
suggesting add the check for rcu_is_watching() into the *held() functions for
completeness.

// will be if (!true) when RCU is actively watching the CPU for readers.
bool rcu_read_lock_any_held() {
	if (!rcu_is_watching())
		return false;
	// do the rest..
}

> > Could you also verify that this patch does not cause bloating of the
> > kernel if lockdep is disabled?
> >
> Sure, I will do the comparison and send the details.

Thanks! This is indeed an interesting usecase of grabbing mutex / blocking in
the reader.

thanks,

 - Joel


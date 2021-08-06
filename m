Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E086C4338F
	for <rcu@archiver.kernel.org>; Fri,  6 Aug 2021 07:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27ADB601FD
	for <rcu@archiver.kernel.org>; Fri,  6 Aug 2021 07:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbhHFHl0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 6 Aug 2021 03:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29433 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231388AbhHFHl0 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 6 Aug 2021 03:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628235670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KQ5uAG6ZB/PH2y+g6j7pYC8+D6CZBF5GiL6FM0n8k9c=;
        b=HH1mPM+XAXV+e8ZjHsh94p5efFvfrCZtjp7zwKshNa8iWviaO8KKZF1YJcG9dHwccEj1kn
        vjE/AyRkSZbYEQ00FMpA6/Ahuw4FuvR38vIfKYT0Sb6RoD9UfuuIsHFtwIAufH4gy/rqPW
        KfKakh9sBjIE+7rluGblWPZD9RnHwaA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-LR0FFqjtNRmdyDeMa3VmPQ-1; Fri, 06 Aug 2021 03:41:09 -0400
X-MC-Unique: LR0FFqjtNRmdyDeMa3VmPQ-1
Received: by mail-wm1-f69.google.com with SMTP id l38-20020a05600c1d26b0290259bef426efso2164957wms.8
        for <rcu@vger.kernel.org>; Fri, 06 Aug 2021 00:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KQ5uAG6ZB/PH2y+g6j7pYC8+D6CZBF5GiL6FM0n8k9c=;
        b=Wm8/kbKw11tucvfEcK3oKL1tqtuyO3hIAydTPesC/fGfp1nLATf0V3gQ4IGLwmPgNE
         SkFB8FJei7sW9sIcm6JrVne3dCNOLTspLXvFbwd79QICOAhebC1QF3zM2ZhOkUeGpbBM
         RObbb3a1iv/mfUOHEk1GkOU5trmumdPEthTB354KxiRBCIE1CVNs7WsE6/99DC4EDs+s
         Yv8DmNpoThKJXzBdB27ULq8KEv2n7J+rW0aFQifv3ykH2anDfc7Shc/YNq/lRPKGKNSC
         040KuGDo2iYDu5YPfX8wV0ER28fK3tTJD6L6+ZJuabo2ZjcD9wIVEGb3CnelZGQOBlha
         BeAw==
X-Gm-Message-State: AOAM531fVyjz40GvYiBOskOYfIatJyEgQbQ++lk+0qM2EujX2NW9I3dc
        ttoHLxV+TCHegv3gNK65TTxr/LfvRkeu1JXt9dSd4CI3mc8xDeba3BRmMBJf5RudHogFBYnCWdR
        ZlCR/b0y6C2Bz
X-Received: by 2002:a05:600c:acd:: with SMTP id c13mr1865577wmr.189.1628235668426;
        Fri, 06 Aug 2021 00:41:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIeNVbyEjFQvuP/nx50mEMfowwJ3pAuJBOT2KcCoGtQAps+DXKwvNw1Otz+500Hn8lnUNw8w==
X-Received: by 2002:a05:600c:acd:: with SMTP id c13mr1865564wmr.189.1628235668273;
        Fri, 06 Aug 2021 00:41:08 -0700 (PDT)
Received: from localhost.localdomain ([151.29.52.108])
        by smtp.gmail.com with ESMTPSA id l7sm7614019wmj.9.2021.08.06.00.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 00:41:07 -0700 (PDT)
Date:   Fri, 6 Aug 2021 09:41:05 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Make rcu_normal_after_boot writable on RT
Message-ID: <YQznkbdkwE/356Vo@localhost.localdomain>
References: <20210805080123.16320-1-juri.lelli@redhat.com>
 <20210805160337.GI4397@paulmck-ThinkPad-P17-Gen-1>
 <20210805210824.GA1203206@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805210824.GA1203206@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

Thanks for reviewing Paul.

On 05/08/21 14:08, Paul E. McKenney wrote:
> On Thu, Aug 05, 2021 at 09:03:37AM -0700, Paul E. McKenney wrote:
> > On Thu, Aug 05, 2021 at 10:01:23AM +0200, Juri Lelli wrote:
> > > Certain configurations (e.g., systems that make heavy use of netns)
> > > need to use synchronize_rcu_expedited() to service RCU grace periods
> > > even after boot.
> > > 
> > > Even though synchronize_rcu_expedited() has been traditionally
> > > considered harmful for RT for the heavy use of IPIs, it is perfectly
> > > usable under certain conditions (e.g. nohz_full).
> > > 
> > > Make rcupdate.rcu_normal_after_boot= again writeable on RT, but keep
> > > its default value to 1 (enabled) to avoid regressions. Users who need
> > > synchronize_rcu_expedited() will boot with rcupdate.rcu_normal_after_
> > > boot=0 in the kernel cmdline.
> > > 
> > > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > 
> > Makes sense to me!
> > 
> > But would another of the -rt people be willing to give an Acked-by?
> > For example, maybe they would prefer this kernel boot parameter to be
> > exposed only if (!PREEMPT_RT || NO_HZ_FULL).  Or are there !NO_HZ_FULL
> > situations where rcu_normal_after_boot makes sense?
> 
> Ah, and this will also need to be reflected in the WARN_ON_ONCE()
> in synchronize_rcu_expedited_wait() in kernel/rcu/tree_exp.h.

Indeed. Will add the change as soon as I receive indication about your
first point.

Best,
Juri


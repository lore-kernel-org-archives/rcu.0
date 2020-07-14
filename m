Return-Path: <SRS0=gxlL=AZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE60C433E0
	for <rcu@archiver.kernel.org>; Tue, 14 Jul 2020 20:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6899C21527
	for <rcu@archiver.kernel.org>; Tue, 14 Jul 2020 20:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbXeRrFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgGNURj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgGNURi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 14 Jul 2020 16:17:38 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800BDC061755;
        Tue, 14 Jul 2020 13:17:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t9so13181181lfl.5;
        Tue, 14 Jul 2020 13:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7gM/D7X4Px1PAJl5nZi9KE2EoEB12I2kmkXvzNOm5Jw=;
        b=AbXeRrFaDICon3lRQAXfYLh7Hl05VoMmEY2Dy22Yf8PFbFOhYKUsTpN67w0rCzM6J4
         FdfHDJIj1UaB0jGHBM9Yzbs4O9SFmDWAi1K7YaIjNlEz5qRjj41OGR/HR6n6IlMCvLR3
         FogO5OZ3j+cZOx/Fe9IMH48Io914hJckTDPxBPq9svbls9fbvboJQiG7mjQydOp5hlGv
         H0In9HwqcOWZxyg3oet2edGlnTIdAUrLtpv+tNdIKDeJTyJRNhWpRYqPUNbTylffT3RO
         gT16yqa+LHIZlbde4D43p8szOTSmPDXZ9gJ1BWxRBzT+q5lRIJUL8E+IUMl3Le8UU5w8
         Dc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7gM/D7X4Px1PAJl5nZi9KE2EoEB12I2kmkXvzNOm5Jw=;
        b=pqgERy2hvC4daGGYmtYmO5bo/7ESTVDDuvjEOd/Pa8xhV3N/07FIBOi+T3XtITQa/n
         /oc31mJJMHJ114UmXn1Hi62n0f8YrmkfHKUSJaXpKyAf0f/NClzyy7+eYxf75Si9p2M8
         6WOyz+bMrw4zEHOf+p898wkXrFEQ+EeMI71HaAvbPgVwhqb+DJCJw5jaiBuyfGbJo5JB
         mt4++NnNn6FcbA7DrfgskuE3gkB8qbl5InV9YRM1FdfK8Owxk8JV+MvyUG2SyD5g5mPE
         v8mAPKe6G32prF1rZQ+cSSeF1fDxL3rF8hrajONDaGPaAjtG6MUcTGrbrtvn9TuIlCn1
         8P1Q==
X-Gm-Message-State: AOAM5317bXYEdNI6uOF7k1Aua7Bn/lfiRcYZeOkvc2BognlI/jw1CJ4y
        5AUyNYmcC70SSLiFgTBTLg+D1eigpOU=
X-Google-Smtp-Source: ABdhPJxCvRcgWHPWRkgmSbgrAPiuA3JK9vDWtjQABAUY3+2sJeRI0ycFLQ7eYQ9oIwbpwolmtFljJg==
X-Received: by 2002:ac2:5f6d:: with SMTP id c13mr2936834lfc.53.1594757856974;
        Tue, 14 Jul 2020 13:17:36 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id x17sm6702lfr.63.2020.07.14.13.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:17:36 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 14 Jul 2020 22:17:34 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, arnd@arndb.de, elver@google.com, ethp@qq.com,
        frederic@kernel.org, jbi.octave@gmail.com, joel@joelfernandes.org,
        lihaoliang@google.com, madhuparnabhowmik10@gmail.com,
        mchehab+huawei@kernel.org, peter.enderborg@sony.com,
        rdunlap@infradead.org, richard.weiyang@linux.alibaba.com,
        urezki@gmail.com, zou_wei@huawei.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU commits for v5.9
Message-ID: <20200714201734.GA20470@pc636>
References: <20200714172701.GA31369@paulmck-ThinkPad-P72>
 <20200714181426.hhguqzrcqdubyvae@linutronix.de>
 <20200714182732.GU9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714182732.GU9247@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 14, 2020 at 11:27:32AM -0700, Paul E. McKenney wrote:
> On Tue, Jul 14, 2020 at 08:14:26PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-07-14 10:27:01 [-0700], Paul E. McKenney wrote:
> > > Joel Fernandes (Google) (5):
> > >       rcu/tree: Skip entry into the page allocator for PREEMPT_RT
> > 
> > If it is too late to drop this then I am going send a revert okay?
> 
> I believe that Ulad and Joel are working on an update.
> 
> Now that you mention it Ulad and Joel, how is this coming along?
> 
Yes. I have made a proposal with dropping the lock. I do not see
any issues by doing that. I will upload a patch soon.

--
Vlad Rezki

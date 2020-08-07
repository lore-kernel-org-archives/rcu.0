Return-Path: <SRS0=1SSE=BR=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60E4C433E0
	for <rcu@archiver.kernel.org>; Fri,  7 Aug 2020 18:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF9E2074D
	for <rcu@archiver.kernel.org>; Fri,  7 Aug 2020 18:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="d/TLBHsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGSba (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGSb2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 7 Aug 2020 14:31:28 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD6EC061756
        for <rcu@vger.kernel.org>; Fri,  7 Aug 2020 11:31:28 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z17so2567247ill.6
        for <rcu@vger.kernel.org>; Fri, 07 Aug 2020 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ow/n+p5v9AzYTA+9JReZiErGOMiITrcf1jfAhTavps8=;
        b=d/TLBHsbUxJim9gdd6Ilv6C2+IoLB5KGJSQKC8Y7rBSGC//gc3mJa8d+nyjASUx6Ld
         /Sap8yf2yTNMWrWQguBMFeBDe457yQgWGC1T1RXw2xz8rd6dATNB/I6tYOvkkueY3fQB
         ut599aJHWiP0JG0noR7f1MkiPe0AeqXyYCwUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ow/n+p5v9AzYTA+9JReZiErGOMiITrcf1jfAhTavps8=;
        b=lrDH/CfMGdn2JI1Bd9ODTplximcYGjHiu5qTN07458MIWIFLfyK0d2D4/k+MX7mI2u
         iSZLcF8G70Sp+BIlP9BWi41EZp32XjzAOjfrpH2q/7pMlfCkK2+0Lrx5sdjkNu29TCmd
         wqh0pZhHYQzgPROEg8Ul9VF/TRqEeiTKQmHnRy2RnY92eqnEuRDsa0/6oy88WZcngIJI
         IRWkfb6sOwieiDUXDhTnD7+6sOk7PNs1zaVJYk6vvm1FW9kuhoX3J4c4D55ASEUdge/B
         RTNPUF+7DpjXF/7JZtAxLpiQkluhpqeNkGEnR32Rk1jsfZlWMPWihKdEnUqaSEk/Eg3O
         wTDA==
X-Gm-Message-State: AOAM533JBQlgpcWTctnzRG53ay1bJpw52++/Dwx2NtXFzA6flxAI0F5Q
        1m2sAhde2ucx4j9kEYihzc44qKlixx6+rEf0hMwjtA==
X-Google-Smtp-Source: ABdhPJy8Y0pVCBFunfYxLQ12k7YK8BWag29BNhppx9OX5t9Bt5CkoRs73Za0PwiTyL4uNOvTk/9RI6PwxpJZBtDtM9Q=
X-Received: by 2002:a92:cb06:: with SMTP id s6mr5997240ilo.13.1596825087854;
 Fri, 07 Aug 2020 11:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200807170722.2897328-1-joel@joelfernandes.org>
In-Reply-To: <20200807170722.2897328-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 7 Aug 2020 14:31:16 -0400
Message-ID: <CAEXW_YSCjELpkFUoX=kNvrkPvU-mDwv50Bbu=MZmbKa8=+BbYw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] option-subject: RCU and CPU hotplug checks and docs
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Vineeth Pillai <vineethrp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 7, 2020 at 1:07 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
>
> This series improves/adds to RCU's warnings about CPU hotplug and adds
> documentation and testing.
>
> v3->v4: Minor cleanups.
>
> Joel Fernandes (Google) (5):
> rcu/tree: Add a warning if CPU being onlined did not report QS already
> rcu/tree: Clarify comments about FQS loop reporting quiescent states
> rcu/tree: Make FQS complaining about offline CPU more aggressive
> rcutorture: Force synchronizing of RCU flavor from hotplug notifier
> docs: Update RCU's hotplug requirements with a bit about design

Apologies that the cover-letter subject has the weird 'option-subject'
in it.  Likely my git-send script misunderstood one of my markers.

thanks,

 - Joel

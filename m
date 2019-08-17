Return-Path: <SRS0=/cn9=WN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D36C3A59D
	for <rcu@archiver.kernel.org>; Sat, 17 Aug 2019 01:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E06A21721
	for <rcu@archiver.kernel.org>; Sat, 17 Aug 2019 01:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Fv/d7xHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfHQBcj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Aug 2019 21:32:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43602 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfHQBcg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Aug 2019 21:32:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id h15so6801725ljg.10
        for <rcu@vger.kernel.org>; Fri, 16 Aug 2019 18:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHBSgVtbyrH7bBR6euG6hAkhNuTFa6ViU5ynAtyXjDc=;
        b=Fv/d7xHKFOOhbqVgF/o21Bh1Hdl2CtcIoYZ9wPIWJfMNHlbv1NhwHhITS9Yaq2Em7S
         9DhdAr5A3Ug3IlssVUk2s3Gx3v2mb6GMQ/kZ36dXtYgArRMkSIL9aUB1EmyepecCmll9
         ogetUAIGa0jPUBez3Mmv7tVLRhpInvbADfrh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHBSgVtbyrH7bBR6euG6hAkhNuTFa6ViU5ynAtyXjDc=;
        b=Xl2554Swn/usNnAnMdNH0AZAO7XvHWa6MVKVPWWVzq7D2ihTGDcpy7bA21eLzt9emk
         Z2YLau8x0E9Dm0YRuDjfNifCSJ+N8+Tthqn2HkqAe/Fd3F2cxaiepHHvCcaTEhHyNS9V
         TcipV2LhpDwo17j2uT4v4pvKT3VIHOUT14bpEatnCndVqCyxqn7n4PTyOaxrl+sytSPW
         zLJEuQuaIelNhaekQjF4X3tH1l54bBgp2bFzyHYyIo+ZD1jQu+lKSzu5KgfLIsSRoYsp
         NquzOEpv6C85F0KfU9ZtJm2Y5ZZCMbH7hrOJ3k050zM8R7mA0hcZfmkpnixbmMAMTrMF
         sNDA==
X-Gm-Message-State: APjAAAV1s33ixWKir5lkQKrwWRc+lE/4eul3MtQS9XaOKHXzPsq30K7p
        n7iXh+/veoci5d1pfETw43Frt7Cs5gpagiRjXsZMoA==
X-Google-Smtp-Source: APXvYqz44jJ0slF1oFo0hbcPkbHA8WFv38ynrt7Ruo/kP6XTloz/kjFVDiSKV2i0SiVFLFWSgsG52DewRobQZmUBo+s=
X-Received: by 2002:a2e:b0cb:: with SMTP id g11mr6828481ljl.76.1566005554663;
 Fri, 16 Aug 2019 18:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190816164330.GA8320@linux.ibm.com> <20190816174429.GE10481@google.com> <20190816191629.GW28441@linux.ibm.com>
In-Reply-To: <20190816191629.GW28441@linux.ibm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 16 Aug 2019 21:32:23 -0400
Message-ID: <CAEXW_YTSJaKzWGC5nTbOuoQ6dxO4_uYW6=ttTJY6FWGb5rcB6Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rcu/tree: Add basic support for kfree_rcu() batching
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        kernel-team <kernel-team@lge.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Fri, Aug 16, 2019 at 3:16 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > > Hello, Joel,
> > >
> > > I reworked the commit log as follows, but was then unsuccessful in
> > > working out which -rcu commit to apply it to.  Could you please
> > > tell me what commit to apply this to?  (Once applied, git cherry-pick
> > > is usually pretty good about handling minor conflicts.)
> >
> > It was originally based on v5.3-rc2
> >
> > I was able to apply it just now to the rcu -dev branch and I pushed it here:
> > https://github.com/joelagnel/linux-kernel.git (branch paul-dev)
> >
> > Let me know if any other issues, thanks for the change log rework!
>
> Pulled and cherry-picked, thank you!
>
> Just for grins, I also  pushed out a from-joel.2019.08.16a showing the
> results of the pull.  If you pull that branch, then run something like
> "gitk v5.3-rc2..", and then do the same with branch "dev", comparing the
> two might illustrate some of the reasons for the current restrictions
> on pull requests and trees subject to rebase.

Right, I did the compare and see what you mean. I guess sending any
future pull requests against Linux -next would be the best option?

thanks,

 - Joel

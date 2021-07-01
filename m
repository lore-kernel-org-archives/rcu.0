Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570B8C11F64
	for <rcu@archiver.kernel.org>; Thu,  1 Jul 2021 20:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3895261411
	for <rcu@archiver.kernel.org>; Thu,  1 Jul 2021 20:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhGAUGk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Jul 2021 16:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhGAUGk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Jul 2021 16:06:40 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AABAC061762
        for <rcu@vger.kernel.org>; Thu,  1 Jul 2021 13:04:09 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f21so8976844ioh.13
        for <rcu@vger.kernel.org>; Thu, 01 Jul 2021 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgNgvCyGz352VukOHyoZcBwZGKkuG4rgxw11qph8Xms=;
        b=TxCDpLsIeTkBYoS7Jz2iCV6Lo8QwW/mhhZr6gSXQmI3U0HqOkx8g//FYjjq4FbI5M1
         zr2mMAHd1yPlkcdpHMlqpLrUVL6A6wTVcqKfG66ldk9j2F+gs6l+E81GfvMh5uTx0lGW
         k2Og2APw3DtGG8lfHZpGxgfKtIN1x5LuKpY7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgNgvCyGz352VukOHyoZcBwZGKkuG4rgxw11qph8Xms=;
        b=VdCdwITzSbNsCIy0FRYZDI+VjZaRzcQYsrTmFUoQmtIQM5e0JLyPKbXBY3sEnyDarh
         BqkQ2ZZ8D2+K5nsmrD8YFdSXhJZb3fr8sgZjYVR53BXXcB+ZDhIWxt1u2uxx5z724ebL
         7Hv064SDHr85deJ++/2O58a+2LtLls360cH4QYB7Kn4MoEUUtgwRycn7zvRt3Crz1O0t
         RbE/D3WT3JhFoBDLEr+lUC+i/s39CwTJJM7k2iomxQNpGh1wToUQS8ZX+Dkx6I/i582y
         pw+1Psny0NCY/oFcjeZ4CO7MmAR/OgRTQfugfMwiqpCqNRvm2UrwOLfVLdAwJsnjuVGW
         fiDQ==
X-Gm-Message-State: AOAM5330CiwSTry41bdnIbXVE9L3m92DYL2mzmCF/0HDWCPrLREY1OKw
        FPWeRh/mDyGNN6tlpQSJkfbfcvraOUAuPTg6Cft40A==
X-Google-Smtp-Source: ABdhPJyifrROxuzcZGwturQNVNTRdiqSc5JOL7aCG3y1QJfgeUv2pIv+9eeCo1I2u+dJVDvdKtgzhhceKnA9KdnnTJI=
X-Received: by 2002:a5d:8154:: with SMTP id f20mr874802ioo.89.1625169848747;
 Thu, 01 Jul 2021 13:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210630140802.39138-1-fishland@aliyun.com> <85a49682-a196-65e5-b0a4-52f51b76626c@codeaurora.org>
 <20210701163115.GE4397@paulmck-ThinkPad-P17-Gen-1> <bb788228-9756-2ee9-f11c-eae133c34593@codeaurora.org>
 <20210701183933.GA1948@pc638.lan> <20210701195701.GG4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210701195701.GG4397@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 1 Jul 2021 16:03:58 -0400
Message-ID: <CAEXW_YT9emLvb=n5mHgg_BsGH=mdDKgN6VOLdHwJSfc+zf1jSQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: Use per_cpu_ptr to get the pointer of per_cpu variable
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Liu Song <fishland@aliyun.com>, liu.song11@zte.com.cn,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 1, 2021 at 3:57 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Jul 01, 2021 at 08:39:33PM +0200, Uladzislau Rezki wrote:
> > On Thu, Jul 01, 2021 at 10:35:43PM +0530, Neeraj Upadhyay wrote:
> > >
> > >
> > > On 7/1/2021 10:01 PM, Paul E. McKenney wrote:
> > > > On Thu, Jul 01, 2021 at 08:24:32PM +0530, Neeraj Upadhyay wrote:
> > > > >
> > > > >
> > > > > On 6/30/2021 7:38 PM, Liu Song wrote:
> > > > > > From: Liu Song <liu.song11@zte.com.cn>
> > > > > >
> > > > > > In rcu, most codes have used per_cpu_ptr to obtain per_cpu variable
> > > > > > pointers. This patch adjusts a few codes that have not done so.
> > > > > >
> > > > >
> > > > > Minor: Can we also add below statement?
> > > > > "This patch doesn't introduce any functional change."
> > > > >
> > > > > > Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> > > >
> > > > Applied with the usual wordsmithing, including adding words to this
> > > > effect, so thank you all!  I removed the obsolete chunk that Neeraj
> > > > pointed out as well.
> > > >
> > > > Please take a look and check to see if all is well.
> > > >
> > >
> > > Looks good to me
> > >
> > Same to me. Looks good.
> >
> > There are two dots though in the commit message: "change.." :)
>
> Good eyes, fixed, thank you!

LGTM as well, thanks!
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

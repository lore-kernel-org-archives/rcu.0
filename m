Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F315EC43331
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 14:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF379206F6
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 14:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="I+iBu8zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbgDAOqI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:46:08 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36966 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733062AbgDAOqI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 10:46:08 -0400
Received: by mail-il1-f194.google.com with SMTP id a6so179045ilr.4
        for <rcu@vger.kernel.org>; Wed, 01 Apr 2020 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZcglO/uhS0ifb7KGuROmO8gY0j2umpsbqPd9xyiG0o8=;
        b=I+iBu8zkO552J01jKV6fjakpR39blBjN+08eSYXhfKl4ues3EMOfaeK290YIVMWt4+
         /IlgX8Z/17KBiwgFwox22rIS1MsLPRSBPaPqLKPDhIOHOX2BApZdxTkwFW/XfDUN9h5X
         iQN4oomqdvHygKtip5nD6/Ighto6NGAD14uJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZcglO/uhS0ifb7KGuROmO8gY0j2umpsbqPd9xyiG0o8=;
        b=ZeUDpZkgCTWDlPLYXCpYnUZJocJRTI+WvmRuPAxJcYqE4i1UaIsEP2thsRqhNy0xy2
         VGrgyCS1mXOs38zs+XfrWn/iopwtHsdRSxE4Yp+lGg+W1rox7aXFbV96ll4YORFkb7SI
         e3egmILtXQYOEH4bzIEA/VXNLdfMVzT6U/1iWR0PLUEp4IeO9HS+Ik9NU4z0UtGH5Kda
         CPwEp/RFfR0OAfPtJl8obg2InVqJT9Ic3m2Ovr6WmWhfCTcNVhWwjmOMEmuOn7JGIxYF
         1wUKBK2DL5uBGvU3Pdztf8faga+wfc4dYIhO0RewWBzj8LFVRVs55Ji2j0P2xR8F4T3e
         cWDw==
X-Gm-Message-State: ANhLgQ139jhhRo/48BLAq2TDhYqvu+/BAudbVVJfsV7t3LB0QhSSp2mA
        Y8EmWNm1qB2ni9FUXw9vSObZFfvHxrQVoLWMTASHXQ==
X-Google-Smtp-Source: ADFU+vtlL32MlDzpQe6oFSRHkl19s5SnsvVysgkEkDVY6eabwhZRZKYQgmqKsDQ1UVtbK0xu+21Ck7cuZWxbfpoFmvE=
X-Received: by 2002:a92:844f:: with SMTP id l76mr22924204ild.13.1585752367189;
 Wed, 01 Apr 2020 07:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com> <20200331153450.GM30449@dhcp22.suse.cz>
 <20200331160117.GA170994@google.com> <20200401072359.GC22681@dhcp22.suse.cz> <20200401131426.GN3772@suse.de>
In-Reply-To: <20200401131426.GN3772@suse.de>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 1 Apr 2020 10:45:56 -0400
Message-ID: <CAEXW_YTpXojYiskwiqZGHpT45v3xZYhuvy0CubaeyB3fMrmw7g@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
To:     Mel Gorman <mgorman@suse.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, rcu <rcu@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Neil Brown <neilb@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 1, 2020 at 9:14 AM Mel Gorman <mgorman@suse.de> wrote:
>
> On Wed, Apr 01, 2020 at 09:23:59AM +0200, Michal Hocko wrote:
> > > Can you suggest what prevents other users of GFP_MEMALLOC from doing that
> > > also?
> >
> > There is no explicit mechanism which is indeed unfortunate. The only
> > user real user of the flag is Swap over NFS AFAIK. I have never dared to
> > look into details on how the complete reserves depletion is prevented.
> > Mel would be much better fit here.
> >
>
> It's "prevented" by the fact that every other memory allocation request
> that is not involved with reclaiming memory gets stalled in the allocator
> with only the swap subsystem making any progress until the machine
> recovers. Potentially only kswapd is still running until the system
> recovers if stressed hard enough.
>
> The naming is terrible but is mased on kswapd's use of the PF_MEMALLOC
> flag. For swap-over-nfs, GFP_MEMALLOC saying "this allocation request is
> potentially needed for kswapd to make forward progress and not freeze".
>
> I would not be comfortable with kfree_rcu() doing the same thing because
> there can be many callers in parallel and it's freeing slab objects.
> Swap over NFS should free at least one page, freeing a slab object is
> not guaranteed to free anything.

Got it Mel. Just to clarify to the onlooker. It seemed to fit the
pattern that's why I proposed it as RFC, I was never sure it was the
right approach -- I just proposed it for discussion-sake because I
thought it was worth talking about at least. It was not even merged in
my tree, was just RFC.

Thanks Mel for clarifying the usage of the flag.

 - Joel

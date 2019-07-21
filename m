Return-Path: <SRS0=pgRM=VS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE636C76188
	for <rcu@archiver.kernel.org>; Sun, 21 Jul 2019 13:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4122085A
	for <rcu@archiver.kernel.org>; Sun, 21 Jul 2019 13:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DLbQ4opc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfGUN2q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 21 Jul 2019 09:28:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35160 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfGUN2p (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 21 Jul 2019 09:28:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so17858785plp.2
        for <rcu@vger.kernel.org>; Sun, 21 Jul 2019 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tf1DKfYz6MJVrEbH9g9T7Q+vdj4I3AhFgEqPaqSMi9k=;
        b=DLbQ4opcL9Khu3nj4ptPiQ+8Fzz6MPii51+rhhus2K7X4cn0BcNqcdbRi6relEeE4q
         Gtu39h2Q1IKVBlFhV1BzSzqhbO7t/BfXNyGd7ucUNeMmHjSACi3w790/gTj7p/vKbfgp
         t5QjCfCr1S7BsBHcehRQKQKztW4TVkIYnBBsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tf1DKfYz6MJVrEbH9g9T7Q+vdj4I3AhFgEqPaqSMi9k=;
        b=omreZQbxbz2QpFnPVv7nEe1nzfk1vGbYhKKTvx1sIIe1xys3xmmr1IGso9GHq3UFvj
         HGPBB4U+1W5UU2lPFP0GULfCsZUyoSnaNcm2JF3oqSm/Cev1RE+p4VjWrd8d/kF8sXUs
         NWAFrzL0PCCo3CxXDRrq39zy2yrIQBCBQom2xxJvwetzeTt1T11s1S9B6CdI82/uC2ID
         yE243AzIKU698VawwEO7tCkWvvaFbBzp80rYaMA3d4iKbFrkCK6uaKhDMJ+usYVha9Ph
         dJ65aKm/qSgSa2lm9/51BZ64XFMc09tbLlTVPQtKr/H0CTVtBSM8K+yi5QVerjck7WDi
         0rWw==
X-Gm-Message-State: APjAAAWrcK6eUJBkhnzIvwAYF78OzypYsv5+ST7sLgMwgPy12PwXZssh
        JF/hosjdyDdZpXVGmXTsBQ3IsxHr
X-Google-Smtp-Source: APXvYqxX9mmiVUI0zjerY0iYf3SclUHtjco7scU3wNmdizCJbVdLk45RqWlEx2TJOiaR8As04xRfcg==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr68454868plo.290.1563715724870;
        Sun, 21 Jul 2019 06:28:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h9sm33874301pgh.51.2019.07.21.06.28.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 06:28:43 -0700 (PDT)
Date:   Sun, 21 Jul 2019 09:28:42 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     rcu <rcu@vger.kernel.org>, kernel-team@lge.com
Subject: Re: This percpu_rwsem that always enters its reader slow path
Message-ID: <20190721132842.GA4584@google.com>
References: <CAEXW_YR39bnCCj+eo30jSZrNEvcJY8wrXuA0fYr_gfbfNiVsPQ@mail.gmail.com>
 <20190719075011.GD28226@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719075011.GD28226@X58A-UD3R>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 19, 2019 at 04:50:11PM +0900, Byungchul Park wrote:
> On Thu, Jul 18, 2019 at 05:09:45PM -0400, Joel Fernandes wrote:
> > Hello friends,
> > 
> > Just providing an update on my debugging of percpu_rwsem (related to
> > rcu-sync) for the day! which I pinged Byungchul about. Please ignore
> > this email if you are busy :) I am just archiving it in here..
> > 
> > As you may know, percpu_rwsem uses rcu-sync framework to reduce cost
> > of read-side by making it free of any serializing/atomic instructions
> > at all. However, there was one sempahore which broke the rules!
> > 
> > I spent a couple hours trying to figure out why
> > cgroup_threadgroup_rwsem always entered the reader-slow path on my
> > system (RCU-sync turns out to be non-idle for this rwsem). I really
> > thought it was a bug, because I felt what's the pointed of rcu-sync if
> > it never goes idle..
> 
> Yes, with the following patch, the cgroup rwsem cannot make use of
> rcu_sync any more, but it still gets benefit from percpu structure
> as you told me like avoiding cache bouncing and contention on a shared
> area even though every read lock keeps firing smp full barrier.

Yes. So it seems to me main benefit of RCU in percpu_rw_sempahore is to
completely avoid memory barriers in the read path, while also benefiting from
the percpu nature of the lock.

> What matters is which one is more expensive between (1) firing smp_mb
> and (2) accessing a shared data, sem->count, and acquiring/releasing
> sem->wait_lock. I think using percpu-rwsem involving the smp barrier is
> much better even with rcu_sync disabled.

Right. Fully agreed.

thanks,

 - Joel


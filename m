Return-Path: <SRS0=q/VE=T7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FB8C04AB6
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 14:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C89F26AD5
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 14:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lFuE7Tzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEaOnl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 31 May 2019 10:43:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34467 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaOnl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 31 May 2019 10:43:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id j24so9906988ljg.1
        for <rcu@vger.kernel.org>; Fri, 31 May 2019 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PswtOJAomPPWBtzsozo2zLXICMfwMKX0ykeXVxxlIYc=;
        b=lFuE7Tznx3886xmAs3rOxCP3M1WGFlBwq+Mf9sW3tl+MQhdRREP/s7oT9JBSd34Y7c
         RlyPl4EFWpQjpbFil5+FXUDm2BIf9XMUsi4aObQr5A+BrbBzfNGpt+oTU+H7BMrXTiWv
         Nap7I1zzJeKRm35EQNCsEV1cCZgd7T6AfzpWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PswtOJAomPPWBtzsozo2zLXICMfwMKX0ykeXVxxlIYc=;
        b=aPsndAxBgtkSAf2koexheUweJCarSNAH51eyEOnCbxT+8nffbVE6zSufcHW90tifSi
         MN4akvvOoxCUzDV9JeuDVyqtuYfxNnH1FiGGvgngsya90xBcV1JVF5gkVKHmgL/Lf90a
         Ss/XR+cit2UR1QVE949orLAUUddl8c6ZD7OJ2v/+VYwJXD+k9H9fQJMXpetVy3O5ZPec
         BKE20B8wy7ffbzZwNuS8zk25+z5uKAaBI8lZqyw0/BOSSCItsjw8vlkf3D1eXy8/xHKo
         qvDUcCIAZjQlEoCMOLvH0xSCuC/PH+QC7pifNVlncwkevqLIIe7smfHygd5khZWrGwUg
         CwdQ==
X-Gm-Message-State: APjAAAVoHKNGgclxRhH6+FfAlmx20J1y9kbm8X+mAAMskrzNoHZqGong
        Wg/UzBZZUxuvFo2EDgAadfyhVHOq72NlePafCTB9uLRUdLs=
X-Google-Smtp-Source: APXvYqxgl1iyuw/FDdUGgk2WgP6sh25vlmQy/g0lZH4v/6uxDEtMwwUJ4TnFgqL9be/QPwvfVEW1f2tTbReQEtGhcgs=
X-Received: by 2002:a2e:9742:: with SMTP id f2mr6234729ljj.184.1559313819087;
 Fri, 31 May 2019 07:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YTzUsT8xCD=vkSR=mT+L7ot7tCESTWYVqNt_3SQeVDUEA@mail.gmail.com>
 <20190531135051.GL28207@linux.ibm.com>
In-Reply-To: <20190531135051.GL28207@linux.ibm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 31 May 2019 10:43:27 -0400
Message-ID: <CAEXW_YReo2juN8A3CF+CKv8PcN_cH23gYWkLfkOJQqignyx85g@mail.gmail.com>
Subject: Re: Question about cacheline bounching with percpu-rwsem and rcu-sync
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Eric Dumazet <edumazet@google.com>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 31, 2019 at 9:52 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Fri, May 31, 2019 at 09:10:16AM -0400, Joel Fernandes wrote:
> > Hi,
> > As per the documentation for rationale of percpu-rwsem, the Documentation says:
> >
> > The problem with traditional read-write semaphores is that when multiple
> > cores take the lock for reading, the cache line containing the semaphore
> > is bouncing between L1 caches of the cores, causing performance
> > degradation.
> >
> > However, it appears to me that the struct percpu_rwsem "rss" element
> > which is used by the RCU-sync is not a per-cpu element. So even in the
> > fastpath case (only readers and no writers), the cacheline containing
> > rss is shared and will bounce by multiple CPUs. For that matter, even
> > the cacheline containing the percpu_rw_semaphore itself will be bounce
> > among multiple reader CPUs.
> >
> > So how does percpu-rwsem eliminate cache line bouncing in the common
> > case. Could you let me know what I am missing?
> >
> > Thanks a lot.
>
> The accesses are loads, except for the __this_cpu_inc(), which updates
> a per-CPU variable.  The locations loaded will replicate across the
> CPUs' caches and the per-CPU variables are private to each CPU.  Hence
> no cacheline bouncing.

Makes sense, thanks for the answer!

>
> Either way, it would be good for you to just try it.  Create a kernel
> module or similar than hammers on percpu_down_read() and percpu_up_read(),
> and empirically check the scalability on a largish system.  Then compare
> this to down_read() and up_read()

Will do! thanks.

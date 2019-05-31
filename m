Return-Path: <SRS0=q/VE=T7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E223C04AB6
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 14:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F117326AD3
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 14:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SS9EfYt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfEaOnA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 31 May 2019 10:43:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46876 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaOnA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 31 May 2019 10:43:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id m15so1570067ljg.13
        for <rcu@vger.kernel.org>; Fri, 31 May 2019 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cj1dziJpkg4AftRC+MQAi3qMacmhd+EZ17On7NFE2+U=;
        b=SS9EfYt6n3DJ7/S/5yoTzQFRGXJlw5a5QzJKt0GynlvYWeu014F2RXTwxyAkk6XNeA
         De9J2rZwtS1fYBnuo5bfDCoxXLRoHm39iBPs3ax6OFQMZ1xAZ+tW20CnGPHiijDPGo/F
         hPopTaBCS55SfDqXN/N6ggf6yuuESJvnOKQNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cj1dziJpkg4AftRC+MQAi3qMacmhd+EZ17On7NFE2+U=;
        b=gvVHJ4NZYN2F88gM9KbfJ8FxBgbdDcXBFVCyuxLqS+XsIgD3HtJHW61/OBfkGOhOlN
         ApI36MhZNKJD2UVzFghORSH7KiXJeyl/Mp7UNTwFUf6VHpdFzTkcEPKv/Kl2TX9kpOrr
         93dKqMKr/LxBPdJlVynC4dIoo2sOZnX1YOxPZ1nVcneBnSx+k9f4EuVIwdHnwBogl2YS
         XN4RTrJxTS19xxFjzsdoKDhFX1VohAyYAPsVjm3kW/jEiFpBCrYmsJl967yiv2ovMlui
         3W/qAUucvXsccr5BGh+Ckby8iMZ591NEaeBF1hokl6SExOunYKCefoiw3jOvyrspv2Km
         UDmA==
X-Gm-Message-State: APjAAAVLjVtdI/HVkOmbIE2SvXcjlnXTk+vAi0wvWHF+e2rKueyQRW4N
        MT0VpdPW5bWQEdqfPQH07wS99DWHmVQAtcRLO1aaEQ==
X-Google-Smtp-Source: APXvYqxvhyScGubi6Pohh1r7kUFOzmBLt/GH6pQAPL9Lk+kMiNaS319HnBWIYcs+IwpNUzJkr743dQJtgn/NiSzCeL4=
X-Received: by 2002:a2e:6109:: with SMTP id v9mr6213051ljb.205.1559313778469;
 Fri, 31 May 2019 07:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YTzUsT8xCD=vkSR=mT+L7ot7tCESTWYVqNt_3SQeVDUEA@mail.gmail.com>
 <20190531134529.GC31323@redhat.com>
In-Reply-To: <20190531134529.GC31323@redhat.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 31 May 2019 10:42:47 -0400
Message-ID: <CAEXW_YR1G2EUUMr+G5VKRqhu5DRjg+S3nk81N-zjH73WmnYe7Q@mail.gmail.com>
Subject: Re: Question about cacheline bounching with percpu-rwsem and rcu-sync
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 31, 2019 at 9:45 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 05/31, Joel Fernandes wrote:
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
>
> The readers won't modify this memory? read_lock/unlock will only update
> the per-cpu counter, ->read_count.

Makes sense, I was confusing cache misses for cache bouncing. Thanks
for clarification!

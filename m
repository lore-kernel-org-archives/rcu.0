Return-Path: <SRS0=SMg2=VP=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7C7C7618F
	for <rcu@archiver.kernel.org>; Thu, 18 Jul 2019 21:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3838521019
	for <rcu@archiver.kernel.org>; Thu, 18 Jul 2019 21:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kRA2DdL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfGRVKz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:10:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44840 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfGRVKz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jul 2019 17:10:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so28719426ljc.11
        for <rcu@vger.kernel.org>; Thu, 18 Jul 2019 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4OqQXyUpTj5Pb7oNFf+/Jq3VIsE371DiXLG/uqJPtc=;
        b=kRA2DdL++rLK5Cz3IYvRbVaZCzARSaIxLfBJzEm+bwGqcRaYiXr1t627WpMITOYdRR
         vc/tg0IkiIiq8ixGP3UXVfxjQk0LS1LrFgpj30TRnOcn7NYYQopVunlpAHkYUpQ+t6fa
         dvxN77zDIj0Hjwvf70gvI6ZJFaA6nVWz2063M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4OqQXyUpTj5Pb7oNFf+/Jq3VIsE371DiXLG/uqJPtc=;
        b=uL7fRZgKOutG1yXFC4uA1A92uKzOnXdn+i+gZv4lKRP/Cvhp5Q92+arqO+yajbswW2
         d7jrrStWqe+QNo8xqeebJDIAWQasUm26WXN/QZYtyML2an4TRyiw3w9/SNZrs9utDhrj
         A3tTLS6tT9O+NSCMI/RDoN8UvtR2te5rbR9uvLsgcSOTsvkuq1+b1hprVUqkCfyWREIo
         lV3uTZRThABP887vHrpA5VDM0EHKBykYpCE9XVE9LOD5g6dFAsizMqMo0DBgLXUSN58J
         8eh0/rcJTi/uRClFNt/sGmOOOuqcpydrZUgXcWsOKEaJC8FTMrATIC9VqX1TaOVz/izp
         EdCA==
X-Gm-Message-State: APjAAAXskU8wQkYK95Cwkjoty1l4/XK8hTw1Nb5afnumxQ1or1aAUFe1
        vYbzFb3JBBkvwh7DnobRxyg8rH7/4+CH+Tgele3hCA==
X-Google-Smtp-Source: APXvYqzUgUDtf7rYjs6PURzctCEJNZd2rcaJJckr98l4gGNrD2qMeEU2/P0iBjmtNXzFHHqVQcoAFiO30Va7av0l4WM=
X-Received: by 2002:a2e:301a:: with SMTP id w26mr24808574ljw.76.1563484253798;
 Thu, 18 Jul 2019 14:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YR39bnCCj+eo30jSZrNEvcJY8wrXuA0fYr_gfbfNiVsPQ@mail.gmail.com>
In-Reply-To: <CAEXW_YR39bnCCj+eo30jSZrNEvcJY8wrXuA0fYr_gfbfNiVsPQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Jul 2019 17:10:42 -0400
Message-ID: <CAEXW_YQE_t+cde2OWzfwgjXU1i0pUhL0fEHFaYJb_3RgmZfAPA@mail.gmail.com>
Subject: Re: This percpu_rwsem that always enters its reader slow path
To:     rcu <rcu@vger.kernel.org>
Cc:     Byungchul Park <byungchul.park@lge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 18, 2019 at 5:09 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hello friends,
>
> Just providing an update on my debugging of percpu_rwsem (related to
> rcu-sync) for the day! which I pinged Byungchul about. Please ignore
> this email if you are busy :) I am just archiving it in here..
>
> As you may know, percpu_rwsem uses rcu-sync framework to reduce cost
> of read-side by making it free of any serializing/atomic instructions
> at all. However, there was one sempahore which broke the rules!
>
> I spent a couple hours trying to figure out why
> cgroup_threadgroup_rwsem always entered the reader-slow path on my
> system (RCU-sync turns out to be non-idle for this rwsem). I really
> thought it was a bug, because I felt what's the pointed of rcu-sync if
> it never goes idle..
>
> Then I landed on the commit below, and turns it was done for Android
> and reported by John :) And the patch author was a certain guy named
> Peter :)
>
> commit 3942a9bd7b5842a924e99ee6ec1350b8006c94ec
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Thu Aug 11 18:54:13 2016 +0200
>
>     locking, rcu, cgroup: Avoid synchronize_sched() in __cgroup_procs_write()
> -----------
>
> Basically, this commit makes the read-side cost percpu_rwsem slightly
> more expensive (one smp_load_acquire of readers_block, at the cost of
> making write-side a bit more expensive...)

I meant here, at the benefit of making write-side cheap and avoiding
synchronize_rcu...

Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DCBC4332F
	for <rcu@archiver.kernel.org>; Fri, 16 Dec 2022 16:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiLPQlP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Dec 2022 11:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiLPQkt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Dec 2022 11:40:49 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FB5389DE
        for <rcu@vger.kernel.org>; Fri, 16 Dec 2022 08:39:33 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c7so3089856qtw.8
        for <rcu@vger.kernel.org>; Fri, 16 Dec 2022 08:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UUp91WprqaNHUITYm3j69t3IfOszFHi9suFKD1u0+mI=;
        b=T8GPa8X/D2OsDZKZfADKGQ/74WXN/z4fbgtDQ3sU4/GoiaD0edPd53afSLhDGqKo3X
         XewU82VH4Hdtv+V3LpO2Q3sRLpGItGQzU4/uoiihj/Onb9f9YzZnWdHzc7uD0K+8HKFN
         dPtzvFyHodNIbjMjuvQpn4a/5fpQWW5DV24vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUp91WprqaNHUITYm3j69t3IfOszFHi9suFKD1u0+mI=;
        b=SHrGogVtVlsu+1qRv8S/AXHuAdG5MJkTU2rFIugHNtZILJHrmX9OxC7zqAB7W/k8ji
         fFmVpxH3EjCoTerJhxOXO3G4YoxqNwmf0PSFPKvpnANHtasRk01uCMkUXQCJMa0V5gXc
         SpqZXd5mnI/bAxdLCHA/5o9rk1XU9s4iodzhvsfNhIX0zkNrfuk0tMKysQL5rG4f5V4S
         ihk5mMlXQqKWcST4o8QbGTcbrh4gz0QGa/I9eo6szY47MuHlnUU586Ma2uI2dm8XojyD
         yMWdQSeUJ30MSaEu5SWlXyaoyuOhfn/SjAcmdN23zI20gBjLqD1QMW8kaGJu71zgAzmC
         8mCQ==
X-Gm-Message-State: ANoB5pks+u78nhDIqJgCRKm805Wkz9W2zj3PXpiVmjDozT5Ib10l7Eab
        ORu1/CGDptR5QbfEO+uJ2btYmQ==
X-Google-Smtp-Source: AA0mqf62zlQCnbD3tXThc/MoCtlSiqHErYqPO3xyrTaRvhDl+tokw48r6iJtzKCmQLoe+hwMWiGReg==
X-Received: by 2002:ac8:7419:0:b0:3a7:e805:a010 with SMTP id p25-20020ac87419000000b003a7e805a010mr46935325qtq.21.1671208772426;
        Fri, 16 Dec 2022 08:39:32 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id ca18-20020a05622a1f1200b003a7ee9613a6sm1578878qtb.25.2022.12.16.08.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:39:31 -0800 (PST)
Date:   Fri, 16 Dec 2022 16:39:31 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <Y5yfQwUpCU5cEQpE@google.com>
References: <20221215201356.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <EE4EC3CC-395E-475D-BEBE-545955AB97C8@joelfernandes.org>
 <20221216010914.GX4001@paulmck-ThinkPad-P17-Gen-1>
 <Y5ydp2YPRqGHq+eM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5ydp2YPRqGHq+eM@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 16, 2022 at 04:32:39PM +0000, Joel Fernandes wrote:
> On Thu, Dec 15, 2022 at 05:09:14PM -0800, Paul E. McKenney wrote:
> [...]
> > > >> 2. unlock()'s smp_mb() happened before Flip+smp_mb() , now the reader
> > > >> has no new smp_mb() that happens AFTER the flip happened. So it can
> > > >> totally sample the old idx again -- that particular reader will
> > > >> increment twice, but the next time, it will see the flipped one.
> > > > 
> > > > I will let you transliterate both.  ;-)
> > > 
> > > I think I see what you mean now :)
> > > 
> > > I believe the access I am referring to is the read of idx on one side and
> > > the write to idx on the other. However that is incomplete and I need to
> > > pair that with some of other access on both sides.
> > > 
> > > So perhaps this:
> > > 
> > > Writer does flip + smp_mb + read unlock counts [1]
> > > 
> > > Reader does:
> > >  read idx + smp_mb() + increment lock counts [2]
> > > 
> > > And subsequently reader does
> > > Smp_mb() + increment unlock count. [3]
> > > 
> > > So [1] races with either [2] or [2]+[3].
> > > 
> > > Is that fair?
> > 
> > That does look much better, thank you!
> 
> Perhaps a comment with an ASCII diagram will help?
> 
> Case 2:

And sorry I did not mention that Case 1 for me is the more trivial one where
the reader is preempted after sampling idx, and then all of them do
lock+unlock in quick succession to induce the counter-delta wrap around.

thanks,

 - Joel


> Both the reader and the updater see each other's writes too late, but because
> of memory barriers on both sides, they will eventually see each other's write
> with respect to their own. This is similar to the store-buffer problem. This
> let's a single reader contribute a maximum (unlock minus lock) imbalance of 2.
> 
> The following diagram shows the subtle worst case followed by a simplified
> store-buffer explanation.
> 
> READER                  UPDATER
> -------------           ----------
>                            // idx is initially 0.
> read_lock() {
>   READ(idx) = 0;
>   lock[0]++; --------------------------------------------,
>                            flip() {                      |               
>                               smp_mb();                  |
>   smp_mb();                                              |
> }                                                        |
>                                                          |
> // RSCS                                                  |
>                                                          |
> read_unlock() {                                          |
>   smp_mb();                                              |
>                               idx++;  // P               |
>                               smp_mb();                  |
>                            }                             |
>                                                          |
>                            scan_readers_idx(0) {         |
>                                count all unlock[0];      |
>                                    |                     |
>                                    |                     |
>   unlock[0]++; //X <--not-counted--`-----,               |
>                                          |               |
> }                                        V               `------,
>                                // Will make sure next scan      |
>                                // will not miss this unlock (X) |
>                                // if other side saw flip (P) ,--`
>                                // Call this MB [1]           |
>                                // Order write(idx) with      |
>                                // next scan's unlock.        |
>                                smp_mb();                 ,---`
> read_lock() {                                            |
>   READ(idx)=0;                                           |
>   lock[0]++; ----------------> count all lock[0];        |
>   smp_mb();         |     }                              |
> }     |             |                                    V
>       |             `---> // Incorrect contribution to lock counting
>       |                   // upto a maximum of 2 times.
>       |
>        `---> // Pairs with MB [1]. Makes sure that
>              // the next read_lock()'s' idx read (Y) is ordered
>              // with above write to unlock[0] (X).
>                             |
> rcu_read_unlock() {         |
>   smp_mb(); <---------------`
>   unlock[0]++; 
> }
> 
> read_lock() {
>   READ(idx) = 1; //Y
>   lock[1]++;
>   ...
> }
>                            scan_readers_idx(0) {
>                                count all unlock[0]; //Q
>                                ...
>                           }
> 
> This makes it similar to the store buffer pattern. Using X, Y, P and Q
> annotated above, we get:
> 
> READER                    UPDATER
> X (write)                 P (write)
> 
> smp_mb();                 smp_mb();
> 
> Y (read)                  Q (read)
> 
> 
> thanks,
> 
>  - Joel
> 

Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3794FC433DB
	for <rcu@archiver.kernel.org>; Fri, 12 Feb 2021 12:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02CE364E2A
	for <rcu@archiver.kernel.org>; Fri, 12 Feb 2021 12:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhBLMb5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Feb 2021 07:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhBLMby (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Feb 2021 07:31:54 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79364C061574;
        Fri, 12 Feb 2021 04:31:13 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id z19so2008861eju.9;
        Fri, 12 Feb 2021 04:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZnEwdEcswYIENMJxkyxRYDg1uixGeEiZFEr7l+5gDuE=;
        b=QPdyFrGDuU6ieI3pcfisRyFSNKIZzaYENuJ0+2zDk7lMfVeQ6PmwMEjJM/eoXauhuY
         P/mcqqFB7TY7+4kutDggf1ZcGjGyBPrW19mSdi8Jib6At2ui2fbxxg6v7sQa9rmlHdm3
         La/Ev+IPgG4wFltEVxQumpnqrarRCVnU4/nwIJ0OwwjgHWZ2sBi+DhjHLBgsO5D02D9b
         YNZlGLU5ZdfidNpo+n88X20lTWjDm4LF9ocKQiPKQeGmn+Xybb+4+lznLA9p+DTNCnzM
         xtkKhUf1MQG9LsBQRDLgxfL7xMWhHXkCO7L21Q9hXNU7z68cO7u2kjdBOL24T7S4iQEr
         iyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZnEwdEcswYIENMJxkyxRYDg1uixGeEiZFEr7l+5gDuE=;
        b=jzyT1wkam9etjoShQkyRhCyF7t/U6AUgCbtzOA4PXKLoDa8oA2cGxame5YygHEfW+0
         hG9dlJMQt3UjwqhQAEKcODSRHmgeDvbE6jiPyE2s2mPSoc95DoSO4nIdmvfbdv2hCFSQ
         DytNYNjphjTY34+Fw/AvbDjFqCWbisolOw/zLRs6WjeYeqGYZTlO5UE5X4K5pi+tzgpU
         3HsmD0qAyeAqwDBTGuy+NuW379COJFHyJ+Zgnf7qLwPBs5E4MCOR140Qic2vH2NTLIQh
         SbuSB/ebQxRzvMboTLeXI3orFhU6IHJ2lSfwlHu7Wf7mK34tSGAwnsksCtPMe25lGY5H
         oO2w==
X-Gm-Message-State: AOAM5302eHtZFj5kTe8w/1s/ive7/y++BFDUuaiSoGSmH2RJHOwuJLav
        h+Z4pHFhg1I+r/zoCYw/2pE=
X-Google-Smtp-Source: ABdhPJwSoFE0a9OzUpv6C/j9WohnTxbh5GHe3YAsH5accEZLPAsJ6owt+EO2eweAbwjFevCQ+/yYRQ==
X-Received: by 2002:a17:906:a2c9:: with SMTP id by9mr2720386ejb.546.1613133072155;
        Fri, 12 Feb 2021 04:31:12 -0800 (PST)
Received: from gmail.com (20014C4E1CA8C200EDF68EEF7D90344C.dsl.pool.telekom.hu. [2001:4c4e:1ca8:c200:edf6:8eef:7d90:344c])
        by smtp.gmail.com with ESMTPSA id zk6sm6215160ejb.119.2021.02.12.04.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:31:11 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 12 Feb 2021 13:31:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     akiyks@gmail.com, bigeasy@linutronix.de, elver@google.com,
        frederic@kernel.org, joel@joelfernandes.org, julia@ni.com,
        mchehab+huawei@kernel.org, neeraju@codeaurora.org,
        paul.gortmaker@windriver.com, peterz@infradead.org,
        qiang.zhang@windriver.com, swood@redhat.com, urezki@gmail.com,
        w@1wt.eu, wangqing@vivo.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, kernel-team@fb.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU, LKMM, and KCSAN commits for v5.12
Message-ID: <20210212123109.GB2185387@gmail.com>
References: <20210128010437.GA32221@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128010437.GA32221@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello, Ingo!
> 
> This pull request contains changes for RCU, KCSAN, LKMM, and nolibc.
> You can pull the entire group using branch for-mingo.  Or, if you prefer,
> you can pull them separately, using for-mingo-rcu to pull the RCU changes,
> for-mingo-kcsan to pull the KCSAN changes, for-mingo-lkmm to pull the
> LKMM changes, and for-mingo-nolibc to pull the noclib changes.
> 
> The changes are as follows:
> 
> 1.	RCU updates (for-mingo-rcu):

> 4.	Fixes to nolibc that allows it to run once again on ARMv8.
>	https://lore.kernel.org/lkml/20210121072031.23777-1-w@1wt.eu/

Pulled these two into tip:core/rcu - as nolibc's main (only?) usecase 
within the kernel is torture-testing.

> 2.	Kernel concurrency sanitizer (KCSAN) updates from Marco Elver.
> 	https://lore.kernel.org/lkml/20210106173323.GA23292@paulmck-ThinkPad-P72/

> 3.	Linux-kernel memory model (LKMM) updates.
> 	https://lore.kernel.org/lkml/20210106173548.GA23664@paulmck-ThinkPad-P72/

Pulled these two into tip:locking/core.

Thanks Paul!

	Ingo

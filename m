Return-Path: <SRS0=efVp=7L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28AAC433DF
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 13:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95717206A4
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590760557;
	bh=Enq4Wi87oreGuApmcECdC9lGbckzzO7dttk0SumdA8I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=IhljZMDesSytxU/ebMBNkpyjWjRvQ+xkvNNAd+1w272R3aPy4/+VbJzrGxknSLZVe
	 yY7df8QBEFNRlJkfy/CPSzt5kSn2vBXuVPwZRSigjcFxMwEH/87b9jd0eq2ov5N2y1
	 +bEsxT/t+/xObW77yAKD6xZZxPCyC03Vb6gY+v8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgE2Nz4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 May 2020 09:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgE2Nz4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 May 2020 09:55:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FEAF206A1;
        Fri, 29 May 2020 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590760556;
        bh=Enq4Wi87oreGuApmcECdC9lGbckzzO7dttk0SumdA8I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=y+vhlNBOERjmS74ytjDE/P3H+GHEsVKlAPSoz794yexAFW2fIJ8C4+hC/l5dMVUO5
         eeuabMM1Jvn7XY2oJnBNU+WUW5XCBf12jzL6bQHdkv6PP0HGmzvq1xojIYHq8mandh
         9FCrsbDJSwxS/0a4hWdnd+kECgtF2rnkg4XCqO0Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 152923522683; Fri, 29 May 2020 06:55:56 -0700 (PDT)
Date:   Fri, 29 May 2020 06:55:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: next-20200528 - build error in kernel/rcu/refperf.c
Message-ID: <20200529135556.GY2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <538911.1590725791@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <538911.1590725791@turing-police>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 29, 2020 at 12:16:31AM -0400, Valdis Klētnieks wrote:
> commit 9088b449814f788d24f35a5840b6b2c2a23cd32a
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Mon May 25 17:22:24 2020 -0700
> 
>     refperf: Provide module parameter to specify number of experiments
> 
> changes this line of code (line 389)
> 
> -               reader_tasks[exp].result_avg = 1000 * process_durations(exp) / ((exp + 1) * loops);
> +               result_avg[exp] = 1000 * process_durations(nreaders) / (nreaders * loops);
> 
> On a 32-bit ARM make allmodconfig with gcc 8.3, this results in:
> 
> ERROR: modpost: "__aeabi_uldivmod" [kernel/rcu/refperf.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:103: __modpost] Error 1
> 
> I admit not understanding why the original line of code worked and the new one doesn't.
> Maybe gcc is smarter/dumber about the ranges of 'exp' and 'nreaders' than we thought?

I was surprised by that as well, but yesterday I took the lazy way out
by making this module depend on 64BIT.  (0day reported a similar issue
on m68k.)  So this issue should no longer show up.  ;-)

							Thanx, Paul

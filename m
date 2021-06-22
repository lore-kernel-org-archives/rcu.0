Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC93C49EA2
	for <rcu@archiver.kernel.org>; Tue, 22 Jun 2021 17:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285546109E
	for <rcu@archiver.kernel.org>; Tue, 22 Jun 2021 17:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhFVRsw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:48:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232437AbhFVRst (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Jun 2021 13:48:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FF1760720;
        Tue, 22 Jun 2021 17:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624383993;
        bh=Q4ZQrlfOs5vHafq6U3E/be3FprQoIcj92Gf69azeL20=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DqwSXiXGa3Lh4rNtrP5hqC+sLMOAyYrEoFO5a2TVIpE1/u1ogy78F+NvPaZMjS5/e
         BzuNP4YyscOvj5femuKHp/zhdSIryXQaGU8/MmzXy32IoHhDmfI/YHMAcmK0lD3mbf
         jkxDmGZii3nGyfbIzSVXzVr7PNZf13Zqspa2dtILUi+cfJiVIplPklRR/ar9VbgOpq
         o7zVWU/ya21VxqtuyDOMI2zGjdGxuhXedhaxpOinBxugt2Cu7MMGPImajEPzENMhZX
         3fSe89+yBL97Ul2yoLm1+gaib3fm9FDPj/2xn32CkKkMU//mi/jvs7Npprp2fRlPx6
         XwVTFxC4pEN/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 522495C0168; Tue, 22 Jun 2021 10:46:33 -0700 (PDT)
Date:   Tue, 22 Jun 2021 10:46:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Jiangong.Han" <jiangong.han@windriver.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcu-scale: rcu-scale returns one less than the real
 number of gps in the dmesg report.
Message-ID: <20210622174633.GD4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210622103708.16814-1-jiangong.han@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622103708.16814-1-jiangong.han@windriver.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 22, 2021 at 06:37:08PM +0800, Jiangong.Han wrote:
> The dmesg report on rcu-scale shows there are N grace periods, and gps
> are listed from 0 to N.
> This commit make writer_n_durations stores the counts of gps,
> and shows there are N+1 gps, change the listed gps index begin from 0 to N.
> 
> From
>     [ 8306.087880] rcu-scale: writer 0 gps: 133
>     ......
>     [ 8307.864630] rcu-scale:    0 writer-duration:     0 44003961
>     [ 8307.935711] rcu-scale:    0 writer-duration:     1 32003582
>     ......
>     [ 8316.472860] rcu-scale:    0 writer-duration:   132 28004391
>     [ 8316.538498] rcu-scale:    0 writer-duration:   133 27996410
> 
> to
>     [ 8306.087880] rcu-scale: writer 0 gps: 134
>     ......
>     [ 8307.864630] rcu-scale:    0 writer-duration:     0 44003961
>     [ 8307.935711] rcu-scale:    0 writer-duration:     1 32003582
>     ......
>     [ 8316.472860] rcu-scale:    0 writer-duration:   132 28004391
>     [ 8316.538498] rcu-scale:    0 writer-duration:   133 27996410
> 
> Signed-off-by: Jiangong.Han <jiangong.han@windriver.com>

Much better, thank you!

As usual, I could not resist the urge to wordsmith a bit, so could
you please check the version below to make sure that I didn't mess
something up?

							Thanx, Paul


------------------------------------------------------------------------

commit 4c154a9103443b22aef8667ab64278d12372e64f
Author: Jiangong.Han <jiangong.han@windriver.com>
Date:   Tue Jun 22 18:37:08 2021 +0800

    rcuscale: Console output claims too few grace periods
    
    The rcuscale console output claims N grace periods, numbered from zero
    to N, which means that there were really N+1 grace periods.  The root
    cause of this bug is that rcu_scale_writer() stores the number of the
    last grace period (numbered from zero) into writer_n_durations[me]
    instead of the number of grace periods.  This commit therefore assigns
    the actual number of grace periods to writer_n_durations[me], and also
    makes the corresponding adjustment to the loop outputting per-grace-period
    measurements.
    
    Sample of old console output:
        rcu-scale: writer 0 gps: 133
        ......
        rcu-scale:    0 writer-duration:     0 44003961
        rcu-scale:    0 writer-duration:     1 32003582
        ......
        rcu-scale:    0 writer-duration:   132 28004391
        rcu-scale:    0 writer-duration:   133 27996410
    
    Sample of new console output:
        rcu-scale: writer 0 gps: 134
        ......
        rcu-scale:    0 writer-duration:     0 44003961
        rcu-scale:    0 writer-duration:     1 32003582
        ......
        rcu-scale:    0 writer-duration:   132 28004391
        rcu-scale:    0 writer-duration:   133 27996410
    
    Signed-off-by: Jiangong.Han <jiangong.han@windriver.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index dca51fe9c73f..2cc34a22a506 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -487,7 +487,7 @@ rcu_scale_writer(void *arg)
 	if (gp_async) {
 		cur_ops->gp_barrier();
 	}
-	writer_n_durations[me] = i_max;
+	writer_n_durations[me] = i_max + 1;
 	torture_kthread_stopping("rcu_scale_writer");
 	return 0;
 }
@@ -561,7 +561,7 @@ rcu_scale_cleanup(void)
 			wdpp = writer_durations[i];
 			if (!wdpp)
 				continue;
-			for (j = 0; j <= writer_n_durations[i]; j++) {
+			for (j = 0; j < writer_n_durations[i]; j++) {
 				wdp = &wdpp[j];
 				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
 					scale_type, SCALE_FLAG,

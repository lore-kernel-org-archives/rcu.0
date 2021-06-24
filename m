Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71470C49EA5
	for <rcu@archiver.kernel.org>; Thu, 24 Jun 2021 16:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A27E613C2
	for <rcu@archiver.kernel.org>; Thu, 24 Jun 2021 16:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhFXQnF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Jun 2021 12:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhFXQnF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Jun 2021 12:43:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FCA4613CA;
        Thu, 24 Jun 2021 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624552846;
        bh=HymNcG1+IzgcE8hHbs0AR1es0sYS8KvJ1NstBZBO46c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=W37CauQhCERdE6JNuOAMBVdh/YJyNd/gHXacIrSZ6GTzf3PctFsWo3f64O6YIwxZA
         eVIXaJZ1jm2+0pL2Q/QPtMiPBPQRVTQ2kAaI9Wr/DEKSEAktOvbatBe3DagzrdwCl1
         OQKJ84Gx7p3Ta1AEUhZB67iJDMfk41ZxKbzqCtI38ta+Pm4gok3Pq239624jOEQlro
         JYvHQRern0kBD9xjMVaXjTjuuPFH8GoPKe78jTzh7Qv9beVdqKNgdGremIuEA/d1fh
         6/QsTv3Uiwb15qfRljeilDqaGKXrIunl9GNyvN+m8P/fodXOXm9WHQcsK85G4e8gl/
         8s7BXeceGBflw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F16665C0525; Thu, 24 Jun 2021 09:40:45 -0700 (PDT)
Date:   Thu, 24 Jun 2021 09:40:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Jiangong.Han" <jiangong.han@windriver.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcuscale: Console output claims too few grace periods
Message-ID: <20210624164045.GU4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210624143424.16158-1-jiangong.han@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624143424.16158-1-jiangong.han@windriver.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 24, 2021 at 10:34:24PM +0800, Jiangong.Han wrote:
> The rcuscale console output claims N grace periods, numbered from zero
> to N, which means that there were really N+1 grace periods.  The root
> cause of this bug is that rcu_scale_writer() stores the number of the
> last grace period (numbered from zero) into writer_n_durations[me]
> instead of the number of grace periods. This commit therefore assigns
> the actual number of grace periods to writer_n_durations[me], and also
> makes the corresponding adjustment to the loop outputting per-grace-period
> measurements.
> 
> Sample of old console output:
> 	rcu-scale: writer 0 gps: 133
> 	......
> 	rcu-scale:    0 writer-duration:     0 44003961
> 	rcu-scale:    0 writer-duration:     1 32003582
> 	......
> 	rcu-scale:    0 writer-duration:   132 28004391
> 	rcu-scale:    0 writer-duration:   133 27996410
> 
> Sample of new console output:
> 	rcu-scale: writer 0 gps: 134
> 	......
> 	rcu-scale:    0 writer-duration:     0 44003961
> 	rcu-scale:    0 writer-duration:     1 32003582
> 	......
> 	rcu-scale:    0 writer-duration:   132 28004391
> 	rcu-scale:    0 writer-duration:   133 27996410
> 
> Signed-off-by: Jiangong.Han <jiangong.han@windriver.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

I already have it queued in -rcu here:

4c154a910344 ("rcuscale: Console output claims too few grace periods")

Or did you find an error in my wordsmithed version of your commit log?
If so, please point out the error explicitly.  (It looks identical to me,
but I could easily be missing something.)

							Thanx, Paul

> ---
>  kernel/rcu/rcuscale.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index dca51fe9c73f..2cc34a22a506 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -487,7 +487,7 @@ rcu_scale_writer(void *arg)
>  	if (gp_async) {
>  		cur_ops->gp_barrier();
>  	}
> -	writer_n_durations[me] = i_max;
> +	writer_n_durations[me] = i_max + 1;
>  	torture_kthread_stopping("rcu_scale_writer");
>  	return 0;
>  }
> @@ -561,7 +561,7 @@ rcu_scale_cleanup(void)
>  			wdpp = writer_durations[i];
>  			if (!wdpp)
>  				continue;
> -			for (j = 0; j <= writer_n_durations[i]; j++) {
> +			for (j = 0; j < writer_n_durations[i]; j++) {
>  				wdp = &wdpp[j];
>  				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
>  					scale_type, SCALE_FLAG,
> -- 
> 2.17.1
> 

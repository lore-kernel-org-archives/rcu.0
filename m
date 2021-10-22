Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0954C433F5
	for <rcu@archiver.kernel.org>; Fri, 22 Oct 2021 23:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9579061040
	for <rcu@archiver.kernel.org>; Fri, 22 Oct 2021 23:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhJVXSP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Oct 2021 19:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhJVXSO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Oct 2021 19:18:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22BBD61038;
        Fri, 22 Oct 2021 23:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634944556;
        bh=bb3dGdJ0lagW2FIIHI5Qm8VCtMbuQ+nAr16JtmAv09o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=idKvV55LR7SoTskQnqI5eQmaOsFnoDoKXBpI6ldDCCDuSQzzj8evhuqGZUGmiBkG+
         Lb6DbimXhEPOBf0r6Yg8UYxsc9CT5rI0lpkMn8wYYIfb7kMoVUGELfaZjgYLIvpOSW
         rhIsGTcOqP+kXdsMQxwZquymd3e/6SUdt6Jc5LqLA7dHCeERdNRjuAqoKkl06nGgPQ
         UQeBSMRfIYiSV7bIKEk+zn5Jiirg6dRZdVC1m80GgRslu4YGzMTU1aUG/j4AMBewnj
         wZF3B4898ZyPcCNX6gEZg9KpUIcHwGIAa6h6HTittKDyZ6bwnOCPm5RI9p47fwJjat
         p76dPXd++/yRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DD4CE5C0BF4; Fri, 22 Oct 2021 16:15:55 -0700 (PDT)
Date:   Fri, 22 Oct 2021 16:15:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] refscale: prevent buffer to pr_alert() being too long
Message-ID: <20211022231555.GG880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211022105111.29455-1-lizhijian@cn.fujitsu.com>
 <20211022105111.29455-2-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022105111.29455-2-lizhijian@cn.fujitsu.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 22, 2021 at 06:51:11PM +0800, Li Zhijian wrote:
> 0Day/LKP observed that the refscale results become incompleted
> when a larger nruns(such as 300) is specified.
> It seems that printk() can accept < 1024 buffer at once.
> Print the buffer if its length exceeds 800 simply.
> 
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

Good catch!  A couple of questions below.

						Thanx, Paul

> ---
>  kernel/rcu/refscale.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index 2cbe2a2ba387..b1b9052010fd 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -604,7 +604,7 @@ static u64 process_durations(int n)
>  	char *buf;
>  	u64 sum = 0;
>  
> -	buf = kmalloc(128 + nreaders * 32, GFP_KERNEL);
> +	buf = kmalloc(64 * 20, GFP_KERNEL);

This allocation (and the one below) is 1280 bytes rather than
1024 bytes.  Why the extra couple hundred bytes?

>  	if (!buf)
>  		return 0;
>  	buf[0] = 0;
> @@ -617,13 +617,15 @@ static u64 process_durations(int n)
>  
>  		if (i % 5 == 0)
>  			strcat(buf, "\n");
> +		if (strlen(buf) > 800) {
> +			pr_alert("%s", buf);

Does the tools/testing/selftests/rcutorture/bin/kvm-recheck-refscale.sh
script also require changes to handle the partial lines?

Same for the later comparison against 800.

> +			buf[0] = 0;
> +		}
>  		strcat(buf, buf1);
>  
>  		sum += rt->last_duration_ns;
>  	}
> -	strcat(buf, "\n");
> -
> -	SCALEOUT("%s\n", buf);
> +	pr_alert("%s\n", buf);
>  
>  	kfree(buf);
>  	return sum;
> @@ -648,7 +650,7 @@ static int main_func(void *arg)
>  
>  	VERBOSE_SCALEOUT("main_func task started");
>  	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
> -	buf = kzalloc(64 + nruns * 32, GFP_KERNEL);
> +	buf = kzalloc(64 * 20, GFP_KERNEL);
>  	if (!result_avg || !buf) {
>  		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
>  		errexit = true;
> @@ -701,10 +703,7 @@ static int main_func(void *arg)
>  	if (errexit)
>  		goto err;
>  
> -	buf[0] = 0;
> -	strcat(buf, "\n");
> -	strcat(buf, "Runs\tTime(ns)\n");
> -
> +	pr_alert("Runs\tTime(ns)\n");
>  	for (exp = 0; exp < nruns; exp++) {
>  		u64 avg;
>  		u32 rem;
> @@ -712,9 +711,13 @@ static int main_func(void *arg)
>  		avg = div_u64_rem(result_avg[exp], 1000, &rem);
>  		sprintf(buf1, "%d\t%llu.%03u\n", exp + 1, avg, rem);
>  		strcat(buf, buf1);
> +		if (strlen(buf) > 800) {
> +			pr_alert("%s", buf);
> +			buf[0] = 0;
> +		}
>  	}
>  
> -	SCALEOUT("%s", buf);
> +	pr_alert("%s", buf);
>  
>  err:
>  	// This will shutdown everything including us.
> -- 
> 2.33.0
> 
> 
> 

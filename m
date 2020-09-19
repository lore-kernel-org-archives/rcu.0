Return-Path: <SRS0=warb=C4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1109C43463
	for <rcu@archiver.kernel.org>; Sat, 19 Sep 2020 03:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF1120758
	for <rcu@archiver.kernel.org>; Sat, 19 Sep 2020 03:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgISDZv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 18 Sep 2020 23:25:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbgISDZv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 18 Sep 2020 23:25:51 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DF6A8AB6E1ECC9ABE957;
        Sat, 19 Sep 2020 11:25:47 +0800 (CST)
Received: from [10.174.177.167] (10.174.177.167) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 11:25:45 +0800
Subject: Re: [PATCH v2 1/2] locktorture: doesn't check nreaders_stress when no
 readlock support
To:     <paulmck@kernel.org>
CC:     Josh Triplett <josh@joshtriplett.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>
References: <20200918033755.GS29330@paulmck-ThinkPad-P72>
 <20200918114424.100852-1-houtao1@huawei.com>
 <20200918175911.GV29330@paulmck-ThinkPad-P72>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <f1d37fd7-32e7-0f31-bc3d-a1286e3fb4c2@huawei.com>
Date:   Sat, 19 Sep 2020 11:25:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918175911.GV29330@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.167]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On 2020/9/19 1:59, Paul E. McKenney wrote:
> On Fri, Sep 18, 2020 at 07:44:24PM +0800, Hou Tao wrote:
>> When do locktorture for exclusive lock which doesn't have readlock
>> support, the following module parameters will be considered as valid:
>>
>>  torture_type=mutex_lock nwriters_stress=0 nreaders_stress=1
>>
>> But locktorture will do nothing useful, so instead of permitting
>> these useless parameters, let's reject these parameters by returning
>> -EINVAL during module init.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> 
> Much better, much easier for people a year from now to understand.
> Queued for v5.11, thank you!
> 
> I did edit the commit log a bit as shown below, so please let me
> know if I messed anything up.
> 
Thanks for your edit, it looks more clearer.

Regards,
Tao
> 							Thanx, Paul
> 
> commit 4985c52e3b5237666265e59f56856f485ee36e71
> Author: Hou Tao <houtao1@huawei.com>
> Date:   Fri Sep 18 19:44:24 2020 +0800
> 
>     locktorture: Ignore nreaders_stress if no readlock support
>     
>     Exclusive locks do not have readlock support, which means that a
>     locktorture run with the following module parameters will do nothing:
>     
>      torture_type=mutex_lock nwriters_stress=0 nreaders_stress=1
>     
>     This commit therefore rejects this combination for exclusive locks by
>     returning -EINVAL during module init.
>     
>     Signed-off-by: Hou Tao <houtao1@huawei.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 316531d..046ea2d 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -870,7 +870,8 @@ static int __init lock_torture_init(void)
>  		goto unwind;
>  	}
>  
> -	if (nwriters_stress == 0 && nreaders_stress == 0) {
> +	if (nwriters_stress == 0 &&
> +	    (!cxt.cur_ops->readlock || nreaders_stress == 0)) {
>  		pr_alert("lock-torture: must run at least one locking thread\n");
>  		firsterr = -EINVAL;
>  		goto unwind;
> .
> 

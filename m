Return-Path: <SRS0=jKPx=DA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B42C4363D
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 02:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A50720838
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 02:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgIWCY0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Sep 2020 22:24:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727201AbgIWCY0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Sep 2020 22:24:26 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E49F98152EDEF6D69D05;
        Wed, 23 Sep 2020 10:24:23 +0800 (CST)
Received: from [10.174.177.167] (10.174.177.167) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 23 Sep 2020 10:24:20 +0800
Subject: Re: [PATCH 2/2] locktorture: call percpu_free_rwsem() to do
 percpu-rwsem cleanup
To:     <paulmck@kernel.org>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>
References: <20200917135910.137389-1-houtao1@huawei.com>
 <20200917135910.137389-3-houtao1@huawei.com>
 <20200922232426.GL29330@paulmck-ThinkPad-P72>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <fe8c274e-efa4-04ec-0d95-d7c49ec4dd83@huawei.com>
Date:   Wed, 23 Sep 2020 10:24:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922232426.GL29330@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.167]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

> On 2020/9/23 7:24, Paul E. McKenney wrote:
snip

>> Fix it by adding an exit hook in lock_torture_ops and
>> use it to call percpu_free_rwsem() for percpu rwsem torture
>> before the module is removed, so we can ensure rcu_sync_func()
>> completes before module exits.
>>
>> Also needs to call exit hook if lock_torture_init() fails half-way,
>> so use ctx->cur_ops != NULL to signal that init hook has been called.
> 
> Good catch, but please see below for comments and questions.
> 
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/locking/locktorture.c | 28 ++++++++++++++++++++++------
>>  1 file changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
>> index bebdf98e6cd78..e91033e9b6f95 100644
>> --- a/kernel/locking/locktorture.c
>> +++ b/kernel/locking/locktorture.c
>> @@ -74,6 +74,7 @@ static void lock_torture_cleanup(void);
>>   */
>>  struct lock_torture_ops {
>>  	void (*init)(void);
>> +	void (*exit)(void);
> 
> This is fine, but why not also add a flag to the lock_torture_cxt
> structure that is set when the ->init() function is called?  Perhaps
> something like this in lock_torture_init():
> 
> 	if (cxt.cur_ops->init) {
> 		cxt.cur_ops->init();
> 		cxt.initcalled = true;
> 	}
> 

You are right. Add a new field to indicate the init hook has been
called is much better than reusing ctx->cur_ops != NULL to do that.

>>  	int (*writelock)(void);
>>  	void (*write_delay)(struct torture_random_state *trsp);
>>  	void (*task_boost)(struct torture_random_state *trsp);
>> @@ -571,6 +572,11 @@ void torture_percpu_rwsem_init(void)
>>  	BUG_ON(percpu_init_rwsem(&pcpu_rwsem));
>>  }
>>  
>> +static void torture_percpu_rwsem_exit(void)
>> +{
>> +	percpu_free_rwsem(&pcpu_rwsem);
>> +}
>> +
snip

>> @@ -828,6 +836,12 @@ static void lock_torture_cleanup(void)
>>  	cxt.lrsa = NULL;
>>  
>>  end:
>> +	/* If init() has been called, then do exit() accordingly */
>> +	if (cxt.cur_ops) {
>> +		if (cxt.cur_ops->exit)
>> +			cxt.cur_ops->exit();
>> +		cxt.cur_ops = NULL;
>> +	}
> 
> The above can then be:
> 
> 	if (cxt.initcalled && cxt.cur_ops->exit)
> 		cxt.cur_ops->exit();
> 
> Maybe you also need to clear cxt.initcalled at this point, but I don't
> immediately see why that would be needed.
> 
Because we are doing cleanup, so I think reset initcalled to false is OK
after the cleanup is done.

>>  	torture_cleanup_end();
>>  }
>>  
>> @@ -835,6 +849,7 @@ static int __init lock_torture_init(void)
>>  {
>>  	int i, j;
>>  	int firsterr = 0;
>> +	struct lock_torture_ops *cur_ops;
> 
> And then you don't need this extra pointer.  Not that this pointer is bad
> in and of itself, but using (!cxt.cur_ops) to indicate that the ->init()
> function has not been called is an accident waiting to happen.
> 
> And the changes below are no longer needed.
> 
> Or am I missing something subtle?
> 
Thanks for your suggestion. Will send v2.

Thanks.



Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0B4C433EF
	for <rcu@archiver.kernel.org>; Sun, 24 Oct 2021 13:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0823160724
	for <rcu@archiver.kernel.org>; Sun, 24 Oct 2021 13:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhJXNgi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 24 Oct 2021 09:36:38 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7494 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231524AbhJXNgi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 24 Oct 2021 09:36:38 -0400
IronPort-Data: =?us-ascii?q?A9a23=3A9t1HmaoBqkCDxLY/CATptfhkGxVeBmJJZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmNKXz3XMvqJZmqmeIxwYNjl8R8F6pXWz9Y1TgNv/HtnQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?cYHwpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlsZ2iS?=
 =?us-ascii?q?QYrP6TKsOoAURhECDw4NqpDkFPCCSHm75fPlxyfLRMAxN0rVinaJ7Yw/+9rAWB?=
 =?us-ascii?q?D6LoUJSsLaQGOnfmezby1S+Jtgd9lJ87uVKsdu3hmwirZBPAiSJHrTKDD5Nse1?=
 =?us-ascii?q?zA17uhUGu3CasYFQTVoaxjFYgYJPU0YYLo8m+qsrnv4fjlWpUiTrKw77nOVyxZ?=
 =?us-ascii?q?+uJDvN8HVUt6NXsVJhEeAom/a4yL+GB5yHMSW1D6A+XGEheLVmy7/HoUIG9WQ+?=
 =?us-ascii?q?vd0jXWI2mMUDBQcTh29rOXRokq/Xc9Pbk8Z4CwjqYAs+0GxCNrwRRu1pDiDpBF?=
 =?us-ascii?q?0c8BbDsUk5wyXjKnZ+QCUAi4DVDEpVTCMnKfaXhRzjhnQwYyvXmcp7dWopbum3?=
 =?us-ascii?q?u/8hVuP1eI9dAfuvRM5cDY=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Av40FR6NFAewFFcBcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.87,178,1631548800"; 
   d="scan'208";a="116340916"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Oct 2021 21:34:16 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 4B2074D0D9DC;
        Sun, 24 Oct 2021 21:34:12 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 24 Oct 2021 21:34:09 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 24 Oct 2021 21:34:07 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 24 Oct 2021 21:34:07 +0800
Subject: Re: [PATCH 1/2] refscale: simplify the errexit checkpoint
To:     <paulmck@kernel.org>
CC:     <dave@stgolabs.net>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211022105111.29455-1-lizhijian@cn.fujitsu.com>
 <20211022231048.GF880162@paulmck-ThinkPad-P17-Gen-1>
From:   "Li, Zhijian" <lizhijian@cn.fujitsu.com>
Message-ID: <4be14a8a-113f-fb37-75e0-bffd5bebf45a@cn.fujitsu.com>
Date:   Sun, 24 Oct 2021 21:34:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211022231048.GF880162@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-yoursite-MailScanner-ID: 4B2074D0D9DC.AE990
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


on 2021/10/23 7:10, Paul E. McKenney wrote:
> On Fri, Oct 22, 2021 at 06:51:10PM +0800, Li Zhijian wrote:
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Good catch!
>
> But given that errexit is only set once at the beginning, why not
> eliminate this local variable in favor of a goto at the point that it
> is currently assigned to?  That would permit further simplification.

It sounds pretty good, i will update it later.

Thanks
Zhijian


> 							Thanx, Paul
>
>> ---
>>   kernel/rcu/refscale.c | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
>> index 66dc14cf5687..2cbe2a2ba387 100644
>> --- a/kernel/rcu/refscale.c
>> +++ b/kernel/rcu/refscale.c
>> @@ -698,26 +698,25 @@ static int main_func(void *arg)
>>   	// Print the average of all experiments
>>   	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
>>   
>> -	if (!errexit) {
>> -		buf[0] = 0;
>> -		strcat(buf, "\n");
>> -		strcat(buf, "Runs\tTime(ns)\n");
>> -	}
>> +	if (errexit)
>> +		goto err;
>> +
>> +	buf[0] = 0;
>> +	strcat(buf, "\n");
>> +	strcat(buf, "Runs\tTime(ns)\n");
>>   
>>   	for (exp = 0; exp < nruns; exp++) {
>>   		u64 avg;
>>   		u32 rem;
>>   
>> -		if (errexit)
>> -			break;
>>   		avg = div_u64_rem(result_avg[exp], 1000, &rem);
>>   		sprintf(buf1, "%d\t%llu.%03u\n", exp + 1, avg, rem);
>>   		strcat(buf, buf1);
>>   	}
>>   
>> -	if (!errexit)
>> -		SCALEOUT("%s", buf);
>> +	SCALEOUT("%s", buf);
>>   
>> +err:
>>   	// This will shutdown everything including us.
>>   	if (shutdown) {
>>   		shutdown_start = 1;
>> -- 
>> 2.33.0
>>
>>
>>
>



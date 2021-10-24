Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2E6C433F5
	for <rcu@archiver.kernel.org>; Sun, 24 Oct 2021 14:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C033360F0F
	for <rcu@archiver.kernel.org>; Sun, 24 Oct 2021 14:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhJXOso (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 24 Oct 2021 10:48:44 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35521 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229674AbhJXOso (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 24 Oct 2021 10:48:44 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AijwePqCMaYvKhRVW/1Tiw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fAgLrhmgnhTdTxmYdXjiOaPeJYTb3etx/O96zpk8F7ZWAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkERcwmj/3auK49CEmifnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9TiieJntJwwdNlu4GyS?=
 =?us-ascii?q?BsyI+vHn+F1vxxwSnggZvEcpOKaSZS4mYnJp6HcSFPpyuluDUwre4EV4eBwEGx?=
 =?us-ascii?q?U7tQVJj4MZRGEnKS9x7fTYuttj8IsN8niOocWu1lvyDjYCbAtRpWra7/N/sNV0?=
 =?us-ascii?q?CsYicdJEfPffIweczUHRBDDezVOPEsaDNQ1m+LArmH/cjlZsBSRpII25XTeyEp?=
 =?us-ascii?q?6172FGNjSd9iiR8JYmkiVvGTP+Wj0GVcdLtP34TiC6XKEhOjUnT/hWZoWGaGks?=
 =?us-ascii?q?PlwjzW73mUODBgdVnO4rOO/h0r4XMhQQ2QY8zQjhbMu+0uvR9PmGRu1vBasuh8?=
 =?us-ascii?q?aRsoVEOAg7gyJ4rTb7hzfBWUeSDNFLts8u6ceXzc3/kGGksmvBjF1trCRD3WH+?=
 =?us-ascii?q?d+pQZmaUcQOBTZaI3ZaEk1euJ++yLzfRynnFr5LeJNZRPWscd0o/w23kQ=3D?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A92gykKjVkWzu96c9cMLqRfgU7XBQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.87,178,1631548800"; 
   d="scan'208";a="116342455"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Oct 2021 22:46:20 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 1E6BA4D0D9DC;
        Sun, 24 Oct 2021 22:46:19 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 24 Oct 2021 22:46:20 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 24 Oct 2021 22:46:20 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 24 Oct 2021 22:46:19 +0800
Subject: Re: [PATCH 2/2] refscale: prevent buffer to pr_alert() being too long
To:     <paulmck@kernel.org>
CC:     <dave@stgolabs.net>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Philip Li <philip.li@intel.com>,
        "kernel test robot" <lkp@intel.com>
References: <20211022105111.29455-1-lizhijian@cn.fujitsu.com>
 <20211022105111.29455-2-lizhijian@cn.fujitsu.com>
 <20211022231555.GG880162@paulmck-ThinkPad-P17-Gen-1>
From:   "Li, Zhijian" <lizhijian@cn.fujitsu.com>
Message-ID: <e49f00c9-b9c8-a6a9-9595-6cedf5efe3e5@cn.fujitsu.com>
Date:   Sun, 24 Oct 2021 22:46:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211022231555.GG880162@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-yoursite-MailScanner-ID: 1E6BA4D0D9DC.A260C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


on 2021/10/23 7:15, Paul E. McKenney wrote:
> On Fri, Oct 22, 2021 at 06:51:11PM +0800, Li Zhijian wrote:
>> 0Day/LKP observed that the refscale results become incompleted
>> when a larger nruns(such as 300) is specified.
>> It seems that printk() can accept < 1024 buffer at once.
>> Print the buffer if its length exceeds 800 simply.
>>
>> CC: Philip Li <philip.li@intel.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Good catch!  A couple of questions below.
>
> 						Thanx, Paul
>
>> ---
>>   kernel/rcu/refscale.c | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
>> index 2cbe2a2ba387..b1b9052010fd 100644
>> --- a/kernel/rcu/refscale.c
>> +++ b/kernel/rcu/refscale.c
>> @@ -604,7 +604,7 @@ static u64 process_durations(int n)
>>   	char *buf;
>>   	u64 sum = 0;
>>   
>> -	buf = kmalloc(128 + nreaders * 32, GFP_KERNEL);
>> +	buf = kmalloc(64 * 20, GFP_KERNEL);
> This allocation (and the one below) is 1280 bytes rather than
> 1024 bytes.  Why the extra couple hundred bytes?

Nothing special, so let's change 1024 or (800 + 64 ),which is sufficent as well ?


>
>>   	if (!buf)
>>   		return 0;
>>   	buf[0] = 0;
>> @@ -617,13 +617,15 @@ static u64 process_durations(int n)
>>   
>>   		if (i % 5 == 0)
>>   			strcat(buf, "\n");
>> +		if (strlen(buf) > 800) {
>> +			pr_alert("%s", buf);
> Does the tools/testing/selftests/rcutorture/bin/kvm-recheck-refscale.sh
> script also require changes to handle the partial lines?

I missed that, i will take a look at it

Thanks

Zhijian


>
> Same for the later comparison against 800.
>
>> +			buf[0] = 0;
>> +		}
>>   		strcat(buf, buf1);
>>   
>>   		sum += rt->last_duration_ns;
>>   	}
>> -	strcat(buf, "\n");
>> -
>> -	SCALEOUT("%s\n", buf);
>> +	pr_alert("%s\n", buf);
>>   
>>   	kfree(buf);
>>   	return sum;
>> @@ -648,7 +650,7 @@ static int main_func(void *arg)
>>   
>>   	VERBOSE_SCALEOUT("main_func task started");
>>   	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
>> -	buf = kzalloc(64 + nruns * 32, GFP_KERNEL);
>> +	buf = kzalloc(64 * 20, GFP_KERNEL);
>>   	if (!result_avg || !buf) {
>>   		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
>>   		errexit = true;
>> @@ -701,10 +703,7 @@ static int main_func(void *arg)
>>   	if (errexit)
>>   		goto err;
>>   
>> -	buf[0] = 0;
>> -	strcat(buf, "\n");
>> -	strcat(buf, "Runs\tTime(ns)\n");
>> -
>> +	pr_alert("Runs\tTime(ns)\n");
>>   	for (exp = 0; exp < nruns; exp++) {
>>   		u64 avg;
>>   		u32 rem;
>> @@ -712,9 +711,13 @@ static int main_func(void *arg)
>>   		avg = div_u64_rem(result_avg[exp], 1000, &rem);
>>   		sprintf(buf1, "%d\t%llu.%03u\n", exp + 1, avg, rem);
>>   		strcat(buf, buf1);
>> +		if (strlen(buf) > 800) {
>> +			pr_alert("%s", buf);
>> +			buf[0] = 0;
>> +		}
>>   	}
>>   
>> -	SCALEOUT("%s", buf);
>> +	pr_alert("%s", buf);
>>   
>>   err:
>>   	// This will shutdown everything including us.
>> -- 
>> 2.33.0
>>
>>
>>
>



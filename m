Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E4D383
	for <rcu@vger.kernel.org>; Tue,  3 Sep 2024 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725335416; cv=none; b=SivbrAhVbQ/IgXbs0p26T+8b8i2fPZ2YJO2vmLzRpkId30Ka5JIrydCqWTGQA0xNnTZJsn0RR0bPD7PgX8udG+HEiCvoCFOmVUn+7fX7gWSxPcC4H0EaiKWdwmrJofapDa3sIq1efz7UxrvfoH4yR0tOPtQRtgg+qzsRq+Ayjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725335416; c=relaxed/simple;
	bh=M4Wvxf33MoDkK+G6h5GG9QZ39iRZnm9Qd7quz+sIvKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LBupIsGtnnav1q7SZB4xHaGmLc0rdEN2p9ReKaafGMeOSCO+40/QO0bIsAW3SF3mPW9atijKG5f5aPeo4eQ+HT3krgmOI+QYQ65KOMs2vnVf7xGr0TSxwIeDDpZtfYdMEF8zZf1NXVyRVDg1ZcBS6diDI2fHKRTZ2/3g9NOSdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WyWp35ptjz14GB1;
	Tue,  3 Sep 2024 11:49:15 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C9AA1400CA;
	Tue,  3 Sep 2024 11:50:11 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Sep 2024 11:50:09 +0800
Message-ID: <c8f15d51-a9ac-c0fa-6fbc-959c4072da9d@huawei.com>
Date: Tue, 3 Sep 2024 11:50:09 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] rcu: Use the BITS_PER_LONG macro
Content-Language: en-US
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, <paulmck@kernel.org>,
	<frederic@kernel.org>, <neeraj.upadhyay@kernel.org>,
	<joel@joelfernandes.org>, <josh@joshtriplett.org>, <boqun.feng@gmail.com>,
	<urezki@gmail.com>, <rostedt@goodmis.org>, <jiangshanlai@gmail.com>,
	<qiang.zhang1211@gmail.com>, <rcu@vger.kernel.org>
References: <20240902110654.2685917-1-ruanjinjie@huawei.com>
 <5ff34e5e-dbeb-4ea3-820c-8def6a723133@efficios.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <5ff34e5e-dbeb-4ea3-820c-8def6a723133@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/2 20:16, Mathieu Desnoyers wrote:
> On 2024-09-02 07:06, Jinjie Ruan wrote:
>> sizeof(unsigned long) * 8 is the number of bits in an unsigned long
>> variable, replace it with BITS_PER_LONG macro to make it simpler.
> 
> An alternative would be:
> 
> if (rcu_fanout_leaf < 2 || sizeof_field(struct rcu_node, qsmask) *
> CHAR_BIT) {
> 
> which would then tie the check to validated member type. But it's
> slightly more verbose, so it's up to the maintainer really.

Yes, it reflects the original purpose but it is too long.

> 
> Thanks,
> 
> Mathieu
> 
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   kernel/rcu/tree.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index a60616e69b66..b48864df415c 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -5579,8 +5579,7 @@ void rcu_init_geometry(void)
>>        * Complain and fall back to the compile-time values if this
>>        * limit is exceeded.
>>        */
>> -    if (rcu_fanout_leaf < 2 ||
>> -        rcu_fanout_leaf > sizeof(unsigned long) * 8) {
>> +    if (rcu_fanout_leaf < 2 || rcu_fanout_leaf > BITS_PER_LONG) {
>>           rcu_fanout_leaf = RCU_FANOUT_LEAF;
>>           WARN_ON(1);
>>           return;
> 
